unit uSpedPisCofins;

interface

uses
    Classes, ACBrSpedPisCofins, SqlExpr, SysUtils, StdCtrls, DB, DBClient,System.SyncObjs, Provider, ComCtrls,  System.Threading, System.StrUtils,

    ACBrEPCBloco_A, ACBrEPCBloco_M, ACBrEPCBloco_P, ACBrEPCBloco_F,
    ACBrEPCBlocos, ACBrEPCBloco_0, ACBrEPCBloco_1,
    ACBrEFDBlocos, ACBrEPCBloco_C, ACBrEPCBloco_D,

    ACBrEFDBloco_C, ACBrEFDBloco_0,
    ACBrEFDBloco_1,
    ACBrEFDBloco_D,
    uFuncoesBasicas, Forms, uConstsGerais, ACBrBase, ACBrDFe,
    ACBrNFe, ACBrNFeNotasFiscais,
    // pcnNFe,
     pcnConversao,  pcnConversaoNFe, Math, ACBrECF, ACBrDevice,
    IniFiles, TypInfo, ACBrSpedFiscal;

type
    TSpedPisCofins = class(TComponent)
      procedure ACBrECFAguardandoRespostaChange(Sender: TObject);
      procedure ACBrECFChangeEstado(const EstadoAnterior, EstadoAtual: TACBrECFEstado);
      procedure ACBrECFMsgAguarde(const Mensagem: String);
      procedure ACBrECFMsgPoucoPapel(Sender: TObject);
    private
      FcdsResultExec : TClientDataSet;
      FqryResultExec: TSQLQuery;
      FdspResultExec: TDataSetProvider;

      FTabelaEmpresa : TClientDataSet;
      FqTabelaEmpresa: TSQLQuery;
      FpTabelaEmpresa: TDataSetProvider;

      FTabelaContador : TClientDataSet;
      FqTabelaContador: TSQLQuery;
      FpTabelaContador: TDataSetProvider;

      FTabelaRegC500: TClientDataSet;
      FqTabelaRegC500: TSQLQuery;
      FpTabelaRegC500: TDataSetprovider;

      FTabelaReg0150: TClientDataSet;
      FTabelaReg0190: TClientDataSet;
      FTabelaReg0200: TClientDataSet;
      FTabelaReg0400: TClientDataSet;
      FTabelaRegC100: TClientDataSet;
      FTabelaRegC170: TClientDataSet;
      FTabelaRegE510: TClientDataSet;
     // FTabelaReg1900: TClientDataSet;
      //FTabelaRegC175: TClientDataSet;
      FTabelaRegC481_C485: TClientDataSet;
      FTabelaRegA100: TClientDataSet;
      FTabelaRegA170: TClientDataSet;
      FTaBelaRegM400: TClientDataSet;
      FTaBelaTempP400:TClientDataSet;
      FTaBelaTempP210:TClientDataSet;
      FTaBelaTempP800:TClientDataSet;
      FTaBelaTempP810:TClientDataSet;

      FcompSpedPisCofins: TACBrSPEDPisCofins;
      FACBrSPEDECF: TACBrSPEDFiscal;
      FACBrECF: TACBrECF;
      FacbrNFe: TACBrNFe;
      FOriginal: Boolean;
      FCodigoEmpresa: Integer;

      FlblStatus: TLabel;
      FConexaoBase: TSQLconnection;
      FGerarCupomFiscal: Boolean;
      FProgressBar: TProgressBar;
      FMemoErro: TMemo;
      FLocalSalvar: String;
      FCnpjEmpresa: String;
      FNrReciboEscritAnterior: String;
      FDataFinal: TDateTime;
      FDataInicial: TDateTime;
      FCodigIbgeUfEmpresa: Integer;
      FLocalDocXml_NFE: String;
      FLocalDocXml_NFCE: String;
      FLocalDocXml_FORN: String;
      FGerarBlocoF: Boolean;
      FListaArquivos: TStrings;
      FECF_RequerZ: Boolean;
      FParamIndApurIPI: String;
      FLocalArquivoMFDSPED: String;
      FGerarComArquivoMFDSPEDLocal: Boolean;
      FSemLimite: Boolean;
      FLocalDocXml_NFSE: String;

      function  GetValorFieldDataSet(cds: TClientDataSet; const Campo: String): String;
      function  ConfiguracoesValidasParaGerarSpedPisCofins: Boolean;
      function  InformacoesNFeValidasParaEscriturar(Notas: TNotasFiscais; const docEntrada: Boolean = False): Boolean;
      procedure GerarLinhaMemoLog(const LinhaLog: String);
      procedure IncBar;
      procedure ClearBar;
      procedure IniciaBar(const iValueMaxBar: Integer);
      procedure AtualizarStatus(const Msg: String);
      procedure SetMemoErro(const Value: TMemo);
      procedure SetEventoOnError;
      procedure OnErrorSpedPisCofins(const MsgError: String); overload;
      procedure OnErrorSpedPisCofins(const MsgError: AnsiString); overload;
      procedure SetLocalSalvar(const Value: String);
      procedure IniciarControles;
      procedure CriarTabelasTmpMem;
      procedure DestruirTabelasTmpMem;
      procedure CriarFieldsDataSets;
      function  GetCodPartByCnpjCpf(const CNPJCPF: String): String;
      function  GetCodNatReg0400ByCFOP(const CFOP: String): String;
      function  ConverterCFOPEntrada(const CFOPSaida: String): String;
      function  ConectarImpressoraECF(var sMsgRet: String): Boolean;
      function  ConverterCST_PIS_COF_SaiToEnt(const CST_SAI: String): String;

      procedure CarregarInformacoesContador;
      procedure CarregarInformacoesEmpresa;
      procedure CarregarInformacoesNotasAguaEnergiaGaz_C500;
      procedure CarregarDocumentosXML;
      procedure CarregarXmldadosProdutos(TotalArquivos:TStrings);
      procedure CarregarXmlGeraRegM400M800(TotalArquivos:TStrings);
      procedure CarregarXmlAnliticoItens(TotalArquivos:TStrings);

      procedure AdicionarDadosParticipante(Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure AdicionarDadosProdutos(Notas: TNotasFiscais; const docEntrada: Boolean = False);
      function  AdicionarDadosNotas(Notas: TNotasFiscais; const docEntrada: Boolean = False): Integer;
      function  AdicionarDadosNotasServicos(Notas: TNotasFiscais; const docEntrada: Boolean = False): Integer;
      procedure AdicionarDadosItensNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure AdicionarDadosItensNotasServicos(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure AcumularValoresIPI(const CFOP, CST: String; const ValorBaseIPI, ValorIPI: Double);
      procedure AdicionarDadosAnaliticosNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure FiltrarDocumentosFornecedores(oListaArq: TStringList; const iLim: Integer = 0);
      procedure AdicionarDadosProdutosCupomFiscal();
      procedure AcumularValoresReceitaReg1900(const CFOP, CST_PIS_COF, ModDoc, Ser, SubSer: String; const ValorReceita, AliqPis, AliqCof: Double);
      procedure AcumularValoreAnaliticoRegC175(const NFID: Integer; const CFOP, CST_PIS_COF: String; const ValorBase, AliqPis,
        AliqCof, ValorPis, ValorCof, ValorDesc: Double);
      procedure AcumularValoresAnaliticosRecC481C485();
      function  ChaveDuplicadaNaApuracao(const Chave: String): Boolean;
      function  NotaCancelada(const Chave: String): Boolean;
      function  TemServicosNaNFe(Notas: TNotasFiscais): Boolean;
      function  GetTotalBasePis(Notas: TNotasFiscais): Double;
      function  GetTotalBaseCofins(Notas: TNotasFiscais): Double;
      function  NotaServicoCancelada(const Chave: String): Boolean;
      function  GetTypeNatBcCred(const sCodNatBaseCred: String): ACBrEPCBlocos.TACBrNatBcCred;
      function  ConverterEquivalenciaCSOSNToCST(const CSOSN: String; const TemAliqIcms: Boolean): String;
      procedure AdicionarDadosProdutosCSTAliquitaBlocoM400M800(Notas: TNotasFiscais);
      function  ConverteCstIPI_Entrada(vIpi :string):String;

      procedure AdicionarDadosNotasNotas(Notas: TNotasFiscais);


      {Blocos}
      procedure GerarBloco_0;
      procedure GerarBloco_A;
      procedure GerarBloco_C;
      procedure GerarBloco_D;
      procedure GerarBloco_F;
      procedure GerarBloco_M;
      procedure GerarBloco_1;

      procedure SetCnpjEmpresa(const Value: String);
      procedure ExecSQL(const SQL: String);
      procedure SetDataFinal(const Value: TDateTime);
      procedure SetDataInicial(const Value: TDateTime);

   public
      procedure GerarAquivo;
      procedure TemP400_410;
      procedure TemP200_210;
      procedure TemP800_810;
      procedure LimparTabela;

//      var
//        RegistrosProcessados: TDictionary<string, Boolean>;
//        RegistrosProcessadosC175: TDictionary<string, Boolean>;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
   published
      property CodigoEmpresa: Integer read FCodigoEmpresa write FCodigoEmpresa;
      property Original: Boolean read FOriginal write FOriginal; {False = Substituto}
      property GerarCupomFiscal: Boolean read FGerarCupomFiscal write FGerarCupomFiscal;
      property MemoErro: TMemo read FMemoErro write SetMemoErro;
      property ConexaoBase: TSQLconnection read FConexaoBase write FConexaoBase;
      property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
      property lblStatus: TLabel read FlblStatus write FlblStatus;
      property LocalSalvar: String read FLocalSalvar write SetLocalSalvar;
      property LocalDocXml_NFE: String read FLocalDocXml_NFE write FLocalDocXml_NFE;
      property LocalDocXml_NFCE: String read FLocalDocXml_NFCE write FLocalDocXml_NFCE;
      property LocalDocXml_FORN: String read FLocalDocXml_FORN write FLocalDocXml_FORN;
      property LocalDocXml_NFSE: String read FLocalDocXml_NFSE write FLocalDocXml_NFSE;
      property CnpjEmpresa: String read FCnpjEmpresa write SetCnpjEmpresa;
      property DataInicial: TDateTime read FDataInicial write SetDataInicial;
      property DataFinal: TDateTime read FDataFinal write SetDataFinal;
      property NrReciboEscritAnterior: String read FNrReciboEscritAnterior write FNrReciboEscritAnterior;
      property CodigIbgeUfEmpresa: Integer read FCodigIbgeUfEmpresa write FCodigIbgeUfEmpresa;
      property ArquivoMFDSPEDLocal: Boolean read FGerarComArquivoMFDSPEDLocal write FGerarComArquivoMFDSPEDLocal;
      property LocalArquivoMFDSPED: String read FLocalArquivoMFDSPED write FLocalArquivoMFDSPED;

      property SemLimite: Boolean read FSemLimite write FSemLimite;
    end;

implementation

{ TSpedPisCofins }

uses udmPrincipal, uMenuPrincipal, Vcl.Controls,
     ACBrEPCBloco_C_Class, ACBrSped,
     ACBrEPCBloco_A_Class, ACBrEPCBloco_0_Class, ACBrEPCBloco_M_Class,
  uSpedFiscal, Vcl.Dialogs, UFrmConsistencia, System.Variants,
  System.Generics.Collections, Winapi.Windows, ACBrNFe.Classes;


procedure TSpedPisCofins.ACBrECFAguardandoRespostaChange(Sender: TObject);
begin
   if (FACBrECF.AguardandoResposta) then
      GerarLinhaMemoLog('Leitura da ECF...');
end;

procedure TSpedPisCofins.ACBrECFChangeEstado(const EstadoAnterior, EstadoAtual: TACBrECFEstado);
var
  sEstAnterior, sEstAtual: String;
begin
  case EstadoAnterior of
    estNaoInicializada: sEstAnterior := 'estNaoInicializada';
    estDesconhecido: sEstAnterior := 'estDesconhecido';
    estLivre: sEstAnterior := 'estLivre';
    estVenda: sEstAnterior := 'estVenda';
    estPagamento: sEstAnterior := 'estPagamento';
    estRelatorio: sEstAnterior := 'estRelatorio';
    estBloqueada: sEstAnterior := 'estBloqueada';
    estRequerZ: sEstAnterior := 'estRequerZ';
    estRequerX: sEstAnterior := 'estRequerX';
    estNaoFiscal: sEstAnterior := 'estNaoFiscal';
  end;

  case EstadoAtual of
    estNaoInicializada: sEstAtual := 'estNaoInicializada';
    estDesconhecido: sEstAtual := 'estDesconhecido';
    estLivre: sEstAtual := 'estLivre';
    estVenda: sEstAtual := 'estVenda';
    estPagamento: sEstAtual := 'estPagamento';
    estRelatorio: sEstAtual := 'estRelatorio';
    estBloqueada: sEstAtual := 'estBloqueada';
    estRequerZ: sEstAtual := 'estRequerZ';
    estRequerX: sEstAtual := 'estRequerX';
    estNaoFiscal: sEstAtual := 'estNaoFiscal';
  end;

  Self.FECF_RequerZ := (EstadoAtual = estRequerZ);
  GerarLinhaMemoLog(Format('Estado Anterior: %s', [sEstAnterior]));
  GerarLinhaMemoLog(Format('Estado Atual: %s', [sEstAtual]));
end;

procedure TSpedPisCofins.ACBrECFMsgAguarde(const Mensagem: String);
var
   sMsg: String;
begin
   sMsg := StringReplace(Mensagem,#10,' ',[rfReplaceAll]);
   if (Trim(sMsg) <> '') then
      GerarLinhaMemoLog(sMsg);
end;
procedure TSpedPisCofins.ACBrECFMsgPoucoPapel(Sender: TObject);
begin
   GerarLinhaMemoLog(_MSG_POUCO_PAPEL);
end;

procedure TSpedPisCofins.AcumularValoreAnaliticoRegC175(const NFID: Integer; const CFOP, CST_PIS_COF: String; const ValorBase,
   AliqPis, AliqCof, ValorPis, ValorCof, ValorDesc: Double);

   function ExisteCombinacaoCST_PIS_COF: Boolean;
   begin

        dmPrincipal.FTabelaRegC175.Close;
        dmPrincipal.FTabelaRegC175.CommandText:='SELECT * FROM FTABELAREGC175  WHERE  NFID ='+IntToStr(NFID)+ ' AND CFOP='+QuotedStr(cfop)+'  AND CST_PIS ='+ QuotedStr(CST_PIS_COF);
        dmPrincipal.FTabelaRegC175.Open;

      Result := (dmPrincipal.FTabelaRegC175.RecordCount > 0);
   end;

begin

//   if (ValorBase <= 0) then
//       Exit;


   if (ExisteCombinacaoCST_PIS_COF()) then
       dmPrincipal.FTabelaRegC175.Edit
   else
       dmPrincipal.FTabelaRegC175.Append;



   if (dmPrincipal.FTabelaRegC175.State = dsInsert) then
      begin
         dmPrincipal.FTabelaRegC175NFID.AsInteger      := NFID;
         dmPrincipal.FTabelaRegC175CFOP.AsString       := Trim(CFOP);
         dmPrincipal.FTabelaRegC175CST_PIS.AsString    := CST_PIS_COF;
         dmPrincipal.FTabelaRegC175CST_COFINS.AsString := CST_PIS_COF;
         dmPrincipal.FTabelaRegC175ALIQ_PIS.AsFloat    := AliqPis;
         dmPrincipal.FTabelaRegC175ALIQ_COFINS.AsFloat := AliqCof;

         dmPrincipal.FTabelaRegC175COD_CTA.AsString    := '';
         dmPrincipal.FTabelaRegC175INFO_COMPL.AsString := '';
      end;

   // Valor Receita
   dmPrincipal.FTabelaRegC175VL_OPR.AsFloat  := dmPrincipal.FTabelaRegC175VL_OPR.AsFloat + ValorBase;
   dmPrincipal.FTabelaRegC175VL_DESC.AsFloat := dmPrincipal.FTabelaRegC175VL_DESC.AsFloat + ValorDesc;

   if (AliqPis > 0) then
      begin
         dmPrincipal.FTabelaRegC175VL_PIS.AsFloat    := dmPrincipal.FTabelaRegC175VL_PIS.AsFloat + ValorPis;
         dmPrincipal.FTabelaRegC175VL_BC_PIS.AsFloat := dmPrincipal.FTabelaRegC175VL_BC_PIS.AsFloat + ValorBase;
      end
   else
     begin
         dmPrincipal.FTabelaRegC175VL_PIS.AsFloat    := dmPrincipal.FTabelaRegC175VL_PIS.AsFloat + 0 ;
         dmPrincipal.FTabelaRegC175VL_BC_PIS.AsFloat := dmPrincipal.FTabelaRegC175VL_BC_PIS.AsFloat + 0;
     end;


  if (AliqCof > 0) then
     begin
         dmPrincipal.FTabelaRegC175VL_COFINS.AsFloat    := dmPrincipal.FTabelaRegC175VL_COFINS.AsFloat + ValorCof;
         dmPrincipal.FTabelaRegC175VL_BC_COFINS.AsFloat := + dmPrincipal.FTabelaRegC175VL_BC_COFINS.AsFloat + ValorBase;
     end
   else
     begin
         dmPrincipal.FTabelaRegC175VL_COFINS.AsFloat    := dmPrincipal.FTabelaRegC175VL_COFINS.AsFloat + 0;
         dmPrincipal.FTabelaRegC175VL_BC_COFINS.AsFloat := + dmPrincipal.FTabelaRegC175VL_BC_COFINS.AsFloat + 0;
     end;

     dmPrincipal.FTabelaRegC175.Post;
     dmPrincipal.FTabelaRegC175.ApplyUpdates(0);

end;

procedure TSpedPisCofins.AcumularValoresAnaliticosRecC481C485();

   function ExisteCombinacaoITEM_CST_PIS_COF(const EcfCx, CodRedZ: Integer; const CodProd, CstPisCof: String): Boolean;
   begin
      FTabelaRegC481_C485.Filtered := False;
      FTabelaRegC481_C485.Filter := 'ECF_CX = ' + IntToStr(EcfCx) + ' and ' +
                                    'CRZ = ' + IntToStr(CodRedZ) + ' and ' +
                                    'COD_ITEM = ' + QuotedStr(CodProd) + ' and ' +
                                    'CST_PIS = ' + QuotedStr(CstPisCof);
      FTabelaRegC481_C485.Filtered := True;
      Result := (FTabelaRegC481_C485.RecordCount > 0);
   end;

var
   RegistroC400List: ACBrEFDBloco_C.TRegistroC400List;
   RegistroC460List: ACBrEFDBloco_C.TRegistroC460List;
   indxC400: Integer;
   indxC405: Integer;
   indxC460: Integer;
   indxC470: Integer;
   iCodEcfAux,
   iCrzAux: Integer;
   sCOD_ITEM: String;
   sCST_PIS_COF: STring;
   dVL_ITEM: Double;
   dVL_PIS: Double;
   dVL_COFINS: Double;
begin
   if (FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.Count > 0) then
      begin
         RegistroC400List := FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400;
         for indxC400 := 0 to RegistroC400List.Count - 1 do
            begin
               iCodEcfAux := StrToIntDef(RegistroC400List.Items[indxC400].ECF_CX,1);

                for indxC405 := 0 to RegistroC400List.items[indxC400].RegistroC405.Count - 1 do
                   begin
                      iCrzAux := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].CRZ;

                      {C460 - Cupons}
                      RegistroC460List := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC460;
                      for indxC460 := 0 to RegistroC460List.Count - 1 do
                         begin

                            {C470 - Itens do cupom}
                            for indxC470 := 0 to RegistroC460List.Items[indxC460].RegistroC470.Count - 1 do
                               begin

                                  sCOD_ITEM  := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].COD_ITEM;
                                  dVL_ITEM   := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].VL_ITEM;
                                  dVL_PIS    := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].VL_PIS;
                                  dVL_COFINS := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].VL_COFINS;
                                  sCST_PIS_COF := '49';

                                  if (ExisteCombinacaoITEM_CST_PIS_COF(iCodEcfAux, iCrzAux, sCOD_ITEM, sCST_PIS_COF)) then
                                     FTabelaRegC481_C485.Edit
                                  else
                                     FTabelaRegC481_C485.Append;

                                  if (FTabelaRegC481_C485.State = dsInsert) then
                                     begin
                                        FTabelaRegC481_C485.FieldByName('ECF_CX').AsInteger := iCodEcfAux;
                                        FTabelaRegC481_C485.FieldByName('CRZ').AsInteger := iCrzAux;
                                        FTabelaRegC481_C485.FieldByName('CST_PIS').AsString := sCST_PIS_COF;
                                        FTabelaRegC481_C485.FieldByName('CST_COFINS').AsString := sCST_PIS_COF;
                                        FTabelaRegC481_C485.FieldByName('COD_ITEM').AsString := sCOD_ITEM;
                                     end;

                                  FTabelaRegC481_C485.FieldByName('VL_ITEM').AsCurrency := FTabelaRegC481_C485.FieldByName('VL_ITEM').AsCurrency + dVL_ITEM;
                                  FTabelaRegC481_C485.FieldByName('VL_BC_PIS').AsCurrency := 0;
                                  FTabelaRegC481_C485.FieldByName('ALIQ_PIS').AsCurrency := 0;
                                  FTabelaRegC481_C485.FieldByName('VL_PIS').AsCurrency := 0;
                                  FTabelaRegC481_C485.FieldByName('VL_BC_COFINS').AsCurrency := 0;
                                  FTabelaRegC481_C485.FieldByName('ALIQ_COFINS').AsCurrency := 0;
                                  FTabelaRegC481_C485.FieldByName('VL_COFINS').AsCurrency := 0;
                                  FTabelaRegC481_C485.FieldByName('COD_CTA').AsString := '';
                               end; {for C470}

                         end; {for C460}
                   end;
            end; {for indxC400}
   end; {if C400.Count > 0}
end;

procedure TSpedPisCofins.AcumularValoresIPI(const CFOP, CST: String; const ValorBaseIPI, ValorIPI: Double);

    function ExisteCombinacaoCST_IPI: Boolean;
    begin
       FTabelaRegE510.IndexFieldNames:='CFOP';
       FTabelaRegE510.IndexFieldNames:='CST_IPI';
       FTabelaRegE510.Filtered := False;
       FTabelaRegE510.Filter := 'CFOP = ' + QuotedStr(Trim(CFOP)) + ' and ' +
                                'CST_IPI = ' + QuotedStr(CST);
       FTabelaRegE510.Filtered := True;
       Result := (FTabelaRegE510.RecordCount > 0);
    end;

begin
   if (ValorIPI <= 0) then
      Exit;

   if (ExisteCombinacaoCST_IPI()) then
      FTabelaRegE510.Edit
   else
      FTabelaRegE510.Append;

   if (FTabelaRegE510.State = dsInsert) then
      begin
         FTabelaRegE510.FieldByName('CFOP').AsString := Trim(CFOP);
         FTabelaRegE510.FieldByName('CST_IPI').AsString := CST;
      end;

   // Total Geral IPI
   FTabelaRegE510.FieldByName('VL_BC_IPI').AsFloat := FTabelaRegE510.FieldByName('VL_BC_IPI').AsFloat + ValorBaseIPI;
   FTabelaRegE510.FieldByName('VL_IPI').AsFloat := FTabelaRegE510.FieldByName('VL_IPI').AsFloat + ValorIPI;

   if (StrToIntDef(Trim(CFOP), 0) > 5000) then
      begin
         // Total Saídas
         FTabelaRegE510.FieldByName('TIPO').AsString := 'S';
         FTabelaRegE510.FieldByName('VL_BC_IPI_S').AsFloat := FTabelaRegE510.FieldByName('VL_BC_IPI_S').AsFloat + ValorBaseIPI;
         FTabelaRegE510.FieldByName('VL_IPI_S').AsFloat := FTabelaRegE510.FieldByName('VL_IPI_S').AsFloat + ValorIPI;
      end
   else
      begin
         // Total Entradas
         FTabelaRegE510.FieldByName('TIPO').AsString := 'E';
         FTabelaRegE510.FieldByName('VL_BC_IPI_E').AsFloat := FTabelaRegE510.FieldByName('VL_BC_IPI_E').AsFloat + ValorBaseIPI;
         FTabelaRegE510.FieldByName('VL_IPI_E').AsFloat := FTabelaRegE510.FieldByName('VL_IPI_E').AsFloat + ValorIPI;
      end;

   FTabelaRegE510.Post;
   FTabelaRegE510.Filtered := False;
end;

procedure TSpedPisCofins.AcumularValoresReceitaReg1900(const CFOP, CST_PIS_COF, ModDoc, Ser, SubSer: String; const ValorReceita, AliqPis, AliqCof: Double);

   function ExisteCombinacaoCST_PIS_COF: Boolean;
   begin
      dmPrincipal.FTabelaReg1900.Close;
      dmPrincipal.FTabelaReg1900.CommandText:='SELECT * FROM FTABELAREG1900 WHERE CFOP='+ QuotedStr(cfop) +' AND CST_PIS_COF='+QuotedStr(CST_PIS_COF)+' AND COD_MOD='+ QuotedStr(ModDoc) +'' ;
      dmPrincipal.FTabelaReg1900.Open;
      Result := (dmPrincipal.FTabelaReg1900.RecordCount > 0);
   end;

begin

   if (ValorReceita <= 0) then
      Exit;

   if (ExisteCombinacaoCST_PIS_COF()) then
      dmPrincipal.FTabelaReg1900.Edit
   else
      dmPrincipal.FTabelaReg1900.Append;


   if (dmPrincipal.FTabelaReg1900.State = dsInsert) then
      begin
         dmPrincipal.FTabelaReg1900CFOP.AsString        := Trim(CFOP);
         dmPrincipal.FTabelaReg1900CST_PIS_COF.AsString := CST_PIS_COF;
         dmPrincipal.FTabelaReg1900COD_MOD.AsString     := ModDoc;
      end;

   // Valor Receita
   dmPrincipal.FTabelaReg1900VL_TOT_REC.AsFloat := dmPrincipal.FTabelaReg1900VL_TOT_REC.AsFloat + ValorReceita;
   dmPrincipal.FTabelaReg1900SER.AsString       := Ser;
   dmPrincipal.FTabelaReg1900SUB_SER.AsString   := SubSer;
   dmPrincipal.FTabelaReg1900ALIQ_PIS.AsFloat   := AliqPis;
   dmPrincipal.FTabelaReg1900ALIQ_COF.AsFloat   := AliqCof;

   dmPrincipal.FTabelaReg1900.Post;
   dmPrincipal.FTabelaReg1900.ApplyUpdates(0);

end;

procedure TSpedPisCofins.AdicionarDadosAnaliticosNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean);
  var
   oItemProduto: TDetCollectionItem;
   Idx: Integer;
   cVlrOperacao,ImpostoItem: Currency;
   sCFOP: String;
   sCstIcms: String;
   dValorBCRed: Double;
begin

   (*
      PIS e COFINS
     REGISTRO C190: CONSOLIDAÇÃO DE NOTAS FISCAIS ELETRÔNICAS (CÓDIGO 55) –
                    OPERAÇÕES DE AQUISIÇÃO COM DIREITO A CRÉDITO, E OPERAÇÕES DE  DEVOLUÇÃO DE COMPRAS E VENDAS.
   *)

end;

procedure TSpedPisCofins.AdicionarDadosItensNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean);
var
   oItemProduto: TDetCollectionItem;
   Idx: Integer;
   sCST_PIS_COF,
   sCFOP,UniMedida,sNCM,vCstpis: String;
   dBasePis,
   dAliqPis,
   dValorPis,
   dBaseCof,
   dAliqCof,
   dValorCof,
   dValorBasePisCof,
   AliqPis,AliqCofins: Double;
   EnquandramentoTributario :String;

begin

   dBasePis:= 0;
   dAliqPis:= 0;
   dValorPis:= 0;
   dBaseCof:= 0;
   dAliqCof:= 0;
   dValorCof:= 0;
   dValorBasePisCof:= 0;
   AliqPis:= 0;
   AliqCofins:= 0;


  sCFOP    :='';
  UniMedida:='';
  sNCM     :='';



  GerarLinhaMemoLog('Carregando ' + IntToStr(Notas.Items[ 0 ].NFe.Det.Count) + ' itens da ' + Notas.Items[0].NFe.infNFe.ID);

  EnquandramentoTributario := dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.AsString ;

   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin


         oItemProduto := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];

        if (Notas.Items[0].NFe.Ide.modelo = 65) then  {notas de saida nfce}
           begin

             sCFOP := oItemProduto.Prod.CFOP;

               case oItemProduto.Imposto.PIS.CST of


                  pis01:
                    begin

                     sCST_PIS_COF     := CSTPISToStr(oItemProduto.Imposto.PIS.CST);
                     dBasePis         := oItemProduto.Imposto.PIS.vBC;
                     dAliqPis         := oItemProduto.Imposto.PIS.pPIS;
                     dValorPis        := oItemProduto.Imposto.PIS.vPIS;
                     dValorBasePisCof := oItemProduto.Prod.vProd;
                     dBaseCof         := oItemProduto.Imposto.COFINS.vBC;
                     dAliqCof         := oItemProduto.Imposto.COFINS.pCOFINS;
                     dValorCof        := oItemProduto.Imposto.COFINS.vCOFINS;
                     sNCM             := oItemProduto.Prod.NCM;



                     if  EnquandramentoTributario = 'P' then   // marretando pra nao da erro quando o fisco estiver errado
                        begin                                                              // 26082024

                          dAliqPis:= 0.65;
                          dAliqCof:= 3.0;

                        end
                     else if (EnquandramentoTributario = 'S') or (EnquandramentoTributario = 'R') then
                         begin

                           dAliqPis:= 1.65;
                           dAliqCof:= 7.6;

                         end;

                    end;

                    pis04, pis06, pis07, pis08, pis09:
                    begin

                       sCST_PIS_COF     := CSTPISToStr(oItemProduto.Imposto.PIS.CST);
                       dBasePis         := 0;
                       dAliqPis         := 0;
                       dValorPis        := 0;
                       dValorBasePisCof := oItemProduto.Prod.vProd;
                       dBaseCof         := 0;
                       dAliqCof         := 0;
                       dValorCof        := 0;

                    end;

                   else
                    begin

                      sCST_PIS_COF     := '49';
                      dBasePis         := 0;
                      dAliqPis         := 0;
                      dValorPis        := 0;
                      dValorBasePisCof := oItemProduto.Prod.vProd;;
                      dBaseCof         := 0;
                      dAliqCof         := 0;
                      dValorCof        := 0;

                    end;

               end;

           end
        else {notas de entrada}
           begin

             sCFOP := oItemProduto.Prod.CFOP;
             sCST_PIS_COF := CSTPISToStr (oItemProduto.Imposto.PIS.CST);

             dBasePis := 0;
             dAliqPis := 0;
             dValorPis:= 0;

             dBaseCof := 0;
             dAliqCof := 0;
             dValorCof:= 0;

             dValorBasePisCof := 0;
           end;



         if ((docEntrada) or (Notas.Items[0].NFe.Ide.tpNF = tnEntrada)) then
             sCST_PIS_COF := ConverterCST_PIS_COF_SaiToEnt( sCST_PIS_COF );


         if (Notas.Items[0].NFe.Ide.modelo <> 65) then
            begin

               UniMedida := 'UN';

               FTabelaRegC170.append;
               FTabelaRegC170.FieldByName('NFID').value           := NFID;
               FTabelaRegC170.FieldByName('NUM_ITEM').AsString    := IntToStr(Idx + 1);
               FTabelaRegC170.FieldByName('COD_ITEM').AsString    := oItemProduto.Prod.cProd;
               FTabelaRegC170.FieldByName('DESCR_COMPL').AsString := Copy(oItemProduto.Prod.xProd,1,60);
               FTabelaRegC170.FieldByName('QTD').AsFloat          := oItemProduto.Prod.qCom;
               FTabelaRegC170.FieldByName('UNID').AsString        := UniMedida;
               FTabelaRegC170.FieldByName('VL_ITEM').Asfloat      := oItemProduto.Prod.vProd;
               FTabelaRegC170.FieldByName('VL_DESC').Asfloat      := oItemProduto.Prod.vDesc;

               if (Length(oItemProduto.Prod.NCM) = 2) then
                  FTabelaRegC170.FieldByName('IND_MOV').AsInteger := 1 // Movimentação fisica = 0.SIM  1.NÃO
               else
                 FTabelaRegC170.FieldByName('IND_MOV').AsInteger  := 0; // Movimentação fisica = 0. SIM 1. NÃO

               if (Notas.Items[0].NFe.Emit.CRT = crtRegimeNormal) then
                  FTabelaRegC170.FieldByName('CST_ICMS').AsString := CSTICMSToStr(oItemProduto.Imposto.ICMS.CST)
               else
                  FTabelaRegC170.FieldByName('CST_ICMS').AsString := CSOSNIcmsToStr(oItemProduto.Imposto.ICMS.CSOSN);

               if (docEntrada) then
                  FTabelaRegC170.FieldByName('CFOP').AsString := ConverterCFOPEntrada(sCFOP)
               else
                  FTabelaRegC170.FieldByName('CFOP').AsString := sCFOP;

               FTabelaRegC170.FieldByName('COD_NAT').AsString      := GetCodNatReg0400ByCFOP(sCFOP);
               FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat    := oItemProduto.Imposto.ICMS.vBC;
               FTabelaRegC170.FieldByName('ALIQ_ICMS').AsFloat     := oItemProduto.Imposto.ICMS.pICMS;
               FTabelaRegC170.FieldByName('VL_ICMS').AsFloat       := oItemProduto.Imposto.ICMS.vICMS;
               FTabelaRegC170.FieldByName('VL_BC_ICMS_ST').AsFloat := oItemProduto.Imposto.ICMS.vBCST;
               FTabelaRegC170.FieldByName('ALIQ_ST').AsFloat       := oItemProduto.Imposto.ICMS.pICMSST;
               FTabelaRegC170.FieldByName('VL_ICMS_ST').AsFloat    := oItemProduto.Imposto.ICMS.vICMSST;

               // IPI
               if (FParamIndApurIPI = dmprincipal.cdsConsEmpresaPERIODO_IPI.Value) then // 0 - Mensal; 1 - Decendial
                  FTabelaRegC170.FieldByName('IND_APUR').AsInteger := 1
               else
                  FTabelaRegC170.FieldByName('IND_APUR').AsInteger := 0;

               if (docEntrada) then
                  FTabelaRegC170.FieldByName('CST_IPI').AsString := ''// ConverteCstIPI_Entrada(CSTIPIToStr(oItemProduto.Imposto.IPI.CST))// '49' // Outras entradas  mexer aqui
               else
                  FTabelaRegC170.FieldByName('CST_IPI').AsString := CSTIPIToStr(oItemProduto.Imposto.IPI.CST);

               FTabelaRegC170.FieldByName('COD_ENQ').AsString := ''; //Não preencher - segundo o manual;
               FTabelaRegC170.FieldByName('VL_BC_IPI').AsFloat:= oItemProduto.Imposto.IPI.vBC;
               FTabelaRegC170.FieldByName('ALIQ_IPI').AsFloat := oItemProduto.Imposto.IPI.pIPI;
               FTabelaRegC170.FieldByName('VL_IPI').AsFloat   := oItemProduto.Imposto.IPI.vIPI;

               if (FcompSpedPisCofins.Bloco_0.Registro0000.IND_ATIV = indAtivIndustrial) then
                  AcumularValoresIPI(sCFOP, CSTIPIToStr(oItemProduto.Imposto.IPI.CST), oItemProduto.Imposto.IPI.vBC, oItemProduto.Imposto.IPI.vIPI);

                 dmPrincipal.FDMemTBCST50.open;
               if sCST_PIS_COF ='50' then
                  begin

                      dBasePis         := oItemProduto.Imposto.PIS.vBC;
                      dBaseCof         := oItemProduto.Imposto.COFINS.vBC;
                      dValorPis        := oItemProduto.Imposto.PIS.vPIS;
                      dValorCof        := oItemProduto.Imposto.COFINS.vCOFINS;

                      dAliqPis         := oItemProduto.Imposto.PIS.pPIS;
                     // dValorBasePisCof := oItemProduto.Prod.vProd;
                      dAliqCof         := oItemProduto.Imposto.COFINS.pCOFINS;


                      //===========================bloco de teste
