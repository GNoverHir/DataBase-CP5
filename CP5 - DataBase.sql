-- PEDRO
CREATE TABLE T_RHSTU_AUTENTICA(
    id_autentica NUMERIC ,
    login varchar(100),
    senha varchar(100),
    st_login char(1) check(st_login in ('i', 'a')),
    CONSTRAINT T_RHSTU_AUTENTICA_PK PRIMARY KEY (id_autentica)
);

CREATE TABLE T_RHSTU_TIPO_CONTATO (
    id_tipo_contato NUMERIC(5) ,
    nm_tipo_contato VARCHAR(80) NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    CONSTRAINT T_RHSTU_TIPO_CONTATO_PK PRIMARY KEY (id_tipo_contato)
);



CREATE TABLE T_RHSTU_PACIENTE (
    id_paciente NUMERIC(9),
    nm_paciente VARCHAR(80) NOT NULL,
    nr_cpf NUMERIC(12) NOT NULL UNIQUE,
    nr_rg VARCHAR(15) UNIQUE,
    dt_nascimento DATE NOT NULL,
    fl_sexo CHAR(1) NOT NULL,
    ds_escolaridade VARCHAR(40) NOT NULL,
    ds_estado_civil VARCHAR(25) NOT NULL,
    tip_grupo_sanguineo VARCHAR(6) NOT NULL,
    nr_altura NUMERIC(3,2) NOT NULL,
    nr_peso NUMERIC(4,1) NOT NULL,
    id_autentica NUMERIC,
     CONSTRAINT T_RHSTU_PACIENTE_PK PRIMARY KEY (id_paciente), 
     CONSTRAINT T_RHSTU_PACIENTE_FK FOREIGN KEY (id_autentica)
         REFERENCES T_RHSTU_AUTENTICA(id_autentica)
);


CREATE TABLE T_RHSTU_FUNCIONARIO(
    id_funcionario NUMERIC,
    nm_funcionario varchar(255),
    fl_sexo char(1),
    ds_escolaridade varchar(40),
    dt_nascimento date,
    id_autentica NUMERIC NOT NULL, 
    CONSTRAINT T_RHSTU_FUNCIONARIO_FK FOREIGN KEY (id_autentica) 
            REFERENCES T_RHSTU_AUTENTICA(id_autentica),
    CONSTRAINT T_RHSTU_FUNCIONARIO_PK PRIMARY KEY (id_funcionario)
);



-- JHEMYSSON
CREATE TABLE T_RHSTU_UNID_HOSPITALAR(
    id_unid_hospitalar NUMERIC(9),
    razao_social varchar(80) not null,
    nr_logradouro NUMERIC(7),
    ds_complemento_numero varchar(30),
    ds_ponto_referencia varchar(50),
    dt_cadastro date not null,
    st_unid_hospitalar varchar(10) check(st_unid_hospitalar in ('i', 'a')),
    CONSTRAINT T_RHSTU_UNID_HOSPITALAR_PK PRIMARY KEY (id_unid_hospitalar)
);

CREATE TABLE T_RHSTU_CONSULTA(
    id_consulta NUMERIC ,
    dt_hr_consulta date not null,
    tp_unidade varchar(255) not null,
    tp_modalidade varchar(255),
    id_paciente NUMERIC(9)  not null,
    id_unid_hospitalar NUMERIC(9)  not null,
    tel_central varchar(14),
    CONSTRAINT T_RHSTU_CONSULTA_PK PRIMARY KEY (id_consulta),
    CONSTRAINT T_RHSTU_CONSULTA_PACIENTE_FK FOREIGN KEY (id_paciente) 
        REFERENCES T_RHSTU_PACIENTE(id_paciente),
    CONSTRAINT T_RHSTU_CONSULTA_HOSPITLAR_FK FOREIGN KEY (id_unid_hospitalar) 
        REFERENCES T_RHSTU_UNID_HOSPITALAR(id_unid_hospitalar)
);

CREATE TABLE T_RHSTU_CONTATO_PACIENTE (
    id_contato NUMERIC(9),
    id_paciente NUMERIC(9),
    id_tipo_contato NUMERIC(5)  NOT NULL,
    nm_contato VARCHAR(40) NOT NULL,
    nr_ddi NUMERIC(3),
    nr_ddd NUMERIC(3),
    nr_telefone NUMERIC(10),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_PK PRIMARY KEY(id_paciente, id_contato),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_FK FOREIGN KEY (id_paciente) 
        REFERENCES T_RHSTU_PACIENTE(id_paciente),
    CONSTRAINT T_RHSTU_CONTATO_PACIENTE_TIPO_CONTATO_FK FOREIGN KEY (id_tipo_contato) 
        REFERENCES T_RHSTU_TIPO_CONTATO(id_tipo_contato) 
);

