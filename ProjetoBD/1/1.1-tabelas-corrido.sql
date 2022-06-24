DROP TABLE evento_reposicao;
DROP TABLE responsavel_por;
DROP TABLE retalhista;
DROP TABLE planograma;
DROP TABLE prateleira;
DROP TABLE instalada_em;
DROP TABLE ponto_de_retalho;
DROP TABLE IVM;
DROP TABLE tem_categoria;
DROP TABLE produto;
DROP TABLE tem_outra;
DROP TABLE super_categoria;
DROP TABLE categoria_simples;
DROP TABLE categoria;

--
-- 
CREATE TABLE categoria (
    nome VARCHAR(255) NOT NULL,
    PRIMARY KEY(nome));
--
-- 
CREATE TABLE categoria_simples (
    nome VARCHAR(255) NOT NULL, 
    PRIMARY KEY(nome),
    FOREIGN KEY(nome) REFERENCES categoria(nome));

--
--
CREATE TABLE super_categoria (
    nome VARCHAR(255) NOT NULL,
    PRIMARY KEY(nome),
    FOREIGN KEY(nome) REFERENCES categoria(nome));
--
-- 
CREATE TABLE tem_outra (
    super_categoria VARCHAR(255) NOT NULL,
    categoria VARCHAR(255) NOT NULL, -- CHECK (super_categoria != categoria)
    UNIQUE(super_categoria, categoria), -- satisfaz RI-RE5 ?e RI-RE4?
    PRIMARY KEY(categoria),
    FOREIGN KEY(super_categoria) REFERENCES super_categoria(nome),
    FOREIGN KEY(categoria) REFERENCES categoria(nome));
--
--
CREATE TABLE produto (
    ean NUMERIC(13) NOT NULL, 
    cat VARCHAR(255) NOT NULL,
    descr VARCHAR(255) NOT NULL,
    PRIMARY KEY(ean),
    FOREIGN KEY(cat) REFERENCES categoria(nome));
--
--
CREATE TABLE tem_categoria (
    ean NUMERIC(13) NOT NULL, -- CHECK(ean IN produto),
    nome VARCHAR(255),
    PRIMARY KEY(ean,nome),
    FOREIGN KEY(ean) REFERENCES produto(ean),
    FOREIGN KEY(nome) REFERENCES categoria(nome));
--
--
CREATE TABLE IVM (
    num_serie SERIAL NOT NULL,
    fabricante VARCHAR(255) NOT NULL,
    PRIMARY KEY(num_serie, fabricante));
--
--
CREATE TABLE ponto_de_retalho (
    nome VARCHAR(255) NOT NULL,
    distrito VARCHAR(255) NOT NULL,
    concelho VARCHAR(255) NOT NULL,
    PRIMARY KEY(nome));
--
--
CREATE TABLE instalada_em (
    num_serie SERIAL NOT NULL,
    fabricante VARCHAR(255) NOT NULL,
    local VARCHAR(255) NOT NULL,
    UNIQUE(num_serie, fabricante),
    PRIMARY KEY(num_serie, fabricante),
    FOREIGN KEY(local) REFERENCES ponto_de_retalho(nome));
--
--
CREATE TABLE prateleira (
    nro INTEGER NOT NULL,
    num_serie SERIAL NOT NULL,
    fabricante VARCHAR(255),
    altura FLOAT NOT NULL, 
    nome VARCHAR(255) NOT NULL,
    PRIMARY KEY(nro, num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante) REFERENCES IVM(num_serie, fabricante),
    FOREIGN KEY(nome) REFERENCES categoria(nome)); 
--
--
CREATE TABLE planograma (
    ean NUMERIC(13) NOT NULL,
    nro INTEGER, /* NOT NULL? */
    num_serie SERIAL NOT NULL,
    fabricante VARCHAR(255),
    faces INTEGER NOT NULL,
    unidades INTEGER NOT NULL,
    loc VARCHAR(255) NOT NULL,
    PRIMARY KEY(ean, nro, num_serie, fabricante),
    FOREIGN KEY(ean) REFERENCES produto(ean), 
    FOREIGN KEY(nro, num_serie, fabricante) REFERENCES prateleira(nro, num_serie, fabricante));
--
--
CREATE TABLE retalhista (
    tin SERIAL,
    name VARCHAR(255),
    UNIQUE(name), -- RI-RE7
    PRIMARY KEY (tin));
--
--
CREATE TABLE responsavel_por (
    nome_cat VARCHAR(255) NOT NULL,
    tin  SERIAL NOT NULL,
    num_serie SERIAL NOT NULL,
    fabricante VARCHAR(255) NOT NULL,
    PRIMARY KEY(num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante) REFERENCES IVM(num_serie, fabricante),
    FOREIGN KEY(tin) REFERENCES retalhista(tin),
    FOREIGN KEY(nome_cat) REFERENCES categoria(nome));
--
--
CREATE TABLE evento_reposicao (
    ean NUMERIC(13) NOT NULL,
    nro INTEGER NOT NULL,
    num_serie SERIAL NOT NULL,
    fabricante VARCHAR(255) NOT NULL,
    instante DATE NOT NULL,
    unidades INTEGER NOT NULL,
    tin SERIAL NOT NULL,
    PRIMARY KEY(ean, nro, num_serie, fabricante, instante),
    FOREIGN KEY(ean, nro, num_serie, fabricante) REFERENCES planograma(ean, nro, num_serie, fabricante), 
    FOREIGN KEY(tin) REFERENCES retalhista(tin));
