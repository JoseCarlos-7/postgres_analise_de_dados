## Análise de dados PostgresSQL.

### questão 1.

Com base nas tabelas existentes nesse projeto, aqui serão feitas a seguintes análises:

Dadas as 3 tabelas:
- students: (id int, name text, enrolled_at date, course_id text)
- courses: (id int, name text, price numeric, school_id text)
- schools: (id int, name text)
a. 
* Quantidade de alunos por escola e por dia
* Valor total das matríuculas
Apenas os cursos que iniciam com o termo 'data', ordenado por dia mais recente para o mais antigo.

b. (com base no resultado de a.)
* a soma acumulada
* a média móvel 7 dias e a média móvel 30 dias (quantidade de alunos)
* a média móvel 7 dias e a média móvel 30 dias (valor de matrícula)

### questão 2.
* a quantidade de empregados, a média salarial, o maior e o menor salários por departamento.
* ordenados pela maior média salarial.

### Passos para executar o projeto.
Após clonar o repositório, verifique se as pastas temp, backups e source estão presentes no diretório; Se não crie-as.
Ajuste o caminho para as pastas temp, backups e source descritos no arquivo .env.
```
DATA_DIRECTORY='C:\Users\josec\Desktop\projeto_subir\analise_postgres\source'
TEMP_DIRECTORY='C:\Users\josec\Desktop\projeto_subir\analise_postgres\temp'
BACKUP_DIRECTORY='C:\Users\josec\Desktop\projeto_subir\analise_postgres\backups'
```

As pastas logs, plugins e config também são indispensáveis. 

cd app
docker compose -f airflow-docker-compose.yaml up   

### Resolução.

**Questão 1.**
![questão 1](app/imagens/diagrama_questao_1.png)

O item (a) da questão 1 é resolvido dentro da instrução WITH (sql_a)

O item (b) da questão 1 é resolvido a partir da linha 56 do código apresentado abaixo.

```sql
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
order by  sql_a."data_matricula",sql_a."nome_escola"  asc
```

**Questão 2.** <br>
![questão 1](app/imagens/diagrama_questao_2.png)

A resolução da questão 2 está descrita no código abaixo: <br>

Para utilizar a função unaccent, utilizada para remover os acentos da string, é necessário habilitá-la. Essa função foi implementada para tratar a string 'salario', que pode vir acentuada. Aplicando a unaccent, evitamos que a cláusula WHERE deixe de considerar os casos em que a palavra venha acentuada. <br>
```sql
CREATE EXTENSION IF NOT EXISTS unaccent;
```
Após habilitá-la, basta executar o código abaixo. <br>

```sql
with agregacoes_gerais as (
select 
'agregacoes' as agregacoes,
round(avg(valor),2) as media_salarial_geral,
max(valor) as maior_salario_geral,
min(valor) as menor_salario_geral
from vencimento
where upper(unaccent(left(vencimento."nome",7))) = 'SALARIO'

),
agregacoes_janela as (
select
distinct
'agregacoes' as agregacoes,
departamento."nome" as nome_departamento,
count(empregado."matr") over (partition by departamento."nome") as numero_de_empregados,

round(avg(vencimento."valor") over (partition by departamento."nome"),2) as media_salarial_departamento,
max(vencimento."valor") over (partition by departamento."nome") as maior_salario_departamento,
min(vencimento."valor") over (partition by departamento."nome") as menor_salario_departamento

from departamento 
inner join empregado 
on departamento.cod_dep = empregado.lotacao

inner join emp_venc 
on empregado."matr" = emp_venc."matr"

inner join vencimento 
on emp_venc."cod_venc" = vencimento."cod_venc"

inner join agregacoes_gerais on 'agregacoes' = agregacoes_gerais."agregacoes"

where upper(unaccent(left(vencimento."nome",7))) = 'SALARIO'
)

select 

agregacoes_janela."nome_departamento",
agregacoes_janela."numero_de_empregados",
agregacoes_gerais."media_salarial_geral",
agregacoes_janela."media_salarial_departamento",
agregacoes_janela."maior_salario_departamento",
agregacoes_gerais."maior_salario_geral",
agregacoes_janela."menor_salario_departamento",
agregacoes_gerais."menor_salario_geral"


from agregacoes_gerais

inner join agregacoes_janela on agregacoes_gerais."agregacoes" = agregacoes_janela."agregacoes"
```