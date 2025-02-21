unit udmPrincipal;

interface

uses
  Forms, SysUtils, Classes, WideStrings, DB, SqlExpr, DBXInterbase, DBXFirebird, IniFiles,
  FMTBcd, Provider, DBClient, ACBrBase, ACBrDFe, ACBrNFe, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet,Vcl.Dialogs, FireDAC.Phys.IBBase, FireDAC.Comp.UI,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,Winapi.WinInet;

type
  TdmPrincipal = class(TDataModule)
    qryConsultaAux1: TSQLQuery;
    cdsConsultaAux1: TClientDataSet;
    dspConsultaAux1: TDataSetProvider;
    FdConsulta: TFDQuery;
    DsFDConsulta: TDataSource;
    FDEmpresa: TFDQuery;
    FDContador: TFDQuery;
    DsEmpresa: TDataSource;
    DsContador: TDataSource;
    connBaseDados: TSQLConnection;
    FDConnFarmax: TFDConnection;
    FDConnSped: TFDConnection;
    FDConsEmpresa: TFDQuery;
    dspConsEmpresa: TDataSetProvider;
    cdsConsEmpresa: TClientDataSet;
    FDConsDadosContador: TFDQuery;
    dspConsDadosContadior: TDataSetProvider;
    cdsConsDadosContador: TClientDataSet;
    FDConsParametros: TFDQuery;
    dspConsParametros: TDataSetProvider;
    cdsConsParametros: TClientDataSet;
    cdsConsParametrosCD_FILIAL: TFloatField;
    cdsConsParametrosRAZAO: TStringField;
    cdsConsParametrosNOMEFANTASIA: TStringField;
    cdsConsParametrosCGC: TStringField;
    cdsConsParametrosENDERECO: TStringField;
    cdsConsParametrosCIDADE: TStringField;
    cdsConsParametrosBAIRRO: TStringField;
    cdsConsParametrosNUMERO: TStringField;
    cdsConsParametrosUF: TStringField;
    cdsConsParametrosFONE: TStringField;
    cdsConsParametrosCD_MUNICIPIO: TStringField;
    cdsConsParametrosEMAIL: TStringField;
    cdsConsParametrosPERFIL: TStringField;
    cdsConsParametrosINSCRICAO: TStringField;
    cdsConsParametrosCONTADORNOME: TStringField;
    cdsConsParametrosCONTADORCPF: TStringField;
    cdsConsParametrosCONTADORCRC: TStringField;
    cdsConsParametrosCONTADORCNPJ: TStringField;
    cdsConsParametrosCONTADORENDERECO: TStringField;
    cdsConsParametrosCONTADORNUMERO: TStringField;
    cdsConsParametrosCONTADORCOMPLEMENTO: TStringField;
    cdsConsParametrosCONTADORBAIRRO: TStringField;
    cdsConsParametrosCONTADORCEP: TStringField;
    cdsConsParametrosCONTADORTELEFONE: TStringField;
    cdsConsParametrosCONTADORFAX: TStringField;
    cdsConsParametrosCONTADOREMAIL: TStringField;
    cdsConsParametrosCONTADORCD_MUNICIPIO: TStringField;
    cdsConsDadosContadorCD_FILIAL: TIntegerField;
    cdsConsDadosContadorNOME: TStringField;
    cdsConsDadosContadorENDERECO: TStringField;
    cdsConsDadosContadorBAIRRO: TStringField;
    cdsConsDadosContadorCEP: TStringField;
    cdsConsDadosContadorCOD_CIDADE: TStringField;
    cdsConsDadosContadorCOMPLEMENTO: TStringField;
    cdsConsDadosContadorCPF: TStringField;
    cdsConsDadosContadorCRC: TStringField;
    cdsConsDadosContadorEMAIL: TStringField;
    cdsConsDadosContadorFAX: TStringField;
    cdsConsDadosContadorTELEFONE: TStringField;
    cdsConsDadosContadorNUMERO: TStringField;
    cdsConsDadosContadorCNPJ: TStringField;
    cdsConsParametrosCRT: TStringField;
    cdsConsParametrosINSC_MUNICIPAL: TStringField;
    cdsConsParametrosCEP: TStringField;
    FdBd: TFDQuery;
    dspBd: TDataSetProvider;
    cdsBD: TClientDataSet;
    FdQueryAuxiliar: TFDQuery;
    cdsBDSERVIDORSPED: TStringField;
    cdsBDBDSPED: TStringField;
    cdsBDBD_FARMAX: TStringField;
    cdsBDSERVIDOR_FARMAX: TStringField;
    cdsBDID: TIntegerField;
    cdsConsParametrosENQUADRAMENTOTRIBUTARIO: TStringField;
    FDQBuscarNfce: TFDQuery;
    DSpBuscarNfce: TDataSetProvider;
    CDSBuscarNfce: TClientDataSet;
    CDSBuscarNfceCHAVE: TStringField;
    CDSBuscarNfceARQUIVO: TMemoField;
    CDSBuscarNfceDATA: TDateField;
    FDQBuscaXmlNfe: TFDQuery;
    DspBuscaXmlNfe: TDataSetProvider;
    cdsBuscaXmlNfe: TClientDataSet;
    cdsBuscaXmlNfeCHAVE: TStringField;
    cdsBuscaXmlNfeARQUIVO: TMemoField;
    FDQBuscaNfePeriodo: TFDQuery;
    DspBuscaNfeperiodo: TDataSetProvider;
    cdsBuscaNfePeriodo: TClientDataSet;
    FDBuscaDanfe: TFDQuery;
    dspBuscaDanfe: TDataSetProvider;
    cdsbuscaDanfe: TClientDataSet;
    FDQBuscaNfe: TFDQuery;
    DspBuscaNfe: TDataSetProvider;
    cdsBuscaNfe: TClientDataSet;
    cdsBuscaNfeCNPJ_FORNECEDOR: TStringField;
    cdsBuscaNfeRAZAO_SOCIAL_FORNECEDOR: TStringField;
    cdsBuscaNfeCHAVE_NF: TStringField;
    cdsBuscaNfeDATA_HORA_LOCAL: TDateField;
    cdsBuscaNfeNUMERO_OPERACAO: TFloatField;
    cdsBuscaNfeDATA_HORA_EMISSAO: TDateField;
    cdsBuscaNfeNUMERO_NF: TStringField;
    cdsBuscaNfeSERIE_NF: TStringField;
    cdsBuscaNfeTOTAL_PRODUTOS: TFloatField;
    cdsBuscaNfeTOTAL_NF: TFloatField;
    cdsBuscaNfeCD_FILIAL: TFloatField;
    FDQBuscaNfeMatriz: TFDQuery;
    DspBuscaNfeMatriz: TDataSetProvider;
    cdsBuscaNfeMatriz: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    DateField1: TDateField;
    FloatField1: TFloatField;
    DateField2: TDateField;
    StringField4: TStringField;
    StringField5: TStringField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FDMConsultaNfe: TFDMemTable;
    FDMConsultaNfechave: TStringField;
    FDMConsultaNfemodelo: TStringField;
    FDMConsultaNfecreatedDate: TStringField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    cdsBuscaNfePeriodoCHAVENFE: TStringField;
    cdsbuscaDanfeCHAVE: TStringField;
    cdsbuscaDanfeARQUIVO: TMemoField;
    dsConsEmpresa: TDataSource;
    cdsConsEmpresaCD_FILIAL: TIntegerField;
    cdsConsEmpresaRAZAO: TStringField;
    cdsConsEmpresaFANTASIA: TStringField;
    cdsConsEmpresaENDERECO: TStringField;
    cdsConsEmpresaCGC: TStringField;
    cdsConsEmpresaCIDADE: TStringField;
    cdsConsEmpresaBAIRRO: TStringField;
    cdsConsEmpresaNUMERO: TStringField;
    cdsConsEmpresaUF: TStringField;
    cdsConsEmpresaTELEFONE: TStringField;
    cdsConsEmpresaCODIGO_CIDADE: TStringField;
    cdsConsEmpresaCOD_INC_TRIB: TStringField;
    cdsConsEmpresaTIPO_CONT_APURADA: TStringField;
    cdsConsEmpresaEMAIL: TStringField;
    cdsConsEmpresaMETODO_APROPRIACAO: TStringField;
    cdsConsEmpresaIND_NAT_PJ: TStringField;
    cdsConsEmpresaIND_REG_CUMULATIVO: TStringField;
    cdsConsEmpresaINSC_ESTADUAL: TStringField;
    cdsConsEmpresaTIPO_ATIV: TStringField;
    cdsConsEmpresaPERFIL: TStringField;
    cdsConsEmpresaPERIODO_IPI: TStringField;
    cdsConsEmpresaLOCAL_ARQUIVOS: TStringField;
    cdsConsEmpresaINSC_MUNICIPAL: TStringField;
    cdsConsEmpresaCEP: TStringField;
    cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO: TStringField;
    cdsConsEmpresaGERARARQUIVODIRETOFARMAX: TIntegerField;
    FDSpedM400: TFDQuery;
    dsSPED_M400: TDataSetProvider;
    cdsSPEDM400: TClientDataSet;
    FDSpedM410: TFDQuery;
    dspSpedM410: TDataSetProvider;
    cdsSPEDM410: TClientDataSet;
    FDTEMP_SPEDC_M410: TFDQuery;
    dspTEMP_SPEDC_M410: TDataSetProvider;
    cdsTEMP_SPEDC_M410: TClientDataSet;
    FDSPEDM210: TFDQuery;
    dspSPEDM210: TDataSetProvider;
    CdsSPEDM210: TClientDataSet;
    FDSPEDM200: TFDQuery;
    dspSPEDM200: TDataSetProvider;
    CdsSPEDM200: TClientDataSet;
    FDSPEDM800: TFDQuery;
    dspSPEDM800: TDataSetProvider;
    cdsSPEDM800: TClientDataSet;
    FDSPEDM810: TFDQuery;
    dspSPEDM810: TDataSetProvider;
    cdsSPEDM810: TClientDataSet;
    cdsSPEDM810NAT_REC: TStringField;
    cdsSPEDM810VL_REC: TFMTBCDField;
    FDCadSPEDM800: TFDQuery;
    dspCadSPEDM800: TDataSetProvider;
    cdsCadSPEDM800: TClientDataSet;
    FDTemCstPIsCof: TFDQuery;
    dspTemCstPIsCof: TDataSetProvider;
    cdsTemCstPIsCof: TClientDataSet;
    cdsTemCstPIsCofCFOP: TStringField;
    cdsTemCstPIsCofCST_PIS: TStringField;
    cdsTemCstPIsCofBASEPIS: TFloatField;
    cdsTemCstPIsCofALIQPIS: TFloatField;
    cdsTemCstPIsCofVALORPIS: TFloatField;
    cdsTemCstPIsCofVALORBASEPISCOF: TFloatField;
    cdsTemCstPIsCofBASECOF: TFloatField;
    cdsTemCstPIsCofALIQCOF: TFloatField;
    cdsTemCstPIsCofVALORCOF: TFloatField;
    cdsTemCstPIsCofNCM: TStringField;
    cdsTemCstPIsCofVALOR_PROD: TFloatField;
    cdsCadSPEDM800CST: TStringField;
    cdsCadSPEDM800NAT_REC: TStringField;
    cdsCadSPEDM800VL_REC: TFMTBCDField;
    cdsTemCstPIsCofEAN: TStringField;
    FDQuery1: TFDQuery;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    FMTBCDField2: TFMTBCDField;
    FMTBCDField3: TFMTBCDField;
    FDCadProd_tribErrada: TFDQuery;
    dspCadProd_tribErrada: TDataSetProvider;
    cdsCadProd_tribErrada: TClientDataSet;
    cdsCadProd_tribErradaCFOP: TStringField;
    cdsCadProd_tribErradaEAN: TStringField;
    cdsCadProd_tribErradaDESCRICAO: TStringField;
    cdsCadProd_tribErradaALIQPIS: TFloatField;
    cdsCadProd_tribErradaALIQCOF: TFloatField;
    FDConsTributacaoErrada: TFDQuery;
    dspConsTributacaoErrada: TDataSetProvider;
    cdsConsTributacaoErrada: TClientDataSet;
    cdsConsTributacaoErradaCFOP: TStringField;
    cdsConsTributacaoErradaEAN: TStringField;
    cdsConsTributacaoErradaDESCRICAO: TStringField;
    cdsConsTributacaoErradaALIQPIS: TFloatField;
    cdsConsTributacaoErradaALIQCOF: TFloatField;
    FDFTABELAREG_C170: TFDQuery;
    dsPFTABELAREG_C170: TDataSetProvider;
    FTabelaRegC170: TClientDataSet;
    FTabelaRegC170NFID: TIntegerField;
    FTabelaRegC170NUM_ITEM: TStringField;
    FTabelaRegC170COD_ITEM: TStringField;
    FTabelaRegC170DESCR_COMPL: TStringField;
    FTabelaRegC170QTD: TFloatField;
    FTabelaRegC170UNID: TStringField;
    FTabelaRegC170VL_ITEM: TFloatField;
    FTabelaRegC170VL_DESC: TFloatField;
    FTabelaRegC170IND_MOV: TIntegerField;
    FTabelaRegC170CST_ICMS: TStringField;
    FTabelaRegC170CFOP: TStringField;
    FTabelaRegC170COD_NAT: TStringField;
    FTabelaRegC170VL_BC_ICMS: TFloatField;
    FTabelaRegC170ALIQ_ICMS: TFloatField;
    FTabelaRegC170VL_ICMS: TFloatField;
    FTabelaRegC170VL_BC_ICMS_ST: TFloatField;
    FTabelaRegC170ALIQ_ST: TFloatField;
    FTabelaRegC170VL_ICMS_ST: TFloatField;
    FTabelaRegC170IND_APUR: TIntegerField;
    FTabelaRegC170CST_IPI: TStringField;
    FTabelaRegC170COD_ENQ: TStringField;
    FTabelaRegC170VL_BC_IPI: TFloatField;
    FTabelaRegC170ALIQ_IPI: TFloatField;
    FTabelaRegC170VL_IPI: TFloatField;
    FTabelaRegC170CST_PIS: TStringField;
    FTabelaRegC170VL_BC_PIS: TFloatField;
    FTabelaRegC170ALIQ_PIS_PERC: TFloatField;
    FTabelaRegC170QUANT_BC_PIS: TFloatField;
    FTabelaRegC170ALIQ_PIS_R: TFloatField;
    FTabelaRegC170VL_PIS: TFloatField;
    FTabelaRegC170CST_COFINS: TStringField;
    FTabelaRegC170VL_BC_COFINS: TFloatField;
    FTabelaRegC170ALIQ_COFINS_PERC: TFloatField;
    FTabelaRegC170QUANT_BC_COFINS: TFloatField;
    FTabelaRegC170ALIQ_COFINS_R: TFloatField;
    FTabelaRegC170VL_COFINS: TFloatField;
    FTabelaRegC170COD_CTA: TStringField;
    cdsBDPORTAFB_FAR: TStringField;
    cdsBDPORTAFB_SPED: TStringField;
    FDFTabelaReg1900: TFDQuery;
    dspFTabelaReg1900: TDataSetProvider;
    FTabelaReg1900: TClientDataSet;
    FTabelaReg1900COD_MOD: TStringField;
    FTabelaReg1900SER: TStringField;
    FTabelaReg1900SUB_SER: TStringField;
    FTabelaReg1900VL_TOT_REC: TFloatField;
    FTabelaReg1900CST_PIS_COF: TStringField;
    FTabelaReg1900CFOP: TStringField;
    FTabelaReg1900ALIQ_PIS: TFloatField;
    FTabelaReg1900ALIQ_COF: TFloatField;
    FDFTabelaRegC175: TFDQuery;
    dspFTabelaRegC175: TDataSetProvider;
    FTabelaRegC175: TClientDataSet;
    FDSQL: TFDQuery;
    FTabelaRegC175NFID: TIntegerField;
    FTabelaRegC175CFOP: TStringField;
    FTabelaRegC175VL_DESC: TFloatField;
    FTabelaRegC175VL_OPR: TFloatField;
    FTabelaRegC175CST_PIS: TStringField;
    FTabelaRegC175ALIQ_PIS: TFloatField;
    FTabelaRegC175VL_PIS: TFloatField;
    FTabelaRegC175VL_BC_PIS: TFloatField;
    FTabelaRegC175CST_COFINS: TStringField;
    FTabelaRegC175ALIQ_COFINS: TFloatField;
    FTabelaRegC175VL_COFINS: TFloatField;
    FTabelaRegC175VL_BC_COFINS: TFloatField;
    FTabelaRegC175COD_CTA: TStringField;
    FTabelaRegC175INFO_COMPL: TStringField;
    CdsSPEDM200VL_REC_BRT: TFloatField;
    CdsSPEDM200VL_BASE_CALCULO: TFloatField;
    cdsSPEDM410NAT_REC: TStringField;
    cdsSPEDM410VL_REC: TFloatField;
    cdsSPEDM400CST: TStringField;
    cdsSPEDM400VL_REC: TFloatField;
    cdsTEMP_SPEDC_M410CST: TStringField;
    cdsTEMP_SPEDC_M410NAT_REC: TStringField;
    cdsTEMP_SPEDC_M410VL_REC: TFloatField;
    CdsSPEDM210COD_CONTA: TStringField;
    CdsSPEDM210VL_REC_BRT: TFloatField;
    CdsSPEDM210VL_BASE_CALCULO: TFloatField;
    cdsSPEDM800CST: TStringField;
    cdsSPEDM800VL_REC: TFloatField;
    RESTClientTestaUrl: TRESTClient;
    RESTReqTestaUrl: TRESTRequest;
    RESTRespTestaUrl: TRESTResponse;
    IdHTTP1: TIdHTTP;
    FDStoredProc: TFDStoredProc;
    FDConsInventaio: TFDQuery;
    dspConsInventario: TDataSetProvider;
    cdsConsInventario: TClientDataSet;
    cdsConsInventarioID_PRODUTO: TFloatField;
    cdsConsInventarioDESCRICAO: TStringField;
    cdsConsInventarioVL_UNIT_ITEM: TFloatField;
    cdsConsInventarioQUANTIDADE: TFloatField;
    cdsConsInventarioVL_ITEM: TFloatField;
    FDQuery: TFDQuery;
    cdsConsInventarioCODIGO_BARRAS_1: TStringField;
    cdsConsInventarioNCM: TStringField;
    FDConBlocoH: TFDQuery;
    dspConsBlocoH: TDataSetProvider;
    cdsConsBlocoH: TClientDataSet;
    cdsConsBlocoHID_PRODUTO: TStringField;
    cdsConsBlocoHEAN: TStringField;
    cdsConsBlocoHDESCRICAO: TStringField;
    cdsConsBlocoHQUANTIDADE: TFloatField;
    cdsConsBlocoHVL_UNIT_ITEM: TFloatField;
    cdsConsBlocoHVL_ITEM: TFloatField;
    cdsConsBlocoHNCM: TStringField;
    procedure DataModuleCreate(Sender: TObject);

  private
    FCodigoFilial: Integer;
    FUsuario: String;
    FNomeFilial: String;
    procedure SetCodigoFilial(const Value: Integer);

  public
     property CodigoFilial: Integer read FCodigoFilial write SetCodigoFilial;
     property NomeFilial: String read FNomeFilial write FNomeFilial;
     property Usuario: String read FUsuario write FUsuario;

     function ExecSQL(const SQL: String): String;
     function GetValorFieldDataSet(cds: TClientDataSet; const Campo: String): String;
     function VerificaFtpFarmaxOnline: Boolean;
     function  ConectadoInternet: boolean;

     procedure VAlidaBd;
     procedure GeraINI;
     Procedure GeraLog(Mensagem: String);
     procedure DownloadArquivoVersaoFtp;


  end;