//                      dmPrincipal.FDMemTBCST50.Edit;
//                      dmPrincipal.FDMemTBCST50valorBC.Value     := dmPrincipal.FDMemTBCST50valorBC.Value     + dBasePis;
//                      dmPrincipal.FDMemTBCST50valorPis.Value    := dmPrincipal.FDMemTBCST50valorPis.Value    + dValorPis;
//                      dmPrincipal.FDMemTBCST50valorCofins.Value := dmPrincipal.FDMemTBCST50valorCofins.Value + dValorCof;
//                      dmPrincipal.FDMemTBCST50.Post;


                    { dmPrincipal.cdsRegC170.close;
                     dmPrincipal.cdsRegC170.Open;
                     dmPrincipal.cdsRegC170.Append;

                     dmPrincipal.cdsRegC170NFID.value        := NFID;
                     dmPrincipal.cdsRegC170NUM_ITEM.value    := IntToStr(Idx + 1);
                     dmPrincipal.cdsRegC170COD_ITEM.value    := oItemProduto.Prod.cProd;
                     dmPrincipal.cdsRegC170DESCR_COMPL.value := Copy(oItemProduto.Prod.xProd,1,60);
                     dmPrincipal.cdsRegC170QTD.AsFloat       := oItemProduto.Prod.qCom;
                     dmPrincipal.cdsRegC170UNID.AsString     := UniMedida;
                     dmPrincipal.cdsRegC170VL_ITEM.Asfloat   := oItemProduto.Prod.vProd;
                     dmPrincipal.cdsRegC170VL_DESC.Asfloat   := oItemProduto.Prod.vDesc;

                     if (Length(oItemProduto.Prod.NCM) = 2) then
                      dmPrincipal.cdsRegC170IND_MOV.AsInteger := 1 // Movimentação fisica = 0.SIM  1.NÃO
                     else
                       dmPrincipal.cdsRegC170IND_MOV.AsInteger  := 0; // Movimentação fisica = 0. SIM 1. NÃO

                     if (Notas.Items[0].NFe.Emit.CRT = crtRegimeNormal) then
                        dmPrincipal.cdsRegC170CST_ICMS.AsString := CSTICMSToStr(oItemProduto.Imposto.ICMS.CST)
                     else
                        dmPrincipal.cdsRegC170CST_ICMS.AsString := CSOSNIcmsToStr(oItemProduto.Imposto.ICMS.CSOSN);

                     if (docEntrada) then
                        dmPrincipal.cdsRegC170CFOP.AsString := ConverterCFOPEntrada(sCFOP);

                     dmPrincipal.cdsRegC170CST_PIS.value      := sCST_PIS_COF;
                     dmPrincipal.cdsRegC170VL_BC_PIS.value    := dBasePis;
                     dmPrincipal.cdsRegC170ALIQ_PIS_PERC.value:= dAliqPis;
                     dmPrincipal.cdsRegC170QUANT_BC_PIS.value := 0;
                     dmPrincipal.cdsRegC170ALIQ_PIS_R.value   := 0; //EM REAIS
                     dmPrincipal.cdsRegC170VL_PIS.value       := dValorPis;

                     // COFINS
                     dmPrincipal.cdsRegC170CST_COFINS.value       := sCST_PIS_COF;
                     dmPrincipal.cdsRegC170VL_BC_COFINS.value     := dBaseCof;
                     dmPrincipal.cdsRegC170ALIQ_COFINS_PERC.value := dAliqCof;
                     dmPrincipal.cdsRegC170QUANT_BC_COFINS.value  := 0;
                     dmPrincipal.cdsRegC170ALIQ_COFINS_R.value    := 0; //EM REAIS
                     dmPrincipal.cdsRegC170VL_COFINS.value        := dValorCof;
                     dmPrincipal.cdsRegC170COD_CTA.value          := '';
                     dmPrincipal.cdsRegC170.Post;
                     dmPrincipal.cdsRegC170.ApplyUpdates(0);   }
                     //===================== teste acima ======================


                        // PIS
                     FTabelaRegC170.FieldByName('CST_PIS').AsString      := sCST_PIS_COF;
                     FTabelaRegC170.FieldByName('VL_BC_PIS').AsFloat     := dBasePis;
                     FTabelaRegC170.FieldByName('ALIQ_PIS_PERC').AsFloat := dAliqPis;
                     FTabelaRegC170.FieldByName('QUANT_BC_PIS').AsFloat  := 0;
                     FTabelaRegC170.FieldByName('ALIQ_PIS_R').AsFloat    := 0; //EM REAIS
                     FTabelaRegC170.FieldByName('VL_PIS').AsFloat        := dValorPis;

                     // COFINS
                     FTabelaRegC170.FieldByName('CST_COFINS').AsString      := sCST_PIS_COF;
                     FTabelaRegC170.FieldByName('VL_BC_COFINS').AsFloat     := dBaseCof;
                     FTabelaRegC170.FieldByName('ALIQ_COFINS_PERC').AsFloat := dAliqCof;
                     FTabelaRegC170.FieldByName('QUANT_BC_COFINS').AsFloat  := 0;
                     FTabelaRegC170.FieldByName('ALIQ_COFINS_R').AsFloat    := 0; //EM REAIS
                     FTabelaRegC170.FieldByName('VL_COFINS').AsFloat        := dValorCof;
                     FTabelaRegC170.FieldByName('COD_CTA').AsString         := '';
                     FTabelaRegC170.Post;

                  end
               else
                  begin

                   // PIS
                   FTabelaRegC170.FieldByName('CST_PIS').AsString      := sCST_PIS_COF;
                   FTabelaRegC170.FieldByName('VL_BC_PIS').AsFloat     := dBasePis;
                   FTabelaRegC170.FieldByName('ALIQ_PIS_PERC').AsFloat := dAliqPis;
                   FTabelaRegC170.FieldByName('QUANT_BC_PIS').AsFloat  := 0;
                   FTabelaRegC170.FieldByName('ALIQ_PIS_R').AsFloat    := 0; //EM REAIS
                   FTabelaRegC170.FieldByName('VL_PIS').AsFloat        := dValorPis;

                   // COFINS
                   FTabelaRegC170.FieldByName('CST_COFINS').AsString      := sCST_PIS_COF;
                   FTabelaRegC170.FieldByName('VL_BC_COFINS').AsFloat     := dBaseCof;
                   FTabelaRegC170.FieldByName('ALIQ_COFINS_PERC').AsFloat := dAliqCof;
                   FTabelaRegC170.FieldByName('QUANT_BC_COFINS').AsFloat  := 0;
                   FTabelaRegC170.FieldByName('ALIQ_COFINS_R').AsFloat    := 0; //EM REAIS
                   FTabelaRegC170.FieldByName('VL_COFINS').AsFloat        := dValorCof;
                   FTabelaRegC170.FieldByName('COD_CTA').AsString         := '';
                   FTabelaRegC170.Post;
                 end;{if <> 65}
            end;

        if (not docEntrada) then
            begin


               AcumularValoresReceitaReg1900(sCFOP,
                                                 sCST_PIS_COF,
                                                 IntToStr(Notas.Items[0].NFe.Ide.modelo),
                                                 IntToStr(Notas.Items[0].NFe.Ide.serie),
                                                 '0', // Subserie
                                                 oItemProduto.Prod.vProd,
                                                 dAliqPis,
                                                 dAliqCof);





                AcumularValoreAnaliticoRegC175(NFID,
                                              sCFOP,
                                              sCST_PIS_COF,
                                              dValorBasePisCof,
                                              dAliqPis,
                                              dAliqCof,
                                              dValorPis,
                                              dValorCof,
                                              FTabelaRegC170.FieldByName('VL_DESC').Asfloat);

            end;
      end;// for


end;

procedure TSpedPisCofins.AdicionarDadosItensNotasServicos(const NFID: Integer; Notas: TNotasFiscais;
   const docEntrada: Boolean);
var
  Idx: Integer;
//  sCFOP: String;
  sCST_PIS_COF: String;
  oItemServico: TDetCollectionItem;
  dBasePis,
  dAliqPis,
  dValorPis,
  dBaseCof,
  dAliqCof,
  dValorCof,
  dValorBasePisCof: Double;
begin
//   GerarLinhaMemoLog('Carregando ' + IntToStr(Notas.Items[ 0 ].NFe.Det.Count) + ' itens de serviço');

   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemServico := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];

//         sCFOP := oItemServico.Prod.CFOP;

         // ** Trata Pis
         if (oItemServico.Imposto.PIS.pPIS > 0) then
            begin
               sCST_PIS_COF := CSTPISToStr(oItemServico.Imposto.PIS.CST);
               dBasePis := oItemServico.Imposto.PIS.vBC;
               dAliqPis := oItemServico.Imposto.PIS.pPIS;
               dValorPis := oItemServico.Imposto.PIS.vPIS;
               dValorBasePisCof := oItemServico.Prod.vProd;
            end
         else
            begin
               sCST_PIS_COF := '49';
               dBasePis := 0;
               dAliqPis := 0;
               dValorPis := 0;
               dValorBasePisCof := 0;
            end;

         if ((docEntrada) or (Notas.Items[0].NFe.Ide.tpNF = tnEntrada)) then
            sCST_PIS_COF := ConverterCST_PIS_COF_SaiToEnt( sCST_PIS_COF );

         // ** Trata Cofins
         if (oItemServico.Imposto.COFINS.pCOFINS > 0) then
            begin
               dBaseCof := oItemServico.Imposto.COFINS.vBC;
               dAliqCof := oItemServico.Imposto.COFINS.pCOFINS;
               dValorCof := oItemServico.Imposto.COFINS.vCOFINS;
            end
         else
            begin
               dBaseCof := 0;
               dAliqCof := 0;
               dValorCof := 0;
            end;

         FTabelaRegA170.Append;
         FTabelaRegA170.FieldByName('NFID').AsInteger := NFID;
         FTabelaRegA170.FieldByName('NUM_ITEM').AsInteger := (Idx + 1);
         FTabelaRegA170.FieldByName('COD_ITEM').AsString := oItemServico.Prod.cProd;
         FTabelaRegA170.FieldByName('DESCR_COMPL').AsString := Copy(oItemServico.Prod.xProd,1,60);
         FTabelaRegA170.FieldByName('VL_ITEM').Asfloat := oItemServico.Prod.vProd;
         FTabelaRegA170.FieldByName('VL_DESC').Asfloat := oItemServico.Prod.vDesc;
         FTabelaRegA170.FieldByName('NAT_BC_CRED').AsString := '13';// Aquisição de bens para revenda; {Código da Base de Cálculo do Crédito - Tabela indicada no item 4.3.7}
         FTabelaRegA170.FieldByName('IND_ORIG_CRED').AsInteger := 0; {0 - Oper. Mercado. Interno, 1 - Oper. Importação}
         FTabelaRegA170.FieldByName('CST_PIS').AsString := sCST_PIS_COF;
         FTabelaRegA170.FieldByName('VL_BC_PIS').AsFloat := dBasePis;
         FTabelaRegA170.FieldByName('ALIQ_PIS').AsFloat := dAliqPis;
         FTabelaRegA170.FieldByName('VL_PIS').AsFloat := dValorPis;
         FTabelaRegA170.FieldByName('CST_COFINS').AsString := sCST_PIS_COF;
         FTabelaRegA170.FieldByName('VL_BC_COFINS').AsFloat := dBaseCof;
         FTabelaRegA170.FieldByName('ALIQ_COFINS').AsFloat := dAliqCof;
         FTabelaRegA170.FieldByName('VL_COFINS').AsFloat := dValorCof;
         FTabelaRegA170.FieldByName('COD_CTA').AsString := '';
         FTabelaRegA170.FieldByName('COD_CCUS').AsString := '';
         FTabelaRegA170.Post;
      end;
end;

function TSpedPisCofins.AdicionarDadosNotas(Notas: TNotasFiscais; const docEntrada: Boolean): Integer;
var
   sCNPJCPF: String;
   sChave: String;
begin


    try

      FTabelaRegC100.AddIndex('CHV_NFEIndex', 'CHV_NFE', [ixUnique]);
      FTabelaRegC100.IndexFieldNames := 'CHV_NFE';

      FTabelaRegC100.Filtered := False;
      Result := (FTabelaRegC100.RecordCount + 1);
      sChave := StringReplace(Notas.Items[0].NFe.infNFe.ID,'NFe',EmptyStr,[rfIgnoreCase]);
      FTabelaRegC100.Filter := 'CHV_NFE = ' + QuotedStr(sChave);
      FTabelaRegC100.Filtered := True;


//      Result := (FTabelaRegC100.RecordCount + 1);
//      sChave := StringReplace(Notas.Items[0].NFe.infNFe.ID,'NFe',EmptyStr,[rfIgnoreCase]);
//   //   FTabelaRegC100.Locate('CHV_NFE',QuotedStr(sChave),[loCaseInsensitive, loPartialKey]);

      if (FTabelaRegC100.IsEmpty) then
         begin

          if (docEntrada) then
               GerarLinhaMemoLog('Carregando dados (C100) da nota entrada' + sChave)
            else
               GerarLinhaMemoLog('Carregando dados (C100) da nota saída' + sChave);

            FTabelaRegC100.Append;
            FTabelaRegC100.FieldByName('ID').AsInteger := Result;

            if (docEntrada) then
               FTabelaRegC100.FieldByName('IND_OPER').AsInteger := 0
            else
            {0-Entrada; 1-Saída}
            if (Notas.Items[0].NFe.Ide.tpNF = tnEntrada) then
               FTabelaRegC100.FieldByName('IND_OPER').AsInteger := 0
            else
               FTabelaRegC100.FieldByName('IND_OPER').AsInteger := 1;

            FTabelaRegC100.FieldByName('COD_MOD').AsString := IntToStr(Notas.Items[0].NFe.Ide.modelo);
            FTabelaRegC100.FieldByName('SER').AsString := FormatFloat('000', Notas.Items[0].NFe.Ide.serie);
            FTabelaRegC100.FieldByName('NUM_DOC').AsInteger := Notas.Items[0].NFe.Ide.nNF;
            FTabelaRegC100.FieldByName('CHV_NFE').AsString := sChave;

            {
              COD_SIT

              sdRegular             0 - Documento regular
              sdExtempRegular       1 - Escrituração extemporânea de documento regular
              sdCancelado           2 - Documento cancelado
              sdCanceladoExtemp     3 - Escrituração extemporânea de documento cancelado
              sdDoctoDenegado       4 - NF-e ou CT-e - denegado
              sdDoctoNumInutilizada 5 - NF-e ou CT-e - Numeração inutilizada
              sdFiscalCompl         6 - Documento Fiscal Complementar
              sdExtempCompl         7 - Escrituração extemporânea de documento complementar
              sdRegimeEspecNEsp     8 - Documento Fiscal emitido com base em Regime Especial ou Norma Específica
            }
            FTabelaRegC100.FieldByName('COD_SIT').AsInteger := 0; {Documento regular}

             if (not docEntrada) then
               begin
                  if (NotaCancelada(sChave)) then
                     begin
                        FTabelaRegC100.FieldByName('COD_SIT').AsInteger := 2; {Documento cancelado}
                        GerarLinhaMemoLog('Documento cancelado: ' + ifthen(Notas.Items[0].NFe.Ide.modelo = 65, 'NFC-e', 'NF-e')
                              + ' Nr. ' + IntToStr(FTabelaRegC100.FieldByName('NUM_DOC').AsInteger));
                     end;
               end;

            sCNPJCPF := Notas.Items[0].NFe.Dest.CNPJCPF;
            if docEntrada then
               sCNPJCPF := Notas.Items[0].NFe.Emit.CNPJCPF;

            FTabelaRegC100.FieldByName('COD_PART').AsString := GetCodPartByCnpjCpf(sCNPJCPF);
            FTabelaRegC100.FieldByName('DT_DOC').AsDateTime := Notas.Items[0].NFe.Ide.dEmi;
            FTabelaRegC100.FieldByName('DT_E_S').AsDateTime := Notas.Items[0].NFe.Ide.dEmi;
            FTabelaRegC100.FieldByName('VL_DOC').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vNF;

            case Notas.Items[0].NFe.Ide.indPag of
               ipVista : FTabelaRegC100.FieldByName('IND_PGTO').AsInteger := 0;
               ipPrazo : FTabelaRegC100.FieldByName('IND_PGTO').AsFloat   := 1;
               ipOutras: FTabelaRegC100.FieldByName('IND_PGTO').AsFloat   := 2;
            else
               FTabelaRegC100.FieldByName('IND_PGTO').AsInteger := 0;
            end;

            FTabelaRegC100.FieldByName('VL_DESC').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vDesc;
            FTabelaRegC100.FieldByName('VL_ABAT_NT').AsFloat := 0;
            FTabelaRegC100.FieldByName('VL_MERC').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vProd;
            {
             0 - Por conta do emitente
             1 - Por conta do destinatário/remetente
             2 - Por conta de terceiros
             9 - Sem cobrança de frete
            }
            case Notas.Items[0].NFe.Transp.ModFrete of
               mfContaEmitente    : FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 0;
               mfContaDestinatario: FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 1;
               mfContaTerceiros   : FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 2;
               mfSemFrete         : FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 9;
            else
               FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 0;
            end;

            FTabelaRegC100.FieldByName('VL_FRT').AsFloat        := Notas.Items[0].NFe.Total.ICMSTot.vFrete;
            FTabelaRegC100.FieldByName('VL_SEG').AsFloat        := Notas.Items[0].NFe.Total.ICMSTot.vSeg;
            FTabelaRegC100.FieldByName('VL_OUT_DA').AsFloat     := Notas.Items[0].NFe.Total.ICMSTot.vOutro;
            FTabelaRegC100.FieldByName('VL_BC_ICMS').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vBC;
            FTabelaRegC100.FieldByName('VL_ICMS').AsFloat       := Notas.Items[0].NFe.Total.ICMSTot.vICMS;
            FTabelaRegC100.FieldByName('VL_BC_ICMS_ST').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vBCST;
            FTabelaRegC100.FieldByName('VL_ICMS_ST').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vST;
            FTabelaRegC100.FieldByName('VL_IPI').AsFloat        := Notas.Items[0].NFe.Total.ICMSTot.vIPI;
            FTabelaRegC100.FieldByName('VL_PIS').AsFloat        := Notas.Items[0].NFe.Total.ICMSTot.vPIS;
            FTabelaRegC100.FieldByName('VL_COFINS').AsFloat     := Notas.Items[0].NFe.Total.ICMSTot.vCOFINS;
            FTabelaRegC100.FieldByName('VL_PIS_ST').AsFloat     := 0;
            FTabelaRegC100.FieldByName('VL_COFINS_ST').AsFloat  := 0;
            FTabelaRegC100.Post;

         end
      else
         Result := 0;
   finally
      FTabelaRegC100.Filtered := False;
   end;


end;

procedure TSpedPisCofins.AdicionarDadosNotasNotas(Notas: TNotasFiscais);
var
   sCNPJCPF: String;
   sChave: String;
   docEntrada :Boolean;
begin
 // mauricio teste 24102024

 try

    if (Copy(sChave, 21, 2) = '55')then
       docEntrada :=true
    else
      docEntrada :=false;


     sChave := StringReplace(Notas.Items[0].NFe.infNFe.ID,'NFe',EmptyStr,[rfIgnoreCase]);

      FTabelaRegC100.Locate('CHV_NFE',QuotedStr(sChave),[]) ;
      if (FTabelaRegC100.IsEmpty) then
         begin
//            if (docEntrada) then
//               GerarLinhaMemoLog('Carregando dados (C100) da nota entrada' + sChave)
//            else
//              GerarLinhaMemoLog('Carregando dados (C100) da nota saída' + sChave);

            FTabelaRegC100.Append;
            FTabelaRegC100.FieldByName('ID').AsInteger :=FTabelaRegC100.RecordCount + 1;//  Result;

            if (docEntrada) then
               FTabelaRegC100.FieldByName('IND_OPER').AsInteger := 0
            else
            {0-Entrada; 1-Saída}
            if (Notas.Items[0].NFe.Ide.tpNF = tnEntrada) then
               FTabelaRegC100.FieldByName('IND_OPER').AsInteger := 0
            else
               FTabelaRegC100.FieldByName('IND_OPER').AsInteger := 1;

            FTabelaRegC100.FieldByName('COD_MOD').AsString  := IntToStr(Notas.Items[0].NFe.Ide.modelo);
            FTabelaRegC100.FieldByName('SER').AsString      := FormatFloat('000', Notas.Items[0].NFe.Ide.serie);
            FTabelaRegC100.FieldByName('NUM_DOC').AsInteger := Notas.Items[0].NFe.Ide.nNF;
            FTabelaRegC100.FieldByName('CHV_NFE').AsString  := sChave;

            {
              COD_SIT

              sdRegular             0 - Documento regular
              sdExtempRegular       1 - Escrituração extemporânea de documento regular
              sdCancelado           2 - Documento cancelado
              sdCanceladoExtemp     3 - Escrituração extemporânea de documento cancelado
              sdDoctoDenegado       4 - NF-e ou CT-e - denegado
              sdDoctoNumInutilizada 5 - NF-e ou CT-e - Numeração inutilizada
              sdFiscalCompl         6 - Documento Fiscal Complementar
              sdExtempCompl         7 - Escrituração extemporânea de documento complementar
              sdRegimeEspecNEsp     8 - Documento Fiscal emitido com base em Regime Especial ou Norma Específica
            }
            FTabelaRegC100.FieldByName('COD_SIT').AsInteger := 0; {Documento regular}

             if (not docEntrada) then
               begin
                  if (NotaCancelada(sChave)) then
                     begin
                        FTabelaRegC100.FieldByName('COD_SIT').AsInteger := 2; {Documento cancelado}
                        GerarLinhaMemoLog('Documento cancelado: ' + ifthen(Notas.Items[0].NFe.Ide.modelo = 65, 'NFC-e', 'NF-e')
                              + ' Nr. ' + IntToStr(FTabelaRegC100.FieldByName('NUM_DOC').AsInteger));
                     end;
               end;

            sCNPJCPF := Notas.Items[0].NFe.Dest.CNPJCPF;
            if docEntrada then
               sCNPJCPF := Notas.Items[0].NFe.Emit.CNPJCPF;

            FTabelaRegC100.FieldByName('COD_PART').AsString := GetCodPartByCnpjCpf(sCNPJCPF);
            FTabelaRegC100.FieldByName('DT_DOC').AsDateTime := Notas.Items[0].NFe.Ide.dEmi;
            FTabelaRegC100.FieldByName('DT_E_S').AsDateTime := Notas.Items[0].NFe.Ide.dEmi;
            FTabelaRegC100.FieldByName('VL_DOC').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vNF;

            case Notas.Items[0].NFe.Ide.indPag of
               ipVista : FTabelaRegC100.FieldByName('IND_PGTO').AsInteger := 0;
               ipPrazo : FTabelaRegC100.FieldByName('IND_PGTO').AsFloat := 1;
               ipOutras: FTabelaRegC100.FieldByName('IND_PGTO').AsFloat := 2;
            else
               FTabelaRegC100.FieldByName('IND_PGTO').AsInteger := 0;
            end;

            FTabelaRegC100.FieldByName('VL_DESC').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vDesc;
            FTabelaRegC100.FieldByName('VL_ABAT_NT').AsFloat := 0;
            FTabelaRegC100.FieldByName('VL_MERC').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vProd;
            {
             0 - Por conta do emitente
             1 - Por conta do destinatário/remetente
             2 - Por conta de terceiros
             9 - Sem cobrança de frete
            }
            case Notas.Items[0].NFe.Transp.ModFrete of
               mfContaEmitente    : FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 0;
               mfContaDestinatario: FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 1;
               mfContaTerceiros   : FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 2;
               mfSemFrete         : FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 9;
            else
               FTabelaRegC100.FieldByName('IND_FRT').AsInteger := 0;
            end;

            FTabelaRegC100.FieldByName('VL_FRT').AsFloat       := Notas.Items[0].NFe.Total.ICMSTot.vFrete;
            FTabelaRegC100.FieldByName('VL_SEG').AsFloat       := Notas.Items[0].NFe.Total.ICMSTot.vSeg;
            FTabelaRegC100.FieldByName('VL_OUT_DA').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vOutro;
            FTabelaRegC100.FieldByName('VL_BC_ICMS').AsFloat   := Notas.Items[0].NFe.Total.ICMSTot.vBC;
            FTabelaRegC100.FieldByName('VL_ICMS').AsFloat      := Notas.Items[0].NFe.Total.ICMSTot.vICMS;
            FTabelaRegC100.FieldByName('VL_BC_ICMS_ST').AsFloat:= Notas.Items[0].NFe.Total.ICMSTot.vBCST;
            FTabelaRegC100.FieldByName('VL_ICMS_ST').AsFloat   := Notas.Items[0].NFe.Total.ICMSTot.vST;
            FTabelaRegC100.FieldByName('VL_IPI').AsFloat       := Notas.Items[0].NFe.Total.ICMSTot.vIPI;
            FTabelaRegC100.FieldByName('VL_PIS').AsFloat       := Notas.Items[0].NFe.Total.ICMSTot.vPIS;
            FTabelaRegC100.FieldByName('VL_COFINS').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vCOFINS;
            FTabelaRegC100.FieldByName('VL_PIS_ST').AsFloat    := 0;
            FTabelaRegC100.FieldByName('VL_COFINS_ST').AsFloat := 0;
            FTabelaRegC100.Post;
         end;

   finally
     // FTabelaRegC100.Filtered := False;
   end;


end;

function TSpedPisCofins.AdicionarDadosNotasServicos(Notas: TNotasFiscais; const docEntrada: Boolean): Integer;
var
   sChave: String;
begin
   try
      FTabelaRegA100.IndexFieldNames:= 'CHV_NFSE';
      FTabelaRegA100.Filtered := False;
      Result := (FTabelaRegA100.RecordCount + 1);
      sChave := StringReplace(Notas.Items[0].NFe.infNFe.ID,'NFe',EmptyStr,[rfIgnoreCase]);
      FTabelaRegA100.Filter := 'CHV_NFSE = ' + QuotedStr(sChave);
      FTabelaRegA100.Filtered := True;

      if (FTabelaRegA100.IsEmpty) then
         begin
            GerarLinhaMemoLog('Carregando dados (A100) da nota de serviços prestados: ' + sChave);

            FTabelaRegA100.Append;
            FTabelaRegA100.FieldByName('ID').AsInteger := Result;


            if docEntrada then
               begin
                  {0 - contratado, 1 - Prestado}
                  FTabelaRegA100.FieldByName('IND_OPER').AsInteger := 0;

                  {0 - Emiss prop. 1 - Emiss. Terc.}
                  FTabelaRegA100.FieldByName('IND_EMIT').AsInteger := 1;
               end
            else
               begin
                  {0 - contratado, 1 - Prestado}
                  FTabelaRegA100.FieldByName('IND_OPER').AsInteger := 1;
                  {0 - Emiss prop. 1 - Emiss. Terc.}
                  FTabelaRegA100.FieldByName('IND_EMIT').AsInteger := 0;
               end;

            FTabelaRegA100.FieldByName('SER').AsString := FormatFloat('000', Notas.Items[0].NFe.Ide.serie);
            FTabelaRegA100.FieldByName('NUM_DOC').AsInteger := Notas.Items[0].NFe.Ide.nNF;
            FTabelaRegA100.FieldByName('CHV_NFSE').AsString := sChave;
            FTabelaRegA100.FieldByName('COD_PART').AsString := GetCodPartByCnpjCpf( Notas.Items[0].NFe.Dest.CNPJCPF );
            FTabelaRegA100.FieldByName('COD_SIT').AsInteger := 0; {00 - Regular, 02 Cancelado}
            if (NotaServicoCancelada(sChave)) then
               begin
                  FTabelaRegA100.FieldByName('COD_SIT').AsInteger := 2; {00 - Regular, 02 Cancelado}
                  GerarLinhaMemoLog('Documento cancelado: NF-e de Serviços Nr. ' + IntToStr(FTabelaRegA100.FieldByName('NUM_DOC').AsInteger));
               end;
            FTabelaRegA100.FieldByName('DT_DOC').AsDateTime := Notas.Items[0].NFe.Ide.dEmi;
            FTabelaRegA100.FieldByName('DT_EXE_SERV').AsDateTime := Notas.Items[0].NFe.Ide.dEmi; { Data conclusão serviço }

            FTabelaRegA100.FieldByName('VL_DOC').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vNF;

            {0 - A vista, 1 - A prazo, 9 - Sem Pgto}
            case Notas.Items[0].NFe.Ide.indPag of
               ipVista : FTabelaRegA100.FieldByName('IND_PGTO').AsInteger := 0;
               ipPrazo : FTabelaRegA100.FieldByName('IND_PGTO').AsFloat := 1;
               ipOutras: FTabelaRegA100.FieldByName('IND_PGTO').AsFloat := 2;
            else
               FTabelaRegA100.FieldByName('IND_PGTO').AsInteger := 0;
            end;

            FTabelaRegA100.FieldByName('VL_DESC').AsFloat       := Notas.Items[0].NFe.Total.ICMSTot.vDesc;
            FTabelaRegA100.FieldByName('VL_BC_PIS').AsFloat     := GetTotalBasePis(Notas);
            FTabelaRegA100.FieldByName('VL_PIS').AsFloat        := Notas.Items[0].NFe.Total.ICMSTot.vPIS;
            FTabelaRegA100.FieldByName('VL_BC_COFINS').AsFloat  := GetTotalBaseCofins(Notas);
            FTabelaRegA100.FieldByName('VL_COFINS').AsFloat     := Notas.Items[0].NFe.Total.ICMSTot.vCOFINS;
            FTabelaRegA100.FieldByName('VL_PIS_RET').AsFloat    := 0;
            FTabelaRegA100.FieldByName('VL_COFINS_RET').AsFloat := 0;
            FTabelaRegA100.FieldByName('VL_ISS').AsFloat        := Notas.Items[0].NFe.Total.ISSQNtot.vISS;

            FTabelaRegA100.Post;
         end;
   finally
      FTabelaRegA100.Filtered := False;
   end;
end;

procedure TSpedPisCofins.AdicionarDadosParticipante(Notas: TNotasFiscais; const docEntrada: Boolean);
var
   iProxSeqCod: Integer;

   sCNPJCPF: String;
   sxNome: String;
   sIE: String;
   sxLgr: String;
   snro: String;
   sxCpl: String;
   sxBairro: String;

   icPais: Integer;
   icMun: Integer;
begin
   // Para documentos de saida NFCe - 65 não adicionar nos participantes
   if (Notas.Items[0].NFe.Ide.modelo = 65) then
      Exit;

  GerarLinhaMemoLog('Carregando dados participante: ' + Notas.Items[0].NFe.infNFe.ID);

   try
      sCNPJCPF := Notas.Items[0].NFe.Dest.CNPJCPF;
      sxNome   := Notas.Items[0].NFe.Dest.xNome;
      icPais   := Notas.Items[0].NFe.Dest.EnderDest.cPais;
      sIE      := Notas.Items[0].NFe.Dest.IE;
      icMun    := Notas.Items[0].NFe.Dest.EnderDest.cMun;
      sxLgr    := Notas.Items[0].NFe.Dest.EnderDest.xLgr;
      snro     := Copy(Notas.Items[0].NFe.Dest.EnderDest.nro,1,60);
      sxCpl    := Copy(Notas.Items[0].NFe.Dest.EnderDest.xCpl,1,60);
      sxBairro := Copy(Notas.Items[0].NFe.Dest.EnderDest.xBairro,1,60);

      if (docEntrada) then
         begin
            sCNPJCPF := Notas.Items[0].NFe.Emit.CNPJCPF;
            sxNome   := Notas.Items[0].NFe.Emit.xNome;
            icPais   := Notas.Items[0].NFe.Emit.EnderEmit.cPais;
            sIE      := Notas.Items[0].NFe.Emit.IE;
            icMun    := Notas.Items[0].NFe.Emit.EnderEmit.cMun;
            sxLgr    := Notas.Items[0].NFe.Emit.EnderEmit.xLgr;
            snro     := Copy(Notas.Items[0].NFe.Emit.EnderEmit.nro,1,60);
            sxCpl    := Copy(Notas.Items[0].NFe.Emit.EnderEmit.xCpl,1,60);
            sxBairro := Copy(Notas.Items[0].NFe.Emit.EnderEmit.xBairro,1,60);
         end;

      FTabelaReg0150.AddIndex('CNPJCPFIndex', 'CNPJCPF', [ixUnique]);
      FTabelaReg0150.Filtered := False;
      iProxSeqCod := (FTabelaReg0150.RecordCount + 1);
      FTabelaReg0150.IndexFieldNames := 'CNPJCPF';
      FTabelaReg0150.Filter := 'CNPJCPF = ' + QuotedStr(sCNPJCPF);
      FTabelaReg0150.Filtered := True;

      if (FTabelaReg0150.IsEmpty) then
         begin
            FTabelaReg0150.Append;

            if (docEntrada) then
               FTabelaReg0150.FieldByName('COD_PART').AsString := 'F' + IntToStr(iProxSeqCod)
            else
               FTabelaReg0150.FieldByName('COD_PART').AsString := 'C' + IntToStr(iProxSeqCod);

            if (sxNome <> '') then
               FTabelaReg0150.FieldByName('NOME').AsString := sxNome
            else
               FTabelaReg0150.FieldByName('NOME').AsString := 'PARTICIPANTE SEM NOME ' + sCNPJCPF;

            FTabelaReg0150.FieldByName('COD_PAIS').AsString   := IntToStr(icPais);
            FTabelaReg0150.FieldByName('CNPJCPF').AsString    := sCNPJCPF;
            FTabelaReg0150.FieldByName('IE').AsString         := sIE;
            FTabelaReg0150.FieldByName('COD_MUN').AsInteger   := icMun;

            if Trim(sxLgr) = '' then
               FTabelaReg0150.FieldByName('ENDERECO').AsString := 'LOGRADOURO NÃO CADASTRADO'
            else
               FTabelaReg0150.FieldByName('ENDERECO').AsString := sxLgr;
            FTabelaReg0150.FieldByName('NUM').AsString         := snro;
            FTabelaReg0150.FieldByName('COMPL').AsString       := sxCpl;
            FTabelaReg0150.FieldByName('BAIRRO').AsString      := sxBairro;

            FTabelaReg0150.Post;
         end;

   finally
      FTabelaReg0150.Filtered := False;
   end;
