/* 
   Par�metro: EMPRESA-IND-NAT-PJ
   
   0 - Sociedade empres�ria geral
   1 - Sociedade Cooperativa
   2 - Entidade sujeita ao PIS/Pasep exclusivamente com base  na folha de sal�rios
   3 - Geral participante de SCP
   4 - Sociedade Cooperativa Participante SCP
   5 - Sociedade em Conta de Particpante

*/

INSERT INTO CONFIG (CHAVE_CONFIG, SECAO_CAMPO, CONTEUDO, FILIAL) VALUES
                   ((SELECT COALESCE(MAX(CHAVE_CONFIG),0) + 1 FROM CONFIG), 'EMPRESA-IND-NAT-PJ', '0', :P_FILIAL);
COMMIT WORK;

/*
    COD_INC_TRIB (EMPRESA-COD-INC-TRIB)
    
       1 - Escritura��o de opera��es com incidencia exclusivamente no regime n�o cumulativo
       2 - Escritura��o de opera��es com incidencia exclusivamente no regime cumulativo
       3 - Escritura��o de opera��es com incidencia nos regimes cumulativo e n�o cumulativo

    IND_APRO_CRED (EMPRESA-IND-APRO-CRED)
    
       0 - M�todo de apropria��o direta
       1 - M�todo de rateio proporcional(Receita Bruta)

    COD_TIPO_CONT (EMPRESA-COD-TIPO-CONT)
    
       1 - Apura��o da Contribui��o Exclusivamente a Al�quota B�sica
       2 - Apura��o da Contribui��o a Al�quotas Espec�ficas (Diferenciadas e/ou por Unidade de Medida de Produto)

    IND_REG_CUM (EMPRESA-IND-REG-CUM)
    
       1 � Regime de Caixa � Escritura��o consolidada (Registro F500)
       2 � Regime de Compet�ncia - Escritura��o consolidada (Registro F550)
       9 � Regime de Compet�ncia - Escritura��o detalhada, com base nos registros dos Blocos �A�, �C�, �D� e �F�.
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