var
  dmPrincipal: TdmPrincipal;
  Ini : TIniFile;
  NomeServidor, CaminhoBD,sLocalConfig : String;

implementation

{$R *.dfm}

uses uFuncoesBasicas, ConfigServer, Winapi.Windows;




function TdmPrincipal.ConectadoInternet: boolean;
 var
 Internet :DWORD;
begin
  Result := False;
 if InternetGetConnectedState(@internet,0) then
  begin
    Result := True;
  end;


end;

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);

begin

 ValidaBD ;


 if FDConnSped.Connected =true then
    begin
     dmPrincipal.cdsConsEmpresa.Close;
     dmPrincipal.cdsConsEmpresa.open;
     SetCodigoFilial(dmPrincipal.cdsConsEmpresaCD_FILIAL.Value);
     end
  else
    showmessage('Não foi possivel conectar ao banco de dados.');


  if ConectadoInternet then
     begin
      if VerificaFtpFarmaxOnline then
       begin
        DownloadArquivoVersaoFtp;
       end;
     end;

end;

procedure TdmPrincipal.DownloadArquivoVersaoFtp;
var
 UrlArquivo,SalvarEm,arquivo:string;
 MyFile:TFileStream;
  DirExecutavel:string;
begin
    //deleta o arquivo Versao.txt do computador,caso exista
 DirExecutavel:=ExtractFilePath(Application.ExeName);
    //deleta o arquivo Versao.txt do computador,caso exista
  if FileExists(ExtractFilePath(Application.ExeName)+'Versoes.txt') then
     DeleteFile(Pchar(ExtractFilePath(Application.ExeName)+'Versoes.txt'));

       //deleta o arquivo VersaoOrizon.ini do computador,caso exista
  if FileExists(ExtractFilePath(Application.ExeName)+'Versoes.ini') then
     DeleteFile(Pchar(ExtractFilePath(Application.ExeName)+'Versoes.ini'));

  try

   UrlArquivo:='http://www.farmax.far.br/download/';
   SalvarEm  := DirExecutavel;
   arquivo   := 'Versoes.ini'; ;

   MyFile := TFileStream.Create(DirExecutavel+arquivo, fmCreate);
      try
        IdHTTP1.Get(UrlArquivo+arquivo, MyFile);
      finally
        IdHTTP1.Free;
        MyFile.Free;
       // RenameFile(DirExecutavel+'VersaoTrn.txt',DirExecutavel + 'VersaoTrn.ini');
      end;
  except on E:Exception do
    GeraLog('Erro ao baixar Versoes.ini:'+E.Message );
  end;