end;

procedure TSpedPisCofins.AdicionarDadosProdutos(Notas: TNotasFiscais; const docEntrada: Boolean);
var
   oItemProduto: TDetCollectionItem;
   Idx,
   iProxSeqCodNat: Integer;
   unidade:string;
begin

   // Documentos 65 não escritura itens
   if (Notas.Items[0].NFe.Ide.modelo = 65) then
      Exit;

   GerarLinhaMemoLog('Carregando dados de produtos/serviços da ' + Notas.Items[0].NFe.infNFe.ID);

   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin

         oItemProduto := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];

         //** Tabela Unidades de medidas
         try

            // UpperCase(COPY(oItemProduto.Prod.uCom,1,2));

            unidade:='UN';

            FTabelaReg0190.AddIndex('UNIDIndex', 'UNID', [ixUnique]);
            FTabelaReg0190.IndexFieldNames:= 'UNID';
            FTabelaReg0190.Locate('UNID',QuotedStr(unidade),[]);

            if (FTabelaReg0190.IsEmpty) then
              begin
                 if unidade =  'UN' then
                   begin
                    FTabelaReg0190.Append;
                    FTabelaReg0190.FieldByName('UNID').AsString := unidade;                      //oItemProduto.Prod.uCom;
                    FTabelaReg0190.FieldByName('DESCR').AsString := 'UNIDADE MEDIDA ' + unidade; //oItemProduto.Prod.uCom;
                    FTabelaReg0190.Post;
                   end
                   else
                   begin
                    unidade :='UN';
                   end;
               end;
         finally
            FTabelaReg0190.Filtered := False;
         end;

         //** Tabela de Identificação do Item (Produtos e Serviços)
         try

            FTabelaReg0200.AddIndex('COD_ITEMIndex', 'COD_ITEM', [ixUnique]);
            FTabelaReg0200.Filtered       := False;
            FTabelaReg0200.IndexFieldNames:= 'COD_ITEM';
            FTabelaReg0200.Filter         := 'COD_ITEM = ' + QuotedStr(oItemProduto.Prod.cProd);
            FTabelaReg0200.Filtered       := True;
            FTabelaReg0200.Locate('COD_ITEM',QuotedStr(oItemProduto.Prod.cProd),[]);
            if FTabelaReg0200.IsEmpty then
               begin
                  FTabelaReg0200.Append;

                  // S = Serviços e P = Produtos
                  if (oItemProduto.Prod.CFOP = '5933') then
                     FTabelaReg0200.FieldByName('TIPO_ITEM').AsString := 'S'
                  else
                     FTabelaReg0200.FieldByName('TIPO_ITEM').AsString := 'P';

                  FTabelaReg0200.FieldByName('COD_ITEM').AsString     := oItemProduto.Prod.cProd;
                  FTabelaReg0200.FieldByName('DESCR_ITEM').AsString   := oItemProduto.Prod.xProd;
                  FTabelaReg0200.FieldByName('COD_BARRA').AsString    := oItemProduto.Prod.cEAN;
                  FTabelaReg0200.FieldByName('COD_ANT_ITEM').AsString := '';
                  FTabelaReg0200.FieldByName('UNID_INV').AsString     := unidade;//oItemProduto.Prod.uCom;

                  if (oItemProduto.Prod.CFOP = '5933') then
                      FTabelaReg0200.FieldByName('COD_NCM').AsString := ''
                  else
                     FTabelaReg0200.FieldByName('COD_NCM').AsString  := oItemProduto.Prod.NCM;

                  FTabelaReg0200.FieldByName('ALIQ_ICMS').AsFloat    := oItemProduto.Imposto.ICMS.pICMS;
                  FTabelaReg0200.Post;
               end;
         finally
            FTabelaReg0200.Filtered := False;
         end;

         //** Tabela de Natureza da operação
         try


            FTabelaReg0400.AddIndex('CFOPIndex', 'CFOP', [ixUnique]);
            FTabelaReg0400.Filtered       := False;
            iProxSeqCodNat                := (FTabelaReg0400.RecordCount + 1);
            FTabelaReg0400.IndexFieldNames:= 'CFOP';
            FTabelaReg0400.Filter         := 'CFOP = ' + QuotedStr(oItemProduto.Prod.CFOP);
            FTabelaReg0400.Filtered       := True;
            FTabelaReg0400.Locate('CFOP',QuotedStr(oItemProduto.Prod.CFOP),[]);
            if (FTabelaReg0400.IsEmpty) then
               begin
                  FTabelaReg0400.Append;
                  FTabelaReg0400.FieldByName('COD_NAT').AsInteger := iProxSeqCodNat;
                  FTabelaReg0400.FieldByName('CFOP').AsString     := oItemProduto.Prod.CFOP;
                  FTabelaReg0400.FieldByName('DESCR_NAT').AsString:= 'NATUREZA DA OPERAÇÃO ' + oItemProduto.Prod.CFOP;
                  FTabelaReg0400.Post;
               end;
         finally
            FTabelaReg0400.Filtered := False;
         end;
      end; // For itens nota
end;

procedure TSpedPisCofins.AdicionarDadosProdutosCSTAliquitaBlocoM400M800(Notas: TNotasFiscais);
var
   oItemProduto: TDetCollectionItem;
   Idx,
   iProxSeqCodNat: Integer;
   unidade,sCST_PIS_COF,sTeste:string;
   AliqPis,AliqCofins:Double;
   CST_PIS,ENQUADRAMENTO_TRIBUTARIO: string;

begin

  if (Notas.Items[0].NFe.Ide.modelo = 55) then
      Exit;

//   dmPrincipal.cdsTemCstPIsCof.Close;
//   dmPrincipal.cdsTemCstPIsCof.Open;

    ENQUADRAMENTO_TRIBUTARIO := dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.value;

   if  ENQUADRAMENTO_TRIBUTARIO = 'P' then
      begin
        AliqPis:= 0.65;
        AliqCofins:= 3.0;
      end
   else
      begin
        AliqPis:= 1.65;
        AliqCofins:= 7.60;
      end;


   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin

           oItemProduto := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];

           dmPrincipal.cdsTemCstPIsCof.Append;
           dmPrincipal.cdsTemCstPIsCofCFOP.Value            := oItemProduto.Prod.CFOP;
           dmPrincipal.cdsTemCstPIsCofNCM.Value             := oItemProduto.Prod.NCM;
           dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value      := oItemProduto.Prod.vProd;
           dmPrincipal.cdsTemCstPIsCofVALORBASEPISCOF.Value := oItemProduto.Prod.vProd;
           dmPrincipal.cdsTemCstPIsCofEAN.Value             := oItemProduto.Prod.cEAN;
           dmPrincipal.cdsTemCstPIsCofBASEPIS.Value         := oItemProduto.Imposto.PIS.vBC;
           dmPrincipal.cdsTemCstPIsCofALIQPIS.Value         := oItemProduto.Imposto.PIS.pPIS;
           dmPrincipal.cdsTemCstPIsCofVALORPIS.Value        := oItemProduto.Imposto.PIS.vPIS;
           dmPrincipal.cdsTemCstPIsCofBASECOF.Value         := oItemProduto.Imposto.COFINS.vBC;
           dmPrincipal.cdsTemCstPIsCofALIQCOF.Value         := oItemProduto.Imposto.COFINS.pCOFINS;
           dmPrincipal.cdsTemCstPIsCofVALORCOF.Value        := oItemProduto.Imposto.COFINS.vCOFINS;

           if oItemProduto.Imposto.PIS.CST = pis01 then
              begin

                 dmPrincipal.cdsTemCstPIsCofCST_PIS.Value  := '01' ;

               if dmPrincipal.cdsTemCstPIsCofALIQPIS.Value =  0 then
                  dmPrincipal.cdsTemCstPIsCofALIQPIS.Value := AliqPis;

               if dmPrincipal.cdsTemCstPIsCofALIQCOF.Value =  0 then
                  dmPrincipal.cdsTemCstPIsCofALIQCOF.Value := AliqCofins;

               end

          else if oItemProduto.Imposto.PIS.CST = pis04 then
              dmPrincipal.cdsTemCstPIsCofCST_PIS.Value   := '04'

          else if oItemProduto.Imposto.PIS.CST = pis06 then
              dmPrincipal.cdsTemCstPIsCofCST_PIS.Value   := '06'

          else if oItemProduto.Imposto.PIS.CST = pis07 then
              dmPrincipal.cdsTemCstPIsCofCST_PIS.Value   := '07'

          else if oItemProduto.Imposto.PIS.CST = pis08 then
              dmPrincipal.cdsTemCstPIsCofCST_PIS.Value   := '08'

          else if oItemProduto.Imposto.PIS.CST = pis09 then
              dmPrincipal.cdsTemCstPIsCofCST_PIS.Value   := '09'

          else if oItemProduto.Imposto.PIS.CST = pis49 then
              dmPrincipal.cdsTemCstPIsCofCST_PIS.Value   := '49'
          else
              dmPrincipal.cdsTemCstPIsCofCST_PIS.Value   := '49';

              dmPrincipal.cdsTemCstPIsCof.post;

      end;

    //  dmPrincipal.cdsTemCstPIsCof.ApplyUpdates(0);

end;

procedure TSpedPisCofins.AdicionarDadosProdutosCupomFiscal;
var
   Registro0200List: ACBrEFDBloco_0.TRegistro0200List;
   indxProd: Integer;
   unidade:String;
begin
   Registro0200List := FACBrSPEDECF.Bloco_0.Registro0001.Registro0200;
   if (Registro0200List.Count = 0) then
      GerarLinhaMemoLog('Não há dados de produtos dos cupons no registro 0200')
   else
      begin
         GerarLinhaMemoLog('Carregando informações de ' + IntToStr(Registro0200List.Count) + ' produto(s) de cupom fiscal');

         for indxProd := 0 to Registro0200List.Count - 1 do
            begin
               //** Tabela Unidades de medidas
               try
                  unidade:= UpperCase(COPY(Registro0200List.Items[indxProd].UNID_INV,1,2));
                  FTabelaReg0190.IndexFieldNames:='UNID';
                  FTabelaReg0190.Filtered := False;
                  FTabelaReg0190.Filter   := 'UNID = ' + QuotedStr(unidade);
                  FTabelaReg0190.Filtered := True;
                  if (FTabelaReg0190.IsEmpty) then
                     begin
                      IF (unidade =  'CX') OR
                         (unidade =  'UN') OR
                         (unidade =  'PC') OR
                         (unidade =  'BI') OR     //07062024   aqui
                         (unidade =  'BL') OR
                         (unidade =  'CT') OR
                         (unidade =  'DP') OR
                         (unidade =  'DZ') OR
                         (unidade =  'EN') OR
                         (unidade =  'FD') OR
                         (unidade =  'FR') OR
                         (unidade =  'KG') OR
                         (unidade =  'LT') OR
                         (unidade =  'PO') OR
                         (unidade =  'TB') OR
                         (unidade =  'VD') then
                       begin
                        FTabelaReg0190.Append;
                        FTabelaReg0190.FieldByName('UNID').AsString := unidade;
                        FTabelaReg0190.FieldByName('DESCR').AsString:= 'UNIDADE MEDIDA ' + unidade;
                        FTabelaReg0190.Post;
                       end
                       else
                       begin

                        FTabelaReg0190.Append;
                        FTabelaReg0190.FieldByName('UNID').AsString := unidade;
                        FTabelaReg0190.FieldByName('DESCR').AsString:= 'UNIDADE MEDIDA ' + 'UN';
                        FTabelaReg0190.Post;
                       end;
                     end;
               finally
                  FTabelaReg0190.Filtered := False;
               end;

               //** Tabela de Identificação do Item (Produtos e Serviços)
               try
                  FTabelaReg0200.IndexFieldNames:='COD_ITEM';
                  FTabelaReg0200.Filtered := False;
                  FTabelaReg0200.Filter   := 'COD_ITEM = ' + QuotedStr(Registro0200List.Items[indxProd].COD_ITEM);
                  FTabelaReg0200.Filtered := True;
                  if FTabelaReg0200.IsEmpty then
                     begin
                       unidade:= UpperCase(COPY(Registro0200List.Items[indxProd].UNID_INV,1,2));
                       IF (unidade <>  'CX') OR
                          (unidade <>  'UN') OR
                          (unidade <>  'PC') OR
                          (unidade <>  'BI') OR
                          (unidade <>  'BL') OR
                          (unidade <>  'CT') OR
                          (unidade <>  'DP') OR
                          (unidade <>  'DZ') OR
                          (unidade <>  'EN') OR
                          (unidade <>  'FD') OR
                          (unidade <>  'FR') OR
                          (unidade <>  'KG') OR
                          (unidade <>  'LT') OR
                          (unidade <>  'PO') OR
                          (unidade <>  'TB') OR
                          (unidade <>  'VD') then
                          BEGIN
                           unidade :=  'UN';
                          END;

                        FTabelaReg0200.Append;
                        FTabelaReg0200.FieldByName('TIPO_ITEM').AsString    := 'P'; // S = Serviços e P = Produtos
                        FTabelaReg0200.FieldByName('COD_ITEM').AsString     := Registro0200List.Items[indxProd].COD_ITEM;
                        FTabelaReg0200.FieldByName('DESCR_ITEM').AsString   := Registro0200List.Items[indxProd].DESCR_ITEM;
                        FTabelaReg0200.FieldByName('COD_BARRA').AsString    := Registro0200List.Items[indxProd].COD_BARRA;
                        FTabelaReg0200.FieldByName('COD_ANT_ITEM').AsString := '';
                        FTabelaReg0200.FieldByName('UNID_INV').AsString     := unidade;//Registro0200List.Items[indxProd].UNID_INV;
                        FTabelaReg0200.FieldByName('COD_NCM').AsString      := Registro0200List.Items[indxProd].COD_NCM;
                        FTabelaReg0200.FieldByName('ALIQ_ICMS').AsFloat     := Registro0200List.Items[indxProd].ALIQ_ICMS;
                        FTabelaReg0200.Post;
                     end;
               finally
                  FTabelaReg0200.Filtered := False;
               end;

            end; {for Registro0200List}
      end;
end;

procedure TSpedPisCofins.AtualizarStatus(const Msg: String);
var
   sPercentual: String;
begin
   if (Assigned(FlblStatus) and Assigned(FProgressBar)) then
      begin
         sPercentual := '0 %';

//         if (FProgressBar.Max > 0) then
//            begin
//               sPercentual := Formatfloat('000', (FProgressBar.Position * 100) / FProgressBar.Max);
//               sPercentual := FloatToStr(StrToFloat(sPercentual)) + ' %';
//            end;

         FlblStatus.Caption := Msg ;{+ '  ' + FormatFloat(',#0', FProgressBar.Position) + '  de  '+
                                 FormatFloat(',#0', FProgressBar.Max) + '           ' + sPercentual;  }

         Application.ProcessMessages;
      end;
end;

procedure TSpedPisCofins.CarregarDocumentosXML;
var
   sFiltroDocEmitido: String;
   Ano, Mes, Dia: Word;
   iDx,
   iIDNota: Integer;
   sChave: String;
   sMsgECF: String;
   dtFinalMovCupons: TDateTime;
   sNomeArquivoMFD: String;
   olstDadosUltimaReducaoZ: TStrings;
   sDataAux,teste: String;
   dtDataHoraUltimaReducaoZ: TDateTime;
   iAux: Integer;
   iCountLimite: Integer;
   lThread : TThread;
   TaskList: TList;
   Task: ITask;
   MaxThreadsSimultaneas: Integer;


begin

  if (DebugHook = 0) and (not Self.FSemLimite) then
      iCountLimite := _LIM_DOC
   else
   iCountLimite := 0;

  Screen.Cursor := crHourglass;

   // ** Documentos próprios emitidos pela empresa
   DecodeDate(Self.FcompSpedPisCofins.DT_INI, Ano, Mes , Dia);
   sFiltroDocEmitido := IntToStr(Self.CodigIbgeUfEmpresa) + Copy(IntToStr(Ano), 3, 2) + FormatFloat('00', Mes) + Self.CnpjEmpresa ;


   GerarLinhaMemoLog('Carregando arquivos xml NFE: ' + Self.LocalDocXml_NFE);
   GerarLinhaMemoLog('Filtro dos arquivos: ' + sFiltroDocEmitido);



   ObterListaAqruivosDiretorio(Self.LocalDocXml_NFE, 'xml', TStringList(FListaArquivos),'*' , True, iCountLimite);
   GerarLinhaMemoLog('Total documentos xml NFE emitidas Danfer: ' + IntToStr(FListaArquivos.Count));
   iAux := FListaArquivos.Count;


   GerarLinhaMemoLog('Carregando arquivos xml NFCE: ' + Self.LocalDocXml_NFCE);
   ObterListaAqruivosDiretorio(Self.LocalDocXml_NFCE, 'xml', TStringList(FListaArquivos),'*' , True, iCountLimite);
   GerarLinhaMemoLog('Total documentos xml NFCE emitidas: ' + IntToStr(FListaArquivos.Count - iAux));


   AtualizarStatus('Gerando Registro M400 e M800: ...');

   dmPrincipal.cdsTemCstPIsCof.Close;
   dmPrincipal.cdsTemCstPIsCof.Open;

   IniciaBar(FListaArquivos.Count);

   for iDx := 0 to FListaArquivos.Count - 1 do
      begin
         IncBar;

        // GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);
         //Load XML nfe - nfce Componente ACBrNFe;

          sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));
          FacbrNFe.NotasFiscais.Clear;

         //AtualizarStatus('Gerando Registro M400 e M800: ');

         if (Copy(sChave, 21, 2) = '55') or (Copy(sChave, 21, 2) = '65') then
            begin

               try
                //  GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);


                  FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                 if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais) then
                     begin


                        AdicionarDadosProdutosCSTAliquitaBlocoM400M800(FacbrNFe.NotasFiscais);


                     end;

                 FacbrNFe.NotasFiscais.Clear;
               except
                  on E: Exception do
                     GerarLinhaMemoLog('Erro ao processar arquivo saída: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
               end;
            end
         else
           GerarLinhaMemoLog('A chave não é Nfe(55) ou NFCe(65): ' + sChave);
      end;

   // dmPrincipal.cdsTemCstPIsCof.Post;
    dmPrincipal.cdsTemCstPIsCof.ApplyUpdates(0);






   FListaArquivos.Clear;
   ObterListaAqruivosDiretorio(Self.LocalDocXml_NFCE, 'xml', TStringList(FListaArquivos),'*' , True, iCountLimite);
   iDx := FListaArquivos.Count;

   AtualizarStatus('Carregando informações de NFE e NFCE...');

   IniciaBar(FListaArquivos.Count);

   for iDx := 0 to FListaArquivos.Count - 1 do
      begin

        //iIDNota:=0;

        IncBar;

        AtualizarStatus('Adicionando dados : Participante , Produtos , NFCe  - Total:'+IntToStr(iDx) +' De '+ IntToStr(FListaArquivos.Count));

         //Load XML nfe - nfce Componente ACBrNFe;

         sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));

         if (Copy(sChave, 21, 2) = '55') or (Copy(sChave, 21, 2) = '65') then
            begin
               try

                 // GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);

                  FacbrNFe.NotasFiscais.Clear;
                  FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                  if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais) then
                     begin


                        // Adicionar dados Participante
                        AdicionarDadosParticipante(FacbrNFe.NotasFiscais);


                        // Adicionar dados dos produtos
                        AdicionarDadosProdutos(FacbrNFe.NotasFiscais);



                        iIDNota := AdicionarDadosNotas(FacbrNFe.NotasFiscais);
                        if (iIDNota > 0) then;
                           begin

                              // Adicionar itens
                              AdicionarDadosItensNotas(iIDNota, FacbrNFe.NotasFiscais);

                           end;

                     end;

               except
                  on E: Exception do
                     GerarLinhaMemoLog('Erro ao processar arquivo saída Carregando informaçoes NFCe: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
               end;

            end
         else
           GerarLinhaMemoLog('A chave não é Nfe(55) ou NFCe(65): ' + sChave);

      end;


  //****************** Fim NFCe*********************************


{$REGION 'NFCe'}

 // mauricio 31012025

 {  AtualizarStatus('Adicionar Dados Itens NFe: ');

   IniciaBar(FListaArquivos.Count);
   for iDx := 0 to FListaArquivos.Count - 1 do
      begin
         IncBar;


         // Criação da tarefa assíncrona (função anônima)



         sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));


         if (Copy(sChave, 21, 2) = '55') or (Copy(sChave, 21, 2) = '65') then
            begin
               try

                  FacbrNFe.NotasFiscais.Clear;
                  FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                  if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais,true) then
                     begin
//                        // Adicionar dados Participante
//                        AdicionarDadosParticipante(FacbrNFe.NotasFiscais);
//
//                        // Adicionar dados dos produtos
//                        AdicionarDadosProdutos(FacbrNFe.NotasFiscais);

                        iIDNota := AdicionarDadosNotas(FacbrNFe.NotasFiscais,true);
                         if (iIDNota > 0) then;
                           begin
                             AdicionarDadosItensNotas(iIDNota, FacbrNFe.NotasFiscais,false);

                           end;

                     end;

                    FacbrNFe.NotasFiscais.Clear;

               except
                  on E: Exception do
                     GerarLinhaMemoLog('Erro ao processar arquivo saída: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
               end;
            end
         else
           GerarLinhaMemoLog('A chave não é Nfe(55) ou NFCe(65): ' + sChave);
      end;
            }



{$ENDREGION}



   // ** XML Fornecedores - Documentos de Terceiros - Onde a Empresa é destinatária no documento
   FListaArquivos.Clear;
   ObterListaAqruivosDiretorio(Self.LocalDocXml_FORN, 'xml', TStringList(FListaArquivos), '*', True, iCountLimite);
   GerarLinhaMemoLog('Total documentos xml fornecedor: ' + IntToStr(FListaArquivos.Count));

   //Filtra os documentos onde a empresa esteja como destinarária
   FiltrarDocumentosFornecedores(TStringList(FListaArquivos), iCountLimite);

   GerarLinhaMemoLog('Total documentos NF-e produtos de entrada: ' + IntToStr(FListaArquivos.Count));

   AtualizarStatus('Carregando informações do doc. NFe XMLs: ');

   IniciaBar(FListaArquivos.Count);
   for iDx := 0 to FListaArquivos.Count - 1 do
     begin
       IncBar;

        // ** Load XML nfe - nfce Componente ACBrNFe;
        sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));


        try


           FacbrNFe.NotasFiscais.Clear;
           FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));


           if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais, True) then
              begin


                 // Adicionar dados Participante
                 AdicionarDadosParticipante(FacbrNFe.NotasFiscais, True);


                 // Adicionar dados dos produtos
                 AdicionarDadosProdutos(FacbrNFe.NotasFiscais, True);


                 // Adicionar dados do cabeçalho dos documentos
                 iIDNota := AdicionarDadosNotas(FacbrNFe.NotasFiscais, True);
                 if (iIDNota > 0) then;
                    begin

                       // Adicionar itens
                       AdicionarDadosItensNotas(iIDNota, FacbrNFe.NotasFiscais, True);


                    end;

              end;

        except
           on E: Exception do
              GerarLinhaMemoLog('Erro ao processar arquivo entrada: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
        end;

     end; {for}



   // Gerar Pis Cofins de Notas de serviços
   if (Self.LocalDocXml_NFSE <> '') and (DirectoryExists(Self.LocalDocXml_NFSE))then
      begin

         GerarLinhaMemoLog('Carregando arquivos xml NFSE (Serviços): ' + Self.LocalDocXml_NFSE);

         FListaArquivos.Clear;
         ObterListaAqruivosDiretorio(Self.LocalDocXml_NFSE, 'xml', TStringList(FListaArquivos), sFiltroDocEmitido, True, iCountLimite);

         GerarLinhaMemoLog('Total documentos serviços - xml NFSE emitidas: ' + IntToStr(FListaArquivos.Count));


         IniciaBar(FListaArquivos.Count);

         for iDx := 0 to FListaArquivos.Count - 1 do
            begin

               IncBar;


               //Load XML Serviços
               sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));
               AtualizarStatus('Carregando informações do documento de serviços: ');

               if (Copy(sChave, 21, 2) = '55') then
                  begin
                     GerarLinhaMemoLog('Carregando XML de serviços (Load): ' + sChave);
                     try
                        FacbrNFe.NotasFiscais.Clear;
                        FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));
                     except
                        on E: Exception do
                           begin
                              GerarLinhaMemoLog('Erro no xml de serviços: ' + FListaArquivos[iDx] + ' Erro: ' + E.Message);
                           end;
                     end;

                     if TemServicosNaNFe(FacbrNFe.NotasFiscais) then
                        begin
                           // Adicionar dados Participante de serviço
                           AdicionarDadosParticipante(FacbrNFe.NotasFiscais);

                           // Adicionar dados dos serviços
                           AdicionarDadosProdutos(FacbrNFe.NotasFiscais);

                           // Adicionar dados do cabeçalho dos documentos
                           iIDNota := AdicionarDadosNotasServicos(FacbrNFe.NotasFiscais);
                           if (iIDNota > 0) then;
                              begin
                                 // Adicionar itens
                                 AdicionarDadosItensNotasServicos(iIDNota, FacbrNFe.NotasFiscais);
                              end;
                        end;
                  end;
            end;{for}

         {Notas de entradas - serviços como despesas}
         FListaArquivos.Clear;
         ObterListaAqruivosDiretorio(Self.LocalDocXml_NFSE, 'xml', TStringList(FListaArquivos), '*', True, iCountLimite);
         GerarLinhaMemoLog('Total documentos xml fornecedor: ' + IntToStr(FListaArquivos.Count));


         // ** Filtra os documentos onde a empresa esteja como destinarária
         FiltrarDocumentosFornecedores(TStringList(FListaArquivos), iCountLimite);


         GerarLinhaMemoLog('Total documentos NF-e serviços de entrada: ' + IntToStr(FListaArquivos.Count));


         AtualizarStatus('Carregando informações do documento NF-e serviços de entrada  : ');

         IniciaBar(FListaArquivos.Count);
         for iDx := 0 to FListaArquivos.Count - 1 do
           begin

              IncBar;
              GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);

              // ** Load XML nfe Serviços de entrada
              sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));
              AtualizarStatus('Carregando informações do documento: ');

              try

                 GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);

                 FacbrNFe.NotasFiscais.Clear;
                 FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                 if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais, True) then
                    begin

                       // Adicionar dados Participante
                       AdicionarDadosParticipante(FacbrNFe.NotasFiscais, True);

                       // Adicionar dados dos serviços
                       AdicionarDadosProdutos(FacbrNFe.NotasFiscais, True);

                       // Adicionar dados do cabeçalho dos documentos
                       iIDNota := AdicionarDadosNotasServicos(FacbrNFe.NotasFiscais, True);
                       if (iIDNota > 0) then;
                          begin
                             // Adicionar itens de serviços
                             AdicionarDadosItensNotasServicos(iIDNota, FacbrNFe.NotasFiscais, True);

                          end;
                    end;
              except
                 on E: Exception do
                    GerarLinhaMemoLog('Erro ao processar nf-e serviços entrada: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
              end;
           end; {for}

      end; {if Self.LocalDocXml_NFSE <> ''}



  Screen.Cursor := crDefault;


{$REGION}

   // ** Informações de notas de despesas de Energia eletrica, Água e Gaz no Caixa
   //CarregarInformacoesNotasAguaEnergiaGaz_C500;


   // ** Informações de cupom fiscal - MFD não gera informações de PIS e COFINS dos cupons
   //if (Self.GerarCupomFiscal) then
//   if (False) then // MFD não gera informações de PIS e COFINS dos cupons
//      begin
//         GerarLinhaMemoLog('Carregando movimentos Pis e Cofins de Cupom Fiscal');
//         try
//            // ** Conectar - verificar conexão da impressora e arquivo ConfigECF.ini;
//            GerarLinhaMemoLog('Conectando na impressora fiscal! Aguarde...');
//            if (not ConectarImpressoraECF(sMsgECF)) then
//               GerarLinhaMemoLog(sMsgECF)
//            else
//               GerarLinhaMemoLog('Impressora fiscal conectada com sucesso!');
//
//            if (Self.FECF_RequerZ) then
//               GerarLinhaMemoLog('ECF requer redução "Z"! Não é possível ler os movimentos dos cupons.')
//            else
//               begin
//                  // ** Pegando a data Str do movimento da ult. red. Z.
//                  olstDadosUltimaReducaoZ := TStringlist.Create;
//                  try
//                     GerarLinhaMemoLog('Obter Dados Última Redução Z');
//                     olstDadosUltimaReducaoZ.Text := StringReplace(FACBrECF.DadosUltimaReducaoZ, ' ', '', [rfReplaceAll, rfIgnoreCase]);
//                     GerarLinhaMemoLog('Data do movimento da última Redução Z: ' + olstDadosUltimaReducaoZ.Values['DataMovimento']);
//                     sDataAux := Trim(olstDadosUltimaReducaoZ.Values['DataMovimento']);
//
//                     if (Length(sDataAux) < 10) then
//                        sDataAux := Copy(sDataAux, 1, 3) + Copy(sDataAux, 4, 3) + '20' + Copy(sDataAux, 7, 2);
//
//                     dtDataHoraUltimaReducaoZ := StrToDateTimeDef(sDataAux, FACBrECF.DataHoraUltimaReducaoZ);
//                  finally
//                     olstDadosUltimaReducaoZ.Free;
//                  end;
//
//                  // **
//                  if (dtDataHoraUltimaReducaoZ < Self.FcompSpedPisCofins.DT_INI) then
//                     GerarLinhaMemoLog('Data da última Redução Z "' + FormatDateTime('dd/mm/yyyy', dtDataHoraUltimaReducaoZ) +
//                        '" é menor que a data inicial do periodo "' + FormatDateTime('dd/mm/yyyy', Self.FcompSpedPisCofins.DT_INI) +
//                        '" - Não há movimentos para gerar.');
//                     begin
//                        dtFinalMovCupons := Self.FcompSpedPisCofins.DT_FIN;
//                        if (dtDataHoraUltimaReducaoZ < Self.FcompSpedPisCofins.DT_FIN) then
//                           begin
//                              dtFinalMovCupons := dtDataHoraUltimaReducaoZ;
//                              GerarLinhaMemoLog('Data da última Redução Z "' + FormatDateTime('dd/mm/yyyy', dtDataHoraUltimaReducaoZ) +
//                                '" é menor que a data final do periodo "' + FormatDateTime('dd/mm/yyyy', Self.FcompSpedPisCofins.DT_FIN) + '"!');
//                              GerarLinhaMemoLog('Período considerado dos cupons: "' + FormatDateTime('dd/mm/yyyy', Self.FcompSpedPisCofins.DT_INI) +
//                                '" até "' + FormatDateTime('dd/mm/yyyy', dtFinalMovCupons) + '"!');
//                           end;
//
//                        // - Gerar o arquivo SPED FACBrECF.ArquivoMFD_DLL();
//                        GerarLinhaMemoLog('Geração do arquivo dos movimentos da ECF - ArquivoMFD_DLL');
//
//                        sNomeArquivoMFD := 'MFD_E_' + IntToStr(Self.FCodigoEmpresa) + '_' + FormatDateTime('mm_yyyy', Self.FcompSpedPisCofins.DT_INI) +
//                                           '_' + FormatDateTime('ddmmyy_hhnnss', Now) + '.ecf';
//
//                        FACBrSPEDECF.Path := ExtractFilePath(Application.ExeName) + 'mfd\';
//
//                        if (not DirectoryExists(FACBrSPEDECF.Path)) then
//                           ForceDirectories(FACBrSPEDECF.Path);
//
//                        FACBrSPEDECF.Arquivo := sNomeArquivoMFD;
//                        GerarLinhaMemoLog('Local: ' + FACBrSPEDECF.Path + FACBrSPEDECF.Arquivo);
//                        GerarLinhaMemoLog('Aguarde... Obtendo informações, não desligue a impressora!');
//                        AtualizarStatus('Aguarde... Obtendo informações, não desligue a impressora!');
//
//                        FACBrECF.ArquivoMFD_DLL(Self.FcompSpedPisCofins.DT_INI, dtFinalMovCupons, AnsiString(FACBrSPEDECF.Path + FACBrSPEDECF.Arquivo), [docTodos], finSPED);
//
//                        // - Carregar os registros do arquivo '.LoadFileTXT;' gerado para DATASETs
//                        GerarLinhaMemoLog('Efetuando leitura do arquivo');
//                        //FACBrSPEDECF.Cod_Mun_Empresa := StrToIntDef(GetValorFieldDataSet(FTabelaEmpresa, 'EMPRESA-CIDADE-CODIGO'),0);
//                        //GerarLinhaMemoLog('Cod. Mun. Empresa: ' + IntToStr(FACBrSPEDECF.Cod_Mun_Empresa));
//                        GerarLinhaMemoLog('Executando "LoadFileTXT"');
//                        //FACBrSPEDECF.LoadFileTXT;
//
//                        //if (Trim(FACBrSPEDECF.ErrosLeitura.Text) = '') then
//                        //   GerarLinhaMemoLog('Erros de Leitura: ' + FACBrSPEDECF.ErrosLeitura.Text);
//
//                        GerarLinhaMemoLog('Total 0200: ' + IntToStr(FACBrSPEDECF.Bloco_0.Registro0001.Registro0200.Count) + ' - Produtos dos cupons');
//                        GerarLinhaMemoLog('Total C400: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.Count) + ' - Equipamento ECF');
//                        GerarLinhaMemoLog('Total C405: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Count) + ' - Redução Z');
//                        GerarLinhaMemoLog('Total C420: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Items[0].RegistroC420.Count)
//                           + ' - Totalizadores parciais');
//                        GerarLinhaMemoLog('Total C460: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Items[0].RegistroC460.Count)
//                           + ' - Cupom Fiscal');
//
//                        AdicionarDadosProdutosCupomFiscal();
//
//                     end; {Data red Z menor que INI}
//               end; {else-if Requer Z}
//         except
//            on E: Exception do
//               begin
//                  GerarLinhaMemoLog('Erro ao gerar movimentos de cupom fiscal!');
//                  GerarLinhaMemoLog(E.Message);
//               end;
//         end;
//      end;{if GerarCupomFiscal}
//
//   // Gerar Pis Cofins de Notas de serviços
//   if (Self.LocalDocXml_NFSE <> '') and (DirectoryExists(Self.LocalDocXml_NFSE))then
//      begin
//         GerarLinhaMemoLog('Carregando arquivos xml NFSE (Serviços): ' + Self.LocalDocXml_NFSE);
//         FListaArquivos.Clear;
//         ObterListaAqruivosDiretorio(Self.LocalDocXml_NFSE, 'xml', TStringList(FListaArquivos), sFiltroDocEmitido, True, iCountLimite);
//         GerarLinhaMemoLog('Total documentos serviços - xml NFSE emitidas: ' + IntToStr(FListaArquivos.Count));
//
//         IniciaBar(FListaArquivos.Count);
//         for iDx := 0 to FListaArquivos.Count - 1 do
//            begin
//               IncBar;
//               GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);
//
//               //Load XML Serviços
//               sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));
//               AtualizarStatus('Carregando informações do documento de serviços: ');
//
//               if (Copy(sChave, 21, 2) = '55') then
//                  begin
//                     GerarLinhaMemoLog('Carregando XML de serviços (Load): ' + sChave);
//                     try
//                        FacbrNFe.NotasFiscais.Clear;
//                        FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));
//                     except
//                        on E: Exception do
//                           begin
//                              GerarLinhaMemoLog('Erro no xml de serviços: ' + FListaArquivos[iDx] + ' Erro: ' + E.Message);
//                           end;
//                     end;
//
//                     if TemServicosNaNFe(FacbrNFe.NotasFiscais) then
//                        begin
//                           // Adicionar dados Participante de serviço
//                           AdicionarDadosParticipante(FacbrNFe.NotasFiscais);
//
//                           // Adicionar dados dos serviços
//                           AdicionarDadosProdutos(FacbrNFe.NotasFiscais);
//
//                           // Adicionar dados do cabeçalho dos documentos
//                           iIDNota := AdicionarDadosNotasServicos(FacbrNFe.NotasFiscais);
//                           if (iIDNota > 0) then;
//                              begin
//                                 // Adicionar itens
//                                 AdicionarDadosItensNotasServicos(iIDNota, FacbrNFe.NotasFiscais);
//                              end;
//                        end;
//                  end;
//            end;{for}
//
//         {Notas de entradas - serviços como despesas}
//         FListaArquivos.Clear;
//         ObterListaAqruivosDiretorio(Self.LocalDocXml_NFSE, 'xml', TStringList(FListaArquivos), '*', True, iCountLimite);
//         GerarLinhaMemoLog('Total documentos xml fornecedor: ' + IntToStr(FListaArquivos.Count));
//
//         // ** Filtra os documentos onde a empresa esteja como destinarária
//         FiltrarDocumentosFornecedores(TStringList(FListaArquivos), iCountLimite);
//
//         GerarLinhaMemoLog('Total documentos NF-e serviços de entrada: ' + IntToStr(FListaArquivos.Count));
//
//         IniciaBar(FListaArquivos.Count);
//         for iDx := 0 to FListaArquivos.Count - 1 do
//           begin
//              IncBar;
//              GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);
//
//              // ** Load XML nfe Serviços de entrada
//              sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));
//              AtualizarStatus('Carregando informações do documento: ');
//
//              try
//                 GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);
//                 FacbrNFe.NotasFiscais.Clear;
//                 FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));
//
//                 if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais, True) then
//                    begin
//                       // Adicionar dados Participante
//                       AdicionarDadosParticipante(FacbrNFe.NotasFiscais, True);
//
//                       // Adicionar dados dos serviços
//                       AdicionarDadosProdutos(FacbrNFe.NotasFiscais, True);
//
//                       // Adicionar dados do cabeçalho dos documentos
//                       iIDNota := AdicionarDadosNotasServicos(FacbrNFe.NotasFiscais, True);
//                       if (iIDNota > 0) then;
//                          begin
//                             // Adicionar itens de serviços
//                             AdicionarDadosItensNotasServicos(iIDNota, FacbrNFe.NotasFiscais, True);
//                          end;
//                    end;
//              except
//                 on E: Exception do
//                    GerarLinhaMemoLog('Erro ao processar nf-e serviços entrada: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
//              end;
//           end; {for}
//
//      end; {if Self.LocalDocXml_NFSE <> ''
 {$endregion}
end;

procedure TSpedPisCofins.CarregarInformacoesContador;
begin
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Carregando dados do contador: FILIAL:' + IntToStr(CodigoEmpresa));
end;

procedure TSpedPisCofins.CarregarInformacoesEmpresa;
begin
   // ** Carregando Parâmetros                                 '
   dmPrincipal.cdsConsEmpresa.Close;
   dmPrincipal.cdsConsEmpresa.open;

   GerarLinhaMemoLog('Carregando Parâmetros SPED Fiscal: FILIAL:' + IntToStr(CodigoEmpresa));

   FParamIndApurIPI := dmPrincipal.cdsConsEmpresaPERIODO_IPI.Value; //1-D ou 0-M

   // ** Carregar dados da empresa
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Carregando dados da empresa: FILIAL:' + IntToStr(CodigoEmpresa));

end;

procedure TSpedPisCofins.CarregarInformacoesNotasAguaEnergiaGaz_C500;
var
   sSQL: String;
   sCodForn: String;
begin
   GerarLinhaMemoLog('Consultando despesas do caixa de Energia elétrica, Água e Gás (C500)');
   // ** Buscar notas
   FTabelaRegC500.Close;
   FqTabelaRegC500.Close;
   FqTabelaRegC500.SQL.Clear;

   FpTabelaRegC500.DataSet := FqTabelaRegC500;
   FTabelaRegC500.SetProvider(FpTabelaRegC500);
   FqTabelaRegC500.SQLConnection := Self.ConexaoBase;

   sSQL := StringReplace(_SQL_DESP_AGUA_ERNERGIA_GAS_C500, ':P_FILIAL', IntToStr(Self.FCodigoEmpresa), [rfReplaceAll,rfIgnoreCase]);
   sSQL := StringReplace(sSQL, ':P_DATA_INI', QuotedStr(FormatDateTime('dd.mm.yyyy',  FcompSpedPisCofins.DT_INI)), [rfReplaceAll,rfIgnoreCase]);
   sSQL := StringReplace(sSQL, ':P_DATA_FIM', QuotedStr(FormatDateTime('dd.mm.yyyy',  FcompSpedPisCofins.DT_FIN)), [rfReplaceAll,rfIgnoreCase]);

   // ** Filtra documentos com valores de pis e confis maior que zero
   sSQL := sSQL + ' and ((CX.VR_PIS > 0) or (CX.VR_COFINS > 0)) ';

   FqTabelaRegC500.SQL.Add(sSQL);

   FqTabelaRegC500.Open;
   FTabelaRegC500.Open;

   FTabelaRegC500.First;
   while not FTabelaRegC500.Eof do
      begin
         //Adicionar participante
         sCodForn := 'CX_F' + Trim(FTabelaRegC500.FieldByName('COD_FORN').AsString);

         // ** Adiconando o fornecedor das notas como participante
         FTabelaReg0150.Filtered := False;
         FTabelaReg0150.Filter := 'COD_PART = ' + QuotedStr(sCodForn);
         FTabelaReg0150.Filtered := True;
         try
           if (FTabelaReg0150.IsEmpty) then
              begin
                 FTabelaReg0150.Append;
                 FTabelaReg0150.FieldByName('COD_PART').AsString := sCodForn;
                 FTabelaReg0150.FieldByName('NOME').AsString     := 'FORNECEDOR CONTAS DESPESAS CX';
                 FTabelaReg0150.FieldByName('COD_PAIS').AsString := '1058';
                 FTabelaReg0150.FieldByName('CNPJCPF').AsString  := Self.CnpjEmpresa;
                 FTabelaReg0150.FieldByName('IE').AsString       := 'ISENTO';
                 FTabelaReg0150.FieldByName('COD_MUN').AsInteger := StrToIntDef(GetValorFieldDataSet(FTabelaEmpresa, 'EMPRESA-CIDADE-CODIGO'),0);
                 FTabelaReg0150.FieldByName('ENDERECO').AsString := 'RUA DO FORNECEDOR';
                 FTabelaReg0150.FieldByName('NUM').AsString      := 'S/N';
                 FTabelaReg0150.FieldByName('COMPL').AsString    := '';
                 FTabelaReg0150.FieldByName('BAIRRO').AsString   := 'BAIRRO FORNECEDOR';

                 FTabelaReg0150.Post;
              end;
         finally
           FTabelaReg0150.Filtered := False;
         end;

         FTabelaRegC500.Next;
      end;{while}
   FTabelaRegC500.First;
end;

procedure TSpedPisCofins.CarregarXmlAnliticoItens(TotalArquivos: TStrings);
var
   sFiltroDocEmitido: String;
   Ano, Mes, Dia: Word;
   iDx,
   iIDNota: Integer;
   sChave: String;
   sMsgECF: String;
   dtFinalMovCupons: TDateTime;
   sNomeArquivoMFD: String;
   olstDadosUltimaReducaoZ: TStrings;
   sDataAux: String;
   dtDataHoraUltimaReducaoZ: TDateTime;
   iAux: Integer;
   iCountLimite: Integer;
begin

   FListaArquivos:= TotalArquivos;
   AtualizarStatus('Gerando Registro Analitico dos itens:');
   Application.ProcessMessages;
   IniciaBar(FListaArquivos.Count);


   for iDx := 0 to FListaArquivos.Count - 1 do
      begin
         IncBar;
         //GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);


         //Load XML nfe - nfce Componente ACBrNFe;
         sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));

        // AtualizarStatus('Gerando Registro Analitico dos itens: ');

         if (Copy(sChave, 21, 2) = '55') or (Copy(sChave, 21, 2) = '65') then
            begin
              Application.ProcessMessages;
               try
                 // GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);
                  if iDx <>0 then
                   FacbrNFe.NotasFiscais.Clear;

                   FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                  if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais) then
                     begin

                        iIDNota := AdicionarDadosNotas(FacbrNFe.NotasFiscais);
                        if (iIDNota > 0) then;
                           begin
                              // Adicionar itens

                              AdicionarDadosItensNotas(iIDNota, FacbrNFe.NotasFiscais);

                           end;

                     end;
               except
                  on E: Exception do
                     GerarLinhaMemoLog('Erro ao processar arquivo saída: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
               end;
            end
         else
           GerarLinhaMemoLog('A chave não é Nfe(55) ou NFCe(65): ' + sChave);
      end;


end;

procedure TSpedPisCofins.CarregarXmldadosProdutos(TotalArquivos:TStrings);
var
   sFiltroDocEmitido: String;
   Ano, Mes, Dia: Word;
   iDx,
   iIDNota: Integer;
   sChave: String;
   sMsgECF: String;
   dtFinalMovCupons: TDateTime;
   sNomeArquivoMFD: String;
   olstDadosUltimaReducaoZ: TStrings;
   sDataAux: String;
   dtDataHoraUltimaReducaoZ: TDateTime;
   iAux: Integer;
   iCountLimite: Integer;
begin

  FListaArquivos:=FListaArquivos;
   AtualizarStatus('Carregando dados dos produtos:...');
   IniciaBar(FListaArquivos.Count);

   for iDx := 0 to FListaArquivos.Count - 1 do
      begin
         IncBar;
        // GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);


         //Load XML nfe - nfce Componente ACBrNFe;
         sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));

         AtualizarStatus('Carregando dados dos produtos: ');

         if (Copy(sChave, 21, 2) = '55') or (Copy(sChave, 21, 2) = '65') then
            begin

               try
                 // GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);
                 if iDx<>0 then
                  FacbrNFe.NotasFiscais.Clear;


                  FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                  if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais) then
                     begin

                        AdicionarDadosProdutos(FacbrNFe.NotasFiscais);

                     end;
               except
                  on E: Exception do
                     GerarLinhaMemoLog('Erro ao processar arquivo saída: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
               end;
            end
         else
           GerarLinhaMemoLog('A chave não é Nfe(55) ou NFCe(65): ' + sChave);
      end;

end;

procedure TSpedPisCofins.CarregarXmlGeraRegM400M800(TotalArquivos: TStrings);
var
   sFiltroDocEmitido: String;
   Ano, Mes, Dia: Word;
   iDx,
   iIDNota: Integer;
   sChave: String;
   sMsgECF: String;
   dtFinalMovCupons: TDateTime;
   sNomeArquivoMFD: String;
   olstDadosUltimaReducaoZ: TStrings;
   sDataAux: String;
   dtDataHoraUltimaReducaoZ: TDateTime;
   iAux: Integer;
   iCountLimite: Integer;
begin

   FListaArquivos:= TotalArquivos;
   AtualizarStatus('Gerando Registro M400 e M800: ...');
   Application.ProcessMessages;
   IniciaBar(FListaArquivos.Count);

   for iDx := 0 to FListaArquivos.Count - 1 do
      begin
         IncBar;
        // GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);


         //Load XML nfe - nfce Componente ACBrNFe;
         sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));

         AtualizarStatus('Gerando Registro M400 e M800: ');

         if (Copy(sChave, 21, 2) = '55') or (Copy(sChave, 21, 2) = '65') then
            begin
              Application.ProcessMessages;
               try
                //  GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);
                  FacbrNFe.NotasFiscais.Clear;
                  FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                //  if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais) then
                     begin
