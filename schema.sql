-- ============================================================
--  Conecta Solidário – Schema do Banco de Dados
--  Como usar no phpMyAdmin (XAMPP):
--    1. Acesse http://localhost/phpmyadmin
--    2. Clique em "Importar" no menu superior
--    3. Selecione este arquivo e clique em "Executar"
--
--  Como usar no MySQL Workbench:
--    1. Abra uma nova aba de query
--    2. Cole o conteúdo deste arquivo e execute (Ctrl+Shift+Enter)

DROP DATABASE IF EXISTS projeto_ong;
CREATE DATABASE projeto_ong;
USE projeto_ong;

CREATE TABLE ong (
	id_ong INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE admin (
	id_admin INT AUTO_INCREMENT PRIMARY KEY,
    id_ong INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR (50) NOT NULL,
    data_criacao DATE,
    FOREIGN KEY (id_ong) REFERENCES ong(id_ong)
    );
    
CREATE TABLE FUNCIONARIO (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    id_ong INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    data_admissao DATE,
    FOREIGN KEY (id_ong) REFERENCES ong(id_ong)
);

CREATE TABLE voluntario (
	id_voluntario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(15),
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    interesse VARCHAR(50),
    observacoes VARCHAR(255),
    data_cadastro DATE
);

CREATE TABLE categoria_campanha (
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE campanha (
	id_campanha INT AUTO_INCREMENT PRIMARY KEY,
    id_ong INT NOT NULL,
    id_categoria INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao VARCHAR(255),
    imagem_url VARCHAR(255),
    data_inicio DATE NOT NULL,
    data_fim DATE,
    meta_arrecadacao FLOAT,
    valor_arrecadado FLOAT,
    status_campanha VARCHAR(20),
    FOREIGN KEY (id_ong) REFERENCES ong(id_ong),
    FOREIGN KEY (id_categoria) REFERENCES categoria_campanha(id_categoria)
);

CREATE TABLE participacao_campanha (
	id_voluntario INT NOT NULL,
    id_campanha INT NOT NULL,
    funcao VARCHAR(50),
    horas_trabalhadas INT,
    PRIMARY KEY (id_voluntario, id_campanha),
    FOREIGN KEY (id_voluntario) REFERENCES voluntario(id_voluntario),
    foreign key (id_campanha) REFERENCES campanha(id_campanha)
);

CREATE TABLE beneficiario(
	id_beneficiario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(15),
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_cadastro DATE
);
    
CREATE TABLE beneficiario_campanha(
	id_beneficiario INT NOT NULL,
    id_campanha INT NOT NULL,
    PRIMARY KEY (id_beneficiario, id_campanha),
    FOREIGN KEY (id_beneficiario) REFERENCES beneficiario(id_beneficiario),
    FOREIGN KEY (id_campanha) REFERENCES campanha(id_campanha)
);

CREATE TABLE doador(
	id_doador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    tipo_doador VARCHAR(20)
);

CREATE TABLE tipo_doacao (
	id_tipo_doacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE doacao (
	id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    id_doador INT NOT NULL,
    id_tipo_doacao INT NOT NULL,
    id_campanha INT NOT NULL,
    valor_doacao FLOAT,
    descricao_doacao VARCHAR(255),
    data_doacao DATE NOT NULL,
    FOREIGN KEY (id_doador) REFERENCES doador(id_doador),
    FOREIGN KEY (id_tipo_doacao) REFERENCES tipo_doacao(id_tipo_doacao),
    FOREIGN KEY (id_campanha) REFERENCES campanha(id_campanha)
);

INSERT INTO ong (nome, cnpj, endereco, telefone, email) 
VALUES ('Conecta Solidário', '12.345.678/0001-99', 'Rua da Faculdade, 123', '11999999999', 'contato@ong.com');

INSERT INTO admin (id_ong, nome, email, senha, data_criacao) 
VALUES (1, 'Admin Aluno', 'admin@ong.com', '123456', '2024-05-20');

INSERT INTO categoria_campanha (nome_categoria) 
VALUES ('Alimentos'), ('Roupas'), ('Educação');

INSERT INTO tipo_doacao (descricao) 
VALUES ('Dinheiro'), ('Cesta Básica'), ('Agasalho');

INSERT INTO campanha (id_ong, id_categoria, titulo, descricao, imagem_url, data_inicio, data_fim, meta_arrecadacao, valor_arrecadado, status_campanha) 
VALUES (1, 1, 'Fome Zero na Comunidade', 'Arrecadação de alimentos', 'linkdaimagem.jpg', '2024-06-01', '2024-06-30', 5000.00, 1500.00, 'Ativa');

INSERT INTO voluntario (nome, cpf, email, telefone, interesse, observacoes, data_cadastro) 
VALUES ('João Estudante', '111.222.333-44', 'joao@email.com', '11988888888', 'Distribuição', 'Disponível à tarde', '2024-05-20');
