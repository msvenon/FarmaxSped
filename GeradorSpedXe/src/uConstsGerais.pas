unit uConstsGerais;

interface

const
   _INICIO_SPED_PIS_COFINS = '********** INICIO DO ARQUIVO SPED PIS COFINS **********';
   _INICIO_SPED_FISCAL = '********** INICIO DO ARQUIVO SPED FISCAL **********';

   _ARQUIVO_CONFIG_INI_ECF = 'ConfigECF.ini';
   _MSG_POUCO_PAPEL = 'Atenção! Pouco Papel...';

   _LIM_DOC = 5; // 0 - ignora - Nr. Limite = NFCE, NFE Sai, NFE Ent, Reduc Z

   _SPED_FIS_BLOCO_0 = 'Sped Fiscal - Bloco 0';
   _SPED_FIS_BLOCO_1 = 'Sped Fiscal - Bloco 1';
   _SPED_FIS_BLOCO_C = 'Sped Fiscal - Bloco C';
   _SPED_FIS_BLOCO_E = 'Sped Fiscal - Bloco E';
   _SPED_FIS_BLOCO_K = 'Sped Fiscal - Bloco K';
   _SPED_FIS_BLOCO_H = 'Sped Fiscal - Bloco H - Inventário Físico';

   _SPED_PIS_COF_BLOCO_0 = 'Sped Pis Cofins - Bloco 0';
   _SPED_PIS_COF_BLOCO_F = 'Sped Pis Cofins - Bloco F';
   _SPED_PIS_COF_BLOCO_C = 'Sped Pis Cofins - Bloco C';

   aSemana: array[1..7] of string = ('Domingo',
                                     'Segunda-feira',
                                     'Terça-feira',
                                     'Quarta-feira',
                                     'Quinta-feira',
                                     'Sexta-feira',
                                     'Sábado');
   // **   SQL  ** //

   _SQL_DESP_AGUA_ERNERGIA_GAS_C500 = 'SELECT CX.CHAVE_CAIXA, ' + sLineBreak +
                                      '       CX.DATA                  AS DT_E_S, ' + sLineBreak +
                                      '       CX.VALOR                 AS VL_DOC, ' + sLineBreak +
                                      '       CX.COD_MOD_DOC_FISC      AS COD_MOD,' + sLineBreak +
                                      '       CX.NUM_DOC_FISC          AS NUM_DOC,' + sLineBreak +
                                      '       CX.SERIE_DOC_FISC        AS SER ,   ' + sLineBreak +
                                      '       CX.SUB_SERIE_DOC_FISC    AS SUB,    ' + sLineBreak +
                                      '       CX.COD_FORN_SERV         AS COD_FORN,' + sLineBreak +
                                      '       CX.COD_CONS_ENERG        AS COD_CONS,' + sLineBreak +
                                      '       CX.DT_EMISS_DOC_FISC     AS DT_DOC,' + sLineBreak +
                                      '       CX.VR_DESCONTO           AS VL_DESC,' + sLineBreak +
                                      '       CX.VR_FORNECIMENTO       AS VL_FORN,' + sLineBreak +
                                      '       CX.VR_SERV_NT            AS VL_SERV_NT,' + sLineBreak +
                                      '       CX.VR_COB_TERC           AS VL_TERC,' + sLineBreak +
                                      '       CX.VR_DESP_ACES          AS VL_DA,' + sLineBreak +
                                      '       CX.VR_BC_ICMS            AS VL_BC_ICMS,' + sLineBreak +
                                      '       CX.VR_ICMS               AS VL_ICMS,' + sLineBreak +
                                      '       CX.VR_BC_ICMS_ST         AS VL_BC_ICMS_ST,' + sLineBreak +
                                      '       CX.VR_ICMS_ST            AS VL_ICMS_ST,' + sLineBreak +
                                      '       CX.VR_PIS                AS VL_PIS,' + sLineBreak +
                                      '       CX.VR_COFINS             AS VL_COFINS,' + sLineBreak +
                                      '       CX.TIPO_LIG_ENERGIA      AS TP_LIGACAO,' + sLineBreak +
                                      '       CX.COD_GRUPO_TENSAO      AS COD_GRUPO_TENSAO, ' + sLineBreak +
                                      '       CX.CFOP                  AS CFOP, ' + sLineBreak +
                                      '       CX.ALIQ_ICMS             AS ALIQ_ICMS ' + sLineBreak +
                                      'FROM   CAIXA CX ' + sLineBreak +
                                      'WHERE  CX.FILIAL = :P_FILIAL ' + sLineBreak +
                                      '   AND CX.COD_MOD_DOC_FISC IN (''06'', ''28'',''29'') ' + sLineBreak +
                                      '   AND CX.DATA BETWEEN :P_DATA_INI AND :P_DATA_FIM';

implementation

end.
