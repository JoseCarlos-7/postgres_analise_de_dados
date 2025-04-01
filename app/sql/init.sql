CREATE ROLE data_postgres_db WITH LOGIN PASSWORD 'user123';
ALTER ROLE data_postgres_db CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE data_postgres_db TO data_postgres_db;

CREATE TABLE departamento(
    cod_dep int,
    nome varchar(50),
    endereco varchar(50)
);

GRANT SELECT ON departamento TO sql_user;
-- ------------------------------------------------------------
CREATE TABLE dependente
(matr int, nome varchar(50), endereco varchar(50));

GRANT SELECT ON dependente TO sql_user;

-- ------------------------------------------------------------
CREATE TABLE desconto
(cod_desc int, nome varchar(50), tipo varchar(10), valor numeric);

GRANT SELECT ON desconto TO sql_user;

-- ------------------------------------------------------------
CREATE TABLE divisao
(cod_divisao int, nome varchar(50), endereco varchar(50), cod_dep int);

GRANT SELECT ON divisao TO sql_user;

-- ------------------------------------------------------------
CREATE TABLE emp_desc
(cod_desc int, matr int);

GRANT SELECT ON emp_desc TO sql_user;

-- ------------------------------------------------------------
CREATE TABLE emp_venc
(cod_venc int, matr int);

GRANT SELECT ON emp_venc TO sql_user;

-- ------------------------------------------------------------
CREATE TABLE empregado
(matr int, nome varchar(50), endereco varchar(50), data_lotacao timestamp, lotacao int,
gerencia_cod_dep int, lotacao_div int, gerencia_div int);

GRANT SELECT ON empregado TO sql_user;

-- ------------------------------------------------------------
CREATE TABLE vencimento
(cod_venc int, nome varchar(50), tipo varchar(10), valor numeric);

GRANT SELECT ON vencimento TO sql_user;

INSERT INTO departamento
("cod_dep", "nome", "endereco")
VALUES
(1, 'Contabilidade', 'R. X'),
(2, 'TI', 'R. Y'),
(3, 'Engenharia', 'R. Y');

INSERT INTO dependente
(matr, nome, endereco)
VALUES
(9999, 'Francisco Jose', 'R. Z'),
(88, 'Maria da Silva', 'R. T'),
(55, 'Virgulino da Silva', 'R. 31');

INSERT INTO desconto
(cod_desc, nome, tipo, valor)
VALUES
(91, 'IR', 'V', 400.00),
(92, 'Plano de saude', 'v', 300.00),
(93, NULL, NULL, NULL);

INSERT INTO divisao
(cod_divisao, nome, endereco, cod_dep)
VALUES
(11, 'Ativo', 'R. X', 1),
(12, 'Passivo', 'R. X', 1),
(21, 'Desenvoilvimento de Projetos', 'R. Y', 2),
(22, 'Analise de Sistemas', 'R. Y', 2),
(23, 'Programacao', 'R. W', 2),
(31, 'Concreto', 'R Y', 3),
(32, 'Calculo Estrutural', 'R. Y', 3);

INSERT INTO emp_desc
(cod_desc, matr)
VALUES
(91, 3),
(91, 27),
(91, 9999),
(92, 27),
(92, 71),
(92, 88),
(92, 9999);

INSERT INTO emp_venc
(cod_venc, matr)
VALUES
(1, 27),
(1, 88),
(1, 135),
(1, 254),
(1, 431),
(2, 1),
(2, 5),
(2, 7),
(2, 13),
(2, 33),
(2, 9999),
(3, 3),
(3, 55),
(3, 71),
(3, 222),
(3, 223),
(4, 25),
(4, 476),
(5, 371),
(6, 3),
(6, 27),
(6, 9999),
(7, 5),
(7, 33),
(7, 55),
(7, 71),
(7, 88),
(7, 254),
(7, 476),
(8, 25),
(8, 91),
(9, 1),
(9, 27),
(9, 91),
(9, 135),
(9, 371),
(9, 9999),
(10, 371),
(10, 9999),
(11, 91),
(12, 3),
(12, 27),
(12, 254),
(12, 9999),
(13, 3),
(13, 5),
(13, 7),
(13, 25),
(13, 33),
(13, 88),
(13, 135);

INSERT INTO empregado
(matr, nome, endereco, data_lotacao, lotacao, gerencia_cod_dep, lotacao_div, gerencia_div)
VALUES
(9999, 'Jose Sampaio', 'R Z', '2006-06-06 00:00:00', 1, 1, 12, NULL),
(33, 'Jose Maria', 'R 21', '2006-03-01 00:00:00', 1, NULL, 11, 11),
(1, 'Maria Jose', 'R. 52', '2003-03-01 00:00:00', 1, NULL, 11, NULL),
(7, 'Yasmim', 'R. 13', '2010-07-02 00:00:00', 1, NULL, 11, NULL),
(5, 'Rebeca', 'R. 1', '2011-04-01 00:00:00', 1, NULL, 12, 12),
(13, 'Sofia', 'R. 28', '2010-09-09 00:00:00', 1, NULL, 12, NULL),
(27, 'Andre', 'R. Z', '2005-05-01 00:00:00', 2, 2, 22, NULL),
(88, 'Yami', 'R. T', '2014-02-01 00:00:00', 2, NULL, 21, 21),
(431, 'Joao da Silva', 'R. Y', '2011-07-03 00:00:00', 2, NULL, 21, NULL),
(135, 'Ricardo Reis', 'R. 33', '2009-08-01 00:00:00', 2, NULL, 21, NULL),
(254, 'Barbara', 'R. Z', '2008-01-03 00:00:00', 2, NULL, 22, 22),
(371, 'Ines', 'R. Y', '2005-01-01 00:00:00', 2, NULL, 22, NULL),
(476, 'Flor', 'r. Z', '2015-10-28 00:00:00', 2, NULL, 23, 23),
(25, 'Lina', 'R. 67', '2014-09-01 00:00:00', 2, NULL, 23, NULL),
(3, 'Jose da Silva', 'R. 8', '2011-01-02 00:00:00', 3, 3, 31, NULL),
(71, 'Silverio dos Reis', 'r. C', '2009-01-05 00:00:00', 3, NULL, 31, 31),
(91, 'Reis da Silva', 'R. Z', '2011-11-05 00:00:00', 3, NULL, 31, NULL),
(55, 'Lucas', 'R 31', '2013-07-01 00:00:00', 3, NULL, 32, 32),
(222, 'Marina', 'R 31', '2015-01-07 00:00:00', 3, NULL, 32, NULL),
(223, 'Naldo', 'R 31', '2015-01-08 00:00:00', 3, NULL, 32, NULL),
(725, 'Angelo', 'R. X', '2001-03-01 00:00:00', 2, NULL, 21, NULL);

