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



**Questão 2.** <br>
![questão 1](app/imagens/diagrama_questao_2.png)

