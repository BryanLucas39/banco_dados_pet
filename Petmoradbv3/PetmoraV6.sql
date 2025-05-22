-- Criando o banco de dados da Pet House
CREATE DATABASE dbpethouse;
USE dbpethouse;

-- Tabela de Usuários
CREATE TABLE usuario (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_usuario ENUM("Cuidador","Tutor","Cuidador/Tutor"),
    Experiencia TEXT,
    Senha_usuario VARCHAR(100) NOT NULL,
    Email_usuario VARCHAR(100) NOT NULL UNIQUE,
    Foto_usuario TEXT NOT NULL,
    N_contato VARCHAR(20)
);

CREATE TABLE contato(
	ID_Contato INT AUTO_INCREMENT PRIMARY KEY,
	ID_Usuario INT,
    Nome VARCHAR(50),
	Telefone VARCHAR(20),
	Celular VARCHAR (20),
    Tipo_usuario VARCHAR(50)
);

-- Tabela de Dados Pessoais
CREATE TABLE dados_pessoais (
    ID_DadosPessoais INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Nome VARCHAR(50) NOT NULL,
    Sobrenome VARCHAR(50) NOT NULL,
    CPF VARCHAR(14) UNIQUE,
    Rg VARCHAR(14) UNIQUE,
    Data_Nascimento DATE NOT NULL,
    Genero VARCHAR(1),
    Celular VARCHAR(20),
    Data_Cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    Consentimento ENUM("sim","não")
);

-- Tabela de Endereços
CREATE TABLE enderecos (
    ID_Endereco INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    CEP VARCHAR(9) NOT NULL,
    Logradouro VARCHAR(100) NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Complemento VARCHAR(50),
    Bairro VARCHAR(50) NOT NULL,
    Cidade VARCHAR(50) NOT NULL,
    Estado CHAR(2) NOT NULL
);

-- Tabela de Pets
CREATE TABLE pet (
	ID_Pet INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Nome VARCHAR(100) NOT NULL,
    Sexo ENUM("Macho","Femea"),
    Idade VARCHAR(18) NOT NULL,
    Especie VARCHAR(50) NOT NULL,
    Raca VARCHAR(50) NOT NULL,
	Porte ENUM("Pequeno","Medio","Grande"),
    Castrado ENUM("Sim","Não"),
    Restricoes VARCHAR(500) NOT NULL,
    Comportamento VARCHAR(500),
    Preferencias VARCHAR(500),
    Foto_Pet TEXT
 
);

-- Tabela de Serviços
CREATE  TABLE servicos(

ID_Servico INT AUTO_INCREMENT PRIMARY KEY,
Cuidador INT,
Tipo_servico VARCHAR(50) NOT NULL,
Preco_servico DECIMAL (6,2) NOT NULL,
qtd_pets INT NOT NULL,
Porte_pet ENUM("Pequeno","Medio","Grande"),
Situacao ENUM("Concluido","Pendente","Cancelado","--")

);

CREATE TABLE agendamento(

ID_agendamento INT AUTO_INCREMENT PRIMARY KEY,
ID_Servico INT,
ID_Endereco INT,
Cuidador INT,
Tutor INT,
ID_Pet INT,
ID_Recibo INT,
data_inicio DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
data_conclusao DATE NOT NULL,
Periodo_entrada ENUM("Diurno","Noturno"),
Periodo_saida ENUM("Diurno","Noturno"),
Instru_Pet VARCHAR(500),
Itens_Pet VARCHAR(500)

);

 -- Tabela de Recibo
 
 CREATE TABLE recibo(
ID_Recibo INT AUTO_INCREMENT PRIMARY KEY,
Detalhes TEXT,
Cuidador INT,
Tutor INT,
ID_Pet INT,
ID_Servico INT,
Data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP

);


-- Criaçao de relacionamentos das tabelas


ALTER TABLE dados_pessoais
ADD CONSTRAINT `fk_ddp_pk_usuario`
FOREIGN KEY (`ID_Usuario`)
REFERENCES usuario(`ID_Usuario`);

ALTER TABLE contato
ADD CONSTRAINT `fk_contato_pk_usuario`
FOREIGN KEY (`ID_Usuario`)
REFERENCES usuario (`ID_Usuario`);

ALTER TABLE enderecos
ADD CONSTRAINT `fk_endereco_pk_usuario`
FOREIGN KEY (`ID_Usuario`)
REFERENCES usuario(`ID_Usuario`);

ALTER TABLE pet
ADD CONSTRAINT `fk_pet_pk_usuario`
FOREIGN KEY (`ID_Usuario`)
REFERENCES usuario(`ID_Usuario`);

-- ALTER TABLES DA TABELA Recibo

ALTER TABLE recibo
ADD CONSTRAINT `fk_recibo_pk_usuarioc`
FOREIGN KEY (`Cuidador`)
REFERENCES usuario (`ID_Usuario`);

ALTER TABLE recibo
ADD CONSTRAINT `fk_recibo_pk_pet`
FOREIGN KEY (`ID_Pet`)
REFERENCES pet (`ID_Pet`);

ALTER TABLE agendamento
ADD CONSTRAINT `fk_agendamento_pk_servico`
FOREIGN KEY (`ID_Servico`)
REFERENCES servicos(`ID_Servico`);


ALTER TABLE agendamento
ADD CONSTRAINT `fk_agendamento_pk_usuarioc`
FOREIGN KEY (`Cuidador`)
REFERENCES usuario(`ID_Usuario`);


ALTER TABLE agendamento
ADD CONSTRAINT `fk_agendamento_pk_usuariot`
FOREIGN KEY (`Tutor`)
REFERENCES usuario (`ID_Usuario`);


ALTER TABLE agendamento
ADD CONSTRAINT `fk_agendamento_pk_recibo`
FOREIGN KEY (`ID_Recibo`)
REFERENCES recibo (`ID_Recibo`);



