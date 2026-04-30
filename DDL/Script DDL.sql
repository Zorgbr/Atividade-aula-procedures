create database aula_trabalho

create table produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    estoque INT NOT NULL
);

create table vendas (
    id SERIAL PRIMARY KEY,
    produto_id INT REFERENCES produtos(id),
    quantidade INT NOT NULL,
    valor_total NUMERIC(10, 2),
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