CREATE TABLE T_RHSTU_ENDERECO_PACIENTE (
    id_endereco NUMERIC(9),
    id_paciente NUMERIC(9) NOT NULL,
    nr_logradouro NUMERIC(7),
    ds_cidade VARCHAR(100),
    ds_complemento_numero VARCHAR(30),
    ds_ponto_referencia VARCHAR(50),
    dt_inicio DATE NOT NULL,
    dt_fim DATE,
    CONSTRAINT T_RHSTU_ENDERECO_PACIENTE_PK PRIMARY KEY( id_endereco),
    CONSTRAINT T_RHSTU_ENDERECO_PACIENTE_FK FOREIGN KEY (id_paciente)
        REFERENCES T_RHSTU_PACIENTE(id_paciente)
);


-- FERNANDO
CREATE TABLE T_RHSTU_FORMA_PAGAMENTO(
    id_forma_pagamento numeric PRIMARY KEY,
    vl_total numeric not null,
    st_forma_pagamento char(1) not null check(st_forma_pagamento in('i', 'a')),
    id_consulta numeric  REFERENCES T_RHSTU_CONSULTA(id_consulta) not null
);

CREATE TABLE  T_RHSTU_FORMA_CONVENIO(
    id_forma_convenio numeric(9) primary key,
    nr_carteira numeric(10),
    nr_trasacao numeric(10),
    dt_trasacao date,
    dt_vencimento date,
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_FORMA_PIX(
    id_forma_pix numeric(9)  primary key,
    nr_transacao numeric(10),
    dt_transacao date,
    tp_chave varchar(60),
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);

CREATE TABLE T_RHSTU_FORMA_CARTAO(
    id_forma_cartao numeric(9)  primary key,
    nr_cartao numeric(36),
    nr_transacao numeric(10),
    dt_transacao date,
    tp_bandeira varchar(60),
    dt_vencimento date,
    id_forma_pagamento numeric(9) references T_RHSTU_FORMA_PAGAMENTO(id_forma_pagamento) not null
);


-- CARLOS


CREATE TABLE T_RHSTU_EMAIL_PACIENTE(
    id_email numeric(9) primary key,
    id_paciente numeric(9) not null,
    ds_email varchar(100) not null,
    tp_email varchar(20) not null,
    st_email char(1) not null check(st_email in ('i', 'a')),

    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente)
);


CREATE TABLE T_RHSTU_TELEFONE_PACIENTE(
    id_paciente numeric(9),
    id_telefone numeric(9),
    nr_ddi numeric(3) not null,
    nr_ddd numeric(3) not null,
    nr_telefone numeric(10) not null,
    tp_telefone varchar(20) not null,
    st_telefone char(1) not null check(st_telefone in ('i', 'a')),

    primary key(id_paciente, id_telefone),
    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente)
);


CREATE TABLE T_RHSTU_PLANO_SAUDE(
    id_plano_saude numeric(5) primary key NOT NULL,
    ds_razao_social varchar(70) not null,
    nm_fantasia_plano_saude varchar(80),
    ds_plano_saude varchar(100) not null,
    nr_cnpj numeric(14) not null,
    nm_contato varchar(30),
    ds_telefone varchar(30),
    dt_inicio date not null,
    dt_fim date
);
 
CREATE TABLE T_RHSTU_PACIENTE_PLANO_SAUDE(
    id_paciente_ps numeric(10) primary key,
    id_paciente numeric(9) not null ,
    id_plano_saude numeric(5) not null,
    nr_carteira_ps numeric(15),       
    dt_inicio date not null,
    dt_fim date,

    FOREIGN KEY (id_paciente) REFERENCES T_RHSTU_PACIENTE(id_paciente),
    FOREIGN KEY (id_plano_saude) REFERENCES T_RHSTU_PLANO_SAUDE(id_plano_saude)
);










-- INSERTs


INSERT INTO T_RHSTU_AUTENTICA VALUES (1, 'login1', 'senhaLogin1', 'a');
INSERT INTO T_RHSTU_AUTENTICA VALUES (2, 'login2', 'senhaLogin2', 'a');


INSERT INTO T_RHSTU_TIPO_CONTATO VALUES(1,'telefone', DATE '2024-04-22', DATE '2024-04-22');
INSERT INTO T_RHSTU_TIPO_CONTATO VALUES(2,'email', DATE '2024-04-22', DATE '2024-04-22');


INSERT INTO T_RHSTU_PACIENTE VALUES(1,'pedro',123456789012,123456789, DATE '2024-04-22','M','Ensino médio completo', 'solteiro', 'O-', 1.77, 64, 1);
INSERT INTO T_RHSTU_PACIENTE VALUES(2,'cadu',12908341,213412, DATE '2024-04-22','M','Ensino médio completo', 'casado', 'O-', 1.87, 66, 2);