//
                       AdicionarDadosProdutosCSTAliquitaBlocoM400M800(FacbrNFe.NotasFiscais);

                     end;
               except
                  on E: Exception do
                     GerarLinhaMemoLog('Erro ao processar arquivo saída: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
               end;
            end
         else
         //  GerarLinhaMemoLog('A chave não é Nfe(55) ou NFCe(65): ' + sChave);
      end;

end;

function TSpedPisCofins.ChaveDuplicadaNaApuracao(const Chave: String): Boolean;
begin
   FTabelaRegC100.IndexFieldNames:='CHV_NFE';
   FTabelaRegC100.Filtered := False;
   FTabelaRegC100.Filter := 'CHV_NFE = ' + QuotedStr(Chave);
   FTabelaRegC100.Filtered := True;
   Result := (not FTabelaRegC100.IsEmpty);
   FTabelaRegC100.Filtered := False;
end;

procedure TSpedPisCofins.ClearBar;
begin
   if (Assigned(FProgressBar)) then
      begin
         FProgressBar.Max      := 0;
         FProgressBar.Position := 0;
      end;
end;

function TSpedPisCofins.ConectarImpressoraECF(var sMsgRet: String): Boolean;
var
   sMsgValid: String;
   INI: TIniFile;
   iCodModECF: Integer;
begin
   sMsgValid := '';
   try
      if (not FileExists(ExtractFilePath(Application.ExeName) + _ARQUIVO_CONFIG_INI_ECF)) then
         begin
            Result := False;
            sMsgValid := 'Arquivo "' + _ARQUIVO_CONFIG_INI_ECF+ '" não econtrado!';
            Exit;
         end;

     INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + _ARQUIVO_CONFIG_INI_ECF);
     try
        iCodModECF := INI.ReadInteger('ECF','Modelo', 0);
        FACBrECF.Modelo := TACBrECFModelo( iCodModECF );
        GerarLinhaMemoLog('Modelo ECF: ' + GetEnumName(TypeInfo(TACBrECFModelo), Integer(iCodModECF)));

        FACBrECF.Porta := INI.ReadString('ECF','Porta', 'Procurar');
        GerarLinhaMemoLog('Porta ECF: ' + FACBrECF.Porta);

        FACBrECF.Device.ParamsString := INI.ReadString('ECF','SerialParams','');

        GerarLinhaMemoLog('Baud rate (Bits por Segundo): ' + IntToStr(FACBrECF.Device.Baud) );

        if (iCodModECF = 0) then
           begin
              Result := False;
              sMsgValid := sMsgValid + ' | Modelo ECF = ecfNenhum - Inválido';
           end;

        if (AnsiUpperCase(FACBrECF.Porta) = AnsiUpperCase('Procurar')) then
           begin
              Result := False;
              sMsgValid := sMsgValid + ' | Porta = Procurar - Inválida';
           end;
     finally
        INI.Free;
     end;

     GerarLinhaMemoLog('Ativando ECF...');
     FACBrECF.Ativar;
     if (FACBrECF.Ativo) then
        begin
           GerarLinhaMemoLog('ECF Ativa!');
           GerarLinhaMemoLog('Dados obtidos da ECF: ');
           GerarLinhaMemoLog('CNPJ: ' + FACBrECF.CNPJ);
           GerarLinhaMemoLog('IE: ' + FACBrECF.IE);
           GerarLinhaMemoLog('IM:' + FACBrECF.IM);
           GerarLinhaMemoLog('Marca: ' + FACBrECF.ModeloStr);
           GerarLinhaMemoLog('Modelo: ' + FACBrECF.SubModeloECF);
           GerarLinhaMemoLog('Nr. ECF: ' + FACBrECF.NumECF);
           GerarLinhaMemoLog('Nr. Série: ' + FACBrECF.NumSerie);
           GerarLinhaMemoLog('Nr. CRZ (Contador de Reduções Z): ' + FACBrECF.NumCRZ);
        end;
     Result := True;
     sMsgRet := sMsgValid;
   except
     on E: Exception do
        sMsgRet := 'Erro desconhecido: ' + E.Message + '  ' + sMsgValid;
   end;
end;

function TSpedPisCofins.ConfiguracoesValidasParaGerarSpedPisCofins: Boolean;
begin
   Result := False;
   Result := False;

   if (DataInicial <= 0) then
      MensagemAviso('A data inicial do período não foi informada no SPED Pis Cofins!')
   else
   if (DataFinal <= 0) then
      MensagemAviso('A data final do período não foi informada no SPED Pis Cofins!')
   else
   if (CodigoEmpresa <= 0) then
      MensagemAviso('Código da empresa não foi informado no SPED Pis Cofins!')
   else
   if (FGerarCupomFiscal) and (FGerarComArquivoMFDSPEDLocal) and (not FileExists(FLocalArquivoMFDSPED)) then
      MensagemAviso('Arquivo MFD SPED não existe no local informado!' + sLineBreak +
                    FLocalArquivoMFDSPED)
   else
      Result := True;
end;

function TSpedPisCofins.ConverteCstIPI_Entrada(vIpi: string): String;
begin


   if  (vIpi = '50')then
        Result := '00'
   else
   if  (vIpi = '51') then
        result := '01'
   else
   if  (vIpi = '52') then
        Result := '02'
   else
   if  (vIpi = '53') then
        Result := '03'
   else
   if  (vIpi = '54')then
        Result := '04'
   else
   if  (vIpi = '55') then
        Result := '05'
   else
   if  (vIpi = '99') then
        Result := '49'
   else
        Result := '49';


end;

function TSpedPisCofins.ConverterCFOPEntrada(const CFOPSaida: String): String;
var
   sCFOPAux: String;
   sCodAux: String;
   SQL,teste: String;
   iCFOP: Integer;
   iCFOPDefault: Integer;
   bBuscarNaBse: Boolean;
begin


   bBuscarNaBse := (Trim(CFOPSaida) <> '');

   if (bBuscarNaBse) then //mauricio 26072024 inicio
      begin

         try
            SQL := ' SELECT CFOP.CFOPEQUIVALENTE'+
                   ' FROM CFOP '+
                   ' WHERE CFOP.CD_CFOP ='+QuotedStr(CFOPSaida);

            dmPrincipal.FdQueryAuxiliar.SQL.Clear;
            dmPrincipal.FdQueryAuxiliar.SQL.Add(SQL);
            dmPrincipal.FdQueryAuxiliar.Open;


            if (not dmPrincipal.FdQueryAuxiliar.IsEmpty) then
               begin
                   sCFOPAux := dmPrincipal.FdQueryAuxiliar.FieldByName('CFOPEQUIVALENTE').AsString;
                   Result := sCFOPAux;
                   if (Result <> '') then
                      Exit;
               end;
         finally
           dmPrincipal.FdQueryAuxiliar.SQL.Clear;
           SQL:='';
         end;
      end;             //mauricio 26072024 fim



   sCodAux := Copy(CFOPSaida,1,1);
   sCFOPAux := Copy(CFOPSaida,2,3);

   if (sCodAux = '7') then
      sCodAux := '3'
   else
   if (sCodAux = '6') then
      sCodAux := '2'
   else
      sCodAux := '1';

   iCFOPDefault := StrToIntDef(sCodAux + '102', 1102);

   iCFOP := StrToIntDef(sCodAux + sCFOPAux, iCFOPDefault);

   // Valida CFOP Entrada

   case iCFOP of
      1101,1102,1111,1113,1116,1117,1118,1120,1121,1122,1124,1125,1126,1128,1151,1152,1153,1154,1201,1202,
      1203,1204,1205,1206,1207,1208,1209,1251,1252,1253,1254,1255,1256,1257,1301,1302,1303,1304,1305,1306,
      1351,1352,1353,1354,1355,1356,1360,1401,1403,1406,1407,1408,1409,1410,1411,1414,1415,1451,1452,1501,
      1503,1504,1505,1506,1551,1552,1553,1554,1555,1556,1557,1601,1602,1603,1604,1605,1651,1652,1653,1658,
      1659,1660,1661,1662,1663,1664,1901,1902,1903,1904,1905,1906,1907,1908,1909,1910,1911,1912,1913,1914,
      1915,1916,1917,1918,1919,1920,1921,1922,1923,1924,1925,1926,1931,1932,1933,1934,1949,2101,2102,2111,
      2113,2116,2117,2118,2120,2121,2122,2124,2125,2126,2128,2151,2152,2153,2154,2201,2202,2203,2204,2205,
      2206,2207,2208,2209,2251,2252,2253,2254,2255,2256,2257,2301,2302,2303,2304,2305,2306,2351,2352,2353,
      2354,2355,2356,2401,2403,2406,2407,2408,2409,2410,2411,2414,2415,2501,2503,2504,2505,2506,2551,2552,
      2553,2554,2555,2556,2557,2603,2651,2652,2653,2658,2659,2660,2661,2662,2663,2664,2901,2902,2903,2904,
      2905,2906,2907,2908,2909,2910,2911,2912,2913,2914,2915,2916,2917,2918,2919,2920,2921,2922,2923,2924,
      2925,2931,2932,2933,2934,2949,3101,3102,3126,3127,3128,3201,3202,3205,3206,3207,3211,3251,3301,3351,
      3352,3353,3354,3355,3356,3503,3551,3553,3556,3651,3652,3653,3930,3949:
      Result := IntToStr(iCFOP)
   else
      // Se a CFOP convertida não está na lista válida, joga a padrão
      Result := sCodAux + '102';
   end;
end;

function TSpedPisCofins.ConverterCST_PIS_COF_SaiToEnt(const CST_SAI: String): String;
begin

   if  (CST_SAI = '01')then
        Result := '50'
   else
   if  (CST_SAI = '02') or
       (CST_SAI = '03') or
       (CST_SAI = '04') then
        Result := '70'
   else
   if  (CST_SAI = '05') then
        Result := '75'
   else
   if  (CST_SAI = '06') then
        Result := '73'
   else
   if  (CST_SAI = '07') or
       (CST_SAI = '08') then
        Result := '70'
   else
   if  (CST_SAI = '09') then
        Result := '70'
   else
   if  (CST_SAI = '49') then
        Result := '99'
   else
        Result := '70';

end;

function TSpedPisCofins.ConverterEquivalenciaCSOSNToCST(const CSOSN: String;
  const TemAliqIcms: Boolean): String;
begin
 {

 --CST--  |             --CSOSN--

00, 20    |               101    |             -
40, 41    |               102    |             -
50, 51    |               300    |             -
10, 70    |               201    |             -
30        |               202    |             -
60        |               500    |             -
90        |               400    |             Não Tributado
-         |               900    |             Outros

}

   if (Trim(CSOSN) = '') then
      Result := IfThen(TemAliqICMS, '00', '40')
   else
   if (Trim(CSOSN) = '101') then
      Result := '00'
   else
   if (Trim(CSOSN) = '102') then
      Result := '40'
   else
   if (Trim(CSOSN) = '300') then
      Result := '50'
   else
   if (Trim(CSOSN) = '201') then
      Result := '10'
   else
   if (Trim(CSOSN) = '202') then
      Result := '30'
   else
   if (Trim(CSOSN) = '500') then
      Result := '60'
   else
   if (Trim(CSOSN) = '400') or
      (Trim(CSOSN) = '900') then
      Result := '90'
   else
      Result := IfThen(TemAliqICMS, '00', '40')

end;

constructor TSpedPisCofins.Create(AOwner: TComponent);
begin
  inherited;
  FSemLimite := False;
  FECF_RequerZ := False;
  FOriginal := True;
  FCodigoEmpresa := 0;

  CriarTabelasTmpMem;
  CriarFieldsDataSets;
  FcompSpedPisCofins := TACBrSPEDPisCofins.Create(Self);
  FACBrSPEDECF := TACBrSPEDFiscal.Create(Self);
  FacbrNFe := TACBrNFe.Create(Self);
  FACBrECF := TACBrECF.Create(Self);

  //** Configurar Eventos ECF
  FACBrECF.OnAguardandoRespostaChange := ACBrECFAguardandoRespostaChange;
  FACBrECF.OnChangeEstado := ACBrECFChangeEstado;
  FACBrECF.OnMsgAguarde := ACBrECFMsgAguarde;
  FACBrECF.OnMsgPoucoPapel := ACBrECFMsgPoucoPapel;

  SetEventoOnError;
  FListaArquivos := TStringList.Create;
end;

procedure TSpedPisCofins.CriarFieldsDataSets;
begin
   GerarLinhaMemoLog('Criando "Fields"... campos estáticos nos datasets');

    // Dataset Registro 0150 - Participantes
   FTabelaReg0150.Close;
   FTabelaReg0150.FieldDefs.Clear;
   FTabelaReg0150.FieldDefs.add('COD_PART', ftString, 10);
   FTabelaReg0150.FieldDefs.add('NOME', ftString, 60);
   FTabelaReg0150.FieldDefs.add('COD_PAIS', ftString, 5);
   FTabelaReg0150.FieldDefs.add('CNPJCPF', ftString, 14);
   FTabelaReg0150.FieldDefs.add('IE', ftString, 14);
   FTabelaReg0150.FieldDefs.add('COD_MUN', ftInteger);
   FTabelaReg0150.FieldDefs.add('ENDERECO', ftString, 60);
   FTabelaReg0150.FieldDefs.add('NUM', ftString, 60);
   FTabelaReg0150.FieldDefs.add('COMPL', ftString, 60);
   FTabelaReg0150.FieldDefs.add('BAIRRO', ftString, 60);
   FTabelaReg0150.CreateDataSet;

   // Dataset Registro 0190 - Unidade de medida
   FTabelaReg0190.Close;
   FTabelaReg0190.FieldDefs.Clear;
   FTabelaReg0190.FieldDefs.add('UNID', ftString, 6);
   FTabelaReg0190.FieldDefs.add('DESCR', ftString, 15);
   FTabelaReg0190.CreateDataSet;

   // Dataset Registro 0200 - Produtos e Serviços
   FTabelaReg0200.Close;
   FTabelaReg0200.FieldDefs.Clear;
   FTabelaReg0200.FieldDefs.add('TIPO_ITEM', ftString, 1); // S = Serviço e P = Produto
   FTabelaReg0200.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaReg0200.FieldDefs.add('DESCR_ITEM', ftString, 60);
   FTabelaReg0200.FieldDefs.add('COD_BARRA', ftString, 60);
   FTabelaReg0200.FieldDefs.add('COD_ANT_ITEM', ftString, 60);
   FTabelaReg0200.FieldDefs.add('UNID_INV', ftString, 60);
   FTabelaReg0200.FieldDefs.add('COD_NCM', ftString, 60);
   FTabelaReg0200.FieldDefs.add('ALIQ_ICMS', ftFloat);
   FTabelaReg0200.CreateDataSet;

   // Dataset Registro 0400 - Natureza de operações
   FTabelaReg0400.Close;
   FTabelaReg0400.FieldDefs.Clear;
   FTabelaReg0400.FieldDefs.add('COD_NAT', ftInteger);
   FTabelaReg0400.FieldDefs.add('CFOP', ftString, 4);
   FTabelaReg0400.FieldDefs.add('DESCR_NAT', ftString, 60);
   FTabelaReg0400.CreateDataSet;

   // Dataset Registro C100 - Notas fiscais
   FTabelaRegC100.Close;
   FTabelaRegC100.FieldDefs.Clear;
   FTabelaRegC100.FieldDefs.add('ID', ftInteger);
   FTabelaRegC100.FieldDefs.add('IND_OPER', ftInteger); // 0=Entrada / 1=Saida
   FTabelaRegC100.FieldDefs.add('COD_MOD', ftString, 2);
   FTabelaRegC100.FieldDefs.add('SER', ftString, 3);
   FTabelaRegC100.FieldDefs.add('NUM_DOC', ftInteger);
   FTabelaRegC100.FieldDefs.add('CHV_NFE', ftString, 44);
   FTabelaRegC100.FieldDefs.add('COD_SIT', ftInteger); {}
   FTabelaRegC100.FieldDefs.add('COD_PART', ftString, 9);
   FTabelaRegC100.FieldDefs.add('DT_DOC', ftDateTime);
   FTabelaRegC100.FieldDefs.add('DT_E_S', ftDateTime);
   FTabelaRegC100.FieldDefs.add('VL_DOC', ftFloat);
   FTabelaRegC100.FieldDefs.add('IND_PGTO', ftInteger);
   FTabelaRegC100.FieldDefs.add('VL_DESC', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_ABAT_NT', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_MERC', ftFloat);
   FTabelaRegC100.FieldDefs.add('IND_FRT', ftInteger);
   FTabelaRegC100.FieldDefs.add('VL_FRT', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_SEG', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_OUT_DA', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_BC_ICMS', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_ICMS', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_BC_ICMS_ST', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_ICMS_ST', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_IPI', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_PIS', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_COFINS', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_PIS_ST', ftFloat);
   FTabelaRegC100.FieldDefs.add('VL_COFINS_ST', ftFloat);
   FTabelaRegC100.CreateDataSet;

   // Dataset Registro C170 - Itens das Notas fiscais
   FTabelaRegC170.Close;
   FTabelaRegC170.FieldDefs.Clear;
   FTabelaRegC170.FieldDefs.add('NFID', ftInteger);
   FTabelaRegC170.FieldDefs.add('NUM_ITEM', ftString, 3);
   FTabelaRegC170.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaRegC170.FieldDefs.add('DESCR_COMPL', ftString, 60);
   FTabelaRegC170.FieldDefs.add('QTD', ftFloat);
   FTabelaRegC170.FieldDefs.add('UNID', ftString, 6);
   FTabelaRegC170.FieldDefs.add('VL_ITEM', ftFloat);
   FTabelaRegC170.FieldDefs.add('VL_DESC', ftFloat);
   FTabelaRegC170.FieldDefs.add('IND_MOV', ftInteger);
   FTabelaRegC170.FieldDefs.add('CST_ICMS', ftString, 3);
   FTabelaRegC170.FieldDefs.add('CFOP', ftString, 4);
   FTabelaRegC170.FieldDefs.add('COD_NAT', ftString, 10);
   FTabelaRegC170.FieldDefs.add('VL_BC_ICMS', ftFloat);
   FTabelaRegC170.FieldDefs.add('ALIQ_ICMS', ftFloat);
   FTabelaRegC170.FieldDefs.add('VL_ICMS', ftFloat);
   FTabelaRegC170.FieldDefs.add('VL_BC_ICMS_ST', ftFloat);
   FTabelaRegC170.FieldDefs.add('ALIQ_ST', ftFloat);
   FTabelaRegC170.FieldDefs.add('VL_ICMS_ST', ftFloat);
   FTabelaRegC170.FieldDefs.add('IND_APUR', ftInteger);
   FTabelaRegC170.FieldDefs.add('CST_IPI', ftString, 2);
   FTabelaRegC170.FieldDefs.add('COD_ENQ', ftString, 3);
   FTabelaRegC170.FieldDefs.add('VL_BC_IPI', ftFloat);
   FTabelaRegC170.FieldDefs.add('ALIQ_IPI', ftFloat);
   FTabelaRegC170.FieldDefs.add('VL_IPI', ftFloat);
   FTabelaRegC170.FieldDefs.add('CST_PIS', ftString, 2);
   FTabelaRegC170.FieldDefs.add('VL_BC_PIS', ftFloat);
   FTabelaRegC170.FieldDefs.add('ALIQ_PIS_PERC', ftFloat);
   FTabelaRegC170.FieldDefs.add('QUANT_BC_PIS', ftFloat);
   FTabelaRegC170.FieldDefs.add('ALIQ_PIS_R', ftFloat);
   FTabelaRegC170.FieldDefs.add('VL_PIS', ftFloat);
   FTabelaRegC170.FieldDefs.add('CST_COFINS', ftString, 2);
   FTabelaRegC170.FieldDefs.add('VL_BC_COFINS', ftFloat);
   FTabelaRegC170.FieldDefs.add('ALIQ_COFINS_PERC', ftFloat);
   FTabelaRegC170.FieldDefs.add('QUANT_BC_COFINS', ftFloat);
   FTabelaRegC170.FieldDefs.add('ALIQ_COFINS_R', ftFloat);
   FTabelaRegC170.FieldDefs.add('VL_COFINS', ftFloat);
   FTabelaRegC170.FieldDefs.add('COD_CTA', ftString, 10);
   FTabelaRegC170.CreateDataSet;

   // Dataset Registros E500
   FTabelaRegE510.Close;
   FTabelaRegE510.FieldDefs.Clear;
   FTabelaRegE510.FieldDefs.add('TIPO', ftString, 1); // Tipo E/S
   FTabelaRegE510.FieldDefs.add('CFOP', ftString, 4);
   FTabelaRegE510.FieldDefs.add('CST_IPI', ftString, 2);
   FTabelaRegE510.FieldDefs.add('VL_CONT_IPI', ftFloat);
   FTabelaRegE510.FieldDefs.add('VL_BC_IPI', ftFloat);
   FTabelaRegE510.FieldDefs.add('VL_IPI', ftFloat);
   FTabelaRegE510.FieldDefs.add('VL_BC_IPI_E', ftFloat);
   FTabelaRegE510.FieldDefs.add('VL_IPI_E', ftFloat);
   FTabelaRegE510.FieldDefs.add('VL_BC_IPI_S', ftFloat);
   FTabelaRegE510.FieldDefs.add('VL_IPI_S', ftFloat);
   FTabelaRegE510.CreateDataSet;

   {FTabelaReg1900.Close;
   FTabelaReg1900.FieldDefs.Clear;
   FTabelaReg1900.FieldDefs.add('COD_MOD', ftString, 2);
   FTabelaReg1900.FieldDefs.add('SER', ftString, 3);
   FTabelaReg1900.FieldDefs.add('SUB_SER', ftString, 5);
   FTabelaReg1900.FieldDefs.add('VL_TOT_REC', ftFloat);
   FTabelaReg1900.FieldDefs.add('CST_PIS_COF', ftString, 2);
   FTabelaReg1900.FieldDefs.add('CFOP', ftString, 4);
   FTabelaReg1900.FieldDefs.add('ALIQ_PIS', ftFloat);
   FTabelaReg1900.FieldDefs.add('ALIQ_COF', ftFloat);
   FTabelaReg1900.CreateDataSet;}

