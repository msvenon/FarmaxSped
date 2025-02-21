/* 
   Parâmetro: EMPRESA-IND-NAT-PJ
   
   0 - Sociedade empresária geral
   1 - Sociedade Cooperativa
   2 - Entidade sujeita ao PIS/Pasep exclusivamente com base  na folha de salários
   3 - Geral participante de SCP
   4 - Sociedade Cooperativa Participante SCP
   5 - Sociedade em Conta de Particpante

*/

INSERT INTO CONFIG (CHAVE_CONFIG, SECAO_CAMPO, CONTEUDO, FILIAL) VALUES
                   ((SELECT COALESCE(MAX(CHAVE_CONFIG),0) + 1 FROM CONFIG), 'EMPRESA-IND-NAT-PJ', '0', :P_FILIAL);
COMMIT WORK;

/*
    COD_INC_TRIB (EMPRESA-COD-INC-TRIB)
    
       1 - Escrituração de operações com incidencia exclusivamente no regime não cumulativo
       2 - Escrituração de operações com incidencia exclusivamente no regime cumulativo
       3 - Escrituração de operações com incidencia nos regimes cumulativo e não cumulativo

    IND_APRO_CRED (EMPRESA-IND-APRO-CRED)
    
       0 - Método de apropriação direta
       1 - Método de rateio proporcional(Receita Bruta)

    COD_TIPO_CONT (EMPRESA-COD-TIPO-CONT)
    
       1 - Apuração da Contribuição Exclusivamente a Alíquota Básica
       2 - Apuração da Contribuição a Alíquotas Específicas (Diferenciadas e/ou por Unidade de Medida de Produto)

    IND_REG_CUM (EMPRESA-IND-REG-CUM)
    
       1 – Regime de Caixa – Escrituração consolidada (Registro F500)
       2 – Regime de Competência - Escrituração consolidada (Registro F550)
       9 – Regime de Competência - Escrituração detalhada, com base nos registros dos Blocos “A”, “C”, “D” e “F”.
*/

INSERT INTO CONFIG (CHAVE_CONFIG, SECAO_CAMPO, CONTEUDO, FILIAL) VALUES
                   ((SELECT COALESCE(MAX(CHAVE_CONFIG),0) + 1 FROM CONFIG), 'EMPRESA-COD-INC-TRIB', '3', :P_FILIAL);
COMMIT WORK;

INSERT INTO CONFIG (CHAVE_CONFIG, SECAO_CAMPO, CONTEUDO, FILIAL) VALUES
                   ((SELECT COALESCE(MAX(CHAVE_CONFIG),0) + 1 FROM CONFIG), 'EMPRESA-IND-APRO-CRED', '1', :P_FILIAL);
COMMIT WORK;

INSERT INTO CONFIG (CHAVE_CONFIG, SECAO_CAMPO, CONTEUDO, FILIAL) VALUES
                   ((SELECT COALESCE(MAX(CHAVE_CONFIG),0) + 1 FROM CONFIG), 'EMPRESA-COD-TIPO-CONT', '1', :P_FILIAL);
COMMIT WORK;

INSERT INTO CONFIG (CHAVE_CONFIG, SECAO_CAMPO, CONTEUDO, FILIAL) VALUES
                   ((SELECT COALESCE(MAX(CHAVE_CONFIG),0) + 1 FROM CONFIG), 'EMPRESA-IND-REG-CUM', '9', :P_FILIAL);
COMMIT WORK;