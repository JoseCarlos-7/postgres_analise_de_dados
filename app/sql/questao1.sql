with sql_a as (
select 

distinct 

s."name" as nome_escola,
st."enrolled_at" as data_matricula,
c."name" as nome_curso,
count(st."id") over(partition by s."name",st."enrolled_at") as numero_matriculas,
sum(c."price") over(partition by s."name",st."enrolled_at") as subtotal_matriculas,
c.price as matricula

from students st
inner join courses c on st.course_id = c.id
inner join schools s on c.school_id = s.id
where left(c."name",4) = 'data'
order by st.enrolled_at desc
)

select 
sql_a."nome_escola",
sql_a."data_matricula",

SUM(sql_a."subtotal_matriculas") 
    OVER (
        PARTITION BY sql_a."nome_escola" 
        ORDER BY sql_a."data_matricula"
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS acumulado_matriculas,

SUM(sql_a."numero_matriculas") 
    OVER (
        PARTITION BY sql_a."nome_escola" 
        ORDER BY sql_a."data_matricula"
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS acumulado_alunos,   
    
round(avg(subtotal_matriculas) 
	OVER (
		partition by sql_a."nome_escola" 
		ORDER BY sql_a."data_matricula" 
		RANGE  BETWEEN INTERVAL '7 days'  PRECEDING AND CURRENT ROW),2
		) AS media_movel_7dias_matriculas,
		
round(avg(numero_matriculas) 
	OVER (partition by sql_a."nome_escola" 
		ORDER BY sql_a."data_matricula" RANGE  BETWEEN INTERVAL '7 days'  PRECEDING AND CURRENT ROW),2
		) AS media_movel_7dias_n_alunos,

round(avg(subtotal_matriculas) 
	OVER (partition by sql_a."nome_escola" 
		ORDER BY sql_a."data_matricula" RANGE  BETWEEN INTERVAL '30 days'  PRECEDING AND CURRENT ROW),2
		) AS media_movel_30dias_matriculas,
		
round(avg(numero_matriculas) 
	OVER (partition by sql_a."nome_escola" 
	ORDER BY sql_a."data_matricula" RANGE  BETWEEN INTERVAL '30 days'  PRECEDING AND CURRENT ROW),2
	) AS media_movel_30dias_n_alunos

from sql_a 
/*
where sql_a."nome_escola" = 'lia 1'
*/
order by  sql_a."data_matricula",sql_a."nome_escola"  asc