//   FTabelaRegC175.Close;
//   FTabelaRegC175.FieldDefs.Clear;
//   FTabelaRegC175.FieldDefs.add('NFID', ftInteger);
//   FTabelaRegC175.FieldDefs.add('CFOP', ftString, 4);
//   FTabelaRegC175.FieldDefs.add('VL_DESC', ftFloat);
//   FTabelaRegC175.FieldDefs.add('VL_OPR', ftFloat);
//   FTabelaRegC175.FieldDefs.add('CST_PIS', ftString, 2);
//   FTabelaRegC175.FieldDefs.add('ALIQ_PIS', ftFloat);
//   FTabelaRegC175.FieldDefs.add('VL_PIS', ftFloat);
//   FTabelaRegC175.FieldDefs.add('VL_BC_PIS', ftFloat);
//   FTabelaRegC175.FieldDefs.add('CST_COFINS', ftString, 2);
//   FTabelaRegC175.FieldDefs.add('ALIQ_COFINS', ftFloat);
//   FTabelaRegC175.FieldDefs.add('VL_COFINS', ftFloat);
//   FTabelaRegC175.FieldDefs.add('VL_BC_COFINS', ftFloat);
//   FTabelaRegC175.FieldDefs.add('COD_CTA', ftString, 10);
//   FTabelaRegC175.FieldDefs.add('INFO_COMPL', ftString, 10);
//   FTabelaRegC175.CreateDataSet;

   FTabelaRegC481_C485.Close;
   FTabelaRegC481_C485.FieldDefs.Clear;
   FTabelaRegC481_C485.FieldDefs.add('ECF_CX', ftInteger);
   FTabelaRegC481_C485.FieldDefs.add('CRZ', ftInteger);
   FTabelaRegC481_C485.FieldDefs.add('CST_PIS', ftString, 2);
   FTabelaRegC481_C485.FieldDefs.add('CST_COFINS', ftString, 2);
   FTabelaRegC481_C485.FieldDefs.add('VL_ITEM', ftFloat);
   FTabelaRegC481_C485.FieldDefs.add('VL_BC_PIS', ftFloat);
   FTabelaRegC481_C485.FieldDefs.add('ALIQ_PIS', ftFloat);
   FTabelaRegC481_C485.FieldDefs.add('VL_PIS', ftFloat);
   FTabelaRegC481_C485.FieldDefs.add('VL_BC_COFINS', ftFloat);
   FTabelaRegC481_C485.FieldDefs.add('ALIQ_COFINS', ftFloat);
   FTabelaRegC481_C485.FieldDefs.add('VL_COFINS', ftFloat);
   FTabelaRegC481_C485.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaRegC481_C485.FieldDefs.add('COD_CTA', ftString, 10);
   FTabelaRegC481_C485.CreateDataSet;

   {A100}
   FTabelaRegA100.Close;
   FTabelaRegA100.FieldDefs.Clear;
   FTabelaRegA100.FieldDefs.add('ID', ftInteger);
   FTabelaRegA100.FieldDefs.add('IND_OPER', ftInteger); {0 - contratado, 1 - Prestado}
   FTabelaRegA100.FieldDefs.add('IND_EMIT', ftInteger); {0 - Emiss prop. 1 - Emiss. Terc.}
   FTabelaRegA100.FieldDefs.add('COD_PART', ftString, 60);
   FTabelaRegA100.FieldDefs.add('COD_SIT', ftString, 2); {00 - Regular, 02 Cancelado}
   FTabelaRegA100.FieldDefs.add('SER', ftString, 20);
   FTabelaRegA100.FieldDefs.add('SUB', ftString, 20);
   FTabelaRegA100.FieldDefs.add('NUM_DOC', ftString, 60);
   FTabelaRegA100.FieldDefs.add('CHV_NFSE', ftString, 60);
   FTabelaRegA100.FieldDefs.add('DT_DOC', ftDateTime);
   FTabelaRegA100.FieldDefs.add('DT_EXE_SERV', ftDateTime); { Data conclusão serviço }
   FTabelaRegA100.FieldDefs.add('VL_DOC', ftFloat);
   FTabelaRegA100.FieldDefs.add('IND_PGTO', ftInteger); {0 - A vista, 1 - A prazo, 9 - Sem Pgto}
   FTabelaRegA100.FieldDefs.add('VL_DESC', ftFloat);
   FTabelaRegA100.FieldDefs.add('VL_BC_PIS', ftFloat);
   FTabelaRegA100.FieldDefs.add('VL_PIS', ftFloat);
   FTabelaRegA100.FieldDefs.add('VL_BC_COFINS', ftFloat);
   FTabelaRegA100.FieldDefs.add('VL_COFINS', ftFloat);
   FTabelaRegA100.FieldDefs.add('VL_PIS_RET', ftFloat);
   FTabelaRegA100.FieldDefs.add('VL_COFINS_RET', ftFloat);
   FTabelaRegA100.FieldDefs.add('VL_ISS', ftFloat);
   FTabelaRegA100.CreateDataSet;

   {A170}
   FTabelaRegA170.Close;
   FTabelaRegA170.FieldDefs.Clear;
   FTabelaRegA170.FieldDefs.add('NFID', ftInteger);
   FTabelaRegA170.FieldDefs.add('NUM_ITEM', ftInteger); {nr seq. item}
   FTabelaRegA170.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaRegA170.FieldDefs.add('DESCR_COMPL', ftString, 60);
   FTabelaRegA170.FieldDefs.add('VL_ITEM', ftFloat);
   FTabelaRegA170.FieldDefs.add('VL_DESC', ftFloat);
   FTabelaRegA170.FieldDefs.add('NAT_BC_CRED', ftString, 2); {Código da Base de Cálculo do Crédito - Tabela indicada no item 4.3.7}
   FTabelaRegA170.FieldDefs.add('IND_ORIG_CRED', ftInteger); {0 - Oper. Mercado. Interno, 1 - Oper. Importação}
   FTabelaRegA170.FieldDefs.add('CST_PIS', ftString, 2);
   FTabelaRegA170.FieldDefs.add('VL_BC_PIS', ftFloat);
   FTabelaRegA170.FieldDefs.add('ALIQ_PIS', ftFloat);
   FTabelaRegA170.FieldDefs.add('VL_PIS', ftFloat);
   FTabelaRegA170.FieldDefs.add('CST_COFINS', ftString, 2);
   FTabelaRegA170.FieldDefs.add('VL_BC_COFINS', ftFloat);
   FTabelaRegA170.FieldDefs.add('ALIQ_COFINS', ftFloat);
   FTabelaRegA170.FieldDefs.add('VL_COFINS', ftFloat);
   FTabelaRegA170.FieldDefs.add('COD_CTA', ftString, 10); {Codigo conta contabil}
   FTabelaRegA170.FieldDefs.add('COD_CCUS', ftString, 10); {Codigo centro de custos}
   FTabelaRegA170.CreateDataSet;

   FTaBelaRegM400.Close;
   FTaBelaRegM400.FieldDefs.Add('CFOP',ftString,4);
   FTaBelaRegM400.FieldDefs.Add('COD_NCM',ftString,60);
   FTaBelaRegM400.FieldDefs.Add('VL_PROD',ftFloat);
   FTaBelaRegM400.FieldDefs.Add('CST_PIS',ftString,2);
   FTaBelaRegM400.CreateDataSet;

   FTaBelaTempP400.close;
   FTaBelaTempP400.FieldDefs.Add('CST',ftString,3);
   FTaBelaTempP400.FieldDefs.Add('NAT_REC',ftString,10);
   FTaBelaTempP400.FieldDefs.Add('VL_REC',ftFloat);
   FTaBelaTempP400.CreateDataSet;

   FTaBelaTempP210.close;
   FTaBelaTempP210.FieldDefs.Add('CST_PIS',ftString,3);
   FTaBelaTempP210.FieldDefs.Add('COD_NCM',ftString,60);
   FTaBelaTempP210.FieldDefs.Add('dBasePis',ftFloat);
   FTaBelaTempP210.FieldDefs.Add('dAliqPis',ftFloat);
   FTaBelaTempP210.FieldDefs.Add('dValorPis',ftFloat);
   FTaBelaTempP210.FieldDefs.Add('dValorBasePisCof',ftFloat);
   FTaBelaTempP210.FieldDefs.Add('dBaseCof',ftFloat);
   FTaBelaTempP210.FieldDefs.Add('dAliqCof',ftFloat);
   FTaBelaTempP210.FieldDefs.Add('dValorCof',ftFloat);
   FTaBelaTempP210.CreateDataSet;


   FTaBelaTempP800.close;
   FTaBelaTempP800.FieldDefs.Add('CST',ftString,3);
   FTaBelaTempP800.FieldDefs.Add('NAT_REC',ftString,10);
   FTaBelaTempP800.FieldDefs.Add('VL_REC',ftFloat);
   FTaBelaTempP800.CreateDataSet;


   FTaBelaTempP810.close;
   FTaBelaTempP810.FieldDefs.Add('CST_PIS',ftString,3);
   FTaBelaTempP810.FieldDefs.Add('dBasePis',ftFloat);
   FTaBelaTempP810.FieldDefs.Add('dAliqPis',ftFloat);
   FTaBelaTempP810.FieldDefs.Add('dValorPis',ftFloat);
   FTaBelaTempP810.FieldDefs.Add('dValorBasePisCof',ftFloat);
   FTaBelaTempP810.FieldDefs.Add('dBaseCof',ftFloat);
   FTaBelaTempP810.FieldDefs.Add('dAliqCof',ftFloat);
   FTaBelaTempP810.FieldDefs.Add('dValorCof',ftFloat);
   FTaBelaTempP810.CreateDataSet;



end;

procedure TSpedPisCofins.CriarTabelasTmpMem;
begin
   // ClientDataSet
   FcdsResultExec := TClientDataSet.Create(Self);
   FTabelaEmpresa := TClientDataSet.Create(Self);
   FTabelaContador := TClientDataSet.Create(Self);
   FTabelaReg0150  := TClientDataSet.Create(Self);
   FTabelaReg0190  := TClientDataSet.Create(Self);
   FTabelaReg0200  := TClientDataSet.Create(Self);
   FTabelaReg0400  := TClientDataSet.Create(Self);
   FTabelaRegC100  := TClientDataSet.Create(Self);
   FTabelaRegC170  := TClientDataSet.Create(Self);
   FTabelaRegE510  := TClientDataSet.Create(Self);
   FTabelaRegC500  := TClientDataSet.Create(Self);
 // FTabelaReg1900  := TClientDataSet.Create(Self);
  // FTabelaRegC175  :=  TClientDataSet.Create(Self);
   FTabelaRegC481_C485 := TClientDataSet.Create(Self);
   FTabelaRegA100  := TClientDataSet.Create(Self);
   FTabelaRegA170  := TClientDataSet.Create(Self);
   FTaBelaRegM400  := TClientDataSet.Create(Self);
   FTaBelaTempP400 := TClientDataSet.Create(Self);
   FTaBelaTempP210 := TClientDataSet.Create(Self);
   FTaBelaTempP800 := TClientDataSet.Create(Self);
   FTaBelaTempP810 := TClientDataSet.Create(Self);
   // Query
   FqryResultExec := TSQLQuery.Create(Self);
   FqTabelaEmpresa := TSQLQuery.Create(Self);
   FqTabelaContador := TSQLQuery.Create(Self);
   FqTabelaRegC500 := TSQLQuery.Create(Self);

   // Provider
   FdspResultExec := TDataSetProvider.Create(Self);
   FpTabelaEmpresa := TDataSetProvider.Create(Self);
   FpTabelaContador := TDataSetProvider.Create(Self);
   FpTabelaRegC500 := TDataSetProvider.Create(Self);
end;

destructor TSpedPisCofins.Destroy;
begin
   FListaArquivos.Free;

   FreeAndNil(FcompSpedPisCofins);
   FreeAndNil(FacbrNFe);
   FreeAndNil(FACBrECF);
   FreeAndNil(FACBrSPEDECF);

   DestruirTabelasTmpMem;
   inherited;
end;

procedure TSpedPisCofins.DestruirTabelasTmpMem;
begin
   FreeAndNil(FcdsResultExec);
   FreeAndNil(FqryResultExec);
   FreeAndNil(FdspResultExec);
   FreeAndNil(FTabelaEmpresa);
   FreeAndNil(FqTabelaEmpresa);
   FreeAndNil(FpTabelaEmpresa);
   FreeAndNil(FTabelaContador);
   FreeAndNil(FqTabelaContador);
   FreeAndNil(FpTabelaContador);
   FreeAndNil(FTabelaReg0150);
   FreeAndNil(FTabelaReg0200);
   FreeAndNil(FTabelaReg0190);
   FreeAndNil(FTabelaReg0400);
   FreeAndNil(FTabelaRegC100);
   FreeAndNil(FTabelaRegC170);
   FreeAndNil(FTabelaRegE510);
   FreeAndNil(FTabelaRegC500);
   FreeAndNil(FqTabelaRegC500);
   FreeAndNil(FpTabelaRegC500);
  // FreeAndNil(FTabelaReg1900);
  // FreeAndNil(FTabelaRegC175);
   FreeAndNil(FTabelaRegC481_C485);
   FreeAndNil(FTabelaRegA100);
   FreeAndNil(FTabelaRegA170);
   FreeAndNil(FTaBelaRegM400);
   FreeAndNil(FTaBelaTempP400);
   FreeAndNil(FTaBelaTempP210);
   FreeAndNil(FTaBelaTempP800);
   FreeAndNil(FTaBelaTempP810);

end;

procedure TSpedPisCofins.GerarAquivo;
begin
   if (ConfiguracoesValidasParaGerarSpedPisCofins) then
      begin
         GerarLinhaMemoLog(_INICIO_SPED_PIS_COFINS);


         IniciarControles;

         LimparTabela;
         CarregarDocumentosXML;

         GerarBloco_0;
         GerarBloco_A;
         GerarBloco_C;
         GerarBloco_D;
         GerarBloco_F;
         GerarBloco_M;
         GerarBloco_1;

         {Salva o arquivo}
         try
            FcompSpedPisCofins.SaveFileTXT;
            GerarLinhaMemoLog('Arquivo SPED Pis Cofins gerado com sucesso!');
            GerarLinhaMemoLog(String(Self.FcompSpedPisCofins.Path) + String(Self.FcompSpedPisCofins.Arquivo));

            MensagemInformacao('Arquivo SPED Pis Cofins gerado com sucesso!' + sLineBreak + sLinebreak +
                              String(Self.FcompSpedPisCofins.Path) + String(Self.FcompSpedPisCofins.Arquivo));
         except
            on E: Exception do
               begin
                  GerarLinhaMemoLog('Erro ao gerar Arquivo SPED Pis Cofins: ' + E.Message);
                  MensagemErro('Erro ao gerar Arquivo SPED Pis Cofins!' + sLineBreak + sLinebreak +
                                     E.Message);
               end;
         end;
      end;
end;

procedure TSpedPisCofins.GerarBloco_0;
var
   Registro0000: ACBrEPCBloco_0.TRegistro0000;
   Registro0001: ACBrEPCBloco_0.TRegistro0001;
   Registro0100: ACBrEPCBloco_0.TRegistro0100;
   Registro0110: ACBrEPCBloco_0.TRegistro0110;
   Registro0111: ACBrEPCBloco_0.TRegistro0111;
   Registro0140: ACBrEPCBloco_0.TRegistro0140;
   Registro0150: ACBrEPCBloco_0.TRegistro0150;
   Registro0190: ACBrEPCBloco_0.TRegistro0190;
   Registro0200: ACBrEPCBloco_0.TRegistro0200;
   Registro0400: ACBrEPCBloco_0.TRegistro0400;
   Registro0500: ACBrEPCBloco_0.TRegistro0500;

   sDocContador,unidade: String;
   IND_REG_CUMULATIVO:Integer;
begin

  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.Open;

  dmPrincipal.cdsConsDadosContador.Close;
  dmPrincipal.cdsConsDadosContador.ParamByName('cd_filial').Value:=dmPrincipal.cdsConsEmpresaCD_FILIAL.Value;
  dmPrincipal.cdsConsDadosContador.Open;


   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0000 - Dados da empresa');
   CarregarInformacoesEmpresa;
   Registro0000 := FcompSpedPisCofins.Bloco_0.Registro0000New;

   {
    001.100 - Versão 1.00 ADE Cofis nº 31/2010 de 01/01/2011
    002.101 - Versão 1.01 ADE Cofis nº 34/2010 de 01/01/2011
    002.200 - Versão 2.00 ADE Cofis nº 20/2012
    003.201 - Versão 2.01 ADE Cofis nº 20/2012 de 14/03/2012
   }
   Registro0000.COD_VER := vlVersao320;

   if (Original) then
      Registro0000.TIPO_ESCRIT := tpEscrOriginal
   else
      Registro0000.TIPO_ESCRIT := tpEscrRetificadora;

   // ** Dados da empresa
   Registro0000.IND_SIT_ESP      := indNenhum;
   Registro0000.NUM_REC_ANTERIOR := Self.FNrReciboEscritAnterior;

   Registro0000.NOME             := dmPrincipal.cdsConsEmpresaRAZAO.value;
   Registro0000.CNPJ             := Self.FCnpjEmpresa;
   Registro0000.UF               := dmPrincipal.cdsConsEmpresaUF.Value;
   Registro0000.COD_MUN          := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.AsInteger;
   Registro0000.SUFRAMA          := '';
     //combobox
   if (FrmPrincipal.CbbNaturezaEmpresarial.ItemIndex = 0) then
      Registro0000.IND_NAT_PJ := indNatPJSocEmpresariaGeral
   else
   if (FrmPrincipal.CbbNaturezaEmpresarial.ItemIndex = 1) then
      Registro0000.IND_NAT_PJ := indNatPJSocCooperativa
   else
   if (FrmPrincipal.CbbNaturezaEmpresarial.ItemIndex = 2) then
      Registro0000.IND_NAT_PJ := indNatPJEntExclusivaFolhaSal;

   if (FrmPrincipal.CbbNaturezaEmpresarial.ItemIndex = 0) then
       Registro0000.IND_ATIV := indAtivComercio
   else
       Registro0000.IND_ATIV := indAtivIndustrial;

   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0001 - Abertura do bloco');
   Registro0001 := FcompSpedPisCofins.Bloco_0.Registro0001New;
   Registro0001.IND_MOV := ACBrEPCBlocos.imComDados;

   // ** Dados do contador
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0100 - Dados do contador.');

   CarregarInformacoesContador;

   Registro0100 := FcompSpedPisCofins.Bloco_0.Registro0100New;

   Registro0100.NOME := dmPrincipal.cdsConsDadosContadorNOME.Value;
   sDocContador := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorCPF.Value);
   if (Length(sDocContador) = 14) then
      Registro0100.CNPJ := sDocContador
   else
      Registro0100.CPF := sDocContador;

   Registro0100.CRC        := dmPrincipal.cdsConsDadosContadorCRC.Value;
   Registro0100.CEP        := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorCEP.Value);
   Registro0100.ENDERECO   := dmPrincipal.cdsConsDadosContadorENDERECO.Value;
   Registro0100.NUM        := dmPrincipal.cdsConsDadosContadorNUMERO.Value;
   Registro0100.COMPL      := dmPrincipal.cdsConsDadosContadorCOMPLEMENTO.Value;
   Registro0100.BAIRRO     := dmPrincipal.cdsConsDadosContadorBAIRRO.Value;
   Registro0100.FONE       := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorTELEFONE.Value);
   Registro0100.FAX        := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorFAX.Value);
   Registro0100.EMAIL      := dmPrincipal.cdsConsDadosContadorEMAIL.Value;
   Registro0100.COD_MUN    := dmPrincipal.cdsConsDadosContadorCOD_CIDADE.AsInteger;

   // ** Regime de apuração

   { COD_INC_TRIB
       codEscrOpIncNaoCumulativo = 1 - Escrituração de operações com incidencia exclusivamente no regime não cumulativo
       codEscrOpIncCumulativo    = 2 - Escrituração de operações com incidencia exclusivamente no regime cumulativo
       codEscrOpIncAmbos         = 3 - Escrituração de operações com incidencia nos regimes cumulativo e não cumulativo

    IND_APRO_CRED
       indMetodoApropriacaoDireta    = 0 - Método de apropriação direta
       indMetodoDeRateioProporcional = 1 - Método de rateio proporcional(Receita Bruta)

    COD_TIPO_CONT
       codIndTipoConExclAliqBasica = 1 - Apuração da Contribuição Exclusivamente a Alíquota Básica
       codIndTipoAliqEspecificas   = 2 - Apuração da Contribuição a Alíquotas Específicas (Diferenciadas e/ou por Unidade de Medida de Produto)

    IND_REG_CUM
       codRegimeCaixa,                  = 1 – Regime de Caixa – Escrituração consolidada (Registro F500)
       codRegimeCompetEscritConsolidada = 2 – Regime de Competência - Escrituração consolidada (Registro F550)
       codRegimeCompetEscritDetalhada   = 9 – Regime de Competência - Escrituração detalhada, com base nos registros dos Blocos “A”, “C”, “D” e “F”.
       }


   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0110 - Regimes de Apuração');

   Registro0110 := FcompSpedPisCofins.Bloco_0.Registro0110New;

        // add mauricio
   case FrmPrincipal.CbbIncidenciaTributaria.ItemIndex + 1 of
     1: Registro0110.COD_INC_TRIB := codEscrOpIncNaoCumulativo;
     2: Registro0110.COD_INC_TRIB := codEscrOpIncCumulativo;
     3: Registro0110.COD_INC_TRIB := codEscrOpIncAmbos;
   end;

   case FrmPrincipal.CbbMetododeApropriacao.ItemIndex + 1 of
     1: Registro0110.IND_APRO_CRED := indMetodoApropriacaoDireta;
     2: Registro0110.IND_APRO_CRED := indMetodoDeRateioProporcional;
   end;

   case FrmPrincipal.CbbTipoContribuicaoApurada.ItemIndex + 1 of
     1: Registro0110.COD_TIPO_CONT := codIndTipoConExclAliqBasica;
     2: Registro0110.COD_TIPO_CONT := codIndTipoAliqEspecificas;
   end;

   if  FrmPrincipal.CbbIndicadorRegimeCumulativo.ItemIndex <=1 then
       IND_REG_CUMULATIVO:=FrmPrincipal.CbbIndicadorRegimeCumulativo.ItemIndex + 1
    else
      IND_REG_CUMULATIVO:=9;


   case IND_REG_CUMULATIVO of
     1: Registro0110.IND_REG_CUM := codRegimeCaixa;
     2: Registro0110.IND_REG_CUM := codRegimeCompetEscritConsolidada;
     9: Registro0110.IND_REG_CUM := codRegimeCompetEscritDetalhada;
   end;

   {
      ** Regra do Manual SPED Pis Cofins

      F500
      OC (se no registro 0110 o Campo “COD_INC_TRIB” = “2” e o Campo “IND_REG_CUM” = “1”) -> Obrigatorio se houver informação
      N (se no registro 0110 o Campo “COD_INC_TRIB” = “1” e “3” ou, se “2” o Campo “IND_REG_CUM” = “2” ou “9”) -> Não Informar

      F550
      OC (se no registro 0110 o Campo “COD_INC_TRIB” = “2” e o Campo “IND_REG_CUM” = “2”)
      N (se no registro 0110 o Campo “COD_INC_TRIB” = “1” e “3” ou, se “2” o Campo “IND_REG_CUM” = “1” ou “9”)
   }

   FGerarBlocoF := ((FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.COD_INC_TRIB = codEscrOpIncCumulativo) and
                    (FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.IND_REG_CUM = codRegimeCaixa));

   if (not FGerarBlocoF) then
      FGerarBlocoF := ((FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.COD_INC_TRIB = codEscrOpIncCumulativo) and
                       (FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.IND_REG_CUM = codRegimeCompetEscritConsolidada));

   // *** Tabela de receita bruta mensal para rateio

   {
     Obrigatório  (se no registro 0110 o Campo “COD_INC_TRIB” = 1, ou 3 e o Campo “IND_APRO_CRED” = 2)
     N (se no registro 0110 o Campo “COD_INC_TRIB” = 2 ou o Campo “IND_APRO_CRED” = 1)
   }
   if ( ((Registro0110.COD_INC_TRIB = codEscrOpIncNaoCumulativo) or
         (Registro0110.COD_INC_TRIB = codEscrOpIncAmbos)) and
        (Registro0110.IND_APRO_CRED = indMetodoApropriacaoDireta) ) then
      begin
         GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0111 - Tabela de Receita Bruta Mensal / Rateio');

         Registro0111 := FcompSpedPisCofins.Bloco_0.Registro0111New;

         {Valores informados nestes campos deverão ser Receita bruta
          mensal obtidas por todos os estabelecimentos.
          Tabela para alimentar mensalmente da receita bruta.}

         Registro0111.REC_BRU_NCUM_TRIB_MI := 0; {Informar neste campo o valor total da receita bruta obtida no mercado interno
                                                  pela pessoa jurídica, vinculadas a receitas tributadas no regime não cumulativo:
                                                  - a alíquotas básicas de 1,65% (PIS/Pasep) e de 7,6% (Cofins);
                                                  - a alíquotas próprias do regime monofásico (diferenciadas e/ou por unidade
                                                    medida de produto);
                                                  - a outras alíquotas específicas.}

         Registro0111.REC_BRU_NCUM_NT_MI   := 0; {Informar neste campo o valor total da receita bruta obtida no
                                                  mercado interno pela pessoa jurídica, vinculadas a vendas efetuadas
                                                  com suspensão, isenção, alíquota zero ou não-incidência das contribuições sociais.}

         Registro0111.REC_BRU_NCUM_EXP     := 0; {Informar neste campo o valor total da receita bruta obtida relativa a operações de:
                                                  - exportação de mercadorias para o exterior;
                                                  - prestação de serviços para pessoa física ou jurídica residente ou domiciliada no exterior,
                                                    cujo pagamento represente ingresso de divisas;
                                                  - vendas a empresa comercial exportadora com o fim específico de exportação.}

         Registro0111.REC_BRU_CUM          := 0; {informar neste campo o valor total da receita bruta obtida pela pessoa jurídica,
                                                  vinculada a receitas tributadas no regime cumulativo a alíquotas de 0,65% (PIS/Pasep)
                                                  e de 3% (Cofins).}

         Registro0111.REC_BRU_TOTAL        := 0; {Informar o total da receita bruta auferida no período, correspondente ao somatório dos

                                                  valores informados nos campos 02, 03, 04 e 05.}
      end;
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0140 - Cadastro de estabelecimento');

   Registro0140 := FcompSpedPisCofins.Bloco_0.Registro0140New;

   Registro0140.COD_EST := '1';      //para juntar o sped empresa com mas de 1 estabelecimento
   Registro0140.NOME    := dmPrincipal.cdsConsEmpresaRAZAO.Value;
   Registro0140.CNPJ    := Self.FCnpjEmpresa;
   Registro0140.UF      := dmPrincipal.cdsConsEmpresaUF.value;
   Registro0140.IE      := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaINSC_ESTADUAL.Value);
   Registro0140.COD_MUN := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.AsInteger;
   Registro0140.IM      := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaINSC_ESTADUAL.Value);
   Registro0140.SUFRAMA := '';

   // 0150 - Participantes
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0150 - Participantes');
   AtualizarStatus('Registro 0150 (Participantes): ');
   FTabelaReg0150.First;
   IniciaBar(FTabelaReg0150.RecordCount);
   while not FTabelaReg0150.Eof do
      begin
         IncBar;


         Registro0150 := FcompSpedPisCofins.Bloco_0.Registro0150New;

         Registro0150.COD_PART := Trim(FTabelaReg0150.FieldByName('COD_PART').AsString);
         Registro0150.NOME     := Trim(FTabelaReg0150.FieldByName('NOME').AsString);
         Registro0150.COD_PAIS := Trim(FTabelaReg0150.FieldByName('COD_PAIS').AsString);

         if Length(Trim(FTabelaReg0150.FieldByName('CNPJCPF').AsString)) = 14 then
            Registro0150.CNPJ  := Trim(FTabelaReg0150.FieldByName('CNPJCPF').AsString)
         else
            Registro0150.CPF   := Trim(FTabelaReg0150.FieldByName('CNPJCPF').AsString);

         if (Registro0150.CPF = '99999999999') then
            Registro0150.CPF := '';

         if (Registro0150.CNPJ = '99999999999999') then
            Registro0150.CNPJ := '';

         if Trim(Registro0150.CNPJ) = '' then
            Registro0150.IE := ''
         else
            Registro0150.IE := RemoveMascaraStr(FTabelaReg0150.FieldByName('IE').AsString);

         if Trim(Registro0150.IE) = 'ISENTO' then
            Registro0150.IE := '';

         Registro0150.COD_MUN  := FTabelaReg0150.FieldByName('COD_MUN').AsInteger;
         Registro0150.SUFRAMA  := '';
         Registro0150.ENDERECO := Trim(FTabelaReg0150.FieldByName('ENDERECO').AsString);

         Registro0150.NUM      := Trim(FTabelaReg0150.FieldByName('NUM').AsString);
         Registro0150.COMPL    := Trim(FTabelaReg0150.FieldByName('COMPL').AsString);
         Registro0150.BAIRRO   := Trim(FTabelaReg0150.FieldByName('BAIRRO').AsString);

         FTabelaReg0150.Next;
      end;{while participantes}

   // 0190 - Unidade de medida
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0190 - Unidade de medida');
   AtualizarStatus('Registro 0190 (Unid. de medida): ');
   FTabelaReg0190.First;
   IniciaBar(FTabelaReg0190.RecordCount);
   while not FTabelaReg0190.Eof do
      begin
         IncBar;

         Registro0190 := FcompSpedPisCofins.Bloco_0.Registro0190New;
         unidade:= UpperCase(COPY(Trim(FTabelaReg0190.FieldByName('UNID').AsString),1,2));
         if(unidade =  'CX') OR
           (unidade =  'UN') OR
           (unidade =  'PC') OR
           (unidade =  'BI') OR     //mauricio 05062024   mudança pra tratar erro de unidade de medida
           (unidade =  'BL') OR
           (unidade =  'CT') OR
           (unidade =  'DP') OR
           (unidade =  'DZ') OR
           (unidade =  'EN') OR
           (unidade =  'FD') OR
           (unidade =  'FR') OR
           (unidade =  'KG') OR
           (unidade =  'LT') OR
           (unidade =  'PO') OR
           (unidade =  'TB') OR
           (unidade =  'VD') then
           begin
            Registro0190.UNID  :=unidade;
            Registro0190.DESCR := Trim(FTabelaReg0190.FieldByName('DESCR').AsString);
           end;

         FTabelaReg0190.Next;
      end;

   // 0200 - Produtos e serviços
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0200 - Produtos e Serviços');
   AtualizarStatus('Registro 0200 (Produtos e serviços): ');
   FTabelaReg0200.First;
   IniciaBar(FTabelaReg0200.RecordCount);
   while not FTabelaReg0200.Eof do
      begin
         IncBar;

         Registro0200 := FcompSpedPisCofins.Bloco_0.Registro0200New;

         Registro0200.COD_ITEM      := Trim(FTabelaReg0200.FieldByName('COD_ITEM').AsString);
         Registro0200.DESCR_ITEM    := Trim(FTabelaReg0200.FieldByName('DESCR_ITEM').AsString);
         Registro0200.COD_BARRA     := Trim(FTabelaReg0200.FieldByName('COD_BARRA').AsString);
         Registro0200.COD_ANT_ITEM  := '';
         Registro0200.UNID_INV      := Trim(FTabelaReg0200.FieldByName('UNID_INV').AsString);

         if (Trim(FTabelaReg0200.FieldByName('TIPO_ITEM').AsString) = 'S') then
            Registro0200.TIPO_ITEM := ACBrEPCBlocos.tiServicos
         else
            Registro0200.TIPO_ITEM := ACBrEPCBlocos.tiMercadoriaRevenda;

         Registro0200.COD_NCM   := RemoveMascaraStr(FTabelaReg0200.FieldByName('COD_NCM').AsString);
         Registro0200.EX_IPI    := '';
         Registro0200.COD_GEN   := '';
         Registro0200.COD_LST   := '';
         Registro0200.ALIQ_ICMS := FTabelaReg0200.FieldByName('ALIQ_ICMS').AsFloat;

         FTabelaReg0200.Next;
      end; {while produtos e serviços}

   // 0400 - Natureza de operações - CFOP
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_0 + ': Gerando Registro 0400 - Natureza de operações - CFOP');
   AtualizarStatus('Registro 0400 (CFOP): ');
   FTabelaReg0400.First;
   IniciaBar(FTabelaReg0400.RecordCount);
   while not FTabelaReg0400.Eof do
      begin
         IncBar;

         Registro0400 :=  FcompSpedPisCofins.Bloco_0.Registro0400New;

         Registro0400.COD_NAT   := Trim(FTabelaReg0400.FieldByName('COD_NAT').AsString);
         Registro0400.DESCR_NAT := Trim(FTabelaReg0400.FieldByName('DESCR_NAT').AsString);

         FTabelaReg0400.Next;
      end; {while}

   // 0500 - Planos de Contas Contábeis
   /// Gerar esse registro se a empresa for "regime não cumulativo" ou "regime cumulativo pelo regime de competência"
   if (
        (Registro0110.COD_INC_TRIB = codEscrOpIncNaoCumulativo) or
        ((Registro0110.COD_INC_TRIB = codEscrOpIncCumulativo) and
         (
         (Registro0110.IND_REG_CUM = codRegimeCompetEscritConsolidada) or
         (Registro0110.IND_REG_CUM = codRegimeCompetEscritDetalhada)
         ))
      ) then
   begin
     Registro0500             := FcompSpedPisCofins.Bloco_0.Registro0500New;
     Registro0500.DT_ALT      := StrToDate('01/04/2011');
     Registro0500.COD_NAT_CC  := ACBrEPCBlocos.TACBrNaturezaConta.ncgAtivo;
     Registro0500.IND_CTA     := ACBrEPCBlocos.TACBrIndCTA.indCTASintetica;
     Registro0500.NIVEL       := '2';
     Registro0500.COD_CTA     := '2';
     Registro0500.NOME_CTA    := 'VENDA DE PRODUTOS';
     Registro0500.COD_CTA_REF := '0';
     Registro0500.CNPJ_EST    := Self.FCnpjEmpresa;

     Registro0500             := FcompSpedPisCofins.Bloco_0.Registro0500New;
     Registro0500.DT_ALT      := StrToDate('01/04/2011');
     Registro0500.COD_NAT_CC  := ACBrEPCBlocos.TACBrNaturezaConta.ncgAtivo;
     Registro0500.IND_CTA     := ACBrEPCBlocos.TACBrIndCTA.indCTAnalitica;
     Registro0500.NIVEL       := '3';
     Registro0500.COD_CTA     := '25';
     Registro0500.NOME_CTA    := 'FORNECEDORES';
     Registro0500.COD_CTA_REF := '0';
     Registro0500.CNPJ_EST    := Self.FCnpjEmpresa;
   end;
end;

procedure TSpedPisCofins.GerarBloco_1;
var
    Registro1001: ACBrEPCBloco_1.TRegistro1001;
    Registro1900: ACBrEPCBloco_1.TRegistro1900;