INSERT INTO T_RHSTU_FUNCIONARIO VALUES (1, 'Joelma', 'f', 'formada', DATE '2024-04-22', 1);
INSERT INTO T_RHSTU_FUNCIONARIO VALUES (2, 'Jorge', 'm', 'formado', DATE '2024-04-22', 2);


INSERT INTO T_RHSTU_UNID_HOSPITALAR (id_unid_hospitalar, razao_social, dt_cadastro, st_unid_hospitalar, ds_ponto_referencia)
VALUES (1, 'Hospital do Cavalo', DATE '2018-09-22', 'i','Próximo ao estábulo');
INSERT INTO T_RHSTU_UNID_HOSPITALAR (id_unid_hospitalar, razao_social, dt_cadastro, st_unid_hospitalar, ds_ponto_referencia)
VALUES (2, 'Hospital Total War Warhammer III', DATE '2022-02-17', 'a', 'Proximo aos Impérios Imortais');
 
 
INSERT INTO T_RHSTU_CONSULTA (id_consulta, dt_hr_consulta, tp_unidade, id_paciente, id_unid_hospitalar)
VALUES (1, DATE '2024-04-25', 'Consulta', 1, 1);
INSERT INTO T_RHSTU_CONSULTA (id_consulta, dt_hr_consulta, tp_unidade, id_paciente, id_unid_hospitalar)
VALUES (2, DATE '2024-04-26', 'Exame', 2, 2);
 
 
INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato, nr_telefone)
VALUES (1, 1, 1, 'Skarbrand', 123456789);
INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato, nr_telefone)
VALUES (2, 2, 2, 'Kairos', 987654321);
 
 
INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, ds_cidade, dt_inicio)
VALUES (1, 1, 'Hexoatl', DATE '2023-01-02');
INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, ds_cidade, dt_inicio)
VALUES (2, 2, 'Lhamia', DATE '2020-07-03');


INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagamento,vl_total,st_forma_pagamento,id_consulta) VALUES (1,12,'i',1);
INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagamento,vl_total,st_forma_pagamento,id_consulta) VALUES (2,50,'a',2);


INSERT INTO T_RHSTU_FORMA_CONVENIO VALUES (1,1,1,DATE '2024-04-25',DATE '2024-04-25',1);
INSERT INTO T_RHSTU_FORMA_CONVENIO VALUES (2,2,2,DATE '2024-04-25',DATE '2024-04-25',2);


INSERT INTO T_RHSTU_FORMA_PIX(id_forma_pix,nr_transacao,dt_transacao,tp_chave,id_forma_pagamento) 
VALUES (1,1,DATE '2024-04-25','CPF',1);
INSERT INTO T_RHSTU_FORMA_PIX(id_forma_pix,nr_transacao,dt_transacao,tp_chave,id_forma_pagamento) 
VALUES (2,2,DATE '2024-04-25','RG',2);


INSERT INTO T_RHSTU_FORMA_CARTAO(id_forma_cartao,nr_cartao,nr_transacao,dt_transacao,tp_bandeira,dt_vencimento, id_forma_pagamento) 
VALUES(1,1,1,DATE '2024-04-25','opa',DATE '2024-04-25',1);
INSERT INTO T_RHSTU_FORMA_CARTAO(id_forma_cartao,nr_cartao,nr_transacao,dt_transacao,tp_bandeira,dt_vencimento, id_forma_pagamento) 
VALUES(2,2,2,DATE '2024-04-25','opa',DATE '2024-04-25',2);


INSERT INTO T_RHSTU_EMAIL_PACIENTE VALUES (1, 1, 'outlook', 'outlook', 'a');
INSERT INTO T_RHSTU_EMAIL_PACIENTE VALUES (2, 2, 'gmail', 'gmail', 'a');


INSERT INTO T_RHSTU_TELEFONE_PACIENTE VALUES (1,1, 55, 11, 940028922, 'celular', 'a');
INSERT INTO T_RHSTU_TELEFONE_PACIENTE VALUES (2,2, 55, 11, 12345678, 'fixo', 'i');


INSERT INTO T_RHSTU_PLANO_SAUDE VALUES (1, 'saude', 'amil', 'um dos bons', 123455678910, 'um muito maluco', 'fixo se pa', DATE '2024-04-25', DATE '2024-04-25');
INSERT INTO T_RHSTU_PLANO_SAUDE VALUES (2, 'saude', 'NotreDame', 'um dos marromeno eu acho', 10987654321, 'um muito doido >:D', 'celular se pa', DATE '2024-04-25', DATE '2024-04-25');


INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE VALUES (1, 1, 1, 22233344410, DATE '2024-04-25', DATE '2024-04-25');
INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE VALUES (2, 2, 2, 10444333222, DATE '2024-04-25', DATE '2024-04-25');








-- SELECTs