end;

function TdmPrincipal.ExecSQL(const SQL: String): String;
begin

  if ( Pos('INSERT', UpperCase(SQL)) > 0 ) or
     ( Pos('UPDATE', UpperCase(SQL)) > 0 ) or
     ( Pos('DELETE', UpperCase(SQL)) > 0 ) then
     begin
        cdsConsultaAux1.Close;
        qryConsultaAux1.Close;
        dspConsultaAux1.DataSet := Nil;
        qryConsultaAux1.SQLConnection := connBaseDados;
        qryConsultaAux1.SQL.Clear;
        qryConsultaAux1.SQL.Add(SQL);
        qryConsultaAux1.ExecSQL;
        Result := 'Registros afetados: ' + IntToStr(qryConsultaAux1.RowsAffected);
     end
  else
     begin
        cdsConsultaAux1.Close;
        qryConsultaAux1.SQLConnection := connBaseDados;
        dspConsultaAux1.DataSet := qryConsultaAux1;
        cdsConsultaAux1.SetProvider(dspConsultaAux1);
        cdsConsultaAux1.CommandText := SQL;
        cdsConsultaAux1.Open;
        Result := cdsConsultaAux1.FieldByName(cdsConsultaAux1.FieldDefs[0].Name).AsString;
     end;

end;