begin
   {
    Registro 1900

    Este registro é de escrituração opcional até o período de apuração referente a março de 2013. A partir de abril
    de 2013 o registro “1900” passa a ser de escrituração obrigatória.
   }
   Registro1001 := FcompSpedPisCofins.Bloco_1.Registro1001New;


   if (FGerarBlocoF) then
      Registro1001.IND_MOV := ACBrEPCBlocos.imComDados
   else
      Registro1001.IND_MOV := ACBrEPCBlocos.imSemDados;

   if (FGerarBlocoF) then
      begin
         dmPrincipal.FTabelaReg1900.First;
         while not dmPrincipal.FTabelaReg1900.Eof do
            begin
               Registro1900 := FcompSpedPisCofins.Bloco_1.Registro1900New;

               Registro1900.CNPJ    := Self.CnpjEmpresa;

               Registro1900.COD_MOD := dmPrincipal.FTabelaReg1900COD_MOD.AsString;
               Registro1900.SER     := dmPrincipal.FTabelaReg1900SER.AsString;;
               Registro1900.SUB_SER := dmPrincipal.FTabelaReg1900SUB_SER.AsString;;

               { COD_SIT

                 csffRegular: 00 – Documento regular
                 csfCancelado: 02 – Documento cancelado
                 csfOutros: 99 – Outros
               }

              Registro1900.COD_SIT    := csffRegular;
              Registro1900.VL_TOT_REC := dmPrincipal.FTabelaReg1900VL_TOT_REC.AsCurrency; {Valor total por modelo de documento}
              Registro1900.QUANT_DOC  := dmPrincipal.FTabelaReg1900.RecordCount; {Quantidade por modelo de documentos}

               {
                  Existindo mais de um CST para o modelo de documento consolidado no registro, sem que a pessoa jurídica tenha
                 como decompor por cada CST, o campo CST_PIS será escriturado em branco.
               }

               Registro1900.CST_PIS := ACBrEPCBlocos.StrToCstPis(dmPrincipal.FTabelaReg1900CST_PIS_COF.AsString);

               {
                  Existindo mais de um CST para o modelo de documento consolidado no registro, sem que a pessoa jurídica tenha
                 como decompor por cada CST, o campo CST_COFINS será escriturado em branco.
               }
               Registro1900.CST_COFINS := ACBrEPCBlocos.StrToCstCofins(dmPrincipal.FTabelaReg1900CST_PIS_COF.AsString);
               Registro1900.CFOP := dmPrincipal.FTabelaReg1900CFOP.AsInteger;

               Registro1900.INF_COMPL := '';
               Registro1900.COD_CTA := '';

               dmPrincipal.FTabelaReg1900.Next;
            end;{while}
      end;
end;

procedure TSpedPisCofins.GerarBloco_A;
var
    RegistroA001: ACBrEPCBloco_A.TRegistroA001;
    RegistroA010: ACBrEPCBloco_A.TRegistroA010;
    RegistroA100: ACBrEPCBloco_A.TRegistroA100;
    RegistroA170: ACBrEPCBloco_A.TRegistroA170;
begin
   {Gerar Tabela de Contratação ou prestação de Serviços...
    Nota Fiscal de Serviços Instituída por Municípios}

   RegistroA001 := FcompSpedPisCofins.Bloco_A.RegistroA001New;

   if (FTabelaRegA100.RecordCount > 0) then
      RegistroA001.IND_MOV := ACBrEPCBlocos.imComDados
   else
      RegistroA001.IND_MOV := ACBrEPCBlocos.imSemDados;

   if (RegistroA001.IND_MOV = ACBrEPCBlocos.imComDados) then
      begin
         RegistroA010      := FcompSpedPisCofins.Bloco_A.RegistroA010New;
         RegistroA010.CNPJ := Self.FCnpjEmpresa;
      end;

   {
     Não podem ser informados, para um mesmo documento fiscal, dois ou mais registros
     com a mesma combinação de valores dos campos formadores da chave do registro.

     A chave deste registro é:

      • Para documentos com campo IND_EMIT igual a “1” (um) – emissão por terceiros: IND_OPER, IND_EMIT, COD_PART, COD_SIT, SER e NUM_DOC;

      • Para documentos com campo (IND_EMIT igual “0” (zero) – emissão própria: IND_OPER, IND_EMIT, COD_SIT, SER e NUM_DOC.
   }

   FTabelaRegA100.First;
   while not FTabelaRegA100.Eof do
      begin
          RegistroA100 := FcompSpedPisCofins.Bloco_A.RegistroA100New;

         {0 - contratado, 1 - Prestado}
         if (FTabelaRegA100.FieldByName('IND_OPER').AsInteger = 0) then
            RegistroA100.IND_OPER := itoContratado
         else
            RegistroA100.IND_OPER := itoPrestado;

         {0 - Emiss prop. 1 - Emiss. Terc.}
         if (FTabelaRegA100.FieldByName('IND_EMIT').AsInteger = 0) then
            RegistroA100.IND_EMIT := iedfProprio
         else
            RegistroA100.IND_EMIT := iedfTerceiro;

         {0 - A vista, 1 - A prazo, 9 - Sem Pgto}
         if (FTabelaRegA100.FieldByName('IND_PGTO').AsInteger = 0) then
            RegistroA100.IND_PGTO := ACBrEPCBlocos.tpVista
         else
         if (FTabelaRegA100.FieldByName('IND_PGTO').AsInteger = 1) then
            RegistroA100.IND_PGTO := ACBrEPCBlocos.tpPrazo
         else
            RegistroA100.IND_PGTO := ACBrEPCBlocos.tpSemPagamento;

         RegistroA100.COD_PART := Trim(FTabelaRegA100.FieldByName('COD_PART').AsString);

         {0 - Regular, 2 Cancelado}
         if (FTabelaRegA100.FieldByName('COD_SIT').AsInteger = 0) then
            RegistroA100.COD_SIT := sdfRegular
         else
            RegistroA100.COD_SIT := sdfCancelado;

         RegistroA100.SER           := Trim(FTabelaRegA100.FieldByName('SER').AsString);
         RegistroA100.SUB           := Trim(FTabelaRegA100.FieldByName('SUB').AsString);
         RegistroA100.NUM_DOC       := Trim(FTabelaRegA100.FieldByName('NUM_DOC').AsString);
         RegistroA100.CHV_NFSE      := Trim(FTabelaRegA100.FieldByName('CHV_NFSE').AsString);
         RegistroA100.DT_DOC        := FTabelaRegA100.FieldByName('DT_DOC').AsDateTime;
         RegistroA100.DT_EXE_SERV   := FTabelaRegA100.FieldByName('DT_EXE_SERV').AsDateTime; { Data conclusão serviço }
         RegistroA100.VL_DOC        := FTabelaRegA100.FieldByName('VL_DOC').AsFloat;
         RegistroA100.VL_DESC       := FTabelaRegA100.FieldByName('VL_DESC').AsFloat;
         RegistroA100.VL_BC_PIS     := FTabelaRegA100.FieldByName('VL_BC_PIS').AsFloat;
         RegistroA100.VL_PIS        := FTabelaRegA100.FieldByName('VL_PIS').AsFloat;
         RegistroA100.VL_BC_COFINS  := FTabelaRegA100.FieldByName('VL_BC_COFINS').AsFloat;
         RegistroA100.VL_COFINS     := FTabelaRegA100.FieldByName('VL_COFINS').AsFloat;
         RegistroA100.VL_PIS_RET    := FTabelaRegA100.FieldByName('VL_PIS_RET').AsFloat;
         RegistroA100.VL_COFINS_RET := FTabelaRegA100.FieldByName('VL_COFINS_RET').AsFloat;
         RegistroA100.VL_ISS        := FTabelaRegA100.FieldByName('VL_ISS').AsFloat;

         {Registros A170}
         FTabelaRegA170.IndexFieldNames:='NFID';
         FTabelaRegA170.Filtered       := False;
         FTabelaRegA170.Filter         := 'NFID = ' + FTabelaRegA170.FieldByName('NFID').AsString;
         FTabelaRegA170.Filtered       := True;

         FTabelaRegA170.First;
         while not FTabelaRegA170.Eof do
            begin
               RegistroA170 := FcompSpedPisCofins.Bloco_A.RegistroA170New;

               RegistroA170.NUM_ITEM      := FTabelaRegA170.FieldByName('NUM_ITEM').AsInteger; {nr seq. item}
               RegistroA170.COD_ITEM      := Trim(FTabelaRegA170.FieldByName('COD_ITEM').AsString);
               RegistroA170.DESCR_COMPL   := Trim(FTabelaRegA170.FieldByName('DESCR_COMPL').AsString);
               RegistroA170.VL_ITEM       := FTabelaRegA170.FieldByName('VL_ITEM').AsFloat;
               RegistroA170.VL_DESC       := FTabelaRegA170.FieldByName('VL_DESC').AsFloat;
               RegistroA170.NAT_BC_CRED   := GetTypeNatBcCred(FTabelaRegA170.FieldByName('NAT_BC_CRED').AsString);
               RegistroA170.IND_ORIG_CRED := opcMercadoInterno; //0 – Operação no Mercado Interno // 1 – Operação de Importação - FTabelaRegA170.FieldByName('IND_ORIG_CRED').AsInteger
               RegistroA170.CST_PIS       := ACBrEPCBlocos.StrToCstPis(Trim(FTabelaRegA170.FieldByName('CST_PIS').AsString));
               RegistroA170.VL_BC_PIS     := FTabelaRegA170.FieldByName('VL_BC_PIS').AsFloat;
               RegistroA170.ALIQ_PIS      := FTabelaRegA170.FieldByName('ALIQ_PIS').AsFloat;
               RegistroA170.VL_PIS        := FTabelaRegA170.FieldByName('VL_PIS').AsFloat;
               RegistroA170.CST_COFINS    := ACBrEPCBlocos.StrToCstCofins(Trim(FTabelaRegA170.FieldByName('CST_COFINS').AsString));
               RegistroA170.VL_BC_COFINS  := FTabelaRegA170.FieldByName('VL_BC_COFINS').AsFloat;
               RegistroA170.ALIQ_COFINS   := FTabelaRegA170.FieldByName('ALIQ_COFINS').AsFloat;
               RegistroA170.VL_COFINS     := FTabelaRegA170.FieldByName('VL_COFINS').AsFloat;
               RegistroA170.COD_CTA       := FTabelaRegA170.FieldByName('COD_CTA').AsString;
               RegistroA170.COD_CCUS      := Trim(FTabelaRegA170.FieldByName('COD_CCUS').AsString);

               FTabelaRegA170.Next;
            end;

         FTabelaRegA100.Next;
      end;
end;

procedure TSpedPisCofins.GerarBloco_C;
var
   RegistroC001: ACBrEPCBloco_C.TRegistroC001;
   RegistroC010: ACBrEPCBloco_C.TRegistroC010;
   RegistroC100: ACBrEPCBloco_C.TRegistroC100;
   RegistroC170: ACBrEPCBloco_C.TRegistroC170;
   RegistroC175: ACBrEPCBloco_C.TRegistroC175;

   RegistroC400: ACBrEPCBloco_C.TRegistroC400;
   RegistroC405: ACBrEPCBloco_C.TRegistroC405;
   RegistroC481: ACBrEPCBloco_C.TRegistroC481;
   RegistroC485: ACBrEPCBloco_C.TRegistroC485;

   RegistroC500: ACBrEPCBloco_C.TRegistroC500;
   RegistroC501: ACBrEPCBloco_C.TRegistroC501;
   RegistroC505: ACBrEPCBloco_C.TRegistroC505;

   iSequencialItem: Integer;

   cTotalPIS_Itens,
   cTotalCOF_Itens: Currency;

   cTotalPIS_Itens_NFCE,
   cTotalCOF_Itens_NFCE,
   cTotalOperacoes: Currency;

   RegistroC400List: ACBrEFDBloco_C.TRegistroC400List;
   indxC400: Integer;
   indxC405: Integer;
   vteste  : string;
begin
   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_C + ': Gerando Registros C001');

   RegistroC001         := FcompSpedPisCofins.Bloco_C.RegistroC001New;
   RegistroC001.IND_MOV := ACBrEPCBlocos.imComDados;


   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_C + ': Gerando Registros C010');
   RegistroC010           := FcompSpedPisCofins.Bloco_C.RegistroC010New;
   RegistroC010.CNPJ      := RemoveMascaraStr(CNPJEmpresa);
   RegistroC010.IND_ESCRI := IndEscriIndividualizado;


   Screen.Cursor := crHourglass;


   GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_C + ': Gerando Registros C100');
   AtualizarStatus('Gerando Registros C100 / C170');


   // C100
   IniciaBar(FTabelaRegC100.RecordCount);
   FTabelaRegC100.First;
   while not FTabelaRegC100.Eof do
      begin


         {
          Na escrituração das NFC-e no registro C100, não precisam ser informados os campos:
                 COD_PART, VL_BC_ICMS_ST, VL_ICMS_ST, VL_IPI, VL_PIS, VL_COFINS, VL_PIS_ST e VL_COFINS_ST
         }
         RegistroC100 := FcompSpedPisCofins.Bloco_C.RegistroC100New;


         if (FTabelaRegC100.FieldByName('IND_OPER').AsInteger = 0) then
            RegistroC100.IND_OPER := ACBrEPCBlocos.tpEntradaAquisicao
         else
            RegistroC100.IND_OPER := ACBrEPCBlocos.tpSaidaPrestacao;


         {Se encontrar o CNPJ na chave do documetno é emissão propria}
         if (Pos(Self.FCnpjEmpresa, FTabelaRegC100.FieldByName('CHV_NFE').AsString) > 0) then
            RegistroC100.IND_EMIT := ACBrEPCBlocos.edEmissaoPropria
         else
            RegistroC100.IND_EMIT := ACBrEPCBlocos.edTerceiros;


         RegistroC100.COD_MOD := Trim(FTabelaRegC100.FieldByName('COD_MOD').AsString);
         RegistroC100.SER     := Trim(FTabelaRegC100.FieldByName('SER').AsString);
         RegistroC100.NUM_DOC := Trim(FTabelaRegC100.FieldByName('NUM_DOC').AsString);
         RegistroC100.CHV_NFE := RemoveMascaraStr(FTabelaRegC100.FieldByName('CHV_NFE').AsString);

         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 0) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdRegular
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 1) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdExtempRegular
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 2) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdCancelado
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 3) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdCanceladoExtemp
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 4) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdDoctoDenegado
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 5) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdDoctoNumInutilizada
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 6) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdFiscalCompl
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 7) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdExtempCompl
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 8) then
            RegistroC100.COD_SIT := ACBrEPCBlocos.sdRegimeEspecNEsp;



         if (RegistroC100.COD_SIT = ACBrEPCBlocos.sdRegular) then
            begin
               {Na escrituração das NFC-e no registro C100, não precisam ser informados os campos:
                   COD_PART, VL_BC_ICMS_ST, VL_ICMS_ST, VL_IPI, VL_PIS, VL_COFINS, VL_PIS_ST e VL_COFINS_ST.
F               }
               if (RegistroC100.COD_MOD = '65') then
                   RegistroC100.COD_PART := ''
               else
                  RegistroC100.COD_PART  := Trim(FTabelaRegC100.FieldByName('COD_PART').AsString);


                RegistroC100.DT_DOC       := FTabelaRegC100.FieldByName('DT_DOC').AsDateTime;
                RegistroC100.DT_E_S       := FTabelaRegC100.FieldByName('DT_E_S').AsDateTime;
                RegistroC100.VL_DOC       := FTabelaRegC100.FieldByName('VL_DOC').AsCurrency;


                if (FTabelaRegC100.FieldByName('IND_PGTO').AsInteger = 2) then
                   RegistroC100.IND_PGTO := ACBrEPCBlocos.tpSemPagamento
                else
                if (FTabelaRegC100.FieldByName('IND_PGTO').AsInteger = 1) then
                   RegistroC100.IND_PGTO := ACBrEPCBlocos.tpPrazo
                else
                   RegistroC100.IND_PGTO := ACBrEPCBlocos.tpVista;


                RegistroC100.VL_DESC    := 0;
                RegistroC100.VL_ABAT_NT := 0;
                RegistroC100.VL_MERC    := FTabelaRegC100.FieldByName('VL_MERC').AsCurrency;


                if (RegistroC100.COD_MOD = '65') then
                   RegistroC100.IND_FRT := ACBrEPCBlocos.tfSemCobrancaFrete
                else
                if (FTabelaRegC100.FieldByName('IND_FRT').AsInteger = 0) then
                   RegistroC100.IND_FRT := ACBrEPCBlocos.tfPorContaEmitente
                else
                if (FTabelaRegC100.FieldByName('IND_FRT').AsInteger = 1) then
                   RegistroC100.IND_FRT := ACBrEPCBlocos.tfPorContaDestinatario
                else
                if (FTabelaRegC100.FieldByName('IND_FRT').AsInteger = 2) then
                   RegistroC100.IND_FRT := ACBrEPCBlocos.tfPorContaTerceiros
                else
                   RegistroC100.IND_FRT := ACBrEPCBlocos.tfSemCobrancaFrete;


                RegistroC100.VL_FRT        := FTabelaRegC100.FieldByName('VL_FRT').AsCurrency;
                RegistroC100.VL_SEG        := FTabelaRegC100.FieldByName('VL_SEG').AsCurrency;
                RegistroC100.VL_OUT_DA     := FTabelaRegC100.FieldByName('VL_OUT_DA').AsCurrency;
                RegistroC100.VL_BC_ICMS    := FTabelaRegC100.FieldByName('VL_BC_ICMS').AsCurrency;
                RegistroC100.VL_ICMS       := FTabelaRegC100.FieldByName('VL_ICMS').AsCurrency;
                RegistroC100.VL_BC_ICMS_ST := FTabelaRegC100.FieldByName('VL_BC_ICMS_ST').AsCurrency;
                RegistroC100.VL_ICMS_ST    := FTabelaRegC100.FieldByName('VL_ICMS_ST').AsCurrency;
                RegistroC100.VL_IPI        := FTabelaRegC100.FieldByName('VL_IPI').AsCurrency;
                RegistroC100.VL_PIS_ST     := 0;
                RegistroC100.VL_COFINS_ST  := 0;


                GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_C + ': Gerando Registros C170');

                {Registro C170}

                FTabelaRegC170.Filtered := False;
                FTabelaRegC170.Filter   := 'NFID = ' + FTabelaRegC100.FieldByName('ID').AsString;
                FTabelaRegC170.Filtered := True;

                cTotalPIS_Itens := 0;
                cTotalCOF_Itens := 0;

               iSequencialItem := 1;
               FTabelaRegC170.First;
               while not FTabelaRegC170.Eof do
                  begin
                     RegistroC170 := FcompSpedPisCofins.Bloco_C.RegistroC170New;

                     RegistroC170.NUM_ITEM := IntToStr(iSequencialItem);

                     RegistroC170.COD_ITEM       := Trim(FTabelaRegC170.FieldByName('COD_ITEM').AsString);
                     RegistroC170.DESCR_COMPL    := Trim(FTabelaRegC170.FieldByName('DESCR_COMPL').AsString);
                     RegistroC170.QTD            := FTabelaRegC170.FieldByName('QTD').AsFloat;
                     RegistroC170.UNID           := Trim(FTabelaRegC170.FieldByName('UNID').AsString);
                     RegistroC170.VL_ITEM        := FTabelaRegC170.FieldByName('VL_ITEM').AsFloat;
                     RegistroC170.VL_DESC        := 0;
                     RegistroC170.IND_MOV        := ACBrEPCBlocos.mfSim;
                     RegistroC170.CST_ICMS       := ACBrEPCBlocos.StrToCstIcms(Trim(FTabelaRegC170.FieldByName('CST_ICMS').AsString));
                     RegistroC170.CFOP           := Trim(FTabelaRegC170.FieldByName('CFOP').AsString);
                     RegistroC170.COD_NAT        := Trim(FTabelaRegC170.FieldByName('COD_NAT').AsString);


                     { 30, 40, 41, 50, ou 60, então os valores dos campos VL_BC_ICMS, ALIQ_ICMS e VL_ICMS deverão ser iguais a “0” (zero)}
                     if (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsIsentaComCobracaPorST) or
                        (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsIsenta) or
                        (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsNaoTributada) or
                        (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsSuspensao) or
                        (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsCobradoAnteriormentePorST) then
                        begin
                           RegistroC170.VL_BC_ICMS := 0;
                           RegistroC170.ALIQ_ICMS  := 0;
                           RegistroC170.VL_ICMS    := 0;
                        end
                     else
                        begin
                           {Diferentes de 30, 40, 41, 50, e 60, então os valores dos campos VL_BC_ICMS, ALIQ_ICMS e VL_ICMS deverão ser maiores que “0” (zero)}
                           RegistroC170.VL_BC_ICMS := FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat;
                           RegistroC170.ALIQ_ICMS  := FTabelaRegC170.FieldByName('ALIQ_ICMS').AsFloat;
                           RegistroC170.VL_ICMS    := FTabelaRegC170.FieldByName('VL_ICMS').AsFloat;
                        end;

                     {10, 30 ou 70, os valores dos campos VL_BC_ICMS_ST, ALIQ_ST e VL_ICMS_ST deverão ser maiores ou iguais a “0” (zero).}
                     if (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsTributadaComCobracaPorST) or
                        (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsIsentaComCobracaPorST) or
                        (RegistroC170.CST_ICMS = ACBrEPCBlocos.sticmsComReducaoPorST) then
                        begin
                            RegistroC170.VL_BC_ICMS_ST := FTabelaRegC170.FieldByName('VL_BC_ICMS_ST').AsFloat;
                            RegistroC170.ALIQ_ST       := FTabelaRegC170.FieldByName('ALIQ_ST').AsFloat;
                            RegistroC170.VL_ICMS_ST    := FTabelaRegC170.FieldByName('VL_ICMS_ST').AsFloat;
                        end
                     else
                        begin
                           {Diferentes de 10, 30 ou 70, os valores dos campos VL_BC_ST, ALIQ_ST e VL_ICMS_ST deverão ser iguais a “0” (zero). }
                           RegistroC170.VL_BC_ICMS_ST := 0;
                           RegistroC170.ALIQ_ST       := 0;
                           RegistroC170.VL_ICMS_ST    := 0;
                        end;


                     if (FTabelaRegC170.FieldByName('IND_APUR').AsInteger = 0) then
                        RegistroC170.IND_APUR := ACBrEPCBlocos.iaMensal
                     else
                        RegistroC170.IND_APUR := ACBrEPCBlocos.iaDecendial;


                     RegistroC170.CST_IPI  := ACBrEPCBlocos.StrToCstIpi(FTabelaRegC170.FieldByName('CST_IPI').AsString);
                     RegistroC170.COD_ENQ  := ''; {Não preencher - segundo o manual}
                     RegistroC170.ALIQ_IPI := FTabelaRegC170.FieldByName('ALIQ_IPI').AsCurrency;


                     if RegistroC170.ALIQ_IPI > 0 then
                        RegistroC170.VL_BC_IPI := FTabelaRegC170.FieldByName('VL_BC_IPI').AsFloat
                     else
                        RegistroC170.VL_BC_IPI := 0;

                     RegistroC170.VL_IPI        := FTabelaRegC170.FieldByName('VL_IPI').AsCurrency;
                     RegistroC170.CST_PIS       := ACBrEPCBlocos.StrToCstPis(FTabelaRegC170.FieldByName('CST_PIS').AsString);
                     RegistroC170.VL_BC_PIS     := 0;
                     RegistroC170.ALIQ_PIS_PERC := 0;
                     RegistroC170.VL_PIS        := 0;


                     if (FTabelaRegC170.FieldByName('ALIQ_PIS_PERC').AsCurrency > 0) then
                        begin
                           RegistroC170.VL_BC_PIS     := FTabelaRegC170.FieldByName('VL_BC_PIS').AsCurrency;
                           RegistroC170.ALIQ_PIS_PERC := FTabelaRegC170.FieldByName('ALIQ_PIS_PERC').AsCurrency;
                           RegistroC170.VL_PIS        := RoundTo(FTabelaRegC170.FieldByName('VL_PIS').AsCurrency, -2);
                        end;


                     RegistroC170.CST_COFINS       := ACBrEPCBlocos.StrToCstCofins(FTabelaRegC170.FieldByName('CST_COFINS').AsString);
                     RegistroC170.VL_BC_COFINS     := 0;
                     RegistroC170.ALIQ_COFINS_PERC := 0;
                     RegistroC170.VL_COFINS        := 0;

                     if (FTabelaRegC170.FieldByName('ALIQ_COFINS_PERC').AsCurrency > 0) then
                        begin
                           RegistroC170.VL_BC_COFINS     := FTabelaRegC170.FieldByName('VL_BC_COFINS').AsCurrency;
                           RegistroC170.ALIQ_COFINS_PERC := FTabelaRegC170.FieldByName('ALIQ_COFINS_PERC').AsCurrency;
                           RegistroC170.VL_COFINS        := RoundTo(FTabelaRegC170.FieldByName('VL_COFINS').AsCurrency, -2);
                        end;

                     //RegistroC170.QUANT_BC_COFINS := 0;
                     //RegistroC170.ALIQ_COFINS_R   := 0; {EM REAIS}

                     if FcompSpedPisCofins.Bloco_0.Registro0001.Registro0500.Count > 0 then
                       begin
                         if (RegistroC100.IND_EMIT = ACBrEPCBlocos.edEmissaoPropria) then
                           RegistroC170.COD_CTA := '2'
                         else
                           RegistroC170.COD_CTA := '25';
                       end
                     else
                       RegistroC170.COD_CTA := '';

                     {Totaliza pis e cofins para atualizar o cabeçalho da nota}
                     {Corrigir problemas de arredondamento}
                     cTotalPIS_Itens := cTotalPIS_Itens + RegistroC170.VL_PIS;
                     cTotalCOF_Itens := cTotalCOF_Itens + RegistroC170.VL_COFINS;

                     FTabelaRegC170.Next;
                     Inc(iSequencialItem);
                  end; {while itens C170}

               {Atualiza valores de PIS e COFINS no cabeçalho da nota}
               RegistroC100.VL_PIS    := cTotalPIS_Itens;
               RegistroC100.VL_COFINS := cTotalCOF_Itens;

               // Registro - C175 - visão analítica, por CST
               if (RegistroC100.COD_MOD = '65') then
                  begin

                     GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_C + ': Gerando Registros C175 - Analítico por CST NFC-e');
                      AtualizarStatus('Gerando Registros C175 - Analítico por CST NFC-e');

                     cTotalPIS_Itens_NFCE := 0;
                     cTotalCOF_Itens_NFCE := 0;
                     cTotalOperacoes      := 0;

                     dmPrincipal.FTabelaRegC175.Close;
                     dmPrincipal.FTabelaRegC175.CommandText:='SELECT * FROM FTABELAREGC175 WHERE NFID = ' + FTabelaRegC100.FieldByName('ID').AsString;
                     dmPrincipal.FTabelaRegC175.Open;

                     dmPrincipal.FTabelaRegC175.First;
                     while not dmPrincipal.FTabelaRegC175.Eof do
                        begin
                           RegistroC175 := FcompSpedPisCofins.Bloco_C.RegistroC175New;

                           RegistroC175.CFOP     := dmPrincipal.FTabelaRegC175CFOP.AsString;
                           RegistroC175.VL_DESC  := dmPrincipal.FTabelaRegC175VL_DESC.AsCurrency;

                           RegistroC175.VL_OPR   := RoundTo(dmPrincipal.FTabelaRegC175VL_OPR.AsCurrency, -2);
                           cTotalOperacoes       := cTotalOperacoes + RegistroC175.VL_OPR;

                           // *** PIS
                           RegistroC175.CST_PIS  := ACBrEPCBlocos.StrToCstPis(dmPrincipal.FTabelaRegC175CST_PIS.AsString);
                           RegistroC175.ALIQ_PIS := dmPrincipal.FTabelaRegC175ALIQ_PIS.AsCurrency;
                           RegistroC175.VL_PIS   := RoundTo((( dmPrincipal.FTabelaRegC175ALIQ_PIS.AsCurrency * dmPrincipal.FTabelaRegC175VL_BC_PIS.AsCurrency )/100), -2);
                           //RoundTo(dmPrincipal.FTabelaRegC175VL_PIS.AsCurrency, -2);

                           if (RegistroC175.VL_OPR > 0) then //mauricio 24052024
                              RegistroC175.VL_BC_PIS := dmPrincipal.FTabelaRegC175VL_BC_PIS.AsCurrency
                           else
                              RegistroC175.VL_BC_PIS := 0;

                           // *** COFINS
                           RegistroC175.CST_COFINS  := ACBrEPCBlocos.StrToCstCofins(dmPrincipal.FTabelaRegC175CST_COFINS.AsString);
                           RegistroC175.ALIQ_COFINS := dmPrincipal.FTabelaRegC175ALIQ_COFINS.AsCurrency;
                           RegistroC175.VL_COFINS   := RoundTo(((dmPrincipal.FTabelaRegC175ALIQ_COFINS.AsCurrency * dmPrincipal.FTabelaRegC175VL_BC_COFINS.AsCurrency)/100),-2);//mauricio 29/05/2024

                           /// RoundTo(FTabelaRegC175.FieldByName('VL_COFINS').AsCurrency, -2);

                           if (RegistroC175.VL_OPR > 0) then
                              RegistroC175.VL_BC_COFINS := dmPrincipal.FTabelaRegC175VL_BC_COFINS.AsCurrency
                           else
                              RegistroC175.VL_BC_COFINS := 0;

                           if FcompSpedPisCofins.Bloco_0.Registro0001.Registro0500.Count > 0 then
                              begin
                                 if (RegistroC100.IND_EMIT = ACBrEPCBlocos.edEmissaoPropria) then
                                   RegistroC175.COD_CTA := '2'
                                 else
                                   RegistroC175.COD_CTA := '25';
                              end
                           else
                             RegistroC175.COD_CTA := '';

                             RegistroC175.INFO_COMPL := '';

                           cTotalPIS_Itens_NFCE := cTotalPIS_Itens_NFCE + RegistroC175.VL_PIS;
                           cTotalCOF_Itens_NFCE := cTotalCOF_Itens_NFCE + RegistroC175.VL_COFINS;

                           dmPrincipal.FTabelaRegC175.Next;
                        end; {while C175}

                     {Atualiza valores de PIS e COFINS no cabeçalho da NFC-e}
                     RegistroC100.VL_PIS    := cTotalPIS_Itens_NFCE;
                     RegistroC100.VL_COFINS := cTotalCOF_Itens_NFCE;
                     RegistroC100.VL_MERC := cTotalOperacoes;
                  end; {if COD_MOD = '65'}


            end;{if regular}

         FTabelaRegC100.Next;
         IncBar;
       //  AtualizarStatus('Registro C100');
      end; {While C100}


 {$REGION 'FACBrSPEDECF'}



   // MFD dos cupons não geram informações de Pis e Cofins
   //if (Self.GerarCupomFiscal) then
   if (False) then
      begin
         if (FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.Count = 0) then
            GerarLinhaMemoLog('Não encontrado movimentos de cupom fiscal para gerar! (RegistroC400.Count = 0)')
         else
            begin
               RegistroC400List := FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400;
               for indxC400 := 0 to RegistroC400List.Count - 1 do
                  begin
                     RegistroC400 := FcompSpedPisCofins.Bloco_C.RegistroC400New;

                     RegistroC400.COD_MOD := RegistroC400List.Items[indxC400].COD_MOD;
                     RegistroC400.ECF_MOD := RegistroC400List.Items[indxC400].ECF_MOD;
                     RegistroC400.ECF_FAB := RegistroC400List.Items[indxC400].ECF_FAB;
                     RegistroC400.ECF_CX  := StrToIntDef(RegistroC400List.Items[indxC400].ECF_CX,1);

                     {C405}
                     for indxC405 := 0 to RegistroC400List.items[indxC400].RegistroC405.Count - 1 do
                        begin
                           RegistroC405 := FcompSpedPisCofins.Bloco_C.RegistroC405New;

                           RegistroC405.DT_DOC      := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].DT_DOC;
                           RegistroC405.CRO         := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].CRO;
                           RegistroC405.CRZ         := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].CRZ;
                           RegistroC405.NUM_COO_FIN := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].NUM_COO_FIN;
                           RegistroC405.GT_FIN      := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].GT_FIN;
                           RegistroC405.VL_BRT      := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].VL_BRT;

                           FTabelaRegC481_C485.Filtered := False;
                           FTabelaRegC481_C485.Filter   := 'ECF_CX = ' + IntToStr(RegistroC400.ECF_CX) + ' and ' +
                                                           'CRZ = ' + IntToSTr(RegistroC405.CRZ);
                           FTabelaRegC481_C485.Filtered := True;


                           FTabelaRegC481_C485.First;
                           while not FTabelaRegC481_C485.Eof do
                              begin
                                 // ** C481 (Pis) - Resumo Diário de Documentos Emitidos por ECF
                                 RegistroC481 := FcompSpedPisCofins.Bloco_C.RegistroC481New;

                                 RegistroC481.CST_PIS := ACBrEPCBlocos.StrToCstPis(FTabelaRegC481_C485.FieldByName('CST_PIS').AsString);
                                 RegistroC481.VL_ITEM := FTabelaRegC481_C485.FieldByName('VL_ITEM').AsCurrency;

                                 RegistroC481.VL_BC_PIS := 0;
                                 RegistroC481.ALIQ_PIS := 0;
                                 RegistroC481.VL_PIS := 0;

                                 if (FTabelaRegC481_C485.FieldByName('ALIQ_PIS').AsCurrency > 0) then
                                    begin
                                       RegistroC481.VL_BC_PIS := FTabelaRegC481_C485.FieldByName('VL_BC_PIS').AsCurrency;
                                       RegistroC481.ALIQ_PIS  := FTabelaRegC481_C485.FieldByName('ALIQ_PIS').AsCurrency;
                                       RegistroC481.VL_PIS    := FTabelaRegC481_C485.FieldByName('VL_PIS').AsCurrency;
                                    end;

                                 RegistroC481.COD_ITEM := Trim(FTabelaRegC481_C485.FieldByName('COD_ITEM').AsString);

                                 if FcompSpedPisCofins.Bloco_0.Registro0001.Registro0500.Count > 0 then
                                 begin
                                   if (RegistroC100.IND_EMIT = ACBrEPCBlocos.edEmissaoPropria) then
                                     RegistroC481.COD_CTA := '2'
                                   else
                                     RegistroC481.COD_CTA := '25';
                                 end
                                 else
                                   RegistroC481.COD_CTA := '';

                                 // ** C485 (Cofins) - Resumo Diário de Documentos Emitidos por ECF
                                 RegistroC485 := FcompSpedPisCofins.Bloco_C.RegistroC485New;

                                 RegistroC485.CST_COFINS := ACBrEPCBlocos.StrToCstCofins(FTabelaRegC481_C485.FieldByName('CST_COFINS').AsString);
                                 RegistroC485.VL_ITEM    := FTabelaRegC481_C485.FieldByName('VL_ITEM').AsCurrency;

                                 RegistroC485.VL_BC_COFINS := 0;
                                 RegistroC485.ALIQ_COFINS := 0;
                                 RegistroC485.VL_COFINS := 0;

                                 if (FTabelaRegC481_C485.FieldByName('ALIQ_COFINS').AsCurrency > 0) then
                                    begin
                                       RegistroC485.VL_BC_COFINS := FTabelaRegC481_C485.FieldByName('VL_BC_COFINS').AsCurrency;
                                       RegistroC485.ALIQ_COFINS  := FTabelaRegC481_C485.FieldByName('ALIQ_COFINS').AsCurrency;
                                       RegistroC485.VL_COFINS    := FTabelaRegC481_C485.FieldByName('VL_COFINS').AsCurrency;
                                    end;

                                 RegistroC485.COD_ITEM := Trim(FTabelaRegC481_C485.FieldByName('COD_ITEM').AsString);

                                 if FcompSpedPisCofins.Bloco_0.Registro0001.Registro0500.Count > 0 then
                                 begin
                                   if (RegistroC100.IND_EMIT = ACBrEPCBlocos.edEmissaoPropria) then
                                     RegistroC485.COD_CTA := '2'
                                   else
                                     RegistroC485.COD_CTA := '25';
                                 end
                                 else
                                   RegistroC485.COD_CTA := '';

                                 FTabelaRegC481_C485.Next;
                              end;{while C481 e C485}

                        end; {for indxC405}
                  end;{for indxC400}
            end;
      end; {if GerarCupomFiscal}

 {$ENDREGION}

   // Registros C500 Agua, Luz e Gas
    AtualizarStatus('Registros C500 Agua, Luz e Gas');
   if (FTabelaRegC500.Active and (FTabelaRegC500.RecordCount > 0)) then
      begin
         FTabelaRegC500.First;
         while (not FTabelaRegC500.Eof) do
            begin
               {Notas Modelo - 06 - 28 - 29}
               RegistroC500 := FcompSpedPisCofins.Bloco_C.RegistroC500New;

               RegistroC500.COD_PART := FTabelaRegC500.FieldByName('COD_PART').AsString;
               RegistroC500.COD_SIT := ACBrEPCBlocos.sdRegular;

               RegistroC500.COD_MOD   := Trim(FTabelaRegC500.FieldByName('COD_MOD').AsString);
               RegistroC500.SER       := Trim(FTabelaRegC500.FieldByName('SER').AsString);
               RegistroC500.SUB       := StrToIntDef(Trim(FTabelaRegC500.FieldByName('SUB').AsString),0);
               RegistroC500.NUM_DOC   := FTabelaRegC500.FieldByName('NUM_DOC').AsInteger;
               RegistroC500.DT_DOC    := FTabelaRegC500.FieldByName('DT_DOC').AsDateTime;
               RegistroC500.DT_ENT    := FTabelaRegC500.FieldByName('DT_ENT').AsDateTime;
               RegistroC500.VL_DOC    := FTabelaRegC500.FieldByName('VL_DOC').AsCurrency;
               RegistroC500.VL_ICMS   := FTabelaRegC500.FieldByName('VL_ICMS').AsCurrency;
               RegistroC500.COD_INF   := '';
               RegistroC500.VL_PIS    := FTabelaRegC500.FieldByName('VL_PIS').AsCurrency;
               RegistroC500.VL_COFINS := FTabelaRegC500.FieldByName('VL_COFINS').AsCurrency;

               {Detalhamento de PIS}
               RegistroC501 := FcompSpedPisCofins.Bloco_C.RegistroC501New;

               RegistroC501.CST_PIS     := ACBrEPCBlocos.StrToCstPis(FTabelaRegC500.FieldByName('CST_PIS').AsString);
               RegistroC501.VL_ITEM     := FTabelaRegC500.FieldByName('VL_ITEM').AsCurrency;
               RegistroC501.NAT_BC_CRED := ACBrEPCBlocos.bccEnergiaEletricaTermica;
               RegistroC501.VL_BC_PIS   := FTabelaRegC500.FieldByName('VL_BC_PIS').AsCurrency;
               RegistroC501.ALIQ_PIS    := FTabelaRegC500.FieldByName('ALIQ_PIS').AsCurrency;
               RegistroC501.VL_PIS      := RegistroC500.VL_PIS;
               RegistroC501.COD_CTA     := '';

               {Detalhamento de Cofins}
               RegistroC505 := FcompSpedPisCofins.Bloco_C.RegistroC505New;

               RegistroC505.CST_COFINS   := ACBrEPCBlocos.StrToCstCofins(FTabelaRegC500.FieldByName('CST_COFINS').AsString);
               RegistroC505.VL_ITEM      := FTabelaRegC500.FieldByName('VL_ITEM').AsCurrency;
               RegistroC505.NAT_BC_CRED  := ACBrEPCBlocos.bccEnergiaEletricaTermica;
               RegistroC505.VL_BC_COFINS := FTabelaRegC500.FieldByName('VL_ITEM').AsCurrency;
               RegistroC505.ALIQ_COFINS  := FTabelaRegC500.FieldByName('ALIQ_COFINS').AsCurrency;
               RegistroC505.VL_COFINS    := RegistroC500.VL_COFINS;
               RegistroC505.COD_CTA      := '';

               FTabelaRegC500.Next;
            end; {while}
      end;

  Screen.Cursor := crDefault;