SELECT * FROM T_RHSTU_AUTENTICA;

SELECT * FROM T_RHSTU_TIPO_CONTATO;

SELECT * FROM T_RHSTU_PACIENTE;

SELECT * FROM T_RHSTU_FUNCIONARIO;

SELECT * FROM T_RHSTU_UNID_HOSPITALAR;

SELECT * FROM T_RHSTU_CONSULTA;

SELECT * FROM T_RHSTU_CONTATO_PACIENTE;

SELECT * FROM T_RHSTU_ENDERECO_PACIENTE;

SELECT * FROM T_RHSTU_FORMA_PAGAMENTO;

SELECT * FROM T_RHSTU_FORMA_CONVENIO;

SELECT * FROM T_RHSTU_FORMA_PIX;

SELECT * FROM T_RHSTU_FORMA_CARTAO;

SELECT * FROM T_RHSTU_EMAIL_PACIENTE;

SELECT * FROM T_RHSTU_TELEFONE_PACIENTE;

SELECT * FROM T_RHSTU_PLANO_SAUDE;

SELECT * FROM T_RHSTU_PACIENTE_PLANO_SAUDE;







-- Uma Atualização Simples para a Tabela T_RHSTU_ENDERECO_PACIENTE utilizando WHERE;
UPDATE T_RHSTU_ENDERECO_PACIENTE SET ds_cidade='Araraquara' WHERE id_endereco = 1;


-- Uma Atualização Simples para a Tabela T_RHSTU_TELEFONE_PACIENTE utilizando WHERE;
UPDATE T_RHSTU_TELEFONE_PACIENTE SET nr_ddi= 33 WHERE id_telefone = 1;


-- Duas Consulta Simples utilizando o WHERE (tabela à escolha do grupo)
SELECT * FROM T_RHSTU_PACIENTE WHERE id_paciente = 1;

SELECT * FROM T_RHSTU_FUNCIONARIO WHERE id_funcionario = 1;









-- DELETEs


-- 1
DELETE FROM T_RHSTU_PACIENTE_PLANO_SAUDE WHERE id_paciente_ps = 2;

-- 2
DELETE FROM T_RHSTU_TELEFONE_PACIENTE WHERE id_paciente = 2;

-- 3
DELETE FROM T_RHSTU_PLANO_SAUDE WHERE id_plano_saude = 2;

-- 4
DELETE FROM T_RHSTU_EMAIL_PACIENTE WHERE id_email = 2;

-- 5
DELETE FROM T_RHSTU_FORMA_CARTAO WHERE id_forma_cartao = 2;

-- 6
DELETE FROM T_RHSTU_FORMA_PIX WHERE id_forma_pix = 2;

-- 7
DELETE FROM T_RHSTU_FORMA_CONVENIO WHERE id_forma_convenio = 2; 

-- 8
DELETE FROM T_RHSTU_FORMA_PAGAMENTO WHERE id_forma_pagamento = 2;

-- 9
DELETE FROM T_RHSTU_ENDERECO_PACIENTE WHERE id_endereco = 2;

-- 10
DELETE FROM T_RHSTU_CONTATO_PACIENTE WHERE id_contato = 2;

-- 11
DELETE FROM T_RHSTU_CONSULTA WHERE id_consulta = 2;

-- 12
DELETE FROM T_RHSTU_UNID_HOSPITALAR WHERE id_unid_hospitalar = 2;

-- 13
DELETE FROM T_RHSTU_FUNCIONARIO WHERE id_funcionario = 2;

-- 14
DELETE FROM T_RHSTU_PACIENTE WHERE id_paciente = 2;

-- 15
DELETE FROM T_RHSTU_TIPO_CONTATO WHERE id_tipo_contato = 2;

-- 16
DELETE FROM T_RHSTU_AUTENTICA WHERE id_autentica = 2;







-- INNER JOIN

SELECT C.*, U.razao_social, P.nm_contato, E.ds_cidade
FROM T_RHSTU_CONSULTA C
INNER JOIN T_RHSTU_UNID_HOSPITALAR U ON C.id_unid_hospitalar = U.id_unid_hospitalar
INNER JOIN T_RHSTU_CONTATO_PACIENTE P ON C.id_paciente = P.id_paciente
INNER JOIN T_RHSTU_ENDERECO_PACIENTE E ON C.id_paciente = E.id_paciente;
 
SELECT P.*, C.tp_unidade, E.ds_cidade, U.razao_social
FROM T_RHSTU_PACIENTE P
INNER JOIN T_RHSTU_CONSULTA C ON P.id_paciente = C.id_paciente
INNER JOIN T_RHSTU_ENDERECO_PACIENTE E ON P.id_paciente = E.id_paciente
INNER JOIN T_RHSTU_UNID_HOSPITALAR U ON C.id_unid_hospitalar = U.id_unid_hospitalar;