procedure TdmPrincipal.GeraINI;
begin
    try
      Application.CreateForm(TFrmConfigServer, FrmConfigServer);
      FrmConfigServer.ShowModal;
    finally
      FrmConfigServer.Free;
     end;

end;

procedure TdmPrincipal.GeraLog(Mensagem: String);
var Log : TextFile;
begin

 if not DirectoryExists(ExtractFilePath(Application.ExeName)+'LogsTrn') then
    CreateDir(ExtractFilePath(Application.ExeName)+'LogsTrn');

    AssignFile(Log, ExtractFilePath(Application.ExeName) + 'LogsSped\SpedLog' + FormatDateTime('ddmmyyyy',Date) + '.txt');
 if FileExists(ExtractFilePath(Application.ExeName) + 'LogsSped\SpedLog' + FormatDateTime('ddmmyyyy',Date) + '.txt') then
     begin

      Append(Log);
      Writeln(Log, FormatDateTime('dd/mm/yyyy - hh:mm:ss', Now) + ' - ' + Application.ExeName + ' - ' + Mensagem);
      CloseFile(Log);

     end
  else
     begin

      AssignFile(Log, ExtractFilePath(Application.ExeName) + 'LogsSped\SpedLog' + FormatDateTime('ddmmyyyy',Date) + '.txt');

      Rewrite(Log);
      Append(Log);
      Writeln(Log, FormatDateTime('dd/mm/yyyy - hh:mm:ss', Now) + ' - ' + Application.ExeName + ' - ' + Mensagem);
      CloseFile(Log);

     end;