end;

procedure TSpedPisCofins.GerarBloco_D;
var
   RegistroD001: ACBrEPCBloco_D.TRegistroD001;
begin
   // Documentos Fiscais II – Serviços (ICMS)
   // Não está no contrato do sped
   RegistroD001 := FcompSpedPisCofins.Bloco_D.RegistroD001New;
   RegistroD001.IND_MOV := ACBrEPCBlocos.imSemDados;
end;

procedure TSpedPisCofins.GerarBloco_F;
var
   RegistroF001: ACBrEPCBloco_F.TRegistroF001;
   RegistroF500: ACBrEPCBloco_F.TRegistroF500;
   RegistroF510: ACBrEPCBloco_F.TRegistroF510;
   RegistroF525: ACBrEPCBloco_F.TRegistroF525;
   RegistroF550: ACBrEPCBloco_F.TRegistroF550;
   RegistroF560: ACBrEPCBloco_F.TRegistroF560;
   RegistroF010: ACBrEPCBloco_F.TRegistroF010;
begin
    GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_F + ': Gerando Registros F001');

   // ** Demais Documentos e Operações
   RegistroF001 := FcompSpedPisCofins.Bloco_F.RegistroF001New;

   if (FGerarBlocoF) then
      RegistroF001.IND_MOV := ACBrEPCBlocos.imComDados
   else
      RegistroF001.IND_MOV := ACBrEPCBlocos.imSemDados;

   if (FGerarBlocoF) then
      begin
         GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_F + ': Gerando Registros F010');
         {Identificação do Estabelecimento}
         RegistroF010 := FcompSpedPisCofins.Bloco_F.RegistroF010New;

         RegistroF010.CNPJ := Self.CnpjEmpresa;

         {Lucro Presumido – Incidência do PIS/Pasep e da Cofins pelo Regime de Caixa}
         if (FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.IND_REG_CUM = codRegimeCaixa) then
            begin
               GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_F + ': Gerando Registros F500');
               // ** F500
               RegistroF500 := FcompSpedPisCofins.Bloco_F.RegistroF500New;

               RegistroF500.VL_REC_CAIXA := 0.00;
               {PIS}
               RegistroF500.CST_PIS := ACBrEPCBlocos.StrToCstPis('01');
               RegistroF500.VL_DESC_PIS := 0.00;
               RegistroF500.VL_BC_PIS := 0.00;
               RegistroF500.ALIQ_PIS := 0.00;
               RegistroF500.VL_PIS := 0.00;
               {COFINS}
               RegistroF500.CST_COFINS := ACBrEPCBlocos.StrToCstCofins('01');
               RegistroF500.VL_DESC_COFINS := 0.00;
               RegistroF500.VL_BC_COFINS := 0.00;
               RegistroF500.ALIQ_COFINS := 0.00;
               RegistroF500.VL_COFINS := 0.00;
               RegistroF500.COD_MOD := '55';
               RegistroF500.CFOP := 5102;
               RegistroF500.INFO_COMPL := '';
            end;

         { ** F509 - OC
          Registro específico para a pessoa jurídica informar a existência de processo administrativo ou judicial que autoriza a adoção de tratamento tributário
          (CST), base de cálculo ou alíquota diversa da prevista na legislação. Trata-se de informação essencial a ser prestada na escrituração para a adequada
          validação das contribuições sociais ou dos créditos.
         }

         {Lucro Presumido – Incidência do PIS/Pasep e da Cofins pelo Regime de Caixa (Apuração da Contribuição por Unidade de Medida de Produto)}
         // ** F510
         if ((FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.IND_REG_CUM = codRegimeCaixa) and
             (FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.COD_TIPO_CONT = codIndTipoAliqEspecificas)) then
            begin
               GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_F + ': Gerando Registros F510');
               RegistroF510 := FcompSpedPisCofins.Bloco_F.RegistroF510New;

               RegistroF510.VL_REC_CAIXA := 0.00;
               {PIS}
               RegistroF510.CST_PIS := ACBrEPCBlocos.StrToCstPis('01');
               RegistroF510.VL_DESC_PIS := 0.00;
               //RegistroF510.QUANT_BC_PIS := 0.00;
               RegistroF510.ALIQ_PIS_QUANT := 0.00;
               RegistroF510.VL_PIS := 0.00;
               {COFINS}
               RegistroF510.CST_COFINS := ACBrEPCBlocos.StrToCstCofins('01');
               RegistroF510.VL_DESC_COFINS := 0.00;
               //RegistroF510.QUANT_BC_COFINS := 0.00;
               RegistroF510.ALIQ_COFINS_QUANT := 0.00;
               RegistroF510.VL_COFINS := 0.00;
               RegistroF510.COD_MOD := '55';
               RegistroF510.CFOP := 5102;
               RegistroF510.INFO_COMPL := '';
            end;

         { ** F519 - OC
          1. Registro específico para a pessoa jurídica informar a existência de processo administrativo ou judicial que autoriza a adoção de tratamento
          tributário (CST), base de cálculo ou alíquota diversa da prevista na legislação. Trata-se de informação essencial a ser prestada na escrituração
          para a adequada validação das contribuições sociais ou dos créditos.

          2. Uma vez procedida à escrituração do Registro “F519”, deve a pessoa jurídica gerar os registros “1010” ou “1020” referentes ao detalhamento do
          processo judicial ou do processo administrativo, conforme o caso, que autoriza a adoção de procedimento especifico de apuração das contribuições
          sociais ou dos créditos.

          3. Devem ser relacionados todos os processos judiciais ou administrativos que fundamente ou autorize a adoção de procedimento especifico na apuração
          das contribuições sociais e dos créditos.
         }

         {Composição da Receita Escriturada no Período – Detalhamento da Receita Recebida pelo Regime de Caixa}
         // ** F525 - OC
         if (FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.IND_REG_CUM = codRegimeCaixa) then
            RegistroF525 := FcompSpedPisCofins.Bloco_F.RegistroF525New;

         {Lucro Presumido – Incidência do PIS/Pasep e da Cofins pelo Regime de Competência}
         // ** F550
         if (FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.IND_REG_CUM = codRegimeCompetEscritConsolidada) then
            begin
               GerarLinhaMemoLog(_SPED_PIS_COF_BLOCO_F + ': Gerando Registros F550');

               dmPrincipal.FTabelaReg1900.First;
               while not dmPrincipal.FTabelaReg1900.Eof do
                  begin
                     RegistroF550 := FcompSpedPisCofins.Bloco_F.RegistroF550New;

                     {VL_REC_COMP: Valor total da receita auferida, referente à combinação de CST e Alíquota.}
                     RegistroF550.VL_REC_COMP := dmPrincipal.FTabelaReg1900VL_TOT_REC.AsCurrency;

                     {Pis}
                     RegistroF550.CST_PIS := ACBrEPCBlocos.StrToCstPis(dmPrincipal.FTabelaReg1900CST_PIS_COF.AsString);
                     RegistroF550.VL_DESC_PIS := 0;

                     RegistroF550.VL_BC_PIS := 0;
                     RegistroF550.ALIQ_PIS := 0;
                     RegistroF550.VL_PIS := 0;
                     if (dmPrincipal.FTabelaReg1900.FieldByName('ALIQ_PIS').AsCurrency > 0) then
                        begin
                           RegistroF550.VL_BC_PIS := dmPrincipal.FTabelaReg1900VL_TOT_REC.AsCurrency;
                           RegistroF550.ALIQ_PIS  := dmPrincipal.FTabelaReg1900ALIQ_PIS.AsCurrency;
                           RegistroF550.VL_PIS    := (dmPrincipal.FTabelaReg1900ALIQ_PIS.AsCurrency *
                                                     dmPrincipal.FTabelaReg1900VL_TOT_REC.AsCurrency);
                        end;

                     {Cofins}
                     RegistroF550.CST_COFINS := ACBrEPCBlocos.StrToCstCofins(dmPrincipal.FTabelaReg1900CST_PIS_COF.AsString);
                     RegistroF550.VL_DESC_COFINS := 0;

                     RegistroF550.VL_BC_COFINS := 0;
                     RegistroF550.ALIQ_COFINS := 0;
                     RegistroF550.VL_COFINS := 0;
                     if (dmPrincipal.FTabelaReg1900ALIQ_COF.AsCurrency > 0) then
                        begin
                           RegistroF550.VL_BC_COFINS := dmPrincipal.FTabelaReg1900VL_TOT_REC.AsCurrency;
                           RegistroF550.ALIQ_COFINS  := dmPrincipal.FTabelaReg1900ALIQ_COF.AsCurrency;
                           RegistroF550.VL_COFINS    := (dmPrincipal.FTabelaReg1900ALIQ_COF.AsCurrency *
                                                        dmPrincipal.FTabelaReg1900VL_TOT_REC.AsCurrency);
                        end;

                     RegistroF550.COD_MOD := dmPrincipal.FTabelaReg1900COD_MOD.AsString;
                     RegistroF550.CFOP    := dmPrincipal.FTabelaReg1900CFOP.AsInteger;
                     RegistroF550.COD_CTA := '';
                     RegistroF550.INFO_COMPL := '';

                     dmPrincipal.FTabelaReg1900.Next;
                  end;{while}
            end;

         { ** F559 - OC
           1. Registro específico para a pessoa jurídica informar a existência de processo administrativo ou judicial que autoriza a adoção de tratamento
           tributário (CST), base de cálculo ou alíquota diversa da prevista na legislação. Trata-se de informação essencial a ser prestada na escrituração
           para a adequada validação das contribuições sociais ou dos créditos.

           2. Uma vez procedida à escrituração do Registro “F559”, deve a pessoa jurídica gerar os registros “1010” ou “1020” referentes ao detalhamento do
           processo judicial ou do processo administrativo, conforme o caso, que autoriza a adoção de procedimento especifico de apuração das contribuições
           sociais ou dos créditos.

           3. Devem ser relacionados todos os processos judiciais ou administrativos que fundamente ou autorize a adoção de procedimento especifico na apuração
           das contribuições sociais e dos créditos.
         }

         {Lucro Presumido – Incidência do PIS/Pasep e da Cofins pelo Regime de Competência (Apuração da Contribuição por Unidade de Medida de Produto)}
         // ** F560
         if ((FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.IND_REG_CUM = codRegimeCompetEscritConsolidada) and
             (FcompSpedPisCofins.Bloco_0.Registro0001.Registro0110.COD_TIPO_CONT = codIndTipoAliqEspecificas)) then
            begin
               RegistroF560 := FcompSpedPisCofins.Bloco_F.RegistroF560New;
            end;

         {Processo Referenciado}
         { ** F569
          1. Registro específico para a pessoa jurídica informar a existência de processo administrativo ou judicial que autoriza a adoção de tratamento
          tributário (CST), base de cálculo ou alíquota diversa da prevista na legislação. Trata-se de informação essencial a ser prestada na escrituração
          para a adequada validação das contribuições sociais ou dos créditos.

          2. Uma vez procedida à escrituração do Registro “F569”, deve a pessoa jurídica gerar os registros “1010” ou “1020” referentes ao detalhamento do
          processo judicial ou do processo administrativo, conforme o caso, que autoriza a adoção de procedimento especifico de apuração das contribuições
          sociais ou dos créditos.

          3. Devem ser relacionados todos os processos judiciais ou administrativos que fundamente ou autorize a adoção de procedimento especifico na apuração
          das contribuições sociais e dos créditos.
         }
      end;
end;

procedure TSpedPisCofins.GerarBloco_M;
var

   fValorTaltalRec04201,fValorTaltalRec04202,
   fValorTaltalRec05201,fValorTaltalRec05202,
   fValorTaltalRec06201,fValorTaltalRec06202,
   fValorTaltalRec07201,fValorTaltalRec07202,
   fValorTaltalRec08201,fValorTaltalRec08202 : Currency;
   sNcm :String;
   AliqPis,AliqCof,dBasePis,dValorPis,dBaseCof,dValorCof:Double;


   _SPED_PIS_COF_BLOCO_M:String;

   SaldoNaoCumulativoaPagarPIS, SaldoNaoCumulativoaPagarCOFINS : Real;

begin


  dBasePis := 0;
  dValorPis:= 0;
  dBaseCof := 0;
  dValorCof:= 0;

  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.open;

   if  dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.value='P' then
       begin
        AliqPis:= 0.65;
        AliqCof:= 3.0;
      end
   else
     begin
        AliqPis:= 1.65;
        AliqCof:= 7.60;
     end;


  Screen.Cursor := crHourglass;

  GerarLinhaMemoLog(' Sped Pis Cofins - Bloco M: Gerando Registros M001');

  //mauricio 24052024    nao tinha esse bloco


   GerarLinhaMemoLog(' Sped Pis Cofins - Bloco M: Gerando Registros M100');

   TemP200_210;
   TemP400_410;
 //  TemP800_810;

   //M100 - Crédito de PIS/PASEP Relativo ao Período
   AtualizarStatus('Sped Pis Cofins - Bloco M: Gerando Registros M');

  with FcompSpedPisCofins.Bloco_M do
   begin
    with RegistroM001New do
       begin

         IND_MOV:= ACBrEPCBlocos.imComDados ;
         dmPrincipal.FDMemTBCST50.Open;

        if dmPrincipal.cdsConsEmpresaPERFIL.AsString='A' then
           begin

              if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                begin

                  FTabelaRegC170.Filtered:=false;
                  FTabelaRegC170.Filter := 'CST_PIS = 50 AND ALIQ_PIS_PERC <> 0';
                  FTabelaRegC170.Filtered:= true;
                  FTabelaRegC170.Open;
                  FTabelaRegC170.First;
                  while not FTabelaRegC170.Eof do
                    begin
                     dBasePis  := FTabelaRegC170.FieldByName('VL_BC_PIS').AsFloat   + dBasePis ;
                     dValorPis := FTabelaRegC170.FieldByName('VL_PIS').AsFloat      + dValorPis;

                     dBaseCof  := FTabelaRegC170.FieldByName('VL_BC_COFINS').AsFloat+ dBaseCof;
                     dValorCof := FTabelaRegC170.FieldByName('VL_COFINS').AsFloat   + dValorCof;
                     FTabelaRegC170.Next;
                    end;


                 with RegistroM100New do
                   begin
                      COD_CRED       := '101';
                      IND_CRED_ORI   := icoOperProprias;
                      VL_BC_PIS      := dBasePis;   {valor da bc pis cst 50 entrada}
                      ALIQ_PIS       := AliqPis;
                      QUANT_BC_PIS   := 0;
                     // ALIQ_PIS_QUANT := 0;
                      VL_CRED        := dValorPis; { VL_BC_PIS* 1,65%}
                      VL_AJUS_ACRES  := 0;
                      VL_AJUS_REDUC  := 0;
                      VL_CRED_DIF    := 0;
                      VL_CRED_DISP   := dValorPis;
                      IND_DESC_CRED  := idcTotal;
                      VL_CRED_DESC   := dValorPis; //Valor do Crédito disponível, descontado da contribuição apurada no próprio período. Se IND_DESC_CRED=0, informar o valor total do Campo 12; Se IND_DESC_CRED=1, informar o valor parcial do Campo 12.
                      SLD_CRED       := 0;
                   end; //Bloco M100
//
//
                    GerarLinhaMemoLog(' Sped Pis Cofins - Bloco M: Gerando Registros M105');
                 with RegistroM105New do
                    begin

                      NAT_BC_CRED      := bccAqBensRevenda;
                      CST_PIS          := ACBrEPCBlocos.stpisOperCredExcRecTribMercInt;
                      VL_BC_PIS_TOT    := dBasePis;
                      //VL_BC_PIS_CUM    := 0;
                      VL_BC_PIS_NC     := dBasePis;
                      VL_BC_PIS        := dBasePis;
                     // QUANT_BC_PIS_TOT := 0;
                      QUANT_BC_PIS     := 0;
                      DESC_CRED        := '';
                    end; //Bloco M105  }



                end;



             if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                begin

                 with RegistroM100New do
                   begin
                      COD_CRED       := '102';
                      IND_CRED_ORI   := icoOperProprias;
                      VL_BC_PIS      := 0;
                      ALIQ_PIS       := 0;
                      QUANT_BC_PIS   := 0;
                     // ALIQ_PIS_QUANT := 0;
                      VL_CRED        := 0;
                      VL_AJUS_ACRES  := 0;
                      VL_AJUS_REDUC  := 0;
                      VL_CRED_DIF    := 0;
                      VL_CRED_DISP   := 0;
                      IND_DESC_CRED  := idcTotal;
                      VL_CRED_DESC   := 0; //Valor do Crédito disponível, descontado da contribuição apurada no próprio período. Se IND_DESC_CRED=0, informar o valor total do Campo 12; Se IND_DESC_CRED=1, informar o valor parcial do Campo 12.
                      SLD_CRED       := 0;
                   end; //Bloco M100
//
//
                    GerarLinhaMemoLog(' Sped Pis Cofins - Bloco M: Gerando Registros M105');
                 with RegistroM105New do
                    begin

                      NAT_BC_CRED      := bccAqBensRevenda;
                      CST_PIS          := ACBrEPCBlocos.stpisOperCredExcRecTribMercInt;
                      VL_BC_PIS_TOT    := 0;
                      //VL_BC_PIS_CUM    := 0;
                      VL_BC_PIS_NC     := 0;
                      VL_BC_PIS        := 0;
                     // QUANT_BC_PIS_TOT := 0;
                      QUANT_BC_PIS     := 0;
                      DESC_CRED        := '';
                    end; //Bloco M105  }



                end;

            end ;

          SaldoNaoCumulativoaPagarPIS:=0;

          dmPrincipal.CdsSPEDM200.Close;
          dmPrincipal.CdsSPEDM200.Open;
          dmPrincipal.CdsSPEDM200.First;
          while not dmPrincipal.CdsSPEDM200.Eof do
             begin
                with RegistroM200New do
                   begin

                     if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                        begin
                          if True then

                           VL_TOT_CONT_NC_PER := (dmPrincipal.CdsSPEDM200VL_REC_BRT.value * AliqPis  / 100);
                           VL_TOT_CRED_DESC   := dValorPis;// dmPrincipal.CdsSPEDM100VL_PIS.AsFloat;

                           if VL_TOT_CONT_NC_PER - VL_TOT_CRED_DESC >0 then
                             begin
                              VL_TOT_CONT_NC_DEV          := VL_TOT_CONT_NC_PER - dValorPis;//DmSPEDContribuicoes.CdsSPEDM100VL_PIS.AsFloat;
                              VL_CONT_NC_REC              := VL_TOT_CONT_NC_DEV;
                              VL_TOT_CONT_REC             := VL_TOT_CONT_NC_DEV;
                              SaldoNaoCumulativoaPagarPIS := VL_TOT_CONT_NC_DEV;
                             end
                             else
                             begin
                              VL_TOT_CONT_NC_DEV := 0;
                              VL_CONT_NC_REC     := 0;
                              VL_TOT_CONT_REC    := 0;
                             end;

                        end
                      else
                        begin

                           VL_CONT_CUM_REC     := 0;
                           VL_TOT_CONT_CUM_PER := 0;
                           VL_TOT_CONT_REC     := 0;
                         while not dmPrincipal.CdsSPEDM210.Eof do
                            begin
                              VL_CONT_CUM_REC     := VL_TOT_CONT_CUM_PER + (dmPrincipal.CdsSPEDM210VL_REC_BRT.value * 0.65) / 100;
                              VL_TOT_CONT_CUM_PER := VL_TOT_CONT_CUM_PER + (dmPrincipal.CdsSPEDM210VL_REC_BRT.value * 0.65) / 100;
                              VL_TOT_CONT_REC     := VL_TOT_CONT_REC     + (dmPrincipal.CdsSPEDM210VL_REC_BRT.value * 0.65) / 100;
                              dmPrincipal.CdsSPEDM210.Next;
                            end;

                           VL_TOT_CRED_DESC            := 0;
                           SaldoNaoCumulativoaPagarPIS := VL_TOT_CONT_CUM_PER;

                        end;


                      VL_TOT_CRED_DESC_ANT := 0;
                      VL_RET_NC            := 0;
                      VL_OUT_DED_NC        := 0;
                      VL_RET_CUM           := 0;
                      VL_OUT_DED_CUM       := 0;

                      if SaldoNaoCumulativoaPagarPIS >0 then // 28082024
                         begin

                            with RegistroM205New do
                               begin
                                 if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                                    NUM_CAMPO := '08'                                      // Saldo Não-Cumulativo a recolher
                                 else
                                    NUM_CAMPO := '12';                                     // Saldo Cumulativo a recolher
                                 COD_REC      := '192101';                                 // Anexo VI do Codac - Contribuição para o PIS_PASEP
                                 VL_DEBITO    := SaldoNaoCumulativoaPagarPIS;
                               end; // Bloco M205

                         end;


                      dmPrincipal.CdsSPEDM210.Open;
                      dmPrincipal.CdsSPEDM210.First;
                      while not dmPrincipal.CdsSPEDM210.Eof do
                       begin
                         with RegistroM210New do
                             begin

                                if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                                   begin
                                       COD_CONT := ccNaoAcumAliqBasica;
                                       ALIQ_PIS := 1.65;
                                   end
                                else
                                   begin
                                      COD_CONT := ccAcumAliqBasica;
                                      ALIQ_PIS := 0.65;
                                   end;

                                 VL_REC_BRT        :=  dmPrincipal.CdsSPEDM210VL_REC_BRT.value;
                                 VL_BC_CONT        :=  dmPrincipal.CdsSPEDM210VL_REC_BRT.value;   //dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat;
                                 VL_BC_CONT_AJUS   :=  dmPrincipal.CdsSPEDM210VL_REC_BRT.value;   //dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat;
                                 VL_CONT_APUR      := (dmPrincipal.CdsSPEDM210VL_REC_BRT.value * ALIQ_PIS) / 100;
                                 VL_AJUS_ACRES     := 0;
                                 VL_AJUS_REDUC     := 0;
                                 VL_CONT_DIFER     := 0;
                                 VL_CONT_DIFER_ANT := 0;
                                 VL_CONT_PER       := (dmPrincipal.CdsSPEDM210VL_REC_BRT.value * ALIQ_PIS) / 100;
                                 {QUANT_BC_PIS := 0;
                                 ALIQ_PIS_QUANT := 0;}
                             end;
                           dmPrincipal.CdsSPEDM210.Next;
                       end;

                   end;
                 dmPrincipal.CdsSPEDM200.Next;
             end;

            AtualizarStatus('Sped Pis Cofins - Bloco M: Gerando Registros M400');
            dmPrincipal.CdsSPEDM400.Close;
            dmPrincipal.CdsSPEDM400.Open;
            dmPrincipal.CdsSPEDM400.First;
            while not dmPrincipal.CdsSPEDM400.Eof do
             begin
               with RegistroM400New do
                begin
                  CST_PIS    :=  ACBrEPCBlocos.StrToCstPis(dmPrincipal.CdsSPEDM400CST.value);
                  VL_TOT_REC :=  dmPrincipal.CdsSPEDM400VL_REC.AsFloat;
                  COD_CTA    := '2';
                  DESC_COMPL := '';

                end; // Bloco M400

               dmPrincipal.cdsSPEDM410.Close;
               dmPrincipal.CdsSPEDM410.ParamByName('CST').AsString := dmPrincipal.CdsSPEDM400CST.AsString;
               dmPrincipal.CdsSPEDM410.Open;
               dmPrincipal.CdsSPEDM410.First;
               while not dmPrincipal.CdsSPEDM410.Eof do
                begin
                  with RegistroM410New do
                   begin
                     NAT_REC := dmPrincipal.CdsSPEDM410NAT_REC.AsString;
                     VL_REC  := dmPrincipal.CdsSPEDM410VL_REC.AsFloat;
                     COD_CTA := '2';
                     DESC_COMPL := '';
                   end; // Bloco M410

                  dmPrincipal.CdsSPEDM410.Next;
                end; // while M410

               dmPrincipal.CdsSPEDM400.Next;
             end; // while M400


           if dmPrincipal.cdsConsEmpresaPERFIL.AsString='A' then
              begin
                if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                   begin

                      with RegistroM500New do
                       begin
                         COD_CRED       := '101';
                         IND_CRED_ORI   := icoOperProprias;
                         VL_BC_COFINS   := dBaseCof;
                         ALIQ_COFINS    := AliqCof;

                         VL_CRED        := dValorCof;;       //DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat; //OBRIGATORIO
                         VL_AJUS_ACRES  := 0;
                         VL_AJUS_REDUC  := 0;
                         VL_CRED_DIFER  := 0;
                         VL_CRED_DISP   := dValorCof;;       //DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat;
                         IND_DESC_CRED  := idcTotal;
                         VL_CRED_DESC   := dValorCof;;      //DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat; //Valor do Crédito disponível, descontado da contribuição apurada no próprio período. Se IND_DESC_CRED=0, informar o valor total do Campo 12; Se IND_DESC_CRED=1, informar o valor parcial do Campo 12.
                         SLD_CRED       := 0;
                       end;


                      with RegistroM505New do
                        begin
                            NAT_BC_CRED         := bccAqBensRevenda;
                            CST_COFINS          := ACBrEPCBlocos.stcofinsOperCredExcRecTribMercInt;
                            VL_BC_COFINS_TOT    := dBaseCof;
                           // VL_BC_COFINS_CUM    := 0;
                            VL_BC_COFINS_NC     := dBaseCof;
                            VL_BC_COFINS        := dBaseCof;
                           // QUANT_BC_COFINS_TOT := 0;
                            QUANT_BC_COFINS     := 0;
                            DESC_CRED           := '';
                        end;


//
                     with RegistroM500New do
                       begin
                         COD_CRED           := '102';
                         IND_CRED_ORI       := icoOperProprias;
                         VL_BC_COFINS       := 0;
                         if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                            ALIQ_COFINS     := 0
                         else
                           ALIQ_COFINS      := 0;

                         VL_CRED        := 0;       //DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat; //OBRIGATORIO
                         VL_AJUS_ACRES  := 0;
                         VL_AJUS_REDUC  := 0;
                         VL_CRED_DIFER  := 0;
                         VL_CRED_DISP   := 0;       //DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat;
                         IND_DESC_CRED  := idcTotal;
                         VL_CRED_DESC   := 0;      //DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat; //Valor do Crédito disponível, descontado da contribuição apurada no próprio período. Se IND_DESC_CRED=0, informar o valor total do Campo 12; Se IND_DESC_CRED=1, informar o valor parcial do Campo 12.
                         SLD_CRED       := 0;
                       end;


                      with RegistroM505New do
                        begin
                            NAT_BC_CRED         := bccAqBensRevenda;
                            CST_COFINS          := ACBrEPCBlocos.stcofinsOperCredExcRecTribMercInt;
                            VL_BC_COFINS_TOT    := 0;
                           // VL_BC_COFINS_CUM    := 0;
                            VL_BC_COFINS_NC     := 0;
                            VL_BC_COFINS        := 0;
                           // QUANT_BC_COFINS_TOT := 0;
                            QUANT_BC_COFINS     := 0;
                            DESC_CRED           := '';
                        end;

                   end;

               end;

            with RegistroM600New do
                begin
                  if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1 then
                     begin

                       VL_TOT_CONT_NC_PER := StrtoFloat(FormatFloat('#0.00', (dmPrincipal.CdsSPEDM200VL_REC_BRT.AsFloat * AliqCof ) / 100));;
                       VL_TOT_CRED_DESC   := dValorCof;        // DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat;

                       if VL_TOT_CONT_NC_PER - VL_TOT_CRED_DESC > 0 then
                        begin
                          VL_TOT_CONT_NC_DEV             := VL_TOT_CONT_NC_PER - VL_TOT_CRED_DESC;
                          VL_CONT_NC_REC                 := VL_TOT_CONT_NC_DEV;
                          VL_TOT_CONT_REC                := VL_TOT_CONT_NC_DEV;
                          SaldoNaoCumulativoaPagarCOFINS := VL_TOT_CONT_NC_DEV;
                        end
                       else
                        begin
                          VL_TOT_CONT_NC_DEV := 0;
                          VL_CONT_NC_REC     := 0;
                          VL_TOT_CONT_REC    := 0;
                        end;

                     end
                    else
                     begin
                       VL_CONT_CUM_REC     := (dmPrincipal.CdsSPEDM200VL_REC_BRT.AsFloat * AliqCof ) / 100;
                       VL_TOT_CONT_REC     := (dmPrincipal.CdsSPEDM200VL_REC_BRT.AsFloat * AliqCof ) / 100;
                       VL_TOT_CONT_CUM_PER := (dmPrincipal.CdsSPEDM200VL_REC_BRT.AsFloat * AliqCof ) / 100;

                      while not dmPrincipal.CdsSPEDM210.Eof do
                        begin
                          VL_CONT_CUM_REC     := VL_TOT_CONT_CUM_PER + (dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat * 3) / 100;
                          VL_TOT_CONT_CUM_PER := VL_TOT_CONT_CUM_PER + (dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat * 3) / 100;
                          VL_TOT_CONT_REC     := VL_TOT_CONT_REC     + (dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat * 3) / 100;

                          dmPrincipal.CdsSPEDM210.Next;
                        end;

                       //VL_TOT_CONT_CUM_PER :=(DmSPEDContribuicoes.CdsSPEDM600VL_REC_BRT.AsFloat * 3) / 100;
                       //VL_CONT_CUM_REC     := DmSPEDContribuicoes.CdsSPEDM600VL_REC_BRT.AsFloat; // - DmSPEDContribuicoes.CdsSPEDM100VL_PIS.AsFloat;
                       //VL_TOT_CONT_REC     := DmSPEDContribuicoes.CdsSPEDM600VL_REC_BRT.AsFloat - DmSPEDContribuicoes.CdsSPEDM500VL_COFINS.AsFloat;
                       VL_TOT_CRED_DESC := 0;
                       SaldoNaoCumulativoaPagarCOFINS := VL_TOT_CONT_CUM_PER;
                     end;
                  VL_TOT_CRED_DESC_ANT := 0;
                  VL_RET_NC            := 0;
                  VL_OUT_DED_NC        := 0;
                  VL_RET_CUM           := 0;
                  VL_OUT_DED_CUM       := 0;
                end; // Bloco M600

                if SaldoNaoCumulativoaPagarCOFINS >0 then
                     begin

                        with RegistroM605New do
                             begin
                              if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1then
                                 NUM_CAMPO := '08'            // Saldo Não-Cumulativo a recolher
                              else
                                 NUM_CAMPO := '12';           // Saldo Cumulativo a recolher

                              COD_REC   := '184001';         // Anexo VII do Codac - Contribuição para o COFINS
                              VL_DEBITO := SaldoNaoCumulativoaPagarCOFINS; //StrtoFloat(FormatFloat('#0.00', (dmPrincipal.CdsSPEDM200VL_REC_BRT.AsFloat * AliqCof ) / 100));

                             end; // Bloco M605

                     end;
                dmPrincipal.CdsSPEDM210.Open;
                dmPrincipal.CdsSPEDM210.First;
             while not dmPrincipal.CdsSPEDM210.Eof do
                begin
                   with RegistroM610New do
                       begin

                         if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1then
                            COD_CONT := ccNaoAcumAliqBasica
                         else
                            COD_CONT := ccAcumAliqBasica;

                         VL_REC_BRT      := dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat;
                         VL_BC_CONT      := dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat;
                         VL_BC_CONT_AJUS := dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat;

                         if FrmPrincipal.CbbIncidenciaTributaria.ItemIndex <> 1then
                            ALIQ_COFINS := 7.6
                         else
                            ALIQ_COFINS := 3;

                         VL_CONT_APUR      := (dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat * ALIQ_COFINS) / 100;
                         VL_AJUS_ACRES     := 0;
                         VL_AJUS_REDUC     := 0;
                         VL_CONT_DIFER     := 0;
                         VL_CONT_DIFER_ANT := 0;
                         VL_CONT_PER       := (dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat * ALIQ_COFINS) / 100;
                         {QUANT_BC_COFINS := 0;
                         ALIQ_COFINS_QUANT := 0;}

                       end; // Bloco M610

                     dmPrincipal.CdsSPEDM210.Next;

                end;

            AtualizarStatus('Sped Pis Cofins - Bloco M: Gerando Registros M800');

            // REGISTRO M800
            dmPrincipal.cdsSPEDM410.close;
            dmPrincipal.cdsSPEDM410.Open;
            dmPrincipal.CdsSPEDM400.First;
            while not dmPrincipal.CdsSPEDM400.Eof do
             begin
               with RegistroM800New do
                begin
                  CST_COFINS :=  ACBrEPCBlocos.StrToCstCofins(dmPrincipal.CdsSPEDM400CST.value);
                  VL_TOT_REC :=  dmPrincipal.CdsSPEDM400VL_REC.AsFloat;
                  COD_CTA    := '2';
                  DESC_COMPL := '';

                end; // Bloco M800


               dmPrincipal.CdsSPEDM410.close;
               dmPrincipal.CdsSPEDM410.ParamByName('CST').AsString := dmPrincipal.CdsSPEDM400CST.AsString;
               dmPrincipal.CdsSPEDM410.Open;
               dmPrincipal.CdsSPEDM410.First;
               while not dmPrincipal.CdsSPEDM410.Eof do
                begin
                  with RegistroM810New do
                   begin
                     NAT_REC    := dmPrincipal.CdsSPEDM410NAT_REC.AsString;
                     VL_REC     := dmPrincipal.CdsSPEDM410VL_REC.AsFloat;
                     COD_CTA    := '2';
                     DESC_COMPL := '';
                   end; // Bloco M810

                  dmPrincipal.CdsSPEDM410.Next;
                end; // while M810

               dmPrincipal.CdsSPEDM400.Next;
             end; // while M800

       end;

  end;
