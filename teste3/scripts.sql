-- Active: 1743188572650@@127.0.0.1@3306@teste3
USE teste3;

-- Tabela para Demonstrações Contábeis
CREATE TABLE demonstracoes_contabeis_2023(
    DATA DATE,
    REG_ANS VARCHAR(6),
    CD_CONTA_CONTABIL VARCHAR(9),
    DESCRICAO VARCHAR(200),
    VL_SALDO_INICIAL DECIMAL(10,2),
    VL_SALDO_FINAL DECIMAL(10,2)
);

CREATE TABLE demonstracoes_contabeis_2024(
    DATA DATE,
    REG_ANS VARCHAR(6),
    CD_CONTA_CONTABIL VARCHAR(9),
    DESCRICAO VARCHAR(200),
    VL_SALDO_INICIAL DECIMAL(10,2),
    VL_SALDO_FINAL DECIMAL(10,2)
);

-- Tabela para Operadoras de planos de saúde com registro ativo
CREATE TABLE operadoras_ativas(
    Registro_ANS VARCHAR(6),
    CNPJ VARCHAR(14),
    Razao_Social VARCHAR(140),
    Nome_Fantasia VARCHAR(140),
    Modalidade VARCHAR(40),
    Logradouro VARCHAR(40),
    Numero VARCHAR(20),
    Complemento VARCHAR(40),
    Bairro VARCHAR(30),
    Cidade VARCHAR(30),
    UF VARCHAR(2),
    CEP VARCHAR(8),
    DDD VARCHAR(4),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Endereco_eletronico VARCHAR(255),
    Representante VARCHAR(50),
    Cargo_Representante VARCHAR(40),
    Regiao_de_Comercializacao INT,
    Data_Registro_ANS DATE
);

-- Inserindo dados na tabela de demonstrações contábeis
-- 2023
LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2023\\1T2023.csv'
INTO TABLE demonstracoes_contabeis_2023
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2023\\2T2023.csv'
INTO TABLE demonstracoes_contabeis_2023
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2023\\3T2023.csv'
INTO TABLE demonstracoes_contabeis_2023
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2023\\4T2023.csv'
INTO TABLE demonstracoes_contabeis_2023
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 2024
LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2024\\1T2024.csv'
INTO TABLE demonstracoes_contabeis_2024
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2024\\2T2024.csv'
INTO TABLE demonstracoes_contabeis_2024
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2024\\3T2024.csv'
INTO TABLE demonstracoes_contabeis_2024
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Contab\\2024\\4T2024.csv'
INTO TABLE demonstracoes_contabeis_2024
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Inserindo dados na tabela de operadoras de planos de saúde com registro ativo
LOAD DATA LOCAL INFILE 'C:\\Users\\giueg\\OneDrive\\Documentos\\Workspace\\Teste_IntuitiveCare\\teste3\\Operadoreas\\Relatorio_cadop.csv'
INTO TABLE operadoras_ativas
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Querys
-- 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre:
SELECT
    `Razao_Social`,
    #`DESCRICAO`
    SUM(`VL_SALDO_FINAL`) AS total_despesas
FROM operadoras_ativas op 
LEFT JOIN demonstracoes_contabeis_2024 d24 ON op.`Registro_ANS` = d24.`REG_ANS`
WHERE `DESCRICAO` LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
AND d24.`DATA` BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY `Razao_Social`
ORDER BY total_despesas DESC
LIMIT 10;

-- 10 operadoras com maiores despesas na categoria "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último ano
SELECT
    `Razao_Social`,
    #`DESCRICAO`
    SUM(`VL_SALDO_FINAL`) AS total_despesas
FROM operadoras_ativas op 
LEFT JOIN demonstracoes_contabeis_2024 d24 ON op.`Registro_ANS` = d24.`REG_ANS`
WHERE `DESCRICAO` LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
GROUP BY `Razao_Social`
ORDER BY total_despesas DESC
LIMIT 10;