INSERT INTO vencimento
(cod_venc, nome, tipo, valor)
VALUES
(1, 'salario base Analista de Sistemas', 'V', 5000.00),
(2, 'Salario base Contador', 'V', 3000.00),
(3, 'Salario Base Engenheiro', 'V', 4500.00),
(4, 'Salario Base Projetista Software', 'V', 5000.00),
(5, 'Salario Base Programador de Sistemas', 'V', 3000.00),
(6, 'Gratificacao Chefia Departamento', 'V', 3750.00),
(7, 'Gratificacao Chefia Divisao', 'V', 2200.00),
(8, 'Salario Trabalhador Costrucao Civil', 'V', 800.00),
(9, 'Auxilio Salario Familia', 'V', 300.00),
(10, 'Gratificacao Tempo de servico', 'V', 350.00),
(11, 'Insalubridade', 'V', 800.00),
(12, 'Gratificacao por titulacao - Doutorado', 'V', 2000.00),
(13, 'Gratificacao por Titularidade - Mestrado', 'V', 800.00);


CREATE TABLE students (
id varchar(5), 
name varchar(50), 
enrolled_at date, 
course_id varchar(5));

GRANT SELECT ON students TO sql_user;

CREATE TABLE courses (
id varchar(5), 
name varchar(50), 
price numeric, 
school_id varchar(5));

GRANT SELECT ON courses TO sql_user;

CREATE TABLE schools (
id varchar(5), 
name varchar(50));

GRANT SELECT ON schools TO sql_user;

INSERT INTO schools
(id, name)
VALUES
('1', 'lia 1'),
('2', 'lia 2');

INSERT INTO students
(id, name, enrolled_at, course_id)
VALUES
('1', 'Vanderleia Martins','2025-01-01','1'),
('2', 'Maria do Socorro','2025-01-02','2'),
('3', 'José Linhares','2025-01-03','3'),
('4', 'Josefa Almeida','2025-01-03','4'),
('5', 'Julia Silva','2025-01-03','4'),
('6', 'Nadia Correia','2025-01-03','3'),
('7', 'Paula Souza','2025-01-03','2'),
('8', 'Plinio Oliveira','2025-01-04','1'),
('9', 'Vanderlei Martins','2025-01-04','1'),
('10', 'Maria Silva','2025-01-04','2'),
('11', 'José Silva','2025-01-05','3'),
('12', 'Josefa Onório','2025-01-05','4'),
('13', 'Julia Calvo','2025-01-05','4'),
('14', 'Nadia Pinheiro','2025-01-05','3'),
('15', 'Paula Souza','2025-01-06','2'),
('16', 'Plinio Soares','2025-01-06','1'),
('17', 'Miriam','2025-01-06','4'),
('18', 'Igor Pinheiro','2025-01-06','3'),
('19', 'Laura Souza','2025-01-07','2'),
('20', 'Juan Soares','2025-01-07','1'),
('21', 'Juan Mathias','2025-01-08','1'),
('22', 'Carlos Gonzales','2025-08-02','2'),
('23', 'Maria do Bairro','2025-01-08','3'),
('24', 'Marieta Dias','2025-01-08','4'),
('25', 'Cristina Machado','2025-01-09','4'),
('26', 'Carlos Veiga','2025-01-09','3'),
('27', 'Paula Oliveira','2025-01-09','2'),
('28', 'Plinio Silva','2025-01-10','1'),
('29', 'Vanderlei Paulossi','2025-01-10','1'),
('30', 'Ciro Silva','2025-01-10','2'),
('31', 'Olga Silva','2025-01-10','3'),
('32', 'Dino Onório','2025-02-05','4'),
('33', 'Homer Calvo','2025-02-05','4'),
('34', 'Icaro Pinheiro','2025-02-05','3'),
('35', 'Ines Souza','2025-02-06','2'),
('36', 'Katia Soares','2025-02-06','1'),
('37', 'Larissa','2025-02-06','4'),
('38', 'Priscila Pinheiro','2025-02-06','3'),
('39', 'Damares Souza','2025-02-07','2'),
('40', 'Nilton Soares','2025-02-07','1');

INSERT INTO courses
(id, name, price, school_id)
VALUES
('1', 'data professional',320.20,'1'),
('2', 'software engineering',150.0,'2'),
('3', 'data analytics',200.20,'2'),
('4', 'Excel avançado',300.10,'1');



/*  Execute this query to drop the tables */
-- DROP TABLE vencimento;
-- DROP TABLE empregado;
-- DROP TABLE emp_venc;
-- DROP TABLE emp_desc;
-- DROP TABLE divisao;
-- DROP TABLE desconto;
-- DROP TABLE dependente;
-- DROP TABLE departamento;