end;


procedure TSpedPisCofins.GerarLinhaMemoLog(const LinhaLog: String);
var
   DiaSemana,
   DataHora,
   Espaco: String;
begin
   DiaSemana := aSemana[DayOfWeek(Date)];
   Espaco := StringOfChar(' ', 15 - Length(DiaSemana));
   DiaSemana := DiaSemana + Espaco;
   DataHora := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
   if Assigned(FMemoErro) then
      FMemoErro.Lines.Add(DiaSemana + DataHora + ' > ' + String(LinhaLog));
end;

function TSpedPisCofins.GetCodNatReg0400ByCFOP(const CFOP: String): String;
begin
   FTabelaReg0400.Filtered := False;
   try
      FTabelaReg0400.Filter := 'CFOP = ' + QuotedStr(CFOP);
      FTabelaReg0400.Filtered := True;
      Result := FTabelaReg0400.FieldByName('COD_NAT').AsString;
   finally
      FTabelaReg0400.Filtered := False;
   end;
end;

function TSpedPisCofins.GetCodPartByCnpjCpf(const CNPJCPF: String): String;
begin
   FTabelaReg0150.Filtered := False;
   try
      FTabelaReg0150.Filter := 'CNPJCPF = ' + QuotedStr(CNPJCPF);
      FTabelaReg0150.Filtered := True;
      Result := FTabelaReg0150.FieldByName('COD_PART').AsString;
   finally
      FTabelaReg0150.Filtered := False;
   end;
end;

function TSpedPisCofins.GetTotalBaseCofins(Notas: TNotasFiscais): Double;
var
   oItemServico: TDetCollectionItem;
   Idx: Integer;
begin
   Result := 0;
   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemServico := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];
         Result := Result + oItemServico.Imposto.COFINS.vBC;
      end;
end;


function TSpedPisCofins.GetTotalBasePis(Notas: TNotasFiscais): Double;
var
   oItemServico: TDetCollectionItem;
   Idx: Integer;
begin
   Result := 0;
   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemServico := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];
         Result := Result + oItemServico.Imposto.PIS.vBC;
      end;
end;

function TSpedPisCofins.GetTypeNatBcCred(const sCodNatBaseCred: String): ACBrEPCBlocos.TACBrNatBcCred;
begin
 {   '01' // Aquisição de bens para revenda
     '02' // Aquisição de bens utilizados como insumo
     '03' // Aquisição de serviços utilizados como insumo
     '04' // Energia elétrica e térmica, inclusive sob a forma de vapor
     '05' // Aluguéis de prédios
     '06' // Aluguéis de máquinas e equipamentos
     '07' // Armazenagem de mercadoria e frete na operação de venda
     '08' // Contraprestações de arrendamento mercantil
     '09' // Máquinas, equipamentos e outros bens incorporados ao ativo imobilizado (crédito sobre encargos de depreciação).
     '10' // Máquinas, equipamentos e outros bens incorporados ao ativo imobilizado (crédito com base no valor de aquisição).
     '11' // Amortização e Depreciação de edificações e benfeitorias em imóveis
     '12' // Devolução de Vendas Sujeitas à Incidência Não-Cumulativa
     '13' // Outras Operações com Direito a Crédito
     '14' // Atividade de Transporte de Cargas – Subcontratação
     '15' // Atividade Imobiliária – Custo Incorrido de Unidade Imobiliária
     '16' // Atividade Imobiliária – Custo Orçado de unidade não concluída
     '17' // Atividade de Prestação de Serviços de Limpeza, Conservação e Manutenção – vale-transporte, vale-refeição ou vale-alimentação, fardamento ou uniforme.
     '18' // Estoque de abertura de bens
 }

   if (sCodNatBaseCred = '01') then
      Result := bccAqBensRevenda
   else
   if (sCodNatBaseCred = '02') then
      Result := bccAqBensUtiComoInsumo
   else
   if (sCodNatBaseCred = '03') then
      Result := bccAqServUtiComoInsumo
   else
   if (sCodNatBaseCred = '04') then
      Result := bccEnergiaEletricaTermica
   else
   if (sCodNatBaseCred = '05') then
      Result := bccAluguelPredios
   else
   if (sCodNatBaseCred = '06') then
      Result := bccAluguelMaqEquipamentos
   else
   if (sCodNatBaseCred = '07') then
      Result := bccArmazenagemMercadoria
   else
   if (sCodNatBaseCred = '08') then
      Result := bccConArrendamentoMercantil
   else
   if (sCodNatBaseCred = '09') then
      Result := bccMaqCredDepreciacao
   else
   if (sCodNatBaseCred = '10') then
      Result := bccMaqCredAquisicao
   else
   if (sCodNatBaseCred = '11') then
      Result := bccAmortizacaoDepreciacaoImoveis
   else
   if (sCodNatBaseCred = '12') then
      Result := bccDevolucaoSujeita
   else
   if (sCodNatBaseCred = '13') then
      Result := bccOutrasOpeComDirCredito
   else
   if (sCodNatBaseCred = '14') then
      Result := bccAtTransporteSubcontratacao
   else
   if (sCodNatBaseCred = '15') then
      Result := bccAtImobCustoIncorrido
   else
   if (sCodNatBaseCred = '16') then
      Result := bccAtImobCustoOrcado
   else
   if (sCodNatBaseCred = '17') then
      Result := bccAtPresServ
   else
   if (sCodNatBaseCred = '18') then
      Result := bccEstoqueAberturaBens
   else
      Result := bccOutrasOpeComDirCredito;
end;

function TSpedPisCofins.GetValorFieldDataSet(cds: TClientDataSet; const Campo: String): String;
begin
  cds.Filtered := False;
  cds.Filter := 'SECAO_CAMPO = ' + QuotedStr(Trim(Campo));
  cds.Filtered := True;
  Result := Trim(cds.FieldByName('CONTEUDO').AsString);
  cds.Filtered := False;
end;

procedure TSpedPisCofins.IncBar;
begin
   if (Assigned(FProgressBar)) then
      begin
         FProgressBar.Position := FProgressBar.Position + 1;
         Application.ProcessMessages;
      end;
end;

function TSpedPisCofins.InformacoesNFeValidasParaEscriturar(Notas: TNotasFiscais; const docEntrada: Boolean): Boolean;
begin
   Result := False;
   if (Notas.Count = 0) then
      begin
         GerarLinhaMemoLog('Nenhuma nota foi encontrada ao carregar o arquivo XML!');
      end
   else
   if (Notas.Count > 1) then
      begin
         GerarLinhaMemoLog('Existem mais de uma NF-e no arquivo XML (Lote)! Chave: ' + Notas.Items[0].NFe.procNFe.chNFe);
      end
   else
   if (Trim(Notas.Items[0].NFe.procNFe.nProt) = '') then
      begin
         GerarLinhaMemoLog('NF-e não está autorizada! Arquivo XML não contém protocolo de autorização! Chave: ' + Notas.Items[0].NFe.procNFe.chNFe);
      end
   else
   if (not docEntrada) and (Notas.Items[0].NFe.Emit.CNPJCPF <> RemoveMascaraStr(Self.CnpjEmpresa)) then
      begin
         GerarLinhaMemoLog('CNPJ Emitente é do arquivo é diferente do cadastro da empresa! Chave: ' + Notas.Items[0].NFe.procNFe.chNFe);
         GerarLinhaMemoLog('CNPJ do Arquivo: ' + MascaraCNPFCPF(Notas.Items[0].NFe.Emit.CNPJCPF) + ' - CNPJ Empresa: ' + MascaraCNPFCPF(Self.CnpjEmpresa));
      end
   else
   if ChaveDuplicadaNaApuracao(Notas.Items[0].NFe.procNFe.chNFe) then
      begin
         GerarLinhaMemoLog('Existem mais de um arquivo no diretório XML! Chave: ' + Notas.Items[0].NFe.procNFe.chNFe);
      end
   else
     Result := True;
end;

procedure TSpedPisCofins.IniciaBar(const iValueMaxBar: Integer);
begin
   if (Assigned(FProgressBar)) then
      begin
         FProgressBar.Max := iValueMaxBar;
         FProgressBar.Position := 0;
      end;
end;

procedure TSpedPisCofins.IniciarControles;
begin
   FECF_RequerZ := False;
   FListaArquivos.Clear;
   {Limpa Lista de erros}
   if Assigned(FMemoErro) then
      FMemoErro.Lines.Clear;

   IniciaBar(0);

   FTabelaRegE510.EmptyDataSet;
  // FTabelaReg1900.EmptyDataSet;

   if (FACBrECF.Ativo) then
      FACBrECF.Desativar;
end;

procedure TSpedPisCofins.LimparTabela;
begin

   dmPrincipal.FdQueryAuxiliar.sql.Clear;
   dmPrincipal.FdQueryAuxiliar.SQL.Text:='DELETE FROM  TEMP_CST_PIS_COF';
   dmPrincipal.FdQueryAuxiliar.ExecSQL;

   dmPrincipal.FdQueryAuxiliar.sql.Clear;
   dmPrincipal.FdQueryAuxiliar.SQL.Text:='DELETE FROM PROD_TRIB_ERRADA';
   dmPrincipal.FdQueryAuxiliar.ExecSQL;

   dmPrincipal.FdQueryAuxiliar.sql.Clear;
   dmPrincipal.FdQueryAuxiliar.SQL.Text:='DELETE FROM FTabelaRegC175';
   dmPrincipal.FdQueryAuxiliar.ExecSQL;

   dmPrincipal.FdQueryAuxiliar.sql.Clear;
   dmPrincipal.FdQueryAuxiliar.SQL.Text:='DELETE FROM FTabelaReg1900';
   dmPrincipal.FdQueryAuxiliar.ExecSQL;



end;

function TSpedPisCofins.NotaCancelada(const Chave: String): Boolean;
var
   oListaCanceladas: TStrings;
   idx: Integer;
begin
   Result := False;

   //** Lista NFe
   oListaCanceladas := TStringList.Create;
   try
      ObterListaAqruivosDiretorio(Self.LocalDocXml_NFE, 'xml', TStringList(oListaCanceladas), Chave + '*');
      if (oListaCanceladas.Count > 1) then
         begin
            for idx := 0 to oListaCanceladas.Count - 1 do
               begin
                  Result := (Pos('can', oListaCanceladas[ idx ]) > 0);
                  if Result then
                     Break;
               end;
         end;
   finally
      oListaCanceladas.Free;
   end;

   //** Lista NFCe
   if (not Result) then
      begin
         oListaCanceladas := TStringList.Create;
         try
            ObterListaAqruivosDiretorio(Self.LocalDocXml_NFCE, 'xml', TStringList(oListaCanceladas), Chave);
            if (oListaCanceladas.Count > 1) then
               begin
                  for idx := 0 to oListaCanceladas.Count - 1 do
                     begin
                        Result := (Pos('can', oListaCanceladas[ idx ]) > 0);
                        if Result then
                           Break;
                     end;
               end;
         finally
            oListaCanceladas.Free;
         end;
      end;
end;

function TSpedPisCofins.NotaServicoCancelada(const Chave: String): Boolean;
var
   oListaCanceladas: TStrings;
   idx: Integer;
begin
   //** Lista NF Serviços
   if (not Result) then
      begin
         oListaCanceladas := TStringList.Create;
         try
            ObterListaAqruivosDiretorio(Self.LocalDocXml_NFSE, 'xml', TStringList(oListaCanceladas), Chave);
            if (oListaCanceladas.Count > 1) then
               begin
                  for idx := 0 to oListaCanceladas.Count - 1 do
                     begin
                        Result := (Pos('can', oListaCanceladas[ idx ]) > 0);
                        if Result then
                           Break;
                     end;
               end;
         finally
            oListaCanceladas.Free;
         end;
      end;
end;

procedure TSpedPisCofins.OnErrorSpedPisCofins(const MsgError: String);
var
   sName_File: String;
   oTmp: TStrings;
begin
   if Assigned(FMemoErro) then
      GerarLinhaMemoLog(MsgError)
   else
      begin
         // Salva em arquivo local
         oTmp := TStringList.Create;
         try
            sName_File := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + '.log';
            sName_File := StringReplace(sName_File, '/', '', [rfReplaceAll,rfIgnoreCase]);
            sName_File := StringReplace(sName_File, ':', '', [rfReplaceAll,rfIgnoreCase]);
            sName_File := StringReplace(sName_File, '_', ' ', [rfReplaceAll,rfIgnoreCase]);
            oTmp.Add(MsgError);
            oTmp.SaveToFile(ExtractFilePath(Application.ExeName) + 'logerror_' + sName_File);
         finally
            oTmp.Free;
         end;
      end;
end;

procedure TSpedPisCofins.OnErrorSpedPisCofins(const MsgError: AnsiString);
var
   sName_File: String;
   oTmp: TStrings;
begin
   if Assigned(FMemoErro) then
      GerarLinhaMemoLog(String(MsgError))
   else
      begin
         // Salva em arquivo local
         oTmp := TStringList.Create;
         try
            sName_File := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + '.log';
            sName_File := StringReplace(sName_File, '/', '', [rfReplaceAll,rfIgnoreCase]);
            sName_File := StringReplace(sName_File, ':', '', [rfReplaceAll,rfIgnoreCase]);
            sName_File := StringReplace(sName_File, '_', ' ', [rfReplaceAll,rfIgnoreCase]);
            oTmp.Add(String(MsgError));
            oTmp.SaveToFile(ExtractFilePath(Application.ExeName) + 'logerror_' + sName_File);
         finally
            oTmp.Free;
         end;
      end;
end;

procedure TSpedPisCofins.SetMemoErro(const Value: TMemo);
begin
   FMemoErro := Value;
   SetEventoOnError;
end;

procedure TSpedPisCofins.TemP200_210;
var
 teste:string;
begin
 AtualizarStatus('Gerando Registro M200 e M210...');
 dmPrincipal.FdQueryAuxiliar.sql.Clear;
 dmPrincipal.FdQueryAuxiliar.SQL.Text:='delete from  TEMP_SPEDC_M210';
 dmPrincipal.FdQueryAuxiliar.ExecSQL;

 dmPrincipal.cdsTemCstPIsCof.close;
 dmPrincipal.cdsTemCstPIsCof.Filtered :=false;
 dmPrincipal.cdsTemCstPIsCof.Filter   :='CST_PIS = 01';
 dmPrincipal.cdsTemCstPIsCof.Filtered :=true;
 dmPrincipal.cdsTemCstPIsCof.Open;
 dmPrincipal.cdsTemCstPIsCof.First;
 IniciaBar( dmPrincipal.cdsTemCstPIsCof.RecordCount);

 if dmPrincipal.cdsTemCstPIsCof.RecordCount >0 then
    begin
      while not dmPrincipal.cdsTemCstPIsCof.Eof do
        begin
         IncBar;
         AtualizarStatus('Gerando Registro M200 e Registro M210...');
         dmPrincipal.CdsSPEDM210.close;
         dmPrincipal.CdsSPEDM210.Filtered:=False;
         dmPrincipal.CdsSPEDM210.Filter  :='COD_CONTA=01';
         dmPrincipal.CdsSPEDM210.Filtered:=True;
         dmPrincipal.CdsSPEDM210.open;
         if dmPrincipal.CdsSPEDM210.RecordCount =0 then
            begin
              dmPrincipal.CdsSPEDM210.Append;
              dmPrincipal.CdsSPEDM210COD_CONTA.Value        :='01';
              dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat     := dmPrincipal.cdsTemCstPIsCofVALORBASEPISCOF.Value;
              dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat:= dmPrincipal.cdsTemCstPIsCofBASEPIS.Value;
              dmPrincipal.CdsSPEDM210.ApplyUpdates(0);
            end
         else
            begin
              dmPrincipal.CdsSPEDM210.Edit;
              dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat     :=  dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat + dmPrincipal.cdsTemCstPIsCofVALORBASEPISCOF.Value;
              dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat:= dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat + dmPrincipal.cdsTemCstPIsCofBASEPIS.Value;
              dmPrincipal.CdsSPEDM210.ApplyUpdates(0);
            end;
          dmPrincipal.cdsTemCstPIsCof.Next;
        end;

    end;

end;

procedure TSpedPisCofins.TemP800_810;
begin

//

 AtualizarStatus('Gerando Registro M800 e M810...');
 dmPrincipal.FdQueryAuxiliar.sql.Clear;
 dmPrincipal.FdQueryAuxiliar.SQL.Text:='delete from  TEMP_SPEDC_M810';
 dmPrincipal.FdQueryAuxiliar.ExecSQL;

 dmPrincipal.cdsTemCstPIsCof.close;
 dmPrincipal.cdsTemCstPIsCof.Filtered :=false;
 dmPrincipal.cdsTemCstPIsCof.Filter   :='CST_PIS = 06';
 dmPrincipal.cdsTemCstPIsCof.Filtered :=true;
 dmPrincipal.cdsTemCstPIsCof.Open;
 dmPrincipal.cdsTemCstPIsCof.First;
 IniciaBar(dmPrincipal.cdsTemCstPIsCof.RecordCount);

 if dmPrincipal.cdsTemCstPIsCof.RecordCount >0 then
    begin
      while not dmPrincipal.cdsTemCstPIsCof.Eof do
        begin
         IncBar;

         dmPrincipal.cdsCadSPEDM800.close;
         dmPrincipal.cdsCadSPEDM800.Filtered:=False;
         dmPrincipal.cdsCadSPEDM800.Filter  :='COD_CONTA=06';
         dmPrincipal.cdsCadSPEDM800.Filtered:=True;
         dmPrincipal.cdsCadSPEDM800.open;
         if dmPrincipal.cdsCadSPEDM800.RecordCount =0 then
            begin
              dmPrincipal.cdsCadSPEDM800.Append;
              dmPrincipal.cdsCadSPEDM800CST.Value :='06';
              dmPrincipal.cdsCadSPEDM800VL_REC.AsFloat      := dmPrincipal.cdsTemCstPIsCofVALORBASEPISCOF.Value;
              dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat:= dmPrincipal.cdsTemCstPIsCofBASEPIS.Value;
              dmPrincipal.CdsSPEDM210.ApplyUpdates(0);
            end
         else
            begin
              dmPrincipal.CdsSPEDM210.EditKey;
              dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat     := dmPrincipal.CdsSPEDM210VL_REC_BRT.AsFloat + dmPrincipal.cdsTemCstPIsCofVALORBASEPISCOF.Value;;
              dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat:= dmPrincipal.CdsSPEDM210VL_BASE_CALCULO.AsFloat + dmPrincipal.cdsTemCstPIsCofBASEPIS.Value;
              dmPrincipal.CdsSPEDM210.ApplyUpdates(0);
            end;
           dmPrincipal.cdsTemCstPIsCof.Next;
        end;

    end;

end;

procedure TSpedPisCofins.TemP400_410;
var
 sNcm,msg:string;
begin

  AtualizarStatus('Carregando informações do  Registro M400...');

 dmPrincipal.FdQueryAuxiliar.sql.Clear;
 dmPrincipal.FdQueryAuxiliar.SQL.Text:='DELETE FROM TEMP_SPEDC_M410';
 dmPrincipal.FdQueryAuxiliar.ExecSQL;

 dmPrincipal.cdsTemCstPIsCof.close;
 dmPrincipal.cdsTemCstPIsCof.Filtered :=false;
 dmPrincipal.cdsTemCstPIsCof.Filter   :='CST_PIS = 04';
 dmPrincipal.cdsTemCstPIsCof.Filtered :=true;
 dmPrincipal.cdsTemCstPIsCof.Open;
 dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value;

 IniciaBar(dmPrincipal.cdsTemCstPIsCof.RecordCount);
 if dmPrincipal.cdsTemCstPIsCof.RecordCount >0 then
    begin
      dmPrincipal.cdsTEMP_SPEDC_M410.Close;
      dmPrincipal.cdsTEMP_SPEDC_M410.Open;
      dmPrincipal.cdsTemCstPIsCof.First;
      while not dmPrincipal.cdsTemCstPIsCof.Eof do
           begin


              if (dmPrincipal.cdsTemCstPIsCofNCM.AsString='') or
                 (dmPrincipal.cdsTemCstPIsCofNCM.AsString='99999999')or
                 (dmPrincipal.cdsTemCstPIsCofNCM.AsString='00000000') then
                  sNcm:='30049099';

                 sNcm:=dmPrincipal.cdsTemCstPIsCofNCM.AsString;
              IncBar;

              try

                if (copy(sNcm,1,4) ='3001')or
                   ((copy(sNcm,1,4)='3003')and (sNcm <>'30039056'))or
                   ((copy(sNcm,1,4)='3004')and (sNcm <>'30049046'))or
                   (copy(sNcm,1,7) ='3002101')or
                   (copy(sNcm,1,7) ='3002102')or
                   (copy(sNcm,1,7) ='3002103')or
                   (copy(sNcm,1,7) ='3002201')or
                   (copy(sNcm,1,7) ='3002202')or
                   (copy(sNcm,1,7) ='3006301')or
                   (copy(sNcm,1,7) ='3006302')or
                   (sNcm ='30029020') or
                   (sNcm ='30029092') or
                   (sNcm ='30029099') or
                   (sNcm ='30051010') or
                   (sNcm ='30066000') then  // medicamentos
                    begin
                     dmPrincipal.cdsTEMP_SPEDC_M410.Close;
                     dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                     dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:= false;
                     dmPrincipal.cdsTEMP_SPEDC_M410.Filter :='CST= 04 and NAT_REC =201 ';
                     dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:=true;
                     dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                     iF dmPrincipal.cdsTEMP_SPEDC_M410.RecordCount =0 then
                        begin
                          dmPrincipal.cdsTEMP_SPEDC_M410.Append;
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('CST').Value    := '04';
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('NAT_REC').Value:= '201';
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value := dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value;
                          dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                        end
                     else
                       begin
                          dmPrincipal.cdsTEMP_SPEDC_M410.Edit;
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value := dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value + dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value ;
                          dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                       end;


                    end
                 else // perfumaria
                    begin

                      dmPrincipal.cdsTEMP_SPEDC_M410.Close;
                      dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                      dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:= false;
                      dmPrincipal.cdsTEMP_SPEDC_M410.Filter :='CST= 04 and NAT_REC =202';
                      dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:=true;
                      dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                      iF dmPrincipal.cdsTEMP_SPEDC_M410.RecordCount =0 then
                        begin
                          dmPrincipal.cdsTEMP_SPEDC_M410.Append;
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('CST').Value    := '04';
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('NAT_REC').Value:= '202';
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value :=  dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value;
                          dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                        end
                     else
                        begin
                          dmPrincipal.cdsTEMP_SPEDC_M410.Edit;
                          dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value := dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value + dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value ;
                          dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                        end;

                    end;

              except on E:Exception do

               msg:=e.Message;

              end;

               dmPrincipal.cdsTemCstPIsCof.Next;
           end;

     end;

   AtualizarStatus('Carregando informações do Cst Registro M410...');
   dmPrincipal.cdsTemCstPIsCof.close;
   dmPrincipal.cdsTemCstPIsCof.Filtered :=false;
   dmPrincipal.cdsTemCstPIsCof.Filter   :='CST_PIS =06';
   dmPrincipal.cdsTemCstPIsCof.Filtered :=true;
   dmPrincipal.cdsTemCstPIsCof.Open;
   IniciaBar(dmPrincipal.cdsTemCstPIsCof.RecordCount);
   if dmPrincipal.cdsTemCstPIsCof.RecordCount >0 then
      begin
          dmPrincipal.cdsTemCstPIsCof.First;
        while not dmPrincipal.cdsTemCstPIsCof.Eof do
             begin

               IncBar;

                 if (dmPrincipal.cdsTemCstPIsCofNCM.AsString='') or
                    (dmPrincipal.cdsTemCstPIsCofNCM.AsString='99999999')or
                    (dmPrincipal.cdsTemCstPIsCofNCM.AsString='00000000') then
                     sNcm:='30049099';

                 sNcm:=dmPrincipal.cdsTemCstPIsCofNCM.AsString;

                try

                   if (copy(sNcm,1,4) ='3001')or
                      ((copy(sNcm,1,4)='3003')and (sNcm <>'30039056'))or
                      ((copy(sNcm,1,4)='3004')and (sNcm <>'30049046'))or
                      (copy(sNcm,1,7) ='3002101')or
                      (copy(sNcm,1,7) ='3002102')or
                      (copy(sNcm,1,7) ='3002103')or
                      (copy(sNcm,1,7) ='3002201')or
                      (copy(sNcm,1,7) ='3002202')or
                      (copy(sNcm,1,7) ='3006301')or
                      (copy(sNcm,1,7) ='3006302')or
                      (sNcm ='30029020') or
                      (sNcm ='30029092') or
                      (sNcm ='30029099') or
                      (sNcm ='30051010') or
                      (sNcm ='30066000') then  //medicamentos
                      begin
                       dmPrincipal.cdsTEMP_SPEDC_M410.Close;
                       dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                       dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:= false;
                       dmPrincipal.cdsTEMP_SPEDC_M410.Filter :='CST= 06 and NAT_REC =201 ';
                       dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:=true;
                       dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                       dmPrincipal.cdsTEMP_SPEDC_M410.First;

                       iF dmPrincipal.cdsTEMP_SPEDC_M410.RecordCount =0 then
                          begin
                            dmPrincipal.cdsTEMP_SPEDC_M410.Append;
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('CST').Value    := '06';
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('NAT_REC').Value:= '201';
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value := dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value;
                            dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                          end
                       else
                         begin
                            dmPrincipal.cdsTEMP_SPEDC_M410.Edit;
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value := dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value + dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value;
                            dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                         end;


                      end
                   else
                      begin //perfumaria

                        dmPrincipal.cdsTEMP_SPEDC_M410.Close;
                        dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                        dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:= false;
                        dmPrincipal.cdsTEMP_SPEDC_M410.Filter :='CST= 06 and NAT_REC =202';
                        dmPrincipal.cdsTEMP_SPEDC_M410.Filtered:=true;
                        dmPrincipal.cdsTEMP_SPEDC_M410.Open;
                        iF dmPrincipal.cdsTEMP_SPEDC_M410.RecordCount =0 then
                          begin
                            dmPrincipal.cdsTEMP_SPEDC_M410.Append;
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('CST').Value    := '06';
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('NAT_REC').Value:= '202';
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value := dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value;
                            dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                          end
                       else
                          begin
                            dmPrincipal.cdsTEMP_SPEDC_M410.Edit;
                            dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value := dmPrincipal.cdsTemCstPIsCofVALOR_PROD.Value + dmPrincipal.cdsTEMP_SPEDC_M410.FieldByName('VL_REC').Value ;
                            dmPrincipal.cdsTEMP_SPEDC_M410.ApplyUpdates(0);
                          end;
                      end;

                except on E:Exception do

                 msg:=e.Message;
                end;

               dmPrincipal.cdsTemCstPIsCof.Next;
             end;
       end;
end;

function TSpedPisCofins.TemServicosNaNFe(Notas: TNotasFiscais): Boolean;
var
   oItemServico: TDetCollectionItem;
   Idx: Integer;
begin

   Result := False;
   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemServico := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];
         Result := (oItemServico.Prod.CFOP = '5933');
         if Result then
            Break;
      end;
end;

procedure TSpedPisCofins.SetCnpjEmpresa(const Value: String);
var
  iCNPJ: Int64;
begin
  FCnpjEmpresa := Value;
  try
     iCNPJ := StrToInt64(FCnpjEmpresa);
  except
     FCnpjEmpresa := RemoveMascaraStr( Desincriptar(Value) );
  end;
end;

procedure TSpedPisCofins.SetDataFinal(const Value: TDateTime);
begin
  FDataFinal := Value;
  Self.FcompSpedPisCofins.DT_FIN := FDataFinal;
end;

procedure TSpedPisCofins.SetDataInicial(const Value: TDateTime);
begin
  FDataInicial := Value;
  Self.FcompSpedPisCofins.DT_INI := FDataInicial;
end;

procedure TSpedPisCofins.SetEventoOnError;
begin
   FcompSpedPisCofins.OnError := OnErrorSpedPisCofins;
end;

procedure TSpedPisCofins.SetLocalSalvar(const Value: String);
var
   sNomeArquivo: String;
begin

  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.open;

  FLocalSalvar := ExtractFilePath(Value);
  sNomeArquivo := 'SPED_PIS_COFINS_EMP_' + dmPrincipal.cdsConsEmpresaRAZAO.AsString + '_MES_' +
                                           FormatDateTime('mm_yyyy', Self.FcompSpedPisCofins.DT_INI) + '.txt';
  Self.FcompSpedPisCofins.Arquivo := AnsiString(FLocalSalvar + sNomeArquivo);
  Self.FcompSpedPisCofins.Path := ExtractFilePath(FLocalSalvar);
  if (not DirectoryExists(String(Self.FcompSpedPisCofins.Path))) then
     ForceDirectories(String(Self.FcompSpedPisCofins.Path));
end;

procedure TSpedPisCofins.ExecSQL(const SQL: String);
begin
   try
      FcdsResultExec.Close;
      FqryResultExec.Close;
      FqryResultExec.SQL.Clear;
      FdspResultExec.DataSet := FqryResultExec;
      FcdsResultExec.SetProvider(FdspResultExec);
      FqryResultExec.SQLConnection := Self.ConexaoBase;

      FqryResultExec.SQL.Add(SQL);
      FqryResultExec.Open;
      FcdsResultExec.Open;
   except
      on E: Exception do
         begin
            GerarLinhaMemoLog('Funcção "TSpedFiscal.ExecSQL" - Erro SQL: ' + E.Message);
         end;
   end;
end;

procedure TSpedPisCofins.FiltrarDocumentosFornecedores(oListaArq: TStringList; const iLim: Integer);
var
  idx: Integer;
  bArquivoValido: Boolean;
begin
   GerarLinhaMemoLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Filtrando Xml de Fornecedores <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
   GerarLinhaMemoLog('Selecionando documentos de entradas/fornecedores:');
   GerarLinhaMemoLog('> Serão apurados somente documentos: ');
   GerarLinhaMemoLog('>> CNPJ destinatário que contém o CNPJ da empresa ' + Self.CnpjEmpresa);
   GerarLinhaMemoLog('>> Data de entrada/saída (dEmi ou dhEmi) do documento deve estar entre "' + FormatDateTime('dd.mm.yyyy', DataInicial) + '"' +
                     ' e "' + FormatDateTime('dd.mm.yyyy', DataFinal) + '"');
   GerarLinhaMemoLog('>> Modelo do documento deve ser "55" ');

   for idx := oListaArq.Count - 1 downto 0 do
      begin
         try
            // Checagem se a estrutura do documento é valido NF-e
            FacbrNFe.NotasFiscais.Clear;
            FacbrNFe.NotasFiscais.LoadFromFile(Trim(oListaArq[iDx]));
            bArquivoValido := True;

            if FacbrNFe.NotasFiscais.Count = 0 then
               begin
                  GerarLinhaMemoLog('Arquivo xml de entrada estrutura inválida: ' + Trim(oListaArq[idx]));
                  bArquivoValido := False;
               end;

         except
            GerarLinhaMemoLog('Arquivo xml de entrada estrutura inválida: ' + Trim(oListaArq[idx]));
            bArquivoValido := False;
         end;

         if (bArquivoValido) then
            begin
               // Se o CNPJ destinatario é o da empresa selecionada para gerar o arquivo fiscal
               if (FacbrNFe.NotasFiscais.Items[0].NFe.Dest.CNPJCPF <> RemoveMascaraStr(Self.CnpjEmpresa)) then
                  begin
                     //GerarLinhaMemoLog('CNPJ Destinatário do documento de entrada difere da empresa (' + Self.CnpjEmpresa + '): ' + Trim(oListaArq[idx]));
                     bArquivoValido := False;
                  end;
            end;

         if (bArquivoValido) then
            begin
               // Se data ent_sai não está dentro do periodo selecionado
               if not ((FacbrNFe.NotasFiscais.Items[0].NFe.Ide.dEmi >= (DataInicial - 7)) and
                        (FacbrNFe.NotasFiscais.Items[0].NFe.Ide.dEmi <= DataFinal)) then
                  begin
                     //GerarLinhaMemoLog('A data de entrada "dEmi" do documento de entrada difere do periodo de apuração "' + FormatDateTime('dd.mm.yyyy', DataInicial) + '"' +
                     //                  ' até "' + FormatDateTime('dd.mm.yyyy', DataFinal) + '": ' + Trim(oListaArq[idx]));
                     bArquivoValido := False;
                  end;
            end;

         if (bArquivoValido) then
            begin
               // Se é documento modelo 55
               if (FacbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo <> 55) then
                  begin
                     GerarLinhaMemoLog('Modelo de documento de entrada difere de 55: ' + Trim(oListaArq[idx]));
                     bArquivoValido := False;
                  end;
            end;

        // Remove da lista o arquivo inválido
        if (not bArquivoValido) then
           oListaArq.Delete(idx);
      end;{for}

   // Limitação
   if (iLim > 0) then
      begin
         if (oListaArq.Count > 0) then
            begin
               while oListaArq.Count > iLim do
                  begin
                     oListaArq.Delete(0);
                  end;
            end;
      end;
end;

end.
