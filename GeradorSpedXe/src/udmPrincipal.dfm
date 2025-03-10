object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 787
  Width = 1191
  object qryConsultaAux1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = connBaseDados
    Left = 40
    Top = 72
  end
  object cdsConsultaAux1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsultaAux1'
    Left = 40
    Top = 168
  end
  object dspConsultaAux1: TDataSetProvider
    DataSet = qryConsultaAux1
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 40
    Top = 120
  end
  object FdConsulta: TFDQuery
    Left = 32
    Top = 240
  end
  object DsFDConsulta: TDataSource
    DataSet = FdConsulta
    Left = 32
    Top = 288
  end
  object FDEmpresa: TFDQuery
    SQL.Strings = (
      ''
      'SELECT * FROM CONFIG WHERE SECAO_CAMPO LIKE '#39'EMPRESA%'#39' ')
    Left = 104
    Top = 240
  end
  object FDContador: TFDQuery
    SQL.Strings = (
      'SELECT * FROM CONFIG WHERE SECAO_CAMPO LIKE '#39'%CONTADOR%'#39' ')
    Left = 168
    Top = 240
  end
  object DsEmpresa: TDataSource
    DataSet = FDEmpresa
    Left = 104
    Top = 288
  end
  object DsContador: TDataSource
    DataSet = FDContador
    Left = 168
    Top = 288
  end
  object connBaseDados: TSQLConnection
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'Database=database.fdb'
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver260.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver260.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    Left = 40
    Top = 24
  end
  object FDConnFarmax: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    Left = 608
    Top = 8
  end
  object FDConnSped: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    Left = 128
    Top = 8
  end
  object FDConsEmpresa: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM EMPRESA')
    Left = 232
    Top = 56
  end
  object dspConsEmpresa: TDataSetProvider
    DataSet = FDConsEmpresa
    Left = 232
    Top = 104
  end
  object cdsConsEmpresa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsEmpresa'
    Left = 232
    Top = 149
    object cdsConsEmpresaCD_FILIAL: TIntegerField
      FieldName = 'CD_FILIAL'
      Required = True
    end
    object cdsConsEmpresaRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
    object cdsConsEmpresaFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 50
    end
    object cdsConsEmpresaENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 50
    end
    object cdsConsEmpresaCGC: TStringField
      FieldName = 'CGC'
      Size = 15
    end
    object cdsConsEmpresaCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 30
    end
    object cdsConsEmpresaBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object cdsConsEmpresaNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object cdsConsEmpresaUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsConsEmpresaTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 10
    end
    object cdsConsEmpresaCODIGO_CIDADE: TStringField
      FieldName = 'CODIGO_CIDADE'
      Size = 10
    end
    object cdsConsEmpresaCOD_INC_TRIB: TStringField
      FieldName = 'COD_INC_TRIB'
      Size = 1
    end
    object cdsConsEmpresaTIPO_CONT_APURADA: TStringField
      FieldName = 'TIPO_CONT_APURADA'
      Size = 1
    end
    object cdsConsEmpresaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object cdsConsEmpresaMETODO_APROPRIACAO: TStringField
      FieldName = 'METODO_APROPRIACAO'
      Size = 1
    end
    object cdsConsEmpresaIND_NAT_PJ: TStringField
      FieldName = 'IND_NAT_PJ'
      Size = 1
    end
    object cdsConsEmpresaIND_REG_CUMULATIVO: TStringField
      FieldName = 'IND_REG_CUMULATIVO'
      Size = 1
    end
    object cdsConsEmpresaINSC_ESTADUAL: TStringField
      FieldName = 'INSC_ESTADUAL'
      Size = 15
    end
    object cdsConsEmpresaTIPO_ATIV: TStringField
      FieldName = 'TIPO_ATIV'
      Size = 2
    end
    object cdsConsEmpresaPERFIL: TStringField
      FieldName = 'PERFIL'
      Size = 2
    end
    object cdsConsEmpresaPERIODO_IPI: TStringField
      FieldName = 'PERIODO_IPI'
      Size = 10
    end
    object cdsConsEmpresaLOCAL_ARQUIVOS: TStringField
      FieldName = 'LOCAL_ARQUIVOS'
      Size = 100
    end
    object cdsConsEmpresaINSC_MUNICIPAL: TStringField
      FieldName = 'INSC_MUNICIPAL'
      Size = 10
    end
    object cdsConsEmpresaCEP: TStringField
      FieldName = 'CEP'
      Size = 12
    end
    object cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO: TStringField
      FieldName = 'ENQUADRAMENTO_TRIBUTARIO'
      Size = 2
    end
    object cdsConsEmpresaGERARARQUIVODIRETOFARMAX: TIntegerField
      FieldName = 'GERARARQUIVODIRETOFARMAX'
    end
  end
  object FDConsDadosContador: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM CONTADOR WHERE CD_FILIAL=:CD_FILIAL')
    Left = 321
    Top = 104
    ParamData = <
      item
        Position = 1
        Name = 'CD_FILIAL'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object dspConsDadosContadior: TDataSetProvider
    DataSet = FDConsDadosContador
    Left = 320
    Top = 148
  end
  object cdsConsDadosContador: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CD_FILIAL'
        ParamType = ptInput
      end>
    ProviderName = 'dspConsDadosContadior'
    Left = 320
    Top = 183
    object cdsConsDadosContadorCD_FILIAL: TIntegerField
      FieldName = 'CD_FILIAL'
      Required = True
    end
    object cdsConsDadosContadorNOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
    object cdsConsDadosContadorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 50
    end
    object cdsConsDadosContadorBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 30
    end
    object cdsConsDadosContadorCEP: TStringField
      FieldName = 'CEP'
      Size = 15
    end
    object cdsConsDadosContadorCOD_CIDADE: TStringField
      FieldName = 'COD_CIDADE'
      Size = 10
    end
    object cdsConsDadosContadorCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 50
    end
    object cdsConsDadosContadorCPF: TStringField
      FieldName = 'CPF'
      Size = 15
    end
    object cdsConsDadosContadorCRC: TStringField
      FieldName = 'CRC'
      Size = 10
    end
    object cdsConsDadosContadorEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object cdsConsDadosContadorFAX: TStringField
      FieldName = 'FAX'
      Size = 10
    end
    object cdsConsDadosContadorTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 10
    end
    object cdsConsDadosContadorNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object cdsConsDadosContadorCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 15
    end
  end
  object FDConsParametros: TFDQuery
    Connection = FDConnFarmax
    SQL.Strings = (
      'select'
      '      parametros.cd_filial,'
      '      parametros.razao,'
      '      parametros.nomefantasia,'
      '      parametros.cgc,'
      '      parametros.endereco,'
      '      parametros.cidade,'
      '      parametros.bairro,'
      '      parametros.numero,'
      '      parametros.cep,'
      '      parametros.uf,'
      '      parametros.fone,'
      '      parametros.cd_municipio,'
      '      parametros.email,'
      '      parametros.perfil,'
      '      parametros.inscricao,'
      '      parametros.contadornome,'
      '      parametros.contadorcpf,'
      '      parametros.contadorcrc,'
      '      parametros.contadorcnpj,'
      '      parametros.contadorendereco,'
      '      parametros.contadornumero,'
      '      parametros.contadorcomplemento,'
      '      parametros.contadorbairro,'
      '      parametros.contadorcep,'
      '      parametros.contadortelefone,'
      '      parametros.contadorfax,'
      '      parametros.contadoremail,'
      '      parametros.contadorcd_municipio,'
      '      parametros.crt,'
      '      parametros.insc_munic as insc_municipal,'
      '      enquadramentotributario'
      'from  parametros')
    Left = 504
    Top = 72
  end
  object dspConsParametros: TDataSetProvider
    DataSet = FDConsParametros
    Left = 504
    Top = 128
  end
  object cdsConsParametros: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsParametros'
    Left = 504
    Top = 184
    object cdsConsParametrosCD_FILIAL: TFloatField
      FieldName = 'CD_FILIAL'
      Required = True
    end
    object cdsConsParametrosRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 40
    end
    object cdsConsParametrosNOMEFANTASIA: TStringField
      FieldName = 'NOMEFANTASIA'
      Size = 30
    end
    object cdsConsParametrosCGC: TStringField
      FieldName = 'CGC'
      Size = 18
    end
    object cdsConsParametrosENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 40
    end
    object cdsConsParametrosCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 35
    end
    object cdsConsParametrosBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object cdsConsParametrosNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object cdsConsParametrosUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsConsParametrosFONE: TStringField
      FieldName = 'FONE'
      Size = 30
    end
    object cdsConsParametrosCD_MUNICIPIO: TStringField
      FieldName = 'CD_MUNICIPIO'
      Size = 7
    end
    object cdsConsParametrosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object cdsConsParametrosPERFIL: TStringField
      FieldName = 'PERFIL'
      Size = 1
    end
    object cdsConsParametrosINSCRICAO: TStringField
      FieldName = 'INSCRICAO'
      Size = 15
    end
    object cdsConsParametrosCONTADORNOME: TStringField
      FieldName = 'CONTADORNOME'
      Size = 100
    end
    object cdsConsParametrosCONTADORCPF: TStringField
      FieldName = 'CONTADORCPF'
      Size = 11
    end
    object cdsConsParametrosCONTADORCRC: TStringField
      FieldName = 'CONTADORCRC'
    end
    object cdsConsParametrosCONTADORCNPJ: TStringField
      FieldName = 'CONTADORCNPJ'
      Size = 14
    end
    object cdsConsParametrosCONTADORENDERECO: TStringField
      FieldName = 'CONTADORENDERECO'
      Size = 100
    end
    object cdsConsParametrosCONTADORNUMERO: TStringField
      FieldName = 'CONTADORNUMERO'
      Size = 10
    end
    object cdsConsParametrosCONTADORCOMPLEMENTO: TStringField
      FieldName = 'CONTADORCOMPLEMENTO'
      Size = 100
    end
    object cdsConsParametrosCONTADORBAIRRO: TStringField
      FieldName = 'CONTADORBAIRRO'
      Size = 100
    end
    object cdsConsParametrosCONTADORCEP: TStringField
      FieldName = 'CONTADORCEP'
      Size = 8
    end
    object cdsConsParametrosCONTADORTELEFONE: TStringField
      FieldName = 'CONTADORTELEFONE'
      Size = 10
    end
    object cdsConsParametrosCONTADORFAX: TStringField
      FieldName = 'CONTADORFAX'
      Size = 10
    end
    object cdsConsParametrosCONTADOREMAIL: TStringField
      FieldName = 'CONTADOREMAIL'
      Size = 100
    end
    object cdsConsParametrosCONTADORCD_MUNICIPIO: TStringField
      FieldName = 'CONTADORCD_MUNICIPIO'
      Size = 10
    end
    object cdsConsParametrosCRT: TStringField
      FieldName = 'CRT'
      Size = 1
    end
    object cdsConsParametrosINSC_MUNICIPAL: TStringField
      FieldName = 'INSC_MUNICIPAL'
      Size = 15
    end
    object cdsConsParametrosCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsConsParametrosENQUADRAMENTOTRIBUTARIO: TStringField
      FieldName = 'ENQUADRAMENTOTRIBUTARIO'
      Size = 1
    end
  end
  object FdBd: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'select * from bd where id=1')
    Left = 392
    Top = 88
  end
  object dspBd: TDataSetProvider
    DataSet = FdBd
    Left = 392
    Top = 136
  end
  object cdsBD: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspBd'
    Left = 392
    Top = 184
    object cdsBDSERVIDORSPED: TStringField
      FieldName = 'SERVIDORSPED'
      Size = 100
    end
    object cdsBDBDSPED: TStringField
      FieldName = 'BDSPED'
      Size = 100
    end
    object cdsBDBD_FARMAX: TStringField
      FieldName = 'BD_FARMAX'
      Size = 100
    end
    object cdsBDSERVIDOR_FARMAX: TStringField
      FieldName = 'SERVIDOR_FARMAX'
      Size = 100
    end
    object cdsBDID: TIntegerField
      FieldName = 'ID'
    end
    object cdsBDPORTAFB_FAR: TStringField
      FieldName = 'PORTAFB_FAR'
      Size = 5
    end
    object cdsBDPORTAFB_SPED: TStringField
      FieldName = 'PORTAFB_SPED'
      Size = 5
    end
  end
  object FdQueryAuxiliar: TFDQuery
    Connection = FDConnSped
    Left = 232
  end
  object FDQBuscarNfce: TFDQuery
    Connection = FDConnFarmax
    SQL.Strings = (
      
        ' SELECT CHAVE,ARQUIVO,DATA FROM  NFCE WHERE DATA BETWEEN :DATA_I' +
        'NI AND :DATA_FIN'
      ' AND STATUS ='#39'E'#39
      ' UNION ALL'
      
        ' SELECT CHAVE,ARQUIVO,DATA FROM  NFCECOPIA WHERE DATA BETWEEN :D' +
        'ATA_INI AND :DATA_FIN'
      ' AND STATUS='#39'E'#39)
    Left = 53
    Top = 425
    ParamData = <
      item
        Name = 'DATA_INI'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_FIN'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object DSpBuscarNfce: TDataSetProvider
    DataSet = FDQBuscarNfce
    Left = 53
    Top = 481
  end
  object CDSBuscarNfce: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'DATA_INI'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_FIN'
        ParamType = ptInput
      end>
    ProviderName = 'DSpBuscarNfce'
    Left = 57
    Top = 537
    object CDSBuscarNfceCHAVE: TStringField
      FieldName = 'CHAVE'
      Size = 100
    end
    object CDSBuscarNfceARQUIVO: TMemoField
      FieldName = 'ARQUIVO'
      BlobType = ftMemo
    end
    object CDSBuscarNfceDATA: TDateField
      FieldName = 'DATA'
    end
  end
  object FDQBuscaXmlNfe: TFDQuery
    Connection = FDConnFarmax
    SQL.Strings = (
      'SELECT'
      '      nFES.CHAVE,'
      '      NFES.ARQUIVO'
      'FROM  NFES'
      'WHERE NFES.chave CONTAINING :CHAVENFE'
      '')
    Left = 154
    Top = 425
    ParamData = <
      item
        Position = 1
        Name = 'CHAVENFE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object DspBuscaXmlNfe: TDataSetProvider
    DataSet = FDQBuscaXmlNfe
    Left = 154
    Top = 481
  end
  object cdsBuscaXmlNfe: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'CHAVENFE'
        ParamType = ptInput
      end>
    ProviderName = 'DspBuscaXmlNfe'
    Left = 154
    Top = 537
    object cdsBuscaXmlNfeCHAVE: TStringField
      FieldName = 'CHAVE'
      Size = 100
    end
    object cdsBuscaXmlNfeARQUIVO: TMemoField
      FieldName = 'ARQUIVO'
      BlobType = ftMemo
    end
  end
  object FDQBuscaNfePeriodo: TFDQuery
    Connection = FDConnFarmax
    SQL.Strings = (
      'SELECT'
      '       COMPRAS.CHAVENFE'
      ' FROM  COMPRAS'
      ' WHERE COMPRAS.DT_ENTRADA   BETWEEN :DATA_INI AND :DATA_FIN'
      ' AND CHAVENFE IS NOT NULL'
      ' AND CHAVENFE <> '#39#39
      ' AND COMPRAS.STATUS='#39'C'#39)
    Left = 261
    Top = 426
    ParamData = <
      item
        Position = 1
        Name = 'DATA_INI'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'DATA_FIN'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object DspBuscaNfeperiodo: TDataSetProvider
    DataSet = FDQBuscaNfePeriodo
    Left = 261
    Top = 473
  end
  object cdsBuscaNfePeriodo: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'DATA_INI'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_FIN'
        ParamType = ptInput
      end>
    ProviderName = 'DspBuscaNfeperiodo'
    Left = 261
    Top = 524
    object cdsBuscaNfePeriodoCHAVENFE: TStringField
      FieldName = 'CHAVENFE'
      Size = 100
    end
  end
  object FDBuscaDanfe: TFDQuery
    Filtered = True
    Connection = FDConnFarmax
    SQL.Strings = (
      'SELECT'
      '     NFECABECALHO.CHAVE,'
      '     NFECABECALHO.ARQUIVO'
      'FROM NFECABECALHO WHERE NFECABECALHO.STATUS ='#39'E'#39
      'AND  NFECABECALHO.ARQUIVO <> '#39#39
      'AND  IDEDATAEMISSAO BETWEEN :DATA_INI AND :DATA_FIN')
    Left = 373
    Top = 428
    ParamData = <
      item
        Position = 1
        Name = 'DATA_INI'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'DATA_FIN'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dspBuscaDanfe: TDataSetProvider
    DataSet = FDBuscaDanfe
    Left = 373
    Top = 476
  end
  object cdsbuscaDanfe: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'DATA_INI'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_FIN'
        ParamType = ptInput
      end>
    ProviderName = 'dspBuscaDanfe'
    Left = 373
    Top = 523
    object cdsbuscaDanfeCHAVE: TStringField
      FieldName = 'CHAVE'
      Size = 1000
    end
    object cdsbuscaDanfeARQUIVO: TMemoField
      FieldName = 'ARQUIVO'
      BlobType = ftMemo
    end
  end
  object FDQBuscaNfe: TFDQuery
    Connection = FDConnFarmax
    SQL.Strings = (
      ''
      'SELECT'
      '      DISTRIBUIDORES.CNPJ AS CNPJ_FORNECEDOR,'
      '      DISTRIBUIDORES.RAZAO AS RAZAO_SOCIAL_FORNECEDOR,'
      '      COMPRAS.CHAVENFE AS CHAVE_NF,'
      '      COMPRAS.DT_ENTRADA AS DATA_HORA_LOCAL ,'
      '      COMPRAS.CD_COMPRAS AS NUMERO_OPERACAO,'
      '      COMPRAS.DT_EMISSAO AS DATA_HORA_EMISSAO,     '
      '      COMPRAS.NOTA_FISCAL AS NUMERO_NF,'
      '      COMPRAS.SERIE_NOTA_FISCAL AS SERIE_NF,'
      '      COMPRAS.VL_TOTALPRODUTOS AS TOTAL_PRODUTOS,'
      '      COMPRAS.TOTAL_NOTA AS TOTAL_NF,'
      '      COMPRAS.CD_FILIAL'
      ' FROM COMPRAS'
      
        ' LEFT OUTER JOIN DISTRIBUIDORES ON  COMPRAS.CD_DISTRIBUIDOR = DI' +
        'STRIBUIDORES.CD_DISTRIBUIDOR'
      ' WHERE COMPRAS.CD_COMPRAS =:CD_COMPRAS'
      '   AND COMPRAS.STATUS ='#39'C'#39
      '   AND CD_FILIAL=:CD_FILIAL'
      ' '
      '')
    Left = 469
    Top = 428
    ParamData = <
      item
        Position = 1
        Name = 'CD_COMPRAS'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CD_FILIAL'
        DataType = ftFloat
        Precision = 16
        ParamType = ptInput
      end>
  end
  object DspBuscaNfe: TDataSetProvider
    DataSet = FDQBuscaNfe
    Left = 469
    Top = 484
  end
  object cdsBuscaNfe: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CD_COMPRAS'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Precision = 16
        Name = 'CD_FILIAL'
        ParamType = ptInput
      end>
    ProviderName = 'DspBuscaNfe'
    Left = 469
    Top = 540
    object cdsBuscaNfeCNPJ_FORNECEDOR: TStringField
      FieldName = 'CNPJ_FORNECEDOR'
      Origin = 'CNPJ_FORNECEDOR'
      Size = 19
    end
    object cdsBuscaNfeRAZAO_SOCIAL_FORNECEDOR: TStringField
      FieldName = 'RAZAO_SOCIAL_FORNECEDOR'
      Origin = 'RAZAO_SOCIAL_FORNECEDOR'
      Size = 50
    end
    object cdsBuscaNfeCHAVE_NF: TStringField
      FieldName = 'CHAVE_NF'
      Origin = 'CHAVE_NF'
      Size = 100
    end
    object cdsBuscaNfeDATA_HORA_LOCAL: TDateField
      FieldName = 'DATA_HORA_LOCAL'
      Origin = 'DATA_HORA_LOCAL'
    end
    object cdsBuscaNfeNUMERO_OPERACAO: TFloatField
      FieldName = 'NUMERO_OPERACAO'
      Origin = 'NUMERO_OPERACAO'
      Required = True
    end
    object cdsBuscaNfeDATA_HORA_EMISSAO: TDateField
      FieldName = 'DATA_HORA_EMISSAO'
      Origin = 'DATA_HORA_EMISSAO'
    end
    object cdsBuscaNfeNUMERO_NF: TStringField
      FieldName = 'NUMERO_NF'
      Origin = 'NUMERO_NF'
      Size = 10
    end
    object cdsBuscaNfeSERIE_NF: TStringField
      FieldName = 'SERIE_NF'
      Origin = 'SERIE_NF'
      Size = 3
    end
    object cdsBuscaNfeTOTAL_PRODUTOS: TFloatField
      FieldName = 'TOTAL_PRODUTOS'
      Origin = 'TOTAL_PRODUTOS'
    end
    object cdsBuscaNfeTOTAL_NF: TFloatField
      FieldName = 'TOTAL_NF'
      Origin = 'TOTAL_NF'
    end
    object cdsBuscaNfeCD_FILIAL: TFloatField
      FieldName = 'CD_FILIAL'
      Required = True
    end
  end
  object FDQBuscaNfeMatriz: TFDQuery
    Connection = FDConnFarmax
    SQL.Strings = (
      'select'
      '      distribuidores.cnpj as cnpj_fornecedor,'
      '      distribuidores.razao as razao_social_fornecedor,'
      '      compras.chavenfe as chave_nf,'
      '      compras.dt_entrada as data_hora_local ,'
      '      compras.cd_compras as numero_operacao,'
      '      compras.dt_emissao as data_hora_emissao,     '
      '      compras.nota_fiscal as numero_nf,'
      '      compras.serie_nota_fiscal as serie_nf,'
      '      compras.vl_totalprodutos as total_produtos,'
      '      compras.total_nota as total_nf'
      ' from compras'
      
        ' left outer join distribuidores on  compras.cd_distribuidor = di' +
        'stribuidores.cd_distribuidor'
      ' where compras.cd_compras =:cd_compras'
      '   and compras.status ='#39'C'#39
      ''
      '   '
      ' '
      '')
    Left = 567
    Top = 429
    ParamData = <
      item
        Position = 1
        Name = 'CD_COMPRAS'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DspBuscaNfeMatriz: TDataSetProvider
    DataSet = FDQBuscaNfeMatriz
    Left = 567
    Top = 485
  end
  object cdsBuscaNfeMatriz: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CD_COMPRAS'
        ParamType = ptInput
      end>
    ProviderName = 'DspBuscaNfeMatriz'
    Left = 567
    Top = 541
    object StringField1: TStringField
      FieldName = 'CNPJ_FORNECEDOR'
      Origin = 'CNPJ_FORNECEDOR'
      Size = 19
    end
    object StringField2: TStringField
      FieldName = 'RAZAO_SOCIAL_FORNECEDOR'
      Origin = 'RAZAO_SOCIAL_FORNECEDOR'
      Size = 50
    end
    object StringField3: TStringField
      FieldName = 'CHAVE_NF'
      Origin = 'CHAVE_NF'
      Size = 100
    end
    object DateField1: TDateField
      FieldName = 'DATA_HORA_LOCAL'
      Origin = 'DATA_HORA_LOCAL'
    end
    object FloatField1: TFloatField
      FieldName = 'NUMERO_OPERACAO'
      Origin = 'NUMERO_OPERACAO'
      Required = True
    end
    object DateField2: TDateField
      FieldName = 'DATA_HORA_EMISSAO'
      Origin = 'DATA_HORA_EMISSAO'
    end
    object StringField4: TStringField
      FieldName = 'NUMERO_NF'
      Origin = 'NUMERO_NF'
      Size = 10
    end
    object StringField5: TStringField
      FieldName = 'SERIE_NF'
      Origin = 'SERIE_NF'
      Size = 3
    end
    object FloatField2: TFloatField
      FieldName = 'TOTAL_PRODUTOS'
      Origin = 'TOTAL_PRODUTOS'
    end
    object FloatField3: TFloatField
      FieldName = 'TOTAL_NF'
      Origin = 'TOTAL_NF'
    end
  end
  object FDMConsultaNfe: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 229
    Top = 232
    object FDMConsultaNfechave: TStringField
      FieldName = 'chave'
      Size = 80
    end
    object FDMConsultaNfemodelo: TStringField
      FieldName = 'modelo'
      Size = 2
    end
    object FDMConsultaNfecreatedDate: TStringField
      FieldName = 'createdDate'
      Size = 30
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 720
    Top = 8
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 512
    Top = 8
  end
  object dsConsEmpresa: TDataSource
    DataSet = cdsConsEmpresa
    Left = 232
    Top = 184
  end
  object FDSpedM400: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      '       CST,'
      '     SUM(VL_REC) AS VL_REC'
      'FROM TEMP_SPEDC_M410'
      'GROUP BY CST')
    Left = 709
    Top = 73
  end
  object dsSPED_M400: TDataSetProvider
    DataSet = FDSpedM400
    Left = 709
    Top = 121
  end
  object cdsSPEDM400: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsSPED_M400'
    Left = 709
    Top = 169
    object cdsSPEDM400CST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object cdsSPEDM400VL_REC: TFloatField
      FieldName = 'VL_REC'
      ReadOnly = True
    end
  end
  object FDSpedM410: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      '   NAT_REC,'
      '   SUM(VL_REC) AS VL_REC'
      'FROM TEMP_SPEDC_M410'
      'WHERE CST = :CST'
      'GROUP BY NAT_REC')
    Left = 797
    Top = 73
    ParamData = <
      item
        Position = 1
        Name = 'CST'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object dspSpedM410: TDataSetProvider
    DataSet = FDSpedM410
    Left = 797
    Top = 121
  end
  object cdsSPEDM410: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'CST'
        ParamType = ptInput
      end>
    ProviderName = 'dspSpedM410'
    Left = 797
    Top = 169
    object cdsSPEDM410NAT_REC: TStringField
      FieldName = 'NAT_REC'
      Size = 10
    end
    object cdsSPEDM410VL_REC: TFloatField
      FieldName = 'VL_REC'
      ReadOnly = True
    end
  end
  object FDTEMP_SPEDC_M410: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      '      TEMP_SPEDC_M410.CST,'
      '      TEMP_SPEDC_M410.NAT_REC,'
      '      TEMP_SPEDC_M410.VL_REC '
      ' FROM TEMP_SPEDC_M410')
    Left = 613
    Top = 73
  end
  object dspTEMP_SPEDC_M410: TDataSetProvider
    DataSet = FDTEMP_SPEDC_M410
    Left = 613
    Top = 121
  end
  object cdsTEMP_SPEDC_M410: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTEMP_SPEDC_M410'
    Left = 613
    Top = 169
    object cdsTEMP_SPEDC_M410CST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object cdsTEMP_SPEDC_M410NAT_REC: TStringField
      FieldName = 'NAT_REC'
      Size = 10
    end
    object cdsTEMP_SPEDC_M410VL_REC: TFloatField
      FieldName = 'VL_REC'
    end
  end
  object FDSPEDM210: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      '     TEMP_SPEDC_M210.COD_CONTA,'
      '     TEMP_SPEDC_M210.VL_REC_BRT,'
      '     TEMP_SPEDC_M210.VL_BASE_CALCULO '
      ''
      ' FROM TEMP_SPEDC_M210')
    Left = 613
    Top = 217
  end
  object dspSPEDM210: TDataSetProvider
    DataSet = FDSPEDM210
    Left = 613
    Top = 259
  end
  object CdsSPEDM210: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSPEDM210'
    Left = 613
    Top = 304
    object CdsSPEDM210COD_CONTA: TStringField
      FieldName = 'COD_CONTA'
      Size = 2
    end
    object CdsSPEDM210VL_REC_BRT: TFloatField
      FieldName = 'VL_REC_BRT'
    end
    object CdsSPEDM210VL_BASE_CALCULO: TFloatField
      FieldName = 'VL_BASE_CALCULO'
    end
  end
  object FDSPEDM200: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      ' CAST(SUM(VL_REC_BRT) AS DOUBLE PRECISION) AS VL_REC_BRT,'
      
        ' CAST(SUM(VL_BASE_CALCULO)AS DOUBLE PRECISION)  AS VL_BASE_CALCU' +
        'LO'
      'FROM'
      ' TEMP_SPEDC_M210')
    Left = 701
    Top = 217
  end
  object dspSPEDM200: TDataSetProvider
    DataSet = FDSPEDM200
    Left = 701
    Top = 265
  end
  object CdsSPEDM200: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSPEDM200'
    Left = 701
    Top = 305
    object CdsSPEDM200VL_REC_BRT: TFloatField
      FieldName = 'VL_REC_BRT'
      ReadOnly = True
    end
    object CdsSPEDM200VL_BASE_CALCULO: TFloatField
      FieldName = 'VL_BASE_CALCULO'
      ReadOnly = True
    end
  end
  object FDSPEDM800: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      '     CST,'
      '     SUM(VL_REC)  AS VL_REC '
      'FROM TEMP_SPEDC_M810'
      'GROUP BY CST')
    Left = 796
    Top = 225
  end
  object dspSPEDM800: TDataSetProvider
    DataSet = FDSPEDM800
    Left = 796
    Top = 267
  end
  object cdsSPEDM800: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSPEDM800'
    Left = 796
    Top = 312
    object cdsSPEDM800CST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object cdsSPEDM800VL_REC: TFloatField
      FieldName = 'VL_REC'
      ReadOnly = True
    end
  end
  object FDSPEDM810: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      '     NAT_REC,'
      '     SUM(VL_REC) AS VL_REC'
      'FROM TEMP_SPEDC_M810'
      'WHERE CST = :CST'
      'GROUP BY NAT_REC')
    Left = 917
    Top = 81
    ParamData = <
      item
        Position = 1
        Name = 'CST'
        DataType = ftString
        ParamType = ptInput
        Size = 3
        Value = Null
      end>
  end
  object dspSPEDM810: TDataSetProvider
    DataSet = FDSPEDM810
    Left = 917
    Top = 123
  end
  object cdsSPEDM810: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'CST'
        ParamType = ptInput
        Size = 3
      end>
    ProviderName = 'dspSPEDM810'
    Left = 917
    Top = 168
    object cdsSPEDM810NAT_REC: TStringField
      FieldName = 'NAT_REC'
      Origin = 'NAT_REC'
      Size = 10
    end
    object cdsSPEDM810VL_REC: TFMTBCDField
      FieldName = 'VL_REC'
      Origin = 'VL_REC'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
  end
  object FDCadSPEDM800: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT *'
      'FROM TEMP_SPEDC_M810')
    Left = 1054
    Top = 79
  end
  object dspCadSPEDM800: TDataSetProvider
    DataSet = FDCadSPEDM800
    Left = 1054
    Top = 121
  end
  object cdsCadSPEDM800: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCadSPEDM800'
    Left = 1054
    Top = 166
    object cdsCadSPEDM800CST: TStringField
      FieldName = 'CST'
      Origin = 'CST'
      Size = 3
    end
    object cdsCadSPEDM800NAT_REC: TStringField
      FieldName = 'NAT_REC'
      Origin = 'NAT_REC'
      Size = 10
    end
    object cdsCadSPEDM800VL_REC: TFMTBCDField
      FieldName = 'VL_REC'
      Origin = 'VL_REC'
      Precision = 18
      Size = 2
    end
  end
  object FDTemCstPIsCof: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM TEMP_CST_PIS_COF')
    Left = 502
    Top = 238
  end
  object dspTemCstPIsCof: TDataSetProvider
    DataSet = FDTemCstPIsCof
    Left = 502
    Top = 280
  end
  object cdsTemCstPIsCof: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTemCstPIsCof'
    Left = 502
    Top = 325
    object cdsTemCstPIsCofCFOP: TStringField
      FieldName = 'CFOP'
      Size = 5
    end
    object cdsTemCstPIsCofCST_PIS: TStringField
      FieldName = 'CST_PIS'
      Size = 3
    end
    object cdsTemCstPIsCofBASEPIS: TFloatField
      FieldName = 'BASEPIS'
    end
    object cdsTemCstPIsCofALIQPIS: TFloatField
      FieldName = 'ALIQPIS'
    end
    object cdsTemCstPIsCofVALORPIS: TFloatField
      FieldName = 'VALORPIS'
    end
    object cdsTemCstPIsCofVALORBASEPISCOF: TFloatField
      FieldName = 'VALORBASEPISCOF'
    end
    object cdsTemCstPIsCofBASECOF: TFloatField
      FieldName = 'BASECOF'
    end
    object cdsTemCstPIsCofALIQCOF: TFloatField
      FieldName = 'ALIQCOF'
    end
    object cdsTemCstPIsCofVALORCOF: TFloatField
      FieldName = 'VALORCOF'
    end
    object cdsTemCstPIsCofNCM: TStringField
      FieldName = 'NCM'
      Size = 10
    end
    object cdsTemCstPIsCofVALOR_PROD: TFloatField
      FieldName = 'VALOR_PROD'
    end
    object cdsTemCstPIsCofEAN: TStringField
      FieldName = 'EAN'
      Size = 14
    end
  end
  object FDQuery1: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT'
      ' SUM(VL_REC_BRT) AS VL_REC_BRT,'
      ' SUM(VL_BASE_CALCULO) AS VL_BASE_CALCULO'
      'FROM'
      ' TEMP_SPEDC_M210')
    Left = 1086
    Top = 254
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = FDQuery1
    Left = 1086
    Top = 302
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSPEDM200'
    Left = 1086
    Top = 342
    object FMTBCDField2: TFMTBCDField
      FieldName = 'VL_REC_BRT'
      ReadOnly = True
      Precision = 18
      Size = 2
    end
    object FMTBCDField3: TFMTBCDField
      FieldName = 'VL_BASE_CALCULO'
      ReadOnly = True
      Precision = 18
      Size = 2
    end
  end
  object FDCadProd_tribErrada: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM PROD_TRIB_ERRADA')
    Left = 694
    Top = 446
  end
  object dspCadProd_tribErrada: TDataSetProvider
    DataSet = FDCadProd_tribErrada
    Left = 694
    Top = 488
  end
  object cdsCadProd_tribErrada: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCadProd_tribErrada'
    Left = 694
    Top = 533
    object cdsCadProd_tribErradaCFOP: TStringField
      FieldName = 'CFOP'
      Size = 5
    end
    object cdsCadProd_tribErradaEAN: TStringField
      FieldName = 'EAN'
      Size = 14
    end
    object cdsCadProd_tribErradaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 40
    end
    object cdsCadProd_tribErradaALIQPIS: TFloatField
      FieldName = 'ALIQPIS'
    end
    object cdsCadProd_tribErradaALIQCOF: TFloatField
      FieldName = 'ALIQCOF'
    end
  end
  object FDConsTributacaoErrada: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM PROD_TRIB_ERRADA')
    Left = 336
    Top = 240
  end
  object dspConsTributacaoErrada: TDataSetProvider
    DataSet = FDConsTributacaoErrada
    Left = 336
    Top = 280
  end
  object cdsConsTributacaoErrada: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsTributacaoErrada'
    Left = 336
    Top = 328
    object cdsConsTributacaoErradaCFOP: TStringField
      FieldName = 'CFOP'
      Size = 5
    end
    object cdsConsTributacaoErradaEAN: TStringField
      FieldName = 'EAN'
      Size = 14
    end
    object cdsConsTributacaoErradaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 40
    end
    object cdsConsTributacaoErradaALIQPIS: TFloatField
      FieldName = 'ALIQPIS'
    end
    object cdsConsTributacaoErradaALIQCOF: TFloatField
      FieldName = 'ALIQCOF'
    end
  end
  object FDFTABELAREG_C170: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM FTABELAREG_C170')
    Left = 846
    Top = 446
  end
  object dsPFTABELAREG_C170: TDataSetProvider
    DataSet = FDFTABELAREG_C170
    Left = 846
    Top = 496
  end
  object cdsRegC170: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsPFTABELAREG_C170'
    Left = 846
    Top = 541
    object cdsRegC170NFID: TIntegerField
      FieldName = 'NFID'
      Origin = 'NFID'
    end
    object cdsRegC170NUM_ITEM: TStringField
      FieldName = 'NUM_ITEM'
      Origin = 'NUM_ITEM'
      Size = 3
    end
    object cdsRegC170COD_ITEM: TStringField
      FieldName = 'COD_ITEM'
      Origin = 'COD_ITEM'
      Size = 60
    end
    object cdsRegC170DESCR_COMPL: TStringField
      FieldName = 'DESCR_COMPL'
      Origin = 'DESCR_COMPL'
      Size = 60
    end
    object cdsRegC170QTD: TFloatField
      FieldName = 'QTD'
      Origin = 'QTD'
    end
    object cdsRegC170UNID: TStringField
      FieldName = 'UNID'
      Origin = 'UNID'
      Size = 6
    end
    object cdsRegC170VL_ITEM: TFloatField
      FieldName = 'VL_ITEM'
      Origin = 'VL_ITEM'
    end
    object cdsRegC170VL_DESC: TFloatField
      FieldName = 'VL_DESC'
      Origin = 'VL_DESC'
    end
    object cdsRegC170IND_MOV: TIntegerField
      FieldName = 'IND_MOV'
      Origin = 'IND_MOV'
    end
    object cdsRegC170CST_ICMS: TStringField
      FieldName = 'CST_ICMS'
      Origin = 'CST_ICMS'
      Size = 3
    end
    object cdsRegC170CFOP: TStringField
      FieldName = 'CFOP'
      Origin = 'CFOP'
      Size = 4
    end
    object cdsRegC170COD_NAT: TStringField
      FieldName = 'COD_NAT'
      Origin = 'COD_NAT'
      Size = 10
    end
    object cdsRegC170VL_BC_ICMS: TFloatField
      FieldName = 'VL_BC_ICMS'
      Origin = 'VL_BC_ICMS'
    end
    object cdsRegC170ALIQ_ICMS: TFloatField
      FieldName = 'ALIQ_ICMS'
      Origin = 'ALIQ_ICMS'
    end
    object cdsRegC170VL_ICMS: TFloatField
      FieldName = 'VL_ICMS'
      Origin = 'VL_ICMS'
    end
    object cdsRegC170VL_BC_ICMS_ST: TFloatField
      FieldName = 'VL_BC_ICMS_ST'
      Origin = 'VL_BC_ICMS_ST'
    end
    object cdsRegC170ALIQ_ST: TFloatField
      FieldName = 'ALIQ_ST'
      Origin = 'ALIQ_ST'
    end
    object cdsRegC170VL_ICMS_ST: TFloatField
      FieldName = 'VL_ICMS_ST'
      Origin = 'VL_ICMS_ST'
    end
    object cdsRegC170IND_APUR: TIntegerField
      FieldName = 'IND_APUR'
      Origin = 'IND_APUR'
    end
    object cdsRegC170CST_IPI: TStringField
      FieldName = 'CST_IPI'
      Origin = 'CST_IPI'
      Size = 2
    end
    object cdsRegC170COD_ENQ: TStringField
      FieldName = 'COD_ENQ'
      Origin = 'COD_ENQ'
      Size = 3
    end
    object cdsRegC170VL_BC_IPI: TFloatField
      FieldName = 'VL_BC_IPI'
      Origin = 'VL_BC_IPI'
    end
    object cdsRegC170ALIQ_IPI: TFloatField
      FieldName = 'ALIQ_IPI'
      Origin = 'ALIQ_IPI'
    end
    object cdsRegC170VL_IPI: TFloatField
      FieldName = 'VL_IPI'
      Origin = 'VL_IPI'
    end
    object cdsRegC170CST_PIS: TStringField
      FieldName = 'CST_PIS'
      Origin = 'CST_PIS'
      Size = 2
    end
    object cdsRegC170VL_BC_PIS: TFloatField
      FieldName = 'VL_BC_PIS'
      Origin = 'VL_BC_PIS'
    end
    object cdsRegC170ALIQ_PIS_PERC: TFloatField
      FieldName = 'ALIQ_PIS_PERC'
      Origin = 'ALIQ_PIS_PERC'
    end
    object cdsRegC170QUANT_BC_PIS: TFloatField
      FieldName = 'QUANT_BC_PIS'
      Origin = 'QUANT_BC_PIS'
    end
    object cdsRegC170ALIQ_PIS_R: TFloatField
      FieldName = 'ALIQ_PIS_R'
      Origin = 'ALIQ_PIS_R'
    end
    object cdsRegC170VL_PIS: TFloatField
      FieldName = 'VL_PIS'
      Origin = 'VL_PIS'
    end
    object cdsRegC170CST_COFINS: TStringField
      FieldName = 'CST_COFINS'
      Origin = 'CST_COFINS'
      Size = 2
    end
    object cdsRegC170VL_BC_COFINS: TFloatField
      FieldName = 'VL_BC_COFINS'
      Origin = 'VL_BC_COFINS'
    end
    object cdsRegC170ALIQ_COFINS_PERC: TFloatField
      FieldName = 'ALIQ_COFINS_PERC'
      Origin = 'ALIQ_COFINS_PERC'
    end
    object cdsRegC170QUANT_BC_COFINS: TFloatField
      FieldName = 'QUANT_BC_COFINS'
      Origin = 'QUANT_BC_COFINS'
    end
    object cdsRegC170ALIQ_COFINS_R: TFloatField
      FieldName = 'ALIQ_COFINS_R'
      Origin = 'ALIQ_COFINS_R'
    end
    object cdsRegC170VL_COFINS: TFloatField
      FieldName = 'VL_COFINS'
      Origin = 'VL_COFINS'
    end
    object cdsRegC170COD_CTA: TStringField
      FieldName = 'COD_CTA'
      Origin = 'COD_CTA'
      Size = 10
    end
  end
  object FDFTabelaReg1900: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM  FTABELAREG1900')
    Left = 934
    Top = 454
  end
  object dspFTabelaReg1900: TDataSetProvider
    DataSet = FDFTabelaReg1900
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 934
    Top = 504
  end
  object FTabelaReg1900: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFTabelaReg1900'
    Left = 934
    Top = 549
    object FTabelaReg1900COD_MOD: TStringField
      FieldName = 'COD_MOD'
      Origin = 'COD_MOD'
      Size = 2
    end
    object FTabelaReg1900SER: TStringField
      FieldName = 'SER'
      Origin = 'SER'
      Size = 3
    end
    object FTabelaReg1900SUB_SER: TStringField
      FieldName = 'SUB_SER'
      Origin = 'SUB_SER'
      Size = 5
    end
    object FTabelaReg1900VL_TOT_REC: TFloatField
      FieldName = 'VL_TOT_REC'
      Origin = 'VL_TOT_REC'
    end
    object FTabelaReg1900CST_PIS_COF: TStringField
      FieldName = 'CST_PIS_COF'
      Origin = 'CST_PIS_COF'
      Size = 2
    end
    object FTabelaReg1900CFOP: TStringField
      FieldName = 'CFOP'
      Origin = 'CFOP'
      Size = 4
    end
    object FTabelaReg1900ALIQ_PIS: TFloatField
      FieldName = 'ALIQ_PIS'
      Origin = 'ALIQ_PIS'
    end
    object FTabelaReg1900ALIQ_COF: TFloatField
      FieldName = 'ALIQ_COF'
      Origin = 'ALIQ_COF'
    end
  end
  object FDFTabelaRegC175: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM FTABELAREGC175')
    Left = 1030
    Top = 454
  end
  object dspFTabelaRegC175: TDataSetProvider
    DataSet = FDFTabelaRegC175
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 1030
    Top = 504
  end
  object FTabelaRegC175: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFTabelaRegC175'
    Left = 1030
    Top = 549
    object FTabelaRegC175NFID: TIntegerField
      FieldName = 'NFID'
    end
    object FTabelaRegC175CFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object FTabelaRegC175VL_DESC: TFloatField
      FieldName = 'VL_DESC'
    end
    object FTabelaRegC175VL_OPR: TFloatField
      FieldName = 'VL_OPR'
    end
    object FTabelaRegC175CST_PIS: TStringField
      FieldName = 'CST_PIS'
      Size = 2
    end
    object FTabelaRegC175ALIQ_PIS: TFloatField
      FieldName = 'ALIQ_PIS'
    end
    object FTabelaRegC175VL_PIS: TFloatField
      FieldName = 'VL_PIS'
    end
    object FTabelaRegC175VL_BC_PIS: TFloatField
      FieldName = 'VL_BC_PIS'
    end
    object FTabelaRegC175CST_COFINS: TStringField
      FieldName = 'CST_COFINS'
      Size = 2
    end
    object FTabelaRegC175ALIQ_COFINS: TFloatField
      FieldName = 'ALIQ_COFINS'
    end
    object FTabelaRegC175VL_COFINS: TFloatField
      FieldName = 'VL_COFINS'
    end
    object FTabelaRegC175VL_BC_COFINS: TFloatField
      FieldName = 'VL_BC_COFINS'
    end
    object FTabelaRegC175COD_CTA: TStringField
      FieldName = 'COD_CTA'
      Size = 10
    end
    object FTabelaRegC175INFO_COMPL: TStringField
      FieldName = 'INFO_COMPL'
      Size = 10
    end
  end
  object FDSQL: TFDQuery
    Connection = FDConnSped
    Left = 320
    Top = 8
  end
  object RESTClientTestaUrl: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://farmax'
    Params = <>
    RaiseExceptionOn500 = False
    SynchronizedEvents = False
    Left = 848
    Top = 16
  end
  object RESTReqTestaUrl: TRESTRequest
    Client = RESTClientTestaUrl
    Params = <>
    Response = RESTRespTestaUrl
    SynchronizedEvents = False
    Left = 952
    Top = 16
  end
  object RESTRespTestaUrl: TRESTResponse
    ContentType = 'text/html'
    Left = 1048
    Top = 16
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 760
    Top = 8
  end
  object FDStoredProc: TFDStoredProc
    Connection = FDConnFarmax
    Left = 448
    Top = 56
  end
  object FDConsInventaio: TFDQuery
    Connection = FDConnFarmax
    SQL.Strings = (
      'SELECT'
      '      POSICAOESTOQUEDATA.ID_PRODUTO,'
      '      PRODUTOS.DESCRICAO,'
      '      PRODUTOS.CODIGO_BARRAS_1,'
      '      PRODUTOS_FISCO.NCM,'
      '      POSICAOESTOQUEDATA.CUSTO AS VL_UNIT_ITEM,'
      '      POSICAOESTOQUEDATA.QUANTIDADE,'
      '      POSICAOESTOQUEDATA.VENDA AS VL_ITEM'
      'FROM  POSICAOESTOQUEDATA'
      
        'INNER JOIN PRODUTOS ON POSICAOESTOQUEDATA.ID_PRODUTO = PRODUTOS.' +
        'ID_PRODUTO'
      
        'INNER JOIN PRODUTOS_FISCO ON POSICAOESTOQUEDATA.ID_PRODUTO= PROD' +
        'UTOS_FISCO.ID_PRODUTO'
      'WHERE QUANTIDADE >0'
      'AND DATA =:DATA')
    Left = 912
    Top = 248
    ParamData = <
      item
        Position = 1
        Name = 'DATA'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dspConsInventario: TDataSetProvider
    DataSet = FDConsInventaio
    Left = 912
    Top = 295
  end
  object cdsConsInventario: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'DATA'
        ParamType = ptInput
      end>
    ProviderName = 'dspConsInventario'
    Left = 912
    Top = 336
    object cdsConsInventarioID_PRODUTO: TFloatField
      FieldName = 'ID_PRODUTO'
      Required = True
    end
    object cdsConsInventarioDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ReadOnly = True
      Size = 60
    end
    object cdsConsInventarioVL_UNIT_ITEM: TFloatField
      FieldName = 'VL_UNIT_ITEM'
    end
    object cdsConsInventarioQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsConsInventarioVL_ITEM: TFloatField
      FieldName = 'VL_ITEM'
    end
    object cdsConsInventarioCODIGO_BARRAS_1: TStringField
      FieldName = 'CODIGO_BARRAS_1'
      ReadOnly = True
      Size = 14
    end
    object cdsConsInventarioNCM: TStringField
      FieldName = 'NCM'
      ReadOnly = True
      Size = 10
    end
  end
  object FDQuery: TFDQuery
    Connection = FDConnFarmax
    Left = 392
    Top = 16
  end
  object FDConBlocoH: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM BLOCO_H')
    Left = 992
    Top = 248
    ParamData = <
      item
        Position = 1
        Name = 'DATA'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dspConsBlocoH: TDataSetProvider
    DataSet = FDConBlocoH
    Left = 992
    Top = 295
  end
  object cdsConsBlocoH: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDate
        Name = 'DATA'
        ParamType = ptInput
      end>
    ProviderName = 'dspConsBlocoH'
    Left = 992
    Top = 344
    object cdsConsBlocoHID_PRODUTO: TStringField
      FieldName = 'ID_PRODUTO'
      Required = True
      Size = 60
    end
    object cdsConsBlocoHEAN: TStringField
      FieldName = 'EAN'
      Size = 14
    end
    object cdsConsBlocoHDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsConsBlocoHQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsConsBlocoHVL_UNIT_ITEM: TFloatField
      FieldName = 'VL_UNIT_ITEM'
    end
    object cdsConsBlocoHVL_ITEM: TFloatField
      FieldName = 'VL_ITEM'
    end
    object cdsConsBlocoHNCM: TStringField
      FieldName = 'NCM'
      Size = 10
    end
  end
  object FDMemTBCST50: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 704
    Top = 360
    object FDMemTBCST50valorBC: TFloatField
      FieldName = 'valorBC'
    end
    object FDMemTBCST50valorPis: TFloatField
      FieldName = 'valorPis'
    end
    object FDMemTBCST50valorCofins: TFloatField
      FieldName = 'valorCofins'
    end
  end
  object FDConsTemReg0200: TFDQuery
    Connection = FDConnSped
    SQL.Strings = (
      'SELECT * FROM TEMP_REG0200')
    Left = 40
    Top = 616
  end
  object dspConsReg0200: TDataSetProvider
    DataSet = FDConsTemReg0200
    Left = 40
    Top = 656
  end
  object cdsConsTempReg0200: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsReg0200'
    Left = 40
    Top = 696
    object cdsConsTempReg0200CODIGO_ITEM: TFloatField
      FieldName = 'CODIGO_ITEM'
      Required = True
    end
  end
end
