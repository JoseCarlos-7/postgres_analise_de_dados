/*
CREATE EXTENSION IF NOT EXISTS unaccent;
*/
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