end;

function TdmPrincipal.GetValorFieldDataSet(cds: TClientDataSet; const Campo: String): String;
begin
  cds.Filtered := False;
  cds.Filter := 'SECAO_CAMPO = ' + QuotedStr(Trim(Campo));
  cds.Filtered := True;
  Result := Trim(cds.FieldByName('CONTEUDO').AsString);
  cds.Filtered := False;
end;

procedure TdmPrincipal.SetCodigoFilial(const Value: Integer); begin

  //   FCodigoFilial :value;  voltando com essa operacao abre o menu fiscal


  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.open;
  FCodigoFilial := dmPrincipal.cdsConsEmpresaCD_FILIAL.Value;

  if (FCodigoFilial > 0) and (FNomeFilial = '') then
     begin
       Self.FNomeFilial := dmPrincipal.cdsConsEmpresaCD_FILIAL.AsString + ' - ' + dmPrincipal.cdsConsEmpresaRAZAO.AsString;
     end;


end;

procedure TdmPrincipal.VAlidaBd;
var Arquivo: TIniFile{uses IniFiles};

NomeServidor,CaminhoBd,porta:String;

begin


 if not FileExists(ExtractFilePath(Application.ExeName)+'ConfigSped.ini') then
   begin
    GeraINI;
   end
   else
   begin

    Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ConfigSped.ini');
    NomeServidor:= Arquivo.ReadString('SERVIDOR','Servidor','');
    CaminhoBd   := Arquivo.ReadString('SERVIDOR','Database','');
    porta       := Arquivo.ReadString('SERVIDOR','portafb','');
    Arquivo.Free;
   end;


    Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ConfigSped.ini');
    NomeServidor:= Arquivo.ReadString('SERVIDOR','Servidor','');
    CaminhoBd   := Arquivo.ReadString('SERVIDOR','Database','');
    porta       := Arquivo.ReadString('SERVIDOR','portafb','');
    Arquivo.Free;



   if porta ='' then
    begin
      GeraINI;
    end;

  if (NomeServidor <> '') and (CaminhoBd <>'') then
   begin
      FDConnSped.Connected :=false;

      FDConnSped.Params.Values['DriverID']  :='FB';
      FDConnSped.Params.Values['Server']    := NomeServidor;
      FDConnSped.Params.Values['Database']  := CaminhoBd;
      FDConnSped.Params.Values['User_Name'] :='sysdba';
      FDConnSped.Params.Values['Password']  :='masterkey';
      FDConnSped.Params.Values['Port']      := porta;
      FDConnSped.Params.Values['Protocol']  :='TCPIP';

      try

       FDConnSped.Connected :=true;

      except
       ExibeWarning('Servidor não localizado. '+NomeServidor +'-'+CaminhoBd+'  Verifique as configurações.');
       GeraINI;
      end;
   end
   else
   begin
    FDConnSped.Connected :=false;
    GeraINI;
   end;
end;

function TdmPrincipal.VerificaFtpFarmaxOnline: Boolean;
const url ='http://www.farmax.far.br/';
begin

   RESTClientTestaUrl.BaseURL:=url;
   RESTReqTestaUrl.Timeout:=10000; // 10.000 ms = 10 segundos
//
  try

     RESTReqTestaUrl.Execute;

    if RESTRespTestaUrl.StatusCode = 200 then
       begin
        Result:=true;
       end
    else
       begin
        result :=false;
       end;

  except on  E:Exception do
    begin
    // Showmessage('Falha ao conectar no webserver Farmax para ObterAtualização.');
      GeraLog('Falha ao conectar no webserver Farmax para baixar nova versao.'+E.Message);
      result :=false;
    end;

  end;
end;

end.
