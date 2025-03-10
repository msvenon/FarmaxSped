unit uSpedFiscal;

interface

uses
    ACBrSpedFiscal, ACBrEFDBlocos, ACBrEFDBloco_0, Classes, SysUtils, ACBrEFDBloco_C, StdCtrls, DB, DBClient, Provider, uFuncoesBasicas, SQLExpr, ACBrNFe,
    ComCtrls, ACBrEFDBloco_E, ACBrEFDBloco_H, Forms, Windows, ACBrEFDBloco_D, ACBrEFDBloco_1, StrUtils, ACBrEFDBloco_K, uConstsGerais, ACBrBase, ACBrDFe,
    ACBrNFeNotasFiscais,
   // pcnNFe,
    pcnConversao, pcnConversaoNFe, Math, ACBrECF, ACBrDevice, IniFiles, TypInfo;

type
   TSpedFiscal = class(TComponent)
      procedure ACBrECFAguardandoRespostaChange(Sender: TObject);
      procedure ACBrECFChangeEstado(const EstadoAnterior, EstadoAtual: TACBrECFEstado);
      procedure ACBrECFMsgAguarde(const Mensagem: String);
      procedure ACBrECFMsgPoucoPapel(Sender: TObject);
   private
      FcompSpedFiscal: TACBrSPEDFiscal;{Componente que vai fazer o trabalho "pesado" gerar a estrutura do arquivo}
      FACBrSPEDECF: TACBrSPEDFiscal;
      FACBrECF: TACBrECF;
      FacbrNFe: TACBrNFe;
      FConexaoBase: TSQLconnection;
      FCodigoEmpresa: Integer;
      FOriginal: Boolean;
      FMemoErro: TMemo;
      FECF_RequerZ: Boolean;
      FListaArquivos: TStrings;

      FcdsResultExec : TClientDataSet;
      FTabelaEmpresa : TClientDataSet;
      FTabelaContador: TClientDataSet;
      FTabelaReg0150: TClientDataSet;
      FTabelaReg0190: TClientDataSet;
      FTabelaReg0200: TClientDataSet;
      FTabelaReg0220: TClientDataSet;
      FTabelaReg0400: TClientDataSet;
      FTabelaRegC100: TClientDataSet;
      FTabelaRegC170: TClientDataSet;
      FTabelaRegC190: TClientDataSet;
      FTabelaRegE510: TClientDataSet;
      FTabelaRegC500: TClientDataSet;
      FTabelaRegH010: TClientDataSet;
      FTabelaRegK200: TClientDataSet;
      FTabelaRegK230: TClientDataSet;
      FTabelaRegK235: TClientDataSet;
      FTabelaUFICMSST: TClientDataSet;

      FqTabelaRegC500: TSQLQuery;
      FqryResultExec: TSQLQuery;

      FdspResultExec: TDataSetProvider;
      FpTabelaRegC500: TDataSetprovider;

      FProgressBar: TProgressBar;
      FLocalSalvar: String;
      FDataFinal: TDateTime;
      FDataInicial: TDateTime;
      FlblStatus: TLabel;
      FLocalDocXml_NFE: String;
      FCodigIbgeUfEmpresa: Integer;
      FCnpjEmpresa: String;
      FcMun_Empresa: Integer;

      {Variáveis de parâmetros do SPED}
      FParamIndApurIPI: String;

      {Variáveis para Acumuladores Bloco E}
      FTOT_VL_ICMS_DEB: Double;
      FTOT_VL_ICMS_CRE: Double;
      FVL_TOT_ICMS_ST_NF_ENTRADA: Double;
      FVL_TOT_ICMS_ST_NF_SAIDA: Double;

      FExitemNotasComSubstituicaoTributaria: Boolean;
      FGerarCupomFiscal: Boolean;
      FLocalDocXml_NFCE: String;
      FLocalDocXml_FORN: String;
      FLocalArquivoMFDSPED: String;
      FArquivoMFDSPEDLocal: Boolean;
      FGerarBlocoK: Boolean;
      FGerarBlocoH: Boolean;
      FSemLimite: Boolean;

      function GetValorFieldDataSet(cds: TClientDataSet; const Campo: String): String;
      procedure SetSpedFiscal(const Value: TACBrSPEDFiscal);
      procedure OnErrorSpedFiscal(const MsgError: String); overload;
      procedure OnErrorSpedFiscal(const MsgError: AnsiString); overload;
      procedure SetMemoErro(const Value: TMemo);
      procedure SetEventoOnError;
      procedure IniciarControles;
      procedure SetLocalSalvar(const Value: String);
      procedure SetDataFinal(const Value: TDateTime);
      procedure SetDataInicial(const Value: TDateTime);

      procedure IncBar;
      procedure ClearBar;
      procedure IniciaBar(const iValueMaxBar: Integer);
      procedure AtualizarStatus(const Msg: String);
      procedure CriarTabelasTmpMem;
      procedure DestruirTabelasTmpMem;
      procedure CriarFieldsDataSets;
      function  ConfiguracoesValidasParaGerarSpedFiscal: Boolean;
      procedure GerarLinhaMemoLog(const LinhaLog: String);
      procedure ConfigurarVersaoLayout(Registro0000: TRegistro0000);
      function  GetCodPartByCnpjCpf(const CNPJCPF: String): String;
      function  GetCodNatReg0400ByCFOP(const CFOP: String): String;
      procedure ExecSQL(const SQL: String);
      function  ExisteCombinacaoRegistroAnalitico(const NFID: Integer; const CstIcms, Cfop: String; const AliqIcms: Currency): Boolean;
      function  InformacoesNFeValidasParaEscriturar(Notas: TNotasFiscais; const docEntrada: Boolean = False): Boolean;
      function  ConverterCFOPEntrada(const CFOPSaida, CodProduto, CodFornec: String): String;
      function  ConectarImpressoraECF(var sMsgRet: String): Boolean;
      function  ConverterEquivalenciaCSOSNToCST(const CSOSN: String; const TemAliqIcms: Boolean): String;
      procedure IncluirUnidProdReg0190(const UnidMedProd: String);
      procedure IncluirCodItemProdReg0200(const CodProd, DescrProd, EAN, UnidM, NCM: String; const pIcms: Double);
      procedure IncluirUnidFatConverReg0220(const CodProd, UnidConv, EAN: String; const dFatConv: Double);
      function  ChaveDuplicadaNaApuracao(const Chave: String): Boolean;
      function  NotaCancelada(const Chave: String): Boolean;
      function  AnoToVersao: TACBrVersaoLeiauteSPEDFiscal;

      procedure CarregarInformacoesEmpresa;
      procedure CarregarInformacoesContador;
      procedure CarregarParametrosSPED;
      procedure CarregarInformacoesNotasAguaEnergiaGaz_C500;

      procedure CarregarDocumentosXML;
      procedure AdicionarDadosParticipante(Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure AdicionarDadosProdutos(Notas: TNotasFiscais; const docEntrada: Boolean = False);
      function  AdicionarDadosNotas(Notas: TNotasFiscais; const docEntrada: Boolean = False): Integer;
      procedure AdicionarDadosItensNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure AdicionarDadosAnaliticosNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure AcumularValoresIPI(const CFOP, CST: String; const ValorBaseIPI, ValorIPI: Double);
      procedure FiltrarDocumentosFornecedores(oListaArq: TStringList; const iLim: Integer = 0);
      procedure AdicionarDadosProdutosCupomFiscal();
      procedure AcumularSaldoEstoque(const bEntrada: Boolean; const CodItem, Unid: String; const Qtde, VlUnit: Double;
            const DescrProd, EAN, UnidM, NCM: String; const pIcms: Double);
      procedure AdicionarDadosMovimentoEstoque(Notas: TNotasFiscais; const docEntrada: Boolean = False);
      procedure AcumularValorIcms_St(const ValorIcmsSt: Currency; const UF: String; const Entrada: Boolean = True);

      {Blocos}
      procedure GerarBloco_0;
      procedure GerarBloco_C;
      procedure GerarBloco_E;
      procedure GerarBloco_D;
      procedure GerarBloco_1;
      procedure GerarBloco_K;
      procedure GerarBloco_H;

      procedure SetCnpjEmpresa(const Value: String);
      function CFOP_DevolucaoCompra(const CFOPDevCompra: String): Boolean;
   public
      procedure GravaLog(Msg: String);
      function verificaDataInvetario(Data:string):TDate;
      procedure GerarAquivo;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure LimparTabela;

   published
      property CodigoEmpresa: Integer read FCodigoEmpresa write FCodigoEmpresa;
      property Original: Boolean read FOriginal write FOriginal; {False = Substituto}
      property GerarCupomFiscal: Boolean read FGerarCupomFiscal write FGerarCupomFiscal;
      property MemoErro: TMemo read FMemoErro write SetMemoErro;
      property ConexaoBase: TSQLconnection read FConexaoBase write FConexaoBase;
      property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
      property LocalSalvar: String read FLocalSalvar write SetLocalSalvar;
      property LocalDocXml_NFE: String read FLocalDocXml_NFE write FLocalDocXml_NFE;
      property LocalDocXml_NFCE: String read FLocalDocXml_NFCE write FLocalDocXml_NFCE;
      property LocalDocXml_FORN: String read FLocalDocXml_FORN write FLocalDocXml_FORN;
      property CnpjEmpresa: String read FCnpjEmpresa write SetCnpjEmpresa;
      property CodigIbgeUfEmpresa: Integer read FCodigIbgeUfEmpresa write FCodigIbgeUfEmpresa;
      property DataInicial: TDateTime read FDataInicial write SetDataInicial;
      property DataFinal: TDateTime read FDataFinal write SetDataFinal;
      property lblStatus: TLabel read FlblStatus write FlblStatus;
      property ArquivoMFDSPEDLocal: Boolean read FArquivoMFDSPEDLocal write FArquivoMFDSPEDLocal;
      property LocalArquivoMFDSPED: String read FLocalArquivoMFDSPED write FLocalArquivoMFDSPED;
      property GerarBlocoK: Boolean read FGerarBlocoK write FGerarBlocoK;
      property GerarBlocoH: Boolean read FGerarBlocoH write FGerarBlocoH;
      property SemLimite: Boolean read FSemLimite write FSemLimite;
   end;

implementation

{ TSpedFiscal }

uses udmPrincipal, uMenuPrincipal, System.UITypes, ACBrNFe.Classes,
  System.DateUtils, Vcl.Dialogs;

procedure TSpedFiscal.GravaLog(Msg: String);
var
  Data :string;
  ArquivoLog: textFile;
  NomeArquivo : String;
begin
  if not DirectoryExists(ExtractFilePath(Application.ExeName)+ '\LogsSped') then
      CreateDir(ExtractFilePath(Application.ExeName)+'\LogsSped');

  Data := FormatDateTime('ddmmYYYY',Now);
  NomeArquivo := ExtractFilePath(Application.ExeName) + '\LogsSped\LogFarmaxSped' + Data +'.txt';
  AssignFile(ArquivoLog, NomeArquivo); // Associa o arquivo

  if FileExists(NomeArquivo) then
    Append(ArquivoLog)
  else
    ReWrite(ArquivoLog);
    try

     WriteLn(ArquivoLog, '----------------------------------------------------------------------');
     WriteLn(ArquivoLog, 'Data: ' + DateToStr(Now) + ' - ' + 'Hora: ' + TimeToStr(Now) + ' - ' + 'Log: ' + Msg) ;

    finally
      CloseFile(ArquivoLog)
    end;
end;

procedure TSpedFiscal.ACBrECFAguardandoRespostaChange(Sender: TObject);
begin
   if (FACBrECF.AguardandoResposta) then
      GerarLinhaMemoLog('Leitura da ECF...');
end;

procedure TSpedFiscal.ACBrECFChangeEstado(const EstadoAnterior, EstadoAtual: TACBrECFEstado);
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

procedure TSpedFiscal.ACBrECFMsgAguarde(const Mensagem: String);
var
   sMsg: String;
begin
   sMsg := StringReplace(Mensagem,#10,' ',[rfReplaceAll]);
   if (Trim(sMsg) <> '') then
      GerarLinhaMemoLog(sMsg);
end;

procedure TSpedFiscal.ACBrECFMsgPoucoPapel(Sender: TObject);
begin
   GerarLinhaMemoLog(_MSG_POUCO_PAPEL);
end;

procedure TSpedFiscal.AcumularSaldoEstoque(const bEntrada: Boolean; const CodItem, Unid: String; const Qtde, VlUnit: Double;
     const DescrProd, EAN, UnidM, NCM: String; const pIcms: Double);
     var
      codigo:String;
begin

   if (Self.FGerarBlocoH) then
      begin

       { comentei em 06032025 porqu estava recebendo codigo de item com letras

          codigo := StringReplace(CodItem,'-','',[rfReplaceAll, rfIgnoreCase]) ;
          codigo := StringReplace(codigo,',','',[rfReplaceAll, rfIgnoreCase]) ;
          codigo := StringReplace(codigo,'.','',[rfReplaceAll, rfIgnoreCase]) ;


          dmPrincipal.FDSQL.SQL.Clear;
          dmPrincipal.FDSQL.sql.add(' SELECT COUNT(*)');
          dmPrincipal.FDSQL.sql.add(' FROM  RDB$RELATIONS');
          dmPrincipal.FDSQL.sql.add(' WHERE RDB$FLAGS=1 and RDB$RELATION_NAME=''TEMP_REG0200'' ');
          dmPrincipal.FDSQL.Open();


          if dmPrincipal.FDSQL.fields[0].value=0 then
              begin

                dmPrincipal.FDSQL.SQL.Clear;
                dmPrincipal.FDSQL.sql.add(' CREATE TABLE ');
                dmPrincipal.FDSQL.sql.add(' TEMP_REG0200 ');
                dmPrincipal.FDSQL.sql.add('   (CODIGO_ITEM DOUBLE PRECISION) ');
                dmPrincipal.FDSQL.ExecSQL;

                dmPrincipal.FDSQL.SQL.Clear;
                dmPrincipal.FDSQL.sql.add('CREATE INDEX ');
                dmPrincipal.FDSQL.sql.add(' TEMP_REG0200_IDX1');
                dmPrincipal.FDSQL.sql.add('   ON TEMP_REG0200 (CODIGO_ITEM)');
                dmPrincipal.FDSQL.ExecSQL;

                try

                 dmPrincipal.cdsConsTempReg0200.Close;
                 dmPrincipal.cdsConsTempReg0200.Open ;
                 dmPrincipal.cdsConsTempReg0200.Append;
                 dmPrincipal.cdsConsTempReg0200CODIGO_ITEM.Value:= codigo.ToDouble;
                 dmPrincipal.cdsConsTempReg0200.ApplyUpdates(0);

                except on E:Exception do

                  showmessage('erro aon incluir codigo tempreg0200:'+e.Message)
                end;


              end
           else
              begin
                try

                 dmPrincipal.cdsConsTempReg0200.Close;
                 dmPrincipal.cdsConsTempReg0200.Open ;
                 dmPrincipal.cdsConsTempReg0200.Append;
                 dmPrincipal.cdsConsTempReg0200CODIGO_ITEM.Value:= codigo.ToDouble;
                 dmPrincipal.cdsConsTempReg0200.ApplyUpdates(0);

                 except on E:Exception do

                  showmessage('erro aon incluir codigo tempreg0200:'+e.Message)
                end;



              end;  }





         FTabelaRegH010.Filtered := False;
         FTabelaRegH010.Filter := 'COD_ITEM = ' + QuotedStr(Trim(CodItem));
         FTabelaRegH010.Filtered := True;


         if (FTabelaRegH010.RecordCount > 0) then
            FTabelaRegH010.Edit
         else
            FTabelaRegH010.Append; // antes insert verificar se nao é append

         if (FTabelaRegH010.State = dsInsert) then
            begin
               FTabelaRegH010.FieldByName('COD_ITEM').AsString := CodItem;
               FTabelaRegH010.FieldByName('UNID').AsString := Unid ;
               FTabelaRegH010.FieldByName('QTD').AsFloat := Qtde;

               IncluirCodItemProdReg0200(CodItem,
                                         DescrProd,
                                         EAN,
                                         UnidM,
                                         NCM,
                                         pIcms);

               IncluirUnidProdReg0190(Unid);
            end;

         if (bEntrada) then
            FTabelaRegH010.FieldByName('QTD').AsFloat  := FTabelaRegH010.FieldByName('QTD').AsFloat + Qtde
         else // Saída
            FTabelaRegH010.FieldByName('QTD').AsFloat  := FTabelaRegH010.FieldByName('QTD').AsFloat - Qtde;

         FTabelaRegH010.FieldByName('VL_UNIT').AsFloat := VlUnit;
         FTabelaRegH010.FieldByName('VL_ITEM').AsFloat := (FTabelaRegH010.FieldByName('VL_UNIT').AsFloat *
                                                           FTabelaRegH010.FieldByName('QTD').AsFloat);

         FTabelaRegH010.Post;
         FTabelaRegH010.Filtered := False;
      end;
end;

procedure TSpedFiscal.AcumularValoresIPI(const CFOP, CST: String; const ValorBaseIPI, ValorIPI: Double);

    function ExisteCombinacaoCST_IPI: Boolean;
    begin
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
         FTabelaRegE510.FieldByName('CFOP').AsString    := Trim(CFOP);
         FTabelaRegE510.FieldByName('CST_IPI').AsString := CST;
      end;

   // Total Geral IPI
   FTabelaRegE510.FieldByName('VL_BC_IPI').AsFloat := FTabelaRegE510.FieldByName('VL_BC_IPI').AsFloat + ValorBaseIPI;
   FTabelaRegE510.FieldByName('VL_IPI').AsFloat    := FTabelaRegE510.FieldByName('VL_IPI').AsFloat + ValorIPI;

   if (StrToIntDef(Trim(CFOP), 0) > 5000) then
      begin
         // Total Saídas
         FTabelaRegE510.FieldByName('TIPO').AsString := 'S';
         FTabelaRegE510.FieldByName('VL_BC_IPI_S').AsFloat := FTabelaRegE510.FieldByName('VL_BC_IPI_S').AsFloat + ValorBaseIPI;
         FTabelaRegE510.FieldByName('VL_IPI_S').AsFloat    := FTabelaRegE510.FieldByName('VL_IPI_S').AsFloat + ValorIPI;
      end
   else
      begin
         // Total Entradas
         FTabelaRegE510.FieldByName('TIPO').AsString := 'E';
         FTabelaRegE510.FieldByName('VL_BC_IPI_E').AsFloat := FTabelaRegE510.FieldByName('VL_BC_IPI_E').AsFloat + ValorBaseIPI;
         FTabelaRegE510.FieldByName('VL_IPI_E').AsFloat    := FTabelaRegE510.FieldByName('VL_IPI_E').AsFloat + ValorIPI;
      end;

   FTabelaRegE510.Post;
   FTabelaRegE510.Filtered := False;
end;

procedure TSpedFiscal.AcumularValorIcms_St(const ValorIcmsSt: Currency; const UF: String; const Entrada: Boolean);
begin
  FTabelaUFICMSST.Filtered := False;
  try
    FTabelaUFICMSST.Filter := 'UF = ' + QuotedStr(UF);
    FTabelaUFICMSST.Filtered := True;

    if (FTabelaUFICMSST.RecordCount > 0) then
    begin
      FTabelaUFICMSST.Edit;
      if Entrada then
        FTabelaUFICMSST.FieldByName('VL_ICMS_ST_E').AsFloat := FTabelaUFICMSST.FieldByName('VL_ICMS_ST_E').AsFloat + ValorIcmsSt
      else
        FTabelaUFICMSST.FieldByName('VL_ICMS_ST_S').AsFloat := FTabelaUFICMSST.FieldByName('VL_ICMS_ST_S').AsFloat + ValorIcmsSt;
    end
    else
    begin
      FTabelaUFICMSST.Append;
      FTabelaUFICMSST.FieldByName('UF').AsString := UF;
      if Entrada then
        FTabelaUFICMSST.FieldByName('VL_ICMS_ST_E').AsFloat := ValorIcmsSt
      else
        FTabelaUFICMSST.FieldByName('VL_ICMS_ST_S').AsFloat := ValorIcmsSt;
    end;
    FTabelaUFICMSST.Post;
  finally
    FTabelaUFICMSST.Filtered := False;
  end;
end;

procedure TSpedFiscal.AdicionarDadosAnaliticosNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean = False);
var
   oItemProduto: TDetCollectionItem;
   Idx: Integer;
   cVlrOperacao,ImpostoItem: Currency;
   sCFOP: String;
   sCstIcms: String;
   dValorBCRed: Double;
begin
   GerarLinhaMemoLog('Carregando dados analíticos da ' + Notas.Items[0].NFe.infNFe.ID);

   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemProduto := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];

         if (docEntrada) then
            begin
               if (Notas.Items[0].NFe.Emit.CRT <> crtRegimeNormal) then
                 sCstIcms := ConverterEquivalenciaCSOSNToCST( CSOSNIcmsToStr(oItemProduto.Imposto.ICMS.CSOSN), (oItemProduto.Imposto.ICMS.pICMS > 0) )
               else
                 sCstIcms := CSTICMSToStr(oItemProduto.Imposto.ICMS.CST);

               sCFOP := ConverterCFOPEntrada(oItemProduto.Prod.CFOP, '', '');
            end
         else
            begin
               if (Notas.Items[0].NFe.Emit.CRT = crtRegimeNormal) then
                  sCstIcms := CSTICMSToStr(oItemProduto.Imposto.ICMS.CST)
               else
                  sCstIcms := CSOSNIcmsToStr(oItemProduto.Imposto.ICMS.CSOSN);

               sCFOP := oItemProduto.Prod.CFOP;
            end;


         if (sCFOP='1403') and (oItemProduto.Imposto.ICMS.pICMS <>20) then
           begin
            oItemProduto.Imposto.ICMS.pICMS:=20;
           end;


         // Se existir a combinação ja filtra para o registro

         if (ExisteCombinacaoRegistroAnalitico(NFID, sCstIcms, sCFOP, oItemProduto.Imposto.ICMS.pICMS)) then
            FTabelaRegC190.Edit
         else
            FTabelaRegC190.Append;

         if (FTabelaRegC190.State = dsInsert) then
            begin
               FTabelaRegC190.FieldByName('NFID').AsInteger       := NFID;
               FTabelaRegC190.FieldByName('CST_ICMS').AsString    := sCstIcms;
               FTabelaRegC190.FieldByName('CFOP').AsString        := sCFOP;
               FTabelaRegC190.FieldByName('ALIQ_ICMS').AsCurrency := oItemProduto.Imposto.ICMS.pICMS;
               FTabelaRegC190.FieldByName('UF').AsString          := CUFtoUF(Notas.Items[0].NFe.Ide.cUF);
            end;

         FTabelaRegC190.FieldByName('VL_BC_ICMS').AsCurrency    := FTabelaRegC190.FieldByName('VL_BC_ICMS').AsCurrency    + oItemProduto.Imposto.ICMS.vBC;
         FTabelaRegC190.FieldByName('VL_ICMS').AsCurrency       := FTabelaRegC190.FieldByName('VL_ICMS').AsCurrency       + oItemProduto.Imposto.ICMS.vICMS;
         FTabelaRegC190.FieldByName('VL_BC_ICMS_ST').AsCurrency := FTabelaRegC190.FieldByName('VL_BC_ICMS_ST').AsCurrency + oItemProduto.Imposto.ICMS.vBCST;
         FTabelaRegC190.FieldByName('VL_ICMS_ST').AsCurrency    := FTabelaRegC190.FieldByName('VL_ICMS_ST').AsCurrency    + oItemProduto.Imposto.ICMS.vICMSST;

         if (sCstIcms = '10') or
            (sCstIcms = '30') or
            (sCstIcms = '70') or
            (sCstIcms = '201') or
            (sCstIcms = '202') then
         begin
           { Soma do campo VL_ICMS_ST do registro C190 (demais CFOPs), quando o primeiro caractere do campo CFOP for ‘1’ ou ‘2’
             exceto se o valor do campo CFOP for 1410, 1411, 1414, 1415, 1660, 1661, 1662, 2410, 2411, 2414, 2415, 2660, 2661 ou 2662. }
           if Pos(sCFOP, '1410, 1411, 1414, 1415, 1660, 1661, 1662, 2410, 2411, 2414, 2415, 2660, 2661, 2662') <= 0  then //1401,1403, mau retirei 24072024
             AcumularValorIcms_St(oItemProduto.Imposto.ICMS.vICMSST, FTabelaRegC190.FieldByName('UF').AsString, docEntrada);
         end;

         dValorBCRed := RoundTo((oItemProduto.Prod.vProd - oItemProduto.Prod.vDesc) * (oItemProduto.Imposto.ICMS.pRedBC/100), -2);

         FTabelaRegC190.FieldByName('VL_RED_BC').AsCurrency := FTabelaRegC190.FieldByName('VL_RED_BC').AsCurrency + dValorBCRed;

         FTabelaRegC190.FieldByName('VL_IPI').AsCurrency := FTabelaRegC190.FieldByName('VL_IPI').AsCurrency + oItemProduto.Imposto.IPI.vIPI;

         cVlrOperacao := (
                           (oItemProduto.Prod.vProd +
                            oItemProduto.Prod.vFrete +
                            oItemProduto.Prod.vSeg +
                            oItemProduto.Prod.vOutro +
                            oItemProduto.Imposto.IPI.vIPI +
                            oItemProduto.Imposto.ICMS.vICMSST +
                            oItemProduto.Imposto.ICMS.vFCPST) -
                            oItemProduto.Prod.vDesc
                          );

         FTabelaRegC190.FieldByName('VL_OPR').AsCurrency := FTabelaRegC190.FieldByName('VL_OPR').AsCurrency + cVlrOperacao;

         FTabelaRegC190.FieldByName('COD_OBS').AsString := '';
         
         FTabelaRegC190.Post;
         FTabelaRegC190.Filtered := False;
      end;
end;

procedure TSpedFiscal.AdicionarDadosItensNotas(const NFID: Integer; Notas: TNotasFiscais; const docEntrada: Boolean = False);
var
   oItemProduto: TDetCollectionItem;
   Idx: Integer;

begin
  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.Open;

   GerarLinhaMemoLog('Carregando ' + IntToStr(Notas.Items[ 0 ].NFe.Det.Count) + ' itens da ' + Notas.Items[0].NFe.infNFe.ID);

   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemProduto := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];

         FTabelaRegC170.Append;
         FTabelaRegC170.FieldByName('NFID').AsInteger       := NFID;
         FTabelaRegC170.FieldByName('NUM_ITEM').AsString    := IntToStr(Idx + 1);
         FTabelaRegC170.FieldByName('COD_ITEM').AsString    := oItemProduto.Prod.cProd;
         FTabelaRegC170.FieldByName('DESCR_COMPL').AsString := Copy(oItemProduto.Prod.xProd,1,60);
         FTabelaRegC170.FieldByName('QTD').AsFloat          := oItemProduto.Prod.qCom;
         FTabelaRegC170.FieldByName('UNID').AsString        := 'UN';//MAURICIO oItemProduto.Prod.uCom;
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
            begin
               if (Notas.Items[0].NFe.Emit.CRT <> crtRegimeNormal) then
                  FTabelaRegC170.FieldByName('CST_ICMS').AsString := ConverterEquivalenciaCSOSNToCST( CSOSNIcmsToStr(oItemProduto.Imposto.ICMS.CSOSN), (oItemProduto.Imposto.ICMS.pICMS > 0) )
               else
                  FTabelaRegC170.FieldByName('CST_ICMS').AsString := CSTICMSToStr(oItemProduto.Imposto.ICMS.CST);

               FTabelaRegC170.FieldByName('CFOP').AsString := ConverterCFOPEntrada(oItemProduto.Prod.CFOP, '', '');
            end
         else
            begin
               if (Notas.Items[0].NFe.Emit.CRT = crtRegimeNormal) then
                  FTabelaRegC170.FieldByName('CST_ICMS').AsString := CSTICMSToStr(oItemProduto.Imposto.ICMS.CST)
               else
                  FTabelaRegC170.FieldByName('CST_ICMS').AsString := CSOSNIcmsToStr(oItemProduto.Imposto.ICMS.CSOSN);

               FTabelaRegC170.FieldByName('CFOP').AsString := oItemProduto.Prod.CFOP;
            end;


         FTabelaRegC170.FieldByName('COD_NAT').AsString      := GetCodNatReg0400ByCFOP(oItemProduto.Prod.CFOP);
         FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat    := oItemProduto.Imposto.ICMS.vBC;
         FTabelaRegC170.FieldByName('ALIQ_ICMS').AsFloat     := oItemProduto.Imposto.ICMS.pICMS;
         FTabelaRegC170.FieldByName('VL_ICMS').AsFloat       := oItemProduto.Imposto.ICMS.vICMS;
         FTabelaRegC170.FieldByName('VL_BC_ICMS_ST').AsFloat := oItemProduto.Imposto.ICMS.vBCST;
         FTabelaRegC170.FieldByName('ALIQ_ST').AsFloat       := oItemProduto.Imposto.ICMS.pICMSST;
         FTabelaRegC170.FieldByName('VL_ICMS_ST').AsFloat    := oItemProduto.Imposto.ICMS.vICMSST;

         // IPI
         if (FParamIndApurIPI = dmPrincipal.cdsConsEmpresaPERIODO_IPI.Value) then // 0 - Mensal; 1 - Decendial
            FTabelaRegC170.FieldByName('IND_APUR').Asinteger := 0
         else
            FTabelaRegC170.FieldByName('IND_APUR').Asinteger := 1;

         if (docEntrada) then
            FTabelaRegC170.FieldByName('CST_IPI').AsString := '49' // Outras entradas
         else
         FTabelaRegC170.FieldByName('CST_IPI').AsString  := CSTIPIToStr(oItemProduto.Imposto.IPI.CST);
         FTabelaRegC170.FieldByName('COD_ENQ').AsString  := ''; //Não preencher - segundo o manual;
         FTabelaRegC170.FieldByName('VL_BC_IPI').AsFloat := oItemProduto.Imposto.IPI.vBC;
         FTabelaRegC170.FieldByName('ALIQ_IPI').AsFloat  := oItemProduto.Imposto.IPI.pIPI;
         FTabelaRegC170.FieldByName('VL_IPI').AsFloat    := oItemProduto.Imposto.IPI.vIPI;

         if (FcompSpedFiscal.Bloco_0.Registro0000.IND_ATIV = atOutros) then
            AcumularValoresIPI(oItemProduto.Prod.CFOP, CSTIPIToStr(oItemProduto.Imposto.IPI.CST), oItemProduto.Imposto.IPI.vBC, oItemProduto.Imposto.IPI.vIPI);

         // PIS
         FTabelaRegC170.FieldByName('CST_PIS').AsString     := CSTPISToStr(oItemProduto.Imposto.PIS.CST);
         FTabelaRegC170.FieldByName('VL_BC_PIS').AsFloat    := oItemProduto.Imposto.PIS.vBC;
         FTabelaRegC170.FieldByName('ALIQ_PIS_PERC').AsFloat:= oItemProduto.Imposto.PIS.pPIS;
         FTabelaRegC170.FieldByName('QUANT_BC_PIS').AsFloat := 0;
         FTabelaRegC170.FieldByName('ALIQ_PIS_R').AsFloat   := 0; //EM REAIS
         FTabelaRegC170.FieldByName('VL_PIS').AsFloat       := oItemProduto.Imposto.PIS.vPIS;

         // COFINS
         FTabelaRegC170.FieldByName('CST_COFINS').AsString      := CSTCOFINSToStr(oItemProduto.Imposto.COFINS.CST);
         FTabelaRegC170.FieldByName('VL_BC_COFINS').AsFloat     := oItemProduto.Imposto.COFINS.vBC;
         FTabelaRegC170.FieldByName('ALIQ_COFINS_PERC').AsFloat := oItemProduto.Imposto.COFINS.pCOFINS;
         FTabelaRegC170.FieldByName('QUANT_BC_COFINS').AsFloat  := 0;
         FTabelaRegC170.FieldByName('ALIQ_COFINS_R').AsFloat    := 0; //EM REAIS
         FTabelaRegC170.FieldByName('VL_COFINS').AsFloat        := oItemProduto.Imposto.COFINS.vCOFINS;
         FTabelaRegC170.FieldByName('COD_CTA').AsString         := '';
         FTabelaRegC170.Post;
      end;// for
end;

procedure TSpedFiscal.AdicionarDadosMovimentoEstoque(Notas: TNotasFiscais; const docEntrada: Boolean);
var
   oItemProduto: TDetCollectionItem;
   Idx: Integer;
begin
   GerarLinhaMemoLog('Carregando dados para movimento de estoque - inventário: ' + Notas.Items[0].NFe.infNFe.ID);
   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemProduto := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];    //mezer aqui
         AcumularSaldoEstoque( docEntrada,
                              oItemProduto.Prod.cProd,
                              'UN',//oItemProduto.Prod.uCom, // mauricio 14022024
                              oItemProduto.Prod.qCom,
                              oItemProduto.Prod.vUnCom,
                              oItemProduto.Prod.xProd,
                              oItemProduto.Prod.cEAN,
                              'UN',//FloatToStr(oItemProduto.Prod.vUnCom), //  mauricio 14022024
                              oItemProduto.Prod.NCM,
                              oItemProduto.Imposto.ICMS.pICMS);
      end;{for}
end;

function TSpedFiscal.AdicionarDadosNotas(Notas: TNotasFiscais; const docEntrada: Boolean = False): Integer;
var
   sCNPJCPF: String;
   sChave,ModeloNota: String;
begin
   try
      FTabelaRegC100.Filtered := False;
      Result := (FTabelaRegC100.RecordCount + 1);
      sChave := StringReplace(Notas.Items[0].NFe.infNFe.ID,'NFe',EmptyStr,[rfIgnoreCase]);
      FTabelaRegC100.Filter := 'CHV_NFE = ' + QuotedStr(sChave);
      FTabelaRegC100.Filtered := True;

      ModeloNota:=IntToStr(Notas.Items[0].NFe.Ide.modelo);

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

          //  if Notas.Items[0].NFe.Ide.dEmi  DataInicial then
               Notas.Items[0].NFe.Ide.dEmi := DataInicial;

            FTabelaRegC100.FieldByName('COD_PART').AsString := GetCodPartByCnpjCpf(sCNPJCPF); //Nfce não informa COD_PART
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

            FTabelaRegC100.FieldByName('VL_DESC').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vDesc;
            FTabelaRegC100.FieldByName('VL_ABAT_NT').AsFloat := 0;
            FTabelaRegC100.FieldByName('VL_MERC').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vProd;
            {Legenda
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

            FTabelaRegC100.FieldByName('VL_FRT').AsFloat     := Notas.Items[0].NFe.Total.ICMSTot.vFrete;
            FTabelaRegC100.FieldByName('VL_SEG').AsFloat     := Notas.Items[0].NFe.Total.ICMSTot.vSeg;
            FTabelaRegC100.FieldByName('VL_OUT_DA').AsFloat  := Notas.Items[0].NFe.Total.ICMSTot.vOutro;
            FTabelaRegC100.FieldByName('VL_BC_ICMS').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vBC;
            FTabelaRegC100.FieldByName('VL_ICMS').AsFloat    := Notas.Items[0].NFe.Total.ICMSTot.vICMS;

            if Notas.Items[0].NFe.Ide.modelo <> 65  then
               begin
                  FTabelaRegC100.FieldByName('VL_BC_ICMS_ST').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vBCST;
                  FTabelaRegC100.FieldByName('VL_ICMS_ST').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vST;
                  FTabelaRegC100.FieldByName('VL_IPI').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vIPI;
                  FTabelaRegC100.FieldByName('VL_PIS').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vPIS;
                  FTabelaRegC100.FieldByName('VL_COFINS').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vCOFINS;
               end;

           if (Notas.Items[0].NFe.Ide.modelo = 65) then
              begin

               FTabelaRegC100.FieldByName('VL_BC_ICMS_ST').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vBCST;
               FTabelaRegC100.FieldByName('VL_ICMS_ST').AsFloat := Notas.Items[0].NFe.Total.ICMSTot.vST;

              end;


            FTabelaRegC100.FieldByName('VL_PIS_ST').AsFloat := 0;
            FTabelaRegC100.FieldByName('VL_COFINS_ST').AsFloat := 0;
            FTabelaRegC100.Post;
         end
      else
         Result := 0;
   finally
      FTabelaRegC100.Filtered := False;
   end;
end;

procedure TSpedFiscal.AdicionarDadosParticipante(Notas: TNotasFiscais; const docEntrada: Boolean = False);
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
   sChave: String;

begin
   sChave := StringReplace(Notas.Items[0].NFe.infNFe.ID,'NFe',EmptyStr,[rfIgnoreCase]);

   // Para documentos de saida NFCe - 65 não adicionar nos participantes
   if (Notas.Items[0].NFe.Ide.modelo = 65) then
      Exit;

   if NotaCancelada(sChave) then
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
            icPais   :=  Notas.Items[0].NFe.Emit.EnderEmit.cPais;
            sIE      := Notas.Items[0].NFe.Emit.IE;
            icMun    := Notas.Items[0].NFe.Emit.EnderEmit.cMun;
            sxLgr    := Notas.Items[0].NFe.Emit.EnderEmit.xLgr;
            snro     := Copy(Notas.Items[0].NFe.Emit.EnderEmit.nro,1,60);
            sxCpl    := Copy(Notas.Items[0].NFe.Emit.EnderEmit.xCpl,1,60);
            sxBairro := Copy(Notas.Items[0].NFe.Emit.EnderEmit.xBairro,1,60);
         end;

      FTabelaReg0150.Filtered := False;
      iProxSeqCod := (FTabelaReg0150.RecordCount + 1);
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

            FTabelaReg0150.FieldByName('COD_PAIS').AsString := IntToStr(icPais);
            FTabelaReg0150.FieldByName('CNPJCPF').AsString := sCNPJCPF;
            FTabelaReg0150.FieldByName('IE').AsString := sIE;
            if icMun = 0 then
               FTabelaReg0150.FieldByName('COD_MUN').AsInteger := FcMun_Empresa
            else
               FTabelaReg0150.FieldByName('COD_MUN').AsInteger := icMun;

            if Trim(sxLgr) = '' then
               FTabelaReg0150.FieldByName('ENDERECO').AsString := 'LOGRADOURO NÃO CADASTRADO'
            else
               FTabelaReg0150.FieldByName('ENDERECO').AsString := sxLgr;
            FTabelaReg0150.FieldByName('NUM').AsString := snro;
            FTabelaReg0150.FieldByName('COMPL').AsString := sxCpl;
            FTabelaReg0150.FieldByName('BAIRRO').AsString := sxBairro;

            FTabelaReg0150.Post;
         end;
   finally
      FTabelaReg0150.Filtered := False;
   end;
end;

procedure TSpedFiscal.AdicionarDadosProdutos(Notas: TNotasFiscais; const docEntrada: Boolean = False);
var
   oItemProduto: TDetCollectionItem;
   Idx,
   iProxSeqCodNat: Integer;
begin
   if (not docEntrada) then
      begin
         // Documentos 55 ou 65 emitidos pela empresa não escritura itens
         if (Notas.Items[0].NFe.Emit.CNPJCPF = Self.FCnpjEmpresa) and ((Notas.Items[0].NFe.Ide.modelo = 55) or (Notas.Items[0].NFe.Ide.modelo = 65)) then
            Exit;
      end;

   GerarLinhaMemoLog('Carregando dados de produtos/serviços da ' + Notas.Items[0].NFe.infNFe.ID);
   for Idx := 0 to Notas.Items[ 0 ].NFe.Det.Count -1 do
      begin
         oItemProduto := Notas.Items[ 0 ].NFe.Det.Items[ Idx ];

         //** Tabela Unidade de medidas
         IncluirUnidProdReg0190(oItemProduto.Prod.uCom);

         //** Tabela de Identificação do Item (Produtos e Serviços)
         IncluirCodItemProdReg0200(oItemProduto.Prod.cProd,
                                   oItemProduto.Prod.xProd,
                                   oItemProduto.Prod.cEAN,
                                   'UN',//mauricio oItemProduto.Prod.uCom,
                                   oItemProduto.Prod.NCM,
                                   oItemProduto.Imposto.ICMS.pICMS);

         //** Tabela de Natureza da operação
         try
            FTabelaReg0400.Filtered := False;
            iProxSeqCodNat := (FTabelaReg0400.RecordCount + 1);
            FTabelaReg0400.Filter := 'CFOP = ' + QuotedStr(oItemProduto.Prod.CFOP);
            FTabelaReg0400.Filtered := True;

            if (FTabelaReg0400.IsEmpty) then
               begin
                  FTabelaReg0400.Append;
                  FTabelaReg0400.FieldByName('COD_NAT').AsInteger := iProxSeqCodNat;
                  FTabelaReg0400.FieldByName('CFOP').AsString := oItemProduto.Prod.CFOP;
                  FTabelaReg0400.FieldByName('DESCR_NAT').AsString := 'NATUREZA DA OPERAÇÃO ' + oItemProduto.Prod.CFOP;
                  FTabelaReg0400.Post;
               end;
         finally
            FTabelaReg0400.Filtered := False;
         end;
      end; // For itens nota
end;

procedure TSpedFiscal.AdicionarDadosProdutosCupomFiscal;
var
    RegistroC400List: TRegistroC400List;
    RegistroC425List: TRegistroC425List;
    RegistroC460List: TRegistroC460List;
    RegistroC490List: TRegistroC490List;
    indxC400: Integer;
    indxC405: Integer;
    indxC460: Integer;
    indxC470: Integer;

    sCodItem: String;
    sNCM: String;
    sDescrProd: String;
    sUnidM: String;
    dQtde: Double;
    dpIcms: Double;
    dVlrItem: Double;
    iCountLimite: Integer;

//var
//   Registro0200List: TRegistro0200List;
//   indxProd: Integer;
begin
//   if (DebugHook = 0) and (not Self.FSemLimite) then
//      iCountLimite := _LIM_DOC
//   else
      iCountLimite := 0;

//   FTabelaReg0200.First;
//   sNCM := RemoveMascaraStr(FTabelaReg0200.FieldByName('COD_NCM').AsString);
//
//   GerarLinhaMemoLog('Iniciando carregar informações registros 0200 e 0190 ');
//    if (FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.Count = 0) then
//       GerarLinhaMemoLog('Não encontrado movimentos de cupom fiscal para carregar informações registros 0200 e 0190! (RegistroC400.Count = 0)')
//    else
//       begin
//         RegistroC400List := FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400;
//         for indxC400 := 0 to RegistroC400List.Count - 1 do
//            begin
//               {C405}
//               for indxC405 := 0 to RegistroC400List.items[indxC400].RegistroC405.Count - 1 do
//                  begin
//                     if (iCountLimite > 0) then
//                        if ((indxC405 + 1) > iCountLimite) then
//                           Break;
//
//                     {C460}
//                     RegistroC460List := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC460;
//                     for indxC460 := 0 to RegistroC460List.Count - 1 do
//                        begin
//                           {C470}
//                           for indxC470 := 0 to RegistroC460List.Items[indxC460].RegistroC470.Count - 1 do
//                              begin
//                                 sCodItem := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].COD_ITEM;
//                                 sDescrProd := 'PRODUTO ECF ' + sCodItem;
//                                 dQtde := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].QTD;
//                                 sUnidM := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].UNID;
//                                 dVlrItem := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].VL_ITEM;
//                                 dpIcms := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].ALIQ_ICMS;
//
//
//                                 // Acumular saldo de estoque ja inclui o Unidade Medida e Produtos
//                                 if (Self.FGerarBlocoH) then
//                                    AcumularSaldoEstoque(False,
//                                                         sCodItem,
//                                                         sUnidM,
//                                                         dQtde,
//                                                         dVlrItem,
//                                                         sDescrProd,
//                                                         '',//cEAN,
//                                                         'UN',//sUnidM,
//                                                         sNCM,
//                                                         dpIcms)
//                                 else
//                                    begin
//                                       IncluirCodItemProdReg0200(sCodItem,
//                                                                 sDescrProd,
//                                                                 '',//EAN,
//                                                                 'UN',//sUnidM,
//                                                                 sNCM,
//                                                                 dpIcms);
//
//                                        IncluirUnidProdReg0190(sUnidM);
//                                    end;
//                              end; {for C470}
//
//                        end; {for C460}
//                  end; {for C405}
//            end;{for C400}
//       end;


{$region}
  (* Versão buscando dos registros 0200 e 0190 do MFD
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
                  FTabelaReg0190.Filtered := False;
                  FTabelaReg0190.Filter := 'UNID = ' + QuotedStr(Registro0200List.Items[indxProd].UNID_INV);
                  FTabelaReg0190.Filtered := True;
                  if (FTabelaReg0190.IsEmpty) then
                     begin
                        FTabelaReg0190.Append;
                        FTabelaReg0190.FieldByName('UNID').AsString := Registro0200List.Items[indxProd].UNID_INV;
                        FTabelaReg0190.FieldByName('DESCR').AsString := 'UNIDADE MEDIDA ' + Registro0200List.Items[indxProd].UNID_INV;
                        FTabelaReg0190.Post;
                     end;
               finally
                  FTabelaReg0190.Filtered := False;
               end;

               //** Tabela de Identificação do Item (Produtos e Serviços)
               try
                  FTabelaReg0200.Filtered := False;
                  FTabelaReg0200.Filter := 'COD_ITEM = ' + QuotedStr(Registro0200List.Items[indxProd].COD_ITEM);
                  FTabelaReg0200.Filtered := True;
                  if FTabelaReg0200.IsEmpty then
                     begin
                        FTabelaReg0200.Append;
                        FTabelaReg0200.FieldByName('TIPO_ITEM').AsString := 'P'; // S = Serviços e P = Produtos
                        FTabelaReg0200.FieldByName('COD_ITEM').AsString := Registro0200List.Items[indxProd].COD_ITEM;
                        FTabelaReg0200.FieldByName('DESCR_ITEM').AsString := Registro0200List.Items[indxProd].DESCR_ITEM;
                        FTabelaReg0200.FieldByName('COD_BARRA').AsString := Registro0200List.Items[indxProd].COD_BARRA;
                        FTabelaReg0200.FieldByName('COD_ANT_ITEM').AsString := '';
                        FTabelaReg0200.FieldByName('UNID_INV').AsString := Registro0200List.Items[indxProd].UNID_INV;
                        FTabelaReg0200.FieldByName('COD_NCM').AsString := Registro0200List.Items[indxProd].COD_NCM;
                        FTabelaReg0200.FieldByName('ALIQ_ICMS').AsFloat := Registro0200List.Items[indxProd].ALIQ_ICMS;
                        FTabelaReg0200.Post;
                     end;
               finally
                  FTabelaReg0200.Filtered := False;
               end;
            end; {for Registro0200List}
      end;
*)
{$endregion}
end;

function TSpedFiscal.AnoToVersao: TACBrVersaoLeiauteSPEDFiscal;
var
  xVer: string;
begin
   if (DataInicial >= StrToDate('01/01/2009')) and (DataFinal <= StrToDate('31/12/2009')) then
    xVer := '002'
  else if (DataInicial >= StrToDate('01/01/2010')) and (DataFinal <= StrToDate('31/12/2010')) then
    xVer := '003'
  else if (DataInicial >= StrToDate('01/01/2011')) and (DataFinal <= StrToDate('31/12/2011')) then
    xVer := '004'
  else if (DataInicial >= StrToDate('01/01/2012')) and (DataFinal <= StrToDate('30/06/2012')) then
    xVer := '005'
  else if (DataInicial >= StrToDate('01/07/2012')) and (DataFinal <= StrToDate('31/12/2012')) then
    xVer := '006'
  else if (DataInicial >= StrToDate('01/01/2013')) and (DataFinal <= StrToDate('31/12/2013')) then
    xVer := '007'
  else if (DataInicial >= StrToDate('01/01/2014')) and (DataFinal <= StrToDate('31/12/2014')) then
    xVer := '008'
  else if (DataInicial >= StrToDate('01/01/2015')) and (DataFinal <= StrToDate('31/12/2015')) then
    xVer := '009'
  else if (DataInicial >= StrToDate('01/01/2016')) and (DataFinal <= StrToDate('31/12/2016')) then
    xVer := '010'
  else if (DataInicial >= StrToDate('01/01/2017')) and (DataFinal <= StrToDate('31/12/2017')) then
    xVer := '011'
  else if (DataInicial >= StrToDate('01/01/2018')) and (DataFinal <= StrToDate('31/12/2018')) then
    xVer := '012'
  else if (DataInicial >= StrToDate('01/01/2019')) and (DataFinal <= StrToDate('31/12/2019')) then
    xVer := '013'
  else if (DataInicial >= StrToDate('01/01/2020')) and (DataFinal <= StrToDate('31/12/2020')) then
    xVer := '014'
  else if (DataInicial >= StrToDate('01/01/2021')) and (DataFinal <= StrToDate('31/12/2021')) then
    xVer := '015'
  else if (DataInicial >= StrToDate('01/01/2022')) and (DataFinal <= StrToDate('31/12/2022')) then
    xVer := '016'
  else if (DataInicial >= StrToDate('01/01/2023')) and (DataFinal <= StrToDate('31/12/2023')) then
    xVer := '017'
  else if (DataInicial >= StrToDate('01/01/2024')) and (DataFinal <= StrToDate('31/12/2024')) then
    xVer := '018'
  else if (DataInicial >= StrToDate('01/01/2025')) and (DataFinal <= StrToDate('31/12/2025')) then
    xVer := '019' ;

   Result := StrToCodVer(xVer);

end;

procedure TSpedFiscal.AtualizarStatus(const Msg: String);
var
   sPercentual: String;
begin

   if (Assigned(FlblStatus) and Assigned(FProgressBar)) then
      begin
         sPercentual := '0 %';

         if (FProgressBar.Max > 0) then
            begin
               sPercentual := Formatfloat('000', (FProgressBar.Position * 100) / FProgressBar.Max);
               sPercentual := FloatToStr(StrToFloat(sPercentual)) + ' %';
            end;

         FlblStatus.Caption := Msg + '  ' + FormatFloat(',#0', FProgressBar.Position) + '  de  '+
                                 FormatFloat(',#0', FProgressBar.Max) + '           ' + sPercentual;

         Application.ProcessMessages;
      end;
end;

procedure TSpedFiscal.GerarBloco_D;
begin
   {
    Telefone - D500, D510, D530 e D590
    Dentro do D500 deve ser informado tb o Código do tipo do Assinante.
   }
end;

procedure TSpedFiscal.CarregarDocumentosXML;
var
   sFiltroDocEmitido: String;
   Ano, Mes, Dia: Word;
   iDx,
   iIDNota: Integer;
   sChave: String;
   sMsgECF: String;
   dtFinalMovCupons: TDateTime;
   sNomeArquivoMFD: String;
   sPathArquivoMFD: String;
   olstDadosUltimaReducaoZ: TStrings;
   sDataAux: String;
   dtDataHoraUltimaReducaoZ: TDateTime;
   iAux: Integer;
   iCountLimite: Integer;
begin

//   if (DebugHook = 0) and (not Self.FSemLimite) then
//      iCountLimite := _LIM_DOC
//   else
      iCountLimite := 0;

   Screen.Cursor := crHourglass;

   // ** Documentos próprios emitidos pela empresa
   DecodeDate(Self.FcompSpedFiscal.DT_INI, Ano, Mes , Dia);
  // sFiltroDocEmitido := IntToStr(Self.CodigIbgeUfEmpresa) + Copy(IntToStr(Ano), 3, 2) + FormatFloat('00', Mes) + Self.CnpjEmpresa ;//+ '*'; 16072024
   sFiltroDocEmitido := IntToStr(Self.CodigIbgeUfEmpresa) + Copy(IntToStr(Ano), 3, 2) + FormatFloat('00', Mes) + Self.CnpjEmpresa ;//+ '*';

   GerarLinhaMemoLog('Carregando arquivos xml NFE: ' + Self.LocalDocXml_NFE);
   GerarLinhaMemoLog('Filtro dos arquivos: ' + sFiltroDocEmitido);

   //ObterListaAqruivosDiretorio(Self.LocalDocXml_NFE, 'xml', TStringList(FListaArquivos), sFiltroDocEmitido, True, iCountLimite);
   ObterListaAqruivosDiretorio(Self.LocalDocXml_NFE, 'xml', TStringList(FListaArquivos), '*', True, iCountLimite);
   GerarLinhaMemoLog('Total documentos xml NFE emitidas Danfer: ' + IntToStr(FListaArquivos.Count));
   iAux := FListaArquivos.Count;

   GerarLinhaMemoLog('Carregando arquivos xml NFCE: ' + Self.LocalDocXml_NFCE);
   ObterListaAqruivosDiretorio(Self.LocalDocXml_NFCE, 'xml', TStringList(FListaArquivos), '*', True, iCountLimite);  //sFiltroDocEmitido
   iDx := FListaArquivos.Count;

   GerarLinhaMemoLog('Total documentos xml NFCE emitidas: ' + IntToStr(FListaArquivos.Count - iAux));

   application.ProcessMessages;

   AtualizarStatus('Carregando informações de NFE e NFCE...');
   IniciaBar(FListaArquivos.Count);
   for iDx := 0 to FListaArquivos.Count - 1 do
      begin

         IncBar;
         GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);

         //Load XML nfe - nfce Componente ACBrNFe;
         sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));
         AtualizarStatus('Carregando informações do doc XMLs: ');

         if (Copy(sChave, 21, 2) = '55') or (Copy(sChave, 21, 2) = '65') then
            begin
               try
                  GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);
                  FacbrNFe.NotasFiscais.Clear;
                  FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

                 if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais) then
                     begin
                        // Adicionar dados Participante
                        AdicionarDadosParticipante(FacbrNFe.NotasFiscais);

                        // Adicionar dados dos produtos
                        AdicionarDadosProdutos(FacbrNFe.NotasFiscais);

                        // Lança estoque para inventario
                       //  AdicionarDadosMovimentoEstoque(FacbrNFe.NotasFiscais);   comentei pra pegar do posicao estoque

                        // Adicionar dados do cabeçalho dos documentos
                        iIDNota := AdicionarDadosNotas(FacbrNFe.NotasFiscais);
                        if (iIDNota > 0) then;
                           begin

                              // Adicionar itens
                              AdicionarDadosItensNotas(iIDNota, FacbrNFe.NotasFiscais);

                              // Adicionar valores analiticos
                              AdicionarDadosAnaliticosNotas(iIDNota, FacbrNFe.NotasFiscais);

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

   // ** XML Fornecedores - Documentos de Terceiros - Onde a Empresa é destinatária no documento
   FListaArquivos.Clear;
   ObterListaAqruivosDiretorio(Self.LocalDocXml_FORN, 'xml', TStringList(FListaArquivos), '*', True, iCountLimite);
   GerarLinhaMemoLog('Total documentos xml fornecedor: ' + IntToStr(FListaArquivos.Count));
   GravaLog('Total documentos xml fornecedor: ' + IntToStr(FListaArquivos.Count));
   //Filtra os documentos onde a empresa esteja como destinatária / filtra data 7 dias maior que o período filtrado
   FiltrarDocumentosFornecedores(TStringList(FListaArquivos), iCountLimite);

   GerarLinhaMemoLog('Total documentos xml de entrada para o período: ' + IntToStr(FListaArquivos.Count));
   application.ProcessMessages;
   IniciaBar(FListaArquivos.Count);
   for iDx := 0 to FListaArquivos.Count - 1 do
     begin
        IncBar;
        GerarLinhaMemoLog('Arquivo: ' + FListaArquivos[iDx]);

        // ** Carregando XML nfe - nfce Componente ACBrNFe;
        sChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));
        AtualizarStatus('Carregando informações do doc NFe: ');

        try
           GerarLinhaMemoLog('Lendo informações do documento: ' + sChave);
           FacbrNFe.NotasFiscais.Clear;
           FacbrNFe.NotasFiscais.LoadFromFile(Trim(FListaArquivos[iDx]));

           if InformacoesNFeValidasParaEscriturar(FacbrNFe.NotasFiscais, True) then
              begin
                 // Adicionar dados Participante
                 AdicionarDadosParticipante(FacbrNFe.NotasFiscais, True);

                 // Adicionar dados dos produtos
                 AdicionarDadosProdutos(FacbrNFe.NotasFiscais, True);

                 // Lança estoque para inventario
                 AdicionarDadosMovimentoEstoque(FacbrNFe.NotasFiscais, True);

                 // Adicionar dados do cabeçalho dos documentos
                 iIDNota := AdicionarDadosNotas(FacbrNFe.NotasFiscais, True);
                 if (iIDNota > 0) then;
                    begin
                       // Adicionar itens
                       AdicionarDadosItensNotas(iIDNota, FacbrNFe.NotasFiscais, True);

                       // Adicionar valores analiticos
                       AdicionarDadosAnaliticosNotas(iIDNota, FacbrNFe.NotasFiscais, True);
                    end;
              end;
        except
           on E: Exception do
              GerarLinhaMemoLog('Erro ao processar arquivo entrada: ' + ExtractFileName(FListaArquivos[iDx]) + ' - ' + E.Message);
        end;
     end;

   // ** Informações de notas de despesas de Energia eletrica, Água e Gaz no Caixa
   //CarregarInformacoesNotasAguaEnergiaGaz_C500;

   // ** Informações de cupom fiscal
   if (Self.GerarCupomFiscal) then
      begin
         GerarLinhaMemoLog('Carregando movimentos de Cupom Fiscal');
         try
            if FArquivoMFDSPEDLocal then
               begin
                  GerarLinhaMemoLog('Opção marcada: Ler arquivo MFD SPED de um local...');
                  sPathArquivoMFD := ExtractFilePath(LocalArquivoMFDSPED);
                  sNomeArquivoMFD := ExtractFileName(LocalArquivoMFDSPED);
               end
            else
               begin
                  // ** Conectar - verificar conexão da impressora e arquivo ConfigECF.ini;
                  GerarLinhaMemoLog('Conectando na impressora fiscal! Aguarde...');
                  if (not ConectarImpressoraECF(sMsgECF)) then
                     GerarLinhaMemoLog(sMsgECF)
                  else
                     GerarLinhaMemoLog('Impressora fiscal conectada com sucesso!');

                  if (Self.FECF_RequerZ) then
                     GerarLinhaMemoLog('ECF requer redução "Z"! Não é possível ler os movimentos dos cupons.')
                  else
                     begin
                        // ** Pegando a data Str do movimento da ult. red. Z.
                        olstDadosUltimaReducaoZ := TStringlist.Create;
                        try
                           GerarLinhaMemoLog('Obter Dados Última Redução Z');
                           olstDadosUltimaReducaoZ.Text := StringReplace(FACBrECF.DadosUltimaReducaoZ, ' ', '', [rfReplaceAll, rfIgnoreCase]);
                           GerarLinhaMemoLog('Data do movimento da última Redução Z: ' + olstDadosUltimaReducaoZ.Values['DataMovimento']);
                           sDataAux := Trim(olstDadosUltimaReducaoZ.Values['DataMovimento']);

                           if (Length(sDataAux) < 10) then
                              sDataAux := Copy(sDataAux, 1, 3) + Copy(sDataAux, 4, 3) + '20' + Copy(sDataAux, 7, 2);

                           dtDataHoraUltimaReducaoZ := StrToDateTimeDef(sDataAux, FACBrECF.DataHoraUltimaReducaoZ);
                        finally
                           olstDadosUltimaReducaoZ.Free;
                        end;
                        // **

                        if (dtDataHoraUltimaReducaoZ < Self.FcompSpedFiscal.DT_INI) then
                           GerarLinhaMemoLog('Data da última Redução Z "' + FormatDateTime('dd/mm/yyyy', dtDataHoraUltimaReducaoZ) +
                              '" é menor que a data inicial do periodo "' + FormatDateTime('dd/mm/yyyy', Self.FcompSpedFiscal.DT_INI) +
                              '" - Não há movimentos para gerar.');
                           begin
                              dtFinalMovCupons := Self.FcompSpedFiscal.DT_FIN;
                              if (dtDataHoraUltimaReducaoZ < Self.FcompSpedFiscal.DT_FIN) then
                                 begin
                                    dtFinalMovCupons := dtDataHoraUltimaReducaoZ;
                                    GerarLinhaMemoLog('Data da última Redução Z "' + FormatDateTime('dd/mm/yyyy', dtDataHoraUltimaReducaoZ) +
                                      '" é menor que a data final do periodo "' + FormatDateTime('dd/mm/yyyy', Self.FcompSpedFiscal.DT_FIN) + '"!');
                                    GerarLinhaMemoLog('Período considerado dos cupons: "' + FormatDateTime('dd/mm/yyyy', Self.FcompSpedFiscal.DT_INI) +
                                      '" até "' + FormatDateTime('dd/mm/yyyy', dtFinalMovCupons) + '"!');
                                 end;

                              // - Gerar o arquivo SPED FACBrECF.ArquivoMFD_DLL();
                              GerarLinhaMemoLog('Geração do arquivo dos movimentos da ECF - ArquivoMFD_DLL');

                              sPathArquivoMFD := ExtractFilePath(Application.ExeName) + 'mfd\';
                              sNomeArquivoMFD := 'MFD_E_' + IntToStr(Self.FCodigoEmpresa) + '_' + FormatDateTime('mm_yyyy', Self.FcompSpedFiscal.DT_INI) +
                                                 '_' + FormatDateTime('ddmmyy_hhnnss', Now) + '.ecf';

                              GerarLinhaMemoLog('Aguarde... Obtendo informações, não desligue a impressora!');
                              AtualizarStatus('Aguarde... Obtendo informações, não desligue a impressora!');

                              if (not DirectoryExists(sPathArquivoMFD)) then
                                 ForceDirectories(sPathArquivoMFD);

                              FACBrECF.ArquivoMFD_DLL(Self.FcompSpedFiscal.DT_INI,
                                                      dtFinalMovCupons,
                                                      AnsiString(sPathArquivoMFD + sNomeArquivoMFD), [docTodos], finSPED);

                           end; {Data red Z menor que INI}
                     end; {else-if Requer Z}
               end;{else arquivo mfd de um local}

               FACBrSPEDECF.Path := sPathArquivoMFD;
               FACBrSPEDECF.Arquivo := sNomeArquivoMFD;

               GerarLinhaMemoLog('Arquivo MFD: ' + sNomeArquivoMFD);
               // - Carregar os registros do arquivo '.LoadFileTXT;' gerado para DATASETs
               GerarLinhaMemoLog('Efetuando leitura do arquivo: Executando "LoadFileTXT"...');
               MensagemAviso('Para Ler Arquivo da impressora falta incluir:' + sLineBreak + sLineBreak +
                             'FACBrSPEDECF.Cod_Mun_Empresa := FcMun_Empresa; ' + sLineBreak +
                             'FACBrSPEDECF.LoadFileTXT;' + sLineBreak
                             );

               GerarLinhaMemoLog('Total 0200: ' + IntToStr(FACBrSPEDECF.Bloco_0.Registro0001.Registro0200.Count) + ' - Produtos dos cupons');
               GerarLinhaMemoLog('Total C400: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.Count) + ' - Equipamento ECF');
               GerarLinhaMemoLog('Total C405: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Count) + ' - Redução Z');
               GerarLinhaMemoLog('Total C420: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Items[0].RegistroC420.Count)
                  + ' - Totalizadores parciais');
               GerarLinhaMemoLog('Total C460: ' + IntToStr(FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Items[0].RegistroC460.Count)
                  + ' - Cupom Fiscal');

               AdicionarDadosProdutosCupomFiscal();
         except
            on E: Exception do
               begin
                  GerarLinhaMemoLog('Erro ao gerar movimentos de cupom fiscal!');
                  GerarLinhaMemoLog(E.Message);
               end;
         end;
      end;{if GerarCupomFiscal}

  Screen.Cursor := crDefault;

end;

procedure TSpedFiscal.CarregarInformacoesContador;
begin
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Carregando dados do contador: FILIAL:' + IntToStr(dmPrincipal.CodigoFilial));
   ExecSQL('SELECT * FROM CONTADOR WHERE CD_FILIAL = ' + IntToStr(dmPrincipal.CodigoFilial));
end;

procedure TSpedFiscal.CarregarInformacoesEmpresa;
begin
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Carregando dados da empresa: FILIAL:' + IntToStr(dmPrincipal.CodigoFilial));
   ExecSQL('SELECT *  FROM EMPRESA WHERE CD_FILIAL = ' + IntToStr(dmPrincipal.CodigoFilial));
end;

procedure TSpedFiscal.CarregarParametrosSPED;
begin
   GerarLinhaMemoLog('Carregando Parâmetros SPED Fiscal:FILIAL:' + IntToStr(dmPrincipal.CodigoFilial));
   ExecSQL('SELECT EMPRESA.PERFIL,EMPRESA.PERIODO_IPI FROM EMPRESA WHERE CD_FILIAL =' + IntToStr(CodigoEmpresa));


  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.open;

  FParamIndApurIPI := dmPrincipal.cdsConsEmpresaPERIODO_IPI.Value;// D ou M periodo de apuracao do IPI decendial ou mensal

  CarregarInformacoesEmpresa;
  Self.FcMun_Empresa := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.AsInteger;

end;

function TSpedFiscal.CFOP_DevolucaoCompra(const CFOPDevCompra: String): Boolean;
const
  _CFOPS_DEVOLUCAO = '5201,5202,5208,5209,5210,5410,5411,5412,5413,5503,5553,5555,5556,5660,' +
                     '5661,5662,5918,5919,5921,6201,6202,6208,6209,6210,6410,6411,6412,6413,' +
                     '6503,6553,6555,6556,6660,6661,6662,6918,6919,6921';
begin
  Result := Pos(CFOPDevCompra, _CFOPS_DEVOLUCAO) > 0;
end;

function TSpedFiscal.ChaveDuplicadaNaApuracao(const Chave: String): Boolean;
begin
   FTabelaRegC100.Filtered := False;
   FTabelaRegC100.Filter := 'CHV_NFE = ' + QuotedStr(Chave);
   FTabelaRegC100.Filtered := True;
   Result := (not FTabelaRegC100.IsEmpty);
   FTabelaRegC100.Filtered := False;
end;

procedure TSpedFiscal.ClearBar;
begin
   if (Assigned(FProgressBar)) then
      begin
         FProgressBar.Max      := 0;
         FProgressBar.Position := 0;
      end;
end;

function TSpedFiscal.ConectarImpressoraECF(var sMsgRet: String): Boolean;
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

function TSpedFiscal.ConfiguracoesValidasParaGerarSpedFiscal: Boolean;
begin
   Result := False;

   if (CodigoEmpresa <= 0) then
      MensagemAviso('Código da empresa não foi informado!')
   else
   if (DataInicial <= 0) then
      MensagemAviso('A data inicial do período não foi informada!')
   else
   if (DataFinal <= 0) then
      MensagemAviso('A data final do período não foi informada!')
   else
   if (Trim(LocalDocXml_NFE) = '') then
      MensagemAviso('O local dos documentos XML NFE não foi informado!')
   else
   if (not DirectoryExists(Trim(LocalDocXml_NFE))) then
      MensagemAviso('O local dos documentos XML NFE não existe!' + sLineBreak + Trim(LocalDocXml_NFE))
   else
   if (Trim(LocalDocXml_NFCE) = '') then
      MensagemAviso('O local dos documentos XML NFCE não foi informado!')
   else
   if (not DirectoryExists(Trim(LocalDocXml_NFCE))) then
      MensagemAviso('O local dos documentos XML NFCE não existe!' + sLineBreak + Trim(LocalDocXml_NFCE))
   else
   if (Trim(LocalDocXml_FORN) = '') then
      MensagemAviso('O local dos documentos XML Fornecedor não foi informado!')
   else
   if (not DirectoryExists(Trim(LocalDocXml_FORN))) then
      MensagemAviso('O local dos documentos XML Fornecedor não existe!' + sLineBreak + Trim(LocalDocXml_FORN))
   else
   if (Trim(CnpjEmpresa) = '') then
      MensagemAviso('O CNPJ da empresa não foi informado!')
   else
   if (CodigIbgeUfEmpresa = 0) then
      MensagemAviso('O Código IBGE da UF da empresa não foi informado!')
   else
   if (FGerarCupomFiscal) and (FArquivoMFDSPEDLocal) and (not FileExists(FLocalArquivoMFDSPED)) then
      MensagemAviso('Arquivo MFD SPED não existe no local informado!' + sLineBreak +
                    FLocalArquivoMFDSPED)
   else
      Result := True;
end;

procedure TSpedFiscal.ConfigurarVersaoLayout(Registro0000: TRegistro0000);
 var
  xVer: string;
begin


//    Código 004 - Versão 1.03
//      Registro0000.COD_VER := vlVersao103;
//    Código 005 - Versão 1.04
//      Registro0000.COD_VER := vlVersao104;
//    Código 006 - Versão 1.05
//      Registro0000.COD_VER := vlVersao105;
//    Código 007 - Versão 1.06
//      Registro0000.COD_VER := vlVersao106;
//    Código 008 - Versão 1.07
//      Registro0000.COD_VER := vlVersao107;
//    Código 009 - Versão 1.08
//      Registro0000.COD_VER :=StrToCodVer;
//    Código 010 - Versão 1.09



   Registro0000.COD_VER := vlVersao118;
end;

procedure TSpedFiscal.CarregarInformacoesNotasAguaEnergiaGaz_C500;
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

   sSQL := StringReplace(_SQL_DESP_AGUA_ERNERGIA_GAS_C500, ':P_FILIAL', IntToStr(dmPrincipal.CodigoFilial), [rfReplaceAll,rfIgnoreCase]);
   sSQL := StringReplace(sSQL, ':P_DATA_INI', QuotedStr(FormatDateTime('dd.mm.yyyy',  FcompSpedFiscal.DT_INI)), [rfReplaceAll,rfIgnoreCase]);
   sSQL := StringReplace(sSQL, ':P_DATA_FIM', QuotedStr(FormatDateTime('dd.mm.yyyy',  FcompSpedFiscal.DT_FIN)), [rfReplaceAll,rfIgnoreCase]);

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
                 FTabelaReg0150.FieldByName('NOME').AsString := 'FORNECEDOR CONTAS DESPESAS CX';
                 FTabelaReg0150.FieldByName('COD_PAIS').AsString := '1058';
                 FTabelaReg0150.FieldByName('CNPJCPF').AsString := Self.CnpjEmpresa;
                 FTabelaReg0150.FieldByName('IE').AsString := 'ISENTO';
                 FTabelaReg0150.FieldByName('COD_MUN').AsInteger := Self.FcMun_Empresa;
                 FTabelaReg0150.FieldByName('ENDERECO').AsString := 'RUA DO FORNECEDOR';
                 FTabelaReg0150.FieldByName('NUM').AsString := 'S/N';
                 FTabelaReg0150.FieldByName('COMPL').AsString := '';
                 FTabelaReg0150.FieldByName('BAIRRO').AsString := 'BAIRRO FORNECEDOR';

                 FTabelaReg0150.Post;
              end;
         finally
           FTabelaReg0150.Filtered := False;
         end;

         FTabelaRegC500.Next;
      end;{while}
   FTabelaRegC500.First;
end;

function TSpedFiscal.ConverterCFOPEntrada(const CFOPSaida, CodProduto, CodFornec: String): String;
var
   sCFOPAux: String;
   sCodAux: String;
   SQL,teste: String;
   iCFOP: Integer;
   iCFOPDefault: Integer;
   bBuscarNaBse: Boolean;

   cdsResult: TClientDataSet;
   qryResult: TSQLQuery;
   dspResult: TDataSetProvider;
begin

   bBuscarNaBse := (Trim(CFOPSaida) <> '');

   if (bBuscarNaBse) then
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
      end;


      // Regra de conversão quando não encontrar na base de dado - Regra anterior


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

function TSpedFiscal.ConverterEquivalenciaCSOSNToCST(const CSOSN: String; const TemAliqIcms: Boolean): String;
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

constructor TSpedFiscal.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FSemLimite := False;
   FcompSpedFiscal := TACBrSPEDFiscal.Create(Self);
   FACBrSPEDECF := TACBrSPEDFiscal.Create(Self);
   FOriginal := True;
   FCodigoEmpresa := 0;

   FacbrNFe := TACBrNFe.Create(Self);
   FACBrECF := TACBrECF.Create(Self);
   //** Configurar Eventos ECF
   FACBrECF.OnAguardandoRespostaChange := ACBrECFAguardandoRespostaChange;
   FACBrECF.OnChangeEstado := ACBrECFChangeEstado;
   FACBrECF.OnMsgAguarde := ACBrECFMsgAguarde;
   FACBrECF.OnMsgPoucoPapel := ACBrECFMsgPoucoPapel;

   CriarTabelasTmpMem;
   CriarFieldsDataSets;
   SetEventoOnError;
   FListaArquivos := TStringList.Create;
end;

procedure TSpedFiscal.CriarFieldsDataSets;
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

   // Dataset Registro 0220 - Fatores de conversão de unidades
   FTabelaReg0220.Close;
   FTabelaReg0220.FieldDefs.Clear;
   FTabelaReg0220.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaReg0220.FieldDefs.add('UNID_CONV', ftString, 6);
   FTabelaReg0220.FieldDefs.add('FAT_CONV', ftFloat);
   FTabelaReg0220.FieldDefs.add('COD_BARRA', ftString, 60);
   FTabelaReg0220.CreateDataSet;

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

   // Dataset Registro C190 - Analitico das Notas fiscais
   FTabelaRegC190.Close;
   FTabelaRegC190.FieldDefs.Clear;
   FTabelaRegC190.FieldDefs.add('NFID', ftInteger);
   FTabelaRegC190.FieldDefs.add('CST_ICMS', ftString, 3);
   FTabelaRegC190.FieldDefs.add('CFOP', ftString, 4);
   FTabelaRegC190.FieldDefs.add('VL_BC_ICMS', ftFloat);
   FTabelaRegC190.FieldDefs.add('VL_ICMS', ftFloat);
   FTabelaRegC190.FieldDefs.add('ALIQ_ICMS', ftFloat);
   FTabelaRegC190.FieldDefs.add('VL_BC_ICMS_ST', ftFloat);
   FTabelaRegC190.FieldDefs.add('VL_ICMS_ST', ftFloat);
   FTabelaRegC190.FieldDefs.add('VL_OPR', ftFloat);
   FTabelaRegC190.FieldDefs.add('VL_RED_BC', ftFloat);
   FTabelaRegC190.FieldDefs.add('VL_IPI', ftFloat);
   FTabelaRegC190.FieldDefs.add('COD_OBS', ftString, 50);
   FTabelaRegC190.FieldDefs.add('UF', ftString, 2);
   FTabelaRegC190.CreateDataSet;

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

   FTabelaRegH010.Close;
   FTabelaRegH010.FieldDefs.Clear;
   FTabelaRegH010.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaRegH010.FieldDefs.add('UNID', ftString, 6);
   FTabelaRegH010.FieldDefs.add('QTD', ftFloat);
   FTabelaRegH010.FieldDefs.add('VL_UNIT', ftFloat);
   FTabelaRegH010.FieldDefs.add('VL_ITEM', ftFloat);
   FTabelaRegH010.CreateDataSet;

   FTabelaRegK200.Close;
   FTabelaRegK200.FieldDefs.Clear;
   FTabelaRegK200.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaRegK200.FieldDefs.add('QTD', ftFloat);
   FTabelaRegK200.CreateDataSet;

   // ** K230 - Itens produzidos
   FTabelaRegK230.Close;
   FTabelaRegK230.FieldDefs.Clear;
   FTabelaRegK230.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaRegK230.FieldDefs.add('COD_DOC_OP', ftString, 30);
   FTabelaRegK230.FieldDefs.add('DT_INI_OP', ftDateTime);
   FTabelaRegK230.FieldDefs.add('DT_FIN_OP', ftDateTime);
   FTabelaRegK230.FieldDefs.add('QTD_ENC', ftFloat);
   FTabelaRegK230.CreateDataSet;

   // ** K235 - Itens Consumidos
   FTabelaRegK235.Close;
   FTabelaRegK235.FieldDefs.Clear;
   FTabelaRegK235.FieldDefs.add('COD_ITEM_PRODUZIDO', ftString, 60);
   FTabelaRegK235.FieldDefs.add('COD_ITEM', ftString, 60);
   FTabelaRegK235.FieldDefs.add('QTD', ftFloat);
   FTabelaRegK235.CreateDataSet;

   FTabelaUFICMSST.Close;
   FTabelaUFICMSST.FieldDefs.Clear;
   FTabelaUFICMSST.FieldDefs.add('UF', ftString, 2);
   FTabelaUFICMSST.FieldDefs.add('VL_ICMS_ST_E', ftFloat);
   FTabelaUFICMSST.FieldDefs.add('VL_ICMS_ST_S', ftFloat);
   FTabelaUFICMSST.FieldDefs.add('IE', ftString,14);
   FTabelaUFICMSST.CreateDataSet;
end;

procedure TSpedFiscal.CriarTabelasTmpMem;
begin
   // ClientDataSet
   FTabelaEmpresa  := TClientDataSet.Create(Self);
   FTabelaContador := TClientDataSet.Create(Self);
   FcdsResultExec  := TClientDataSet.Create(Self);
   FTabelaReg0150  := TClientDataSet.Create(Self);
   FTabelaReg0190  := TClientDataSet.Create(Self);
   FTabelaReg0200  := TClientDataSet.Create(Self);
   FTabelaReg0220  := TClientDataSet.Create(Self);
   FTabelaReg0400  := TClientDataSet.Create(Self);
   FTabelaRegC100  := TClientDataSet.Create(Self);
   FTabelaRegC170  := TClientDataSet.Create(Self);
   FTabelaRegC190  := TClientDataSet.Create(Self);
   FTabelaRegE510  := TClientDataSet.Create(Self);
   FTabelaRegC500  := TClientDataSet.Create(Self);
   FTabelaRegH010  := TClientDAtaSet.Create(Self);
   FTabelaRegK200  := TClientDAtaSet.Create(Self);
   FTabelaRegK230  := TClientDAtaSet.Create(Self);
   FTabelaRegK235  := TClientDAtaSet.Create(Self);
   FTabelaUFICMSST := TClientDAtaSet.Create(Self);

   // Query
   FqTabelaRegC500 := TSQLQuery.Create(Self);
   FqryResultExec := TSQLQuery.Create(Self);

   // DataSetprovider
   FdspResultExec := TDataSetProvider.Create(Self);
   FpTabelaRegC500 := TDataSetprovider.Create(Self);
end;

destructor TSpedFiscal.Destroy;
begin
   FListaArquivos.Free;
   DestruirTabelasTmpMem;
   FreeAndNil(FcompSpedFiscal);
   FreeAndNil(FacbrNFe);
   FreeAndNil(FACBrECF);
   FreeAndNil(FACBrSPEDECF);
   inherited;
end;

procedure TSpedFiscal.DestruirTabelasTmpMem;
begin
   FreeAndNil(FTabelaEmpresa);
   FreeAndNil(FTabelaContador);
   FreeAndNil(FcdsResultExec);
   FreeAndNil(FqryResultExec);
   FreeAndNil(FdspResultExec);
   FreeAndNil(FTabelaReg0150);
   FreeAndNil(FTabelaReg0200);
   FreeAndNil(FTabelaReg0220);
   FreeAndNil(FTabelaReg0190);
   FreeAndNil(FTabelaReg0400);
   FreeAndNil(FTabelaRegC100);
   FreeAndNil(FTabelaRegC170);
   FreeAndNil(FTabelaRegC190);
   FreeAndNil(FTabelaRegE510);
   FreeAndNil(FTabelaRegC500);
   FreeAndNil(FqTabelaRegC500);
   FreeAndNil(FpTabelaRegC500);
   FreeAndNil(FTabelaRegH010);
   FreeAndNil(FTabelaRegK200);
   FreeAndNil(FTabelaRegK230);
   FreeAndNil(FTabelaRegK235);
   FreeAndNil(FTabelaUFICMSST);
end;

procedure TSpedFiscal.ExecSQL(const SQL: String);
begin
   try
      dmPrincipal.FdQueryAuxiliar.Close;
      dmPrincipal.FdQueryAuxiliar.SQL.Clear;

      dmPrincipal.FdQueryAuxiliar.SQL.Add(SQL);
      dmPrincipal.FdQueryAuxiliar.Open;

   except
      on E: Exception do
         begin
            GerarLinhaMemoLog('Funcção "TSpedFiscal.ExecSQL" - Erro SQL: ' + E.Message);
         end;
   end;
end;

function TSpedFiscal.ExisteCombinacaoRegistroAnalitico(const NFID: Integer; const CstIcms, Cfop: String; const AliqIcms: Currency): Boolean;
begin
   FTabelaRegC190.Filtered := False;
   FTabelaRegC190.Filter := 'NFID = ' + IntToStr(NFID) + ' and ' +
                            'CST_ICMS = ' + QuotedStr(CstIcms) + ' and ' +
                            'CFOP = ' + QuotedStr(Cfop) + ' and ' +
                            'ALIQ_ICMS = ' + CurrToStr(AliqIcms);
   FTabelaRegC190.Filtered := True;

   Result := (FTabelaRegC190.RecordCount > 0);
end;

procedure TSpedFiscal.FiltrarDocumentosFornecedores(oListaArq: TStringList; const iLim: Integer = 0);
var
  idx: Integer;
  bArquivoValido: Boolean;
  aChave : String;
begin
   GerarLinhaMemoLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Filtrando Xml de Fornecedores <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
   GerarLinhaMemoLog('Filtrando documentos de entradas/fornecedores válidos');
   GerarLinhaMemoLog('>> CNPJ gerando arquivo fiscal : ' + Self.CnpjEmpresa);
   GravaLog('>> Filtrando documentos de entrada, modelo 55 emitidos para o CNPJ : ' + Self.CnpjEmpresa);

   for idx := oListaArq.Count - 1 downto 0 do
      begin
         aChave := SomenteNumeros(ExtractFileName(FListaArquivos[iDx]));

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
            GravaLog('Arquivo xml de entrada estrutura inválida: ' + Trim(oListaArq[idx]));
            GerarLinhaMemoLog('Arquivo xml de entrada estrutura inválida: ' + Trim(oListaArq[idx]));
            bArquivoValido := False;
         end;

         if (bArquivoValido) then
            begin
                  // Se é documento modelo 55
               if (FacbrNFe.NotasFiscais.Items[0].NFe.Ide.modelo <> 55) then
                  begin
                     GravaLog('Modelo de documento de entrada difere de 55: ' + Trim(oListaArq[idx]));
                     GerarLinhaMemoLog('Modelo de documento de entrada difere de 55: ' + Trim(oListaArq[idx]));
                     bArquivoValido := False;
                  end;
            end;

         if (bArquivoValido) then
            begin
                   // Se o CNPJ gerador do arquivo fiscal é o da empresa selecionada pelo acbr
               if (FacbrNFe.NotasFiscais.Items[0].NFe.Dest.CNPJCPF <> RemoveMascaraStr(Self.CnpjEmpresa)) then
                  begin
                     GerarLinhaMemoLog('CNPJ Destinatário do documento de entrada difere da empresa (' + Self.CnpjEmpresa + '): ' + Trim(oListaArq[idx]));
                     GravaLog('Desconsiderado arquivo xml em que o cnpj gerador não é o da propria empresa. Chave da nota : ' + aChave);
                     bArquivoValido := False;
                  end;
            end;

         if (bArquivoValido) then
            begin
                    // Se data ent_sai não está dentro do periodo selecionado
                 if not ((FacbrNFe.NotasFiscais.Items[0].NFe.Ide.dEmi >= (DataInicial - 7)) and  //Angelo (DataInicial - 7) inserido para pegar nota de entrada que
                          (FacbrNFe.NotasFiscais.Items[0].NFe.Ide.dEmi <= DataFinal)) then
                    begin
                       GerarLinhaMemoLog('A data de entrada "dEmi" do documento de entrada difere do periodo de apuração "' + FormatDateTime('dd.mm.yyyy', DataInicial) + '"' +
                                         ' até "' + FormatDateTime('dd.mm.yyyy', DataFinal) + '": ' + Trim(oListaArq[idx]));
                       GravaLog('Desconsiderado arquivo xml em que a data do xml está fora do período informado <7 dias. Chave da nota : ' + aChave);
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

procedure TSpedFiscal.GerarAquivo;
begin
   if ConfiguracoesValidasParaGerarSpedFiscal then
      begin
         GerarLinhaMemoLog(_INICIO_SPED_FISCAL);

         LimparTabela;

         IniciarControles;

         CarregarParametrosSPED;

         CarregarDocumentosXML;

         GerarBloco_0; { Abertura, Identificação e Referências }

         GerarBloco_1; {Outras informações - Este bloco destina-se à prestação de outras informações exigidas pelo fisco.}

         GerarBloco_C; { Documentos Fiscais I – Mercadorias (ICMS/IPI) }

         GerarBloco_D; { Documentos Fiscais II – Serviços (ICMS) }

         GerarBloco_E; { Apuração do ICMS e do IPI}

         GerarBloco_H; { Inventário Físico }

         GerarBloco_K;

         Self.FcompSpedFiscal.SaveFileTXT;
         GerarLinhaMemoLog('Arquivo SPED Fiscal gerado com sucesso!');
         GerarLinhaMemoLog(String(Self.FcompSpedFiscal.Path) + String(Self.FcompSpedFiscal.Arquivo));
         MensagemInformacao('Arquivo SPED Fiscal gerado com sucesso!' + sLineBreak + sLinebreak +
                            String(Self.FcompSpedFiscal.Path) + String(Self.FcompSpedFiscal.Arquivo) );
      end;
end;

procedure TSpedFiscal.GerarBloco_0;
var
   Registro0000: TRegistro0000;
   Registro0001: TRegistro0001;
   Registro0002: TRegistro0002;
   Registro0005: TRegistro0005;
   Registro0100: TRegistro0100;
   Registro0150: TRegistro0150;
   Registro0190: TRegistro0190;
   Registro0200: TRegistro0200;
   Registro0220: TRegistro0220;
   Registro0400: TRegistro0400;
   Registro0450: TRegistro0450;

   sDocContador: String;
begin

   dmPrincipal.cdsConsEmpresa.Close;
   dmPrincipal.cdsConsEmpresa.open;

   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0000 - Dados da empresa');

   // DADOS DA EMPRESA
   Registro0000 := FcompSpedFiscal.Bloco_0.Registro0000New;

   // Versão Layout
   ConfigurarVersaoLayout(Registro0000);


   if Self.Original then
      Registro0000.COD_FIN := raOriginal
   else
      Registro0000.COD_FIN := raSubstituto;

  // Registro0000.COD_VER    := AnoToVersao;
   Registro0000.NOME       := dmPrincipal.cdsConsEmpresaRAZAO.AsString;
   Registro0000.CNPJ       := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaCGC.AsString);
   Registro0000.CPF        := '';
   Registro0000.UF         := dmPrincipal.cdsConsEmpresaUF.AsString;
   Registro0000.IE         := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaINSC_ESTADUAL.AsString);
   Registro0000.COD_MUN    := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.AsInteger;
   Registro0000.IM         := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaINSC_MUNICIPAL.AsString);
   Registro0000.SUFRAMA    := '';

   if dmPrincipal.cdsConsEmpresaPERFIL.Value = 'C' then
      Registro0000.IND_PERFIL := pfPerfilC
   else
   if dmPrincipal.cdsConsEmpresaPERFIL.Value = 'B' then
      Registro0000.IND_PERFIL := pfPerfilB
   else
      Registro0000.IND_PERFIL := pfPerfilA;
   if FrmPrincipal.CbbTipoAtividade.ItemIndex=0 then { 0 – Industrial ou equiparado a industrial; 1 – Outros. mauricio }
      Registro0000.IND_ATIV := atIndustrial
   else
      Registro0000.IND_ATIV := atOutros;



   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0001 - Abertura do bloco');
   Registro0001         := FcompSpedFiscal.Bloco_0.Registro0001New;
   Registro0001.IND_MOV := imComDados;     //Indicador de movimento:

   //** Dados complementares da Empresa.
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0005 - Dados da complementares empresa');

   Registro0005 := FcompSpedFiscal.Bloco_0.Registro0005New;

   Registro0005.FANTASIA   := dmPrincipal.cdsConsEmpresaFANTASIA.AsString;
   Registro0005.CEP        := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaCEP.AsString);
   Registro0005.ENDERECO   := dmPrincipal.cdsConsEmpresaENDERECO.AsString;
   Registro0005.NUM        := dmPrincipal.cdsConsEmpresaNUMERO.AsString;
   Registro0005.COMPL      := '';
   Registro0005.BAIRRO     := dmPrincipal.cdsConsEmpresaBAIRRO.AsString;
   Registro0005.FONE       := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaTELEFONE.Value);
   Registro0005.FAX        := '';
   Registro0005.EMAIL      := dmPrincipal.cdsConsEmpresaEMAIL.Value;

   //** Dados do contador
   CarregarInformacoesContador;
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0100 - Dados do contador.');

   dmPrincipal.cdsConsDadosContador.Close;
   dmPrincipal.cdsConsDadosContador.ParamByName('cd_filial').Value:=dmPrincipal.cdsConsEmpresaCD_FILIAL.Value;
   dmPrincipal.cdsConsDadosContador.Open;

   Registro0100 := FcompSpedFiscal.Bloco_0.Registro0100New;

   Registro0100.NOME :=    dmPrincipal.cdsConsDadosContadorNOME.Value;
   sDocContador := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorCNPJ.Value);
   if (Length(sDocContador) = 14) then
      Registro0100.CNPJ := sDocContador
   else
      Registro0100.CPF := sDocContador;

   Registro0100.CRC        := dmPrincipal.cdsConsDadosContadorCRC.Value;
   Registro0100.CPF        := dmPrincipal.cdsConsDadosContadorCPF.Value;
   Registro0100.CEP        := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorCEP.AsString);
   Registro0100.ENDERECO   := dmPrincipal.cdsConsDadosContadorENDERECO.AsString;
   Registro0100.NUM        := dmPrincipal.cdsConsDadosContadorNUMERO.AsString;
   Registro0100.COMPL      := dmPrincipal.cdsConsDadosContadorCOMPLEMENTO.AsString;
   Registro0100.BAIRRO     := dmPrincipal.cdsConsDadosContadorBAIRRO.AsString;
   Registro0100.FONE       := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorTELEFONE.AsString);
   Registro0100.FAX        := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorFAX.AsString);
   Registro0100.EMAIL      := dmPrincipal.cdsConsDadosContadorEMAIL.AsString;
   Registro0100.COD_MUN    := StrToInt(dmPrincipal.cdsConsDadosContadorCOD_CIDADE.AsString);

   // 0150 - Participantes
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0150 - Participantes');
   AtualizarStatus('Registro 0150 (Participantes): ');
   FTabelaReg0150.First;
   IniciaBar(FTabelaReg0150.RecordCount);
   while not FTabelaReg0150.Eof do
      begin
         IncBar;


         Registro0150 := FcompSpedFiscal.Bloco_0.Registro0150New;

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
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0190 - Unidade de medida');
   AtualizarStatus('Registro 0190 (Unid. de medida): ');

   FTabelaReg0190.First;
   IniciaBar(FTabelaReg0190.RecordCount);
   while not FTabelaReg0190.Eof do
      begin
         IncBar;

         Registro0190 := FcompSpedFiscal.Bloco_0.Registro0190New;

         Registro0190.UNID  := Trim(FTabelaReg0190.FieldByName('UNID').AsString);
         Registro0190.DESCR := Trim(FTabelaReg0190.FieldByName('DESCR').AsString);

         FTabelaReg0190.Next;
      end;

   // 0200 - Produtos e serviços
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0200 - Produtos e Serviços');
   AtualizarStatus('Registro 0200 (Produtos e serviços): ');

   FTabelaReg0200.First;
   IniciaBar(FTabelaReg0200.RecordCount);
   while not FTabelaReg0200.Eof do
      begin
         IncBar;

         Registro0200 := FcompSpedFiscal.Bloco_0.Registro0200New;

         Registro0200.COD_ITEM      := Trim(FTabelaReg0200.FieldByName('COD_ITEM').AsString);
         Registro0200.DESCR_ITEM    := Trim(FTabelaReg0200.FieldByName('DESCR_ITEM').AsString);
         Registro0200.COD_BARRA     := Trim(FTabelaReg0200.FieldByName('COD_BARRA').AsString);
         Registro0200.COD_ANT_ITEM  := '';
         Registro0200.UNID_INV      := Trim(FTabelaReg0200.FieldByName('UNID_INV').AsString);

         if (Trim(FTabelaReg0200.FieldByName('TIPO_ITEM').AsString) = 'S') then
            Registro0200.TIPO_ITEM := tiServicos
         else
            Registro0200.TIPO_ITEM := tiMercadoriaRevenda;

         Registro0200.COD_NCM   := RemoveMascaraStr(FTabelaReg0200.FieldByName('COD_NCM').AsString);
         Registro0200.EX_IPI    := '';
         Registro0200.COD_GEN   := '';
         Registro0200.COD_LST   := '';
         Registro0200.ALIQ_ICMS := FTabelaReg0200.FieldByName('ALIQ_ICMS').AsFloat;

         // 0220 - Fatores de convesão de unidades
         FTabelaReg0220.Filtered := False;
         FTabelaReg0220.Filter := 'COD_ITEM = ' + QuotedStr(Registro0200.COD_ITEM);
         AtualizarStatus('Registro 0220 (Fatores de conversão de unidades): ');
         FTabelaReg0220.Filtered := True;
         FTabelaReg0220.First;
         while not FTabelaReg0220.Eof do
         begin

           Registro0220 := FcompSpedFiscal.Bloco_0.Registro0220New;
           Registro0220.UNID_CONV := FTabelaReg0220.FieldByName('UNID_CONV').AsString;
           Registro0220.FAT_CONV  := FTabelaReg0220.FieldByName('FAT_CONV').AsFloat;
           Registro0220.COD_BARRA := FTabelaReg0220.FieldByName('COD_BARRA').AsString;

           FTabelaReg0220.Next;
         end;

         FTabelaReg0200.Next;
      end; {while produtos e serviços}

   // 0400 - Natureza de operações - CFOP
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_0 + ': Gerando Registro 0400 - Natureza de operações - CFOP');
   AtualizarStatus('Registro 0400 (CFOP): ');
   FTabelaReg0400.First;
   IniciaBar(FTabelaReg0400.RecordCount);
   while not FTabelaReg0400.Eof do
      begin
         IncBar;

         Registro0400 :=  FcompSpedFiscal.Bloco_0.Registro0400New;

         Registro0400.COD_NAT   := Trim(FTabelaReg0400.FieldByName('COD_NAT').AsString);
         Registro0400.DESCR_NAT := Trim(FTabelaReg0400.FieldByName('DESCR_NAT').AsString);

         FTabelaReg0400.Next;
      end; {while}
end;

procedure TSpedFiscal.GerarBloco_1;
var
   Registro1001: TRegistro1001;
   Registro1010: TRegistro1010;
begin
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_1 + ': Gerando Registro 1010');
   FcompSpedFiscal.Bloco_C.RegistroC001New;

   Registro1001 := FcompSpedFiscal.Bloco_1.Registro1001New;
   Registro1001.IND_MOV := imComDados;

   Registro1010 := FcompSpedFiscal.Bloco_1.Registro1010New;

   Registro1010.IND_EXP   := 'N'; {Registro 1100}
   Registro1010.IND_CCRF  := 'N'; {Registro 1200}
   Registro1010.IND_COMB  := 'N'; {Registro 1300}
   Registro1010.IND_USINA := 'N'; {Registro 1390}
   Registro1010.IND_VA    := 'N'; {Registro 1400}
   Registro1010.IND_EE    := 'N'; {Registro 1500}
   Registro1010.IND_CART  := 'N'; {Registro 1600}
   Registro1010.IND_FORM  := 'N'; {Registro 1700}
   Registro1010.IND_AER   := 'N'; {Registro 1800}
   Registro1010.IND_GIAF1 := 'N'; {Registro 1960}
   Registro1010.IND_GIAF3 := 'N'; {Registro 1970}
   Registro1010.IND_GIAF4 := 'N'; {Registro 1980}
   Registro1010.IND_REST_RESSARC_COMPL_ICMS := 'N'; {Registro 1250}
end;

procedure TSpedFiscal.GerarBloco_C;
var
    RegistroC001: TRegistroC001;
    RegistroC100: TRegistroC100;

//  RegistroC110: TRegistroC110; {Informação complementar da nota}
//  RegistroC112: TRegistroC112; {Documento de arrecadação GNRE}
        {O registro C112 deve ser apresentado, obrigatoriamente, quando no campo C110 da nota fiscal - constar a identificação de um documento de arrecadação.}

//  RegistroC120: TRegistroC120; {Nota de importação}

    RegistroC140: TRegistroC140; {Fatura}
    RegistroC141: TRegistroC141; {Vencimento da Fatura}

    RegistroC170: TRegistroC170;
    RegistroC190: TRegistroC190;

    {ECF}
    RegistroC400: TRegistroC400; {Equipamento ecf}
    RegistroC405: TRegistroC405; {Redução Z}
    RegistroC420: TRegistroC420; {Totalizadores parciais da redução z (cod 02, 2D e 60)}
    RegistroC425: TRegistroC425; {Resumo de itens do movimento diário}
    RegistroC460: TRegistroC460; {Documento fiscal emitido por ecf}
    RegistroC470: TRegistroC470; {Itens Documento fiscal emitido por ecf}
    RegistroC490: TRegistroC490; {Registro analítico do movimento diário}

    RegistroC500: TRegistroC500; {Nota de energia elétrica (código 06), nota de fornecimento d'água canalizada (código 29) e nota fiscal consumo fornecimento de gás (código 28)}
  //RegistroC510: TRegistroC510; {Itens do documento}
    RegistroC590: TRegistroC590; {Registro analítico}

    bGerarItens: Boolean;
    bDocumentoEletronico: Boolean;

    RegistroC400List: TRegistroC400List;
    RegistroC425List: TRegistroC425List;
    RegistroC460List: TRegistroC460List;
    RegistroC490List: TRegistroC490List;
    indxC400: Integer;
    indxC405: Integer;
    indxC420: Integer;
    indxC425: Integer;
    indxC460: Integer;
    indxC470: Integer;
    indxC490: Integer;

    iCountLimite: Integer;
    UniMedida,VTeste,DevComCfopAliq:string;
    ValorIcmsC100,ValorBCIcmsC100,
     ValorIcmsNC100,ValorBCIcmsNC100,ValorIcmsC1001403,ValorBCIcmsC1001403:Double;
begin
//   if (DebugHook = 0) and (not Self.FSemLimite) then
//      iCountLimite := _LIM_DOC
//   else
      iCountLimite := 0;

  Screen.Cursor := crHourglass;

   GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ' : Gerando Registros C100 - NF-e 55 e NFC-e 65');

   // Registro C001
   RegistroC001 := FcompSpedFiscal.Bloco_C.RegistroC001New;
   RegistroC001.IND_MOV := imSemDados;
   AtualizarStatus('Registro C100 (Mod. 55 e 65): ');
   IniciaBar(FTabelaRegC100.RecordCount);
   FTabelaRegC100.First;
   while (not FTabelaRegC100.Eof) do
      begin

         ValorIcmsC100   := 0;
         ValorBCIcmsC100 := 0;

         ValorIcmsNC100  := 0;
         ValorBCIcmsNC100:= 0;

         IncBar;

         AtualizarStatus('Registro C100 (Mod. 55 e 65): ');

         RegistroC100 := FcompSpedFiscal.Bloco_C.RegistroC100New;


         if (FTabelaRegC100.FieldByName('IND_OPER').AsInteger = 0) then
            RegistroC100.IND_OPER := tpEntradaAquisicao
         else
            RegistroC100.IND_OPER := tpSaidaPrestacao;

         {Se encontrar o CNPJ na chave do documetno é emissão propria}
         if (Pos(Self.FCnpjEmpresa, FTabelaRegC100.FieldByName('CHV_NFE').AsString) > 0) then
             RegistroC100.IND_EMIT := edEmissaoPropria
         else
            RegistroC100.IND_EMIT := edTerceiros;

         RegistroC100.COD_MOD  := Trim(FTabelaRegC100.FieldByName('COD_MOD').AsString);
         RegistroC100.SER      := Trim(FTabelaRegC100.FieldByName('SER').AsString);
         RegistroC100.NUM_DOC  := Trim(FTabelaRegC100.FieldByName('NUM_DOC').AsString);
         RegistroC100.CHV_NFE  := FTabelaRegC100.FieldByName('CHV_NFE').AsString;

         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 0) then
             RegistroC100.COD_SIT := sdRegular
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 1) then
             RegistroC100.COD_SIT := sdExtempRegular
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 2) then
             RegistroC100.COD_SIT := sdCancelado
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 3) then
            RegistroC100.COD_SIT := sdCanceladoExtemp
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 4) then
            RegistroC100.COD_SIT := sdDoctoDenegado
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 5) then
            RegistroC100.COD_SIT := sdDoctoNumInutilizada
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 6) then
            RegistroC100.COD_SIT := sdFiscalCompl
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 7) then
            RegistroC100.COD_SIT := sdExtempCompl
         else
         if (FTabelaRegC100.FieldByName('COD_SIT').AsInteger = 8) then
             RegistroC100.COD_SIT := sdRegimeEspecNEsp;

         if (RegistroC100.COD_SIT <> sdRegular) then
            begin
               FTabelaRegC100.Next;
               Continue;
            end;

         RegistroC100.COD_PART := Trim(FTabelaRegC100.FieldByName('COD_PART').AsString);
         RegistroC100.DT_DOC   := FTabelaRegC100.FieldByName('DT_DOC').AsDateTime;
         RegistroC100.DT_E_S   := FTabelaRegC100.FieldByName('DT_E_S').AsDateTime;
         RegistroC100.VL_DOC   := FTabelaRegC100.FieldByName('VL_DOC').AsCurrency;

         if (FTabelaRegC100.FieldByName('IND_PGTO').AsInteger = 2) then
            RegistroC100.IND_PGTO := TACBrIndPgto.tpOutros
         else
         if (FTabelaRegC100.FieldByName('IND_PGTO').AsInteger = 1) then
            RegistroC100.IND_PGTO := TACBrIndPgto.tpPrazo
         else
            RegistroC100.IND_PGTO := TACBrIndPgto.tpVista;

         RegistroC100.VL_DESC    := FTabelaRegC100.FieldByName('VL_DESC').AsCurrency;
         RegistroC100.VL_ABAT_NT := FTabelaRegC100.FieldByName('VL_ABAT_NT').AsCurrency;
         RegistroC100.VL_MERC    := FTabelaRegC100.FieldByName('VL_MERC').AsCurrency;

         if (RegistroC100.COD_MOD = '65') then
            RegistroC100.IND_FRT := tfSemCobrancaFrete
         else
         if (FTabelaRegC100.FieldByName('IND_FRT').AsInteger = 0) then
            RegistroC100.IND_FRT := tfPorContaEmitente
         else
         if (FTabelaRegC100.FieldByName('IND_FRT').AsInteger = 1) then
            RegistroC100.IND_FRT := tfPorContaDestinatario
         else
         if (FTabelaRegC100.FieldByName('IND_FRT').AsInteger = 2) then
            RegistroC100.IND_FRT := tfPorContaTerceiros
         else
            RegistroC100.IND_FRT := tfSemCobrancaFrete;

         RegistroC100.VL_FRT        := FTabelaRegC100.FieldByName('VL_FRT').AsCurrency;
         RegistroC100.VL_SEG        := FTabelaRegC100.FieldByName('VL_SEG').AsCurrency;
         RegistroC100.VL_OUT_DA     := FTabelaRegC100.FieldByName('VL_OUT_DA').AsCurrency;
         RegistroC100.VL_BC_ICMS    := FTabelaRegC100.FieldByName('VL_BC_ICMS').AsCurrency;
         RegistroC100.VL_ICMS       := FTabelaRegC100.FieldByName('VL_ICMS').AsCurrency;


        if  RegistroC100.NUM_DOC='1812'then
           VTeste:='ok';

        if ((RegistroC100.IND_EMIT = edEmissaoPropria) and (RegistroC100.COD_MOD = '55')) or (RegistroC100.IND_EMIT = edTerceiros) then
          begin

              // ******************* gatilho para pegar cfop  6411 ,5411 *******************

             FTabelaRegC170.Filtered := False;
             FTabelaRegC170.Filter   := 'NFID = ' + FTabelaRegC100.FieldByName('ID').AsString;
             FTabelaRegC170.Filtered := True;

             DevComCfopAliq:='';
             if (RegistroC100.IND_EMIT = edEmissaoPropria) then
               begin
                 FTabelaRegC170.Filtered := False;
                 FTabelaRegC170.Filter   := 'NFID = ' + FTabelaRegC100.FieldByName('ID').AsString;
                 FTabelaRegC170.Filtered := True;
                 FTabelaRegC170.First;
                 while (not FTabelaRegC170.Eof) do
                    begin

                       if pos(FTabelaRegC170.FieldByName('CFOP').AsString ,'5411,6411')>0 then
                          begin

                           if (FTabelaRegC170.FieldByName('CST_ICMS').AsString= '00') or
                              (FTabelaRegC170.FieldByName('CST_ICMS').AsString= '20') then
                             begin
                               DevComCfopAliq:='S'; // e NFe devolucao com cfop 5411 ou 6411
                             end;

                          end;

                      FTabelaRegC170.Next;

                    end;

               end;

           //**************************************************************************


            if (RegistroC100.IND_EMIT = edTerceiros) then
               begin

                   RegistroC100.VL_BC_ICMS_ST := 0;
                   RegistroC100.VL_ICMS_ST    := 0;

               end;
//            else
//               begin
//
//                  if (RegistroC100.IND_EMIT = edEmissaoPropria) and (RegistroC100.COD_MOD = '65')  then
//                      begin
//
//                          if ((FTabelaRegC170.FieldByName('CST_ICMS').AsString= '00') or
//                             (FTabelaRegC170.FieldByName('CST_ICMS').AsString= '20')) then
//                              begin
//
//                                 RegistroC100.VL_BC_ICMS    := FTabelaRegC170.FieldByName('VL_BC_ICMS').AsCurrency;
//                                 RegistroC100.VL_ICMS       := FTabelaRegC170.FieldByName('VL_ICMS').AsCurrency;
//                                 RegistroC100.VL_BC_ICMS_ST := FTabelaRegC100.FieldByName('VL_BC_ICMS_ST').AsCurrency;
//                                 RegistroC100.VL_ICMS_ST    := FTabelaRegC100.FieldByName('VL_ICMS_ST').AsCurrency;
//
//
//                              end
//                          else
//                              begin
//
//
//                                 RegistroC100.VL_BC_ICMS    := 0;
//                                 RegistroC100.VL_ICMS       := 0;
//                                 RegistroC100.VL_BC_ICMS_ST := FTabelaRegC100.FieldByName('VL_BC_ICMS_ST').AsCurrency;
//                                 RegistroC100.VL_ICMS_ST    := FTabelaRegC100.FieldByName('VL_ICMS_ST').AsCurrency;
//
//                              end;
//
//
//                      end;
//
//
//               end;



             if (RegistroC100.IND_EMIT = edEmissaoPropria) and (RegistroC100.COD_MOD = '55') and (DevComCfopAliq='S') then
                   begin
                  RegistroC100.VL_BC_ICMS_ST := 0;
                  RegistroC100.VL_ICMS_ST    := 0;
                  RegistroC100.VL_BC_ICMS    := 0;
                  RegistroC100.VL_ICMS       := 0;
                 end
             else if (RegistroC100.IND_EMIT = edEmissaoPropria) and (RegistroC100.COD_MOD = '55')  then
                 begin
                  RegistroC100.VL_BC_ICMS_ST := 0;
                  RegistroC100.VL_ICMS_ST    := 0;
                  RegistroC100.VL_BC_ICMS    := 0;
                  RegistroC100.VL_ICMS       := 0;
                 end ;

             RegistroC100.VL_IPI        := FTabelaRegC100.FieldByName('VL_IPI').AsCurrency;
             RegistroC100.VL_PIS        := FTabelaRegC100.FieldByName('VL_PIS').AsCurrency;
             RegistroC100.VL_COFINS     := FTabelaRegC100.FieldByName('VL_COFINS').AsCurrency;
             RegistroC100.VL_PIS_ST     := 0;
             RegistroC100.VL_COFINS_ST  := 0;


             {Registro C170}
             FTabelaRegC170.Filtered := False;
             FTabelaRegC170.Filter   := 'NFID = ' + FTabelaRegC100.FieldByName('ID').AsString;
             FTabelaRegC170.Filtered := True;

             bDocumentoEletronico := ((RegistroC100.COD_MOD = '55') or (RegistroC100.COD_MOD = '65'));
             bGerarItens := (not ((bDocumentoEletronico) and (RegistroC100.IND_EMIT = edEmissaoPropria)));

             if bGerarItens then
                begin
                   FTabelaRegC170.First;
                   while (not FTabelaRegC170.Eof) do
                      begin
                         //mauricio 05062024
                         UniMedida := UpperCase(COPY(FTabelaRegC170.FieldByName('UNID').AsString,1,2));
                          if (UniMedida <>  'UN') AND
                             (UniMedida <>  'PC') AND
                             (UniMedida <>  'BI') AND
                             (UniMedida <>  'BL') AND
                             (UniMedida <>  'CT') AND
                             (UniMedida <>  'DP') AND
                             (UniMedida <>  'DZ') AND
                             (UniMedida <>  'EN') AND
                             (UniMedida <>  'FD') AND
                             (UniMedida <>  'FR') AND
                             (UniMedida <>  'KG') AND
                             (UniMedida <>  'LT') AND
                             (UniMedida <>  'PO') AND
                             (UniMedida <>  'TB') AND
                             (UniMedida <>  'VD') then
                              UniMedida :=  'UN';

                         RegistroC170 := FcompSpedFiscal.Bloco_C.RegistroC170New;
                         RegistroC170.NUM_ITEM         := FTabelaRegC170.FieldByName('NUM_ITEM').AsString;
                         RegistroC170.COD_ITEM         := Trim(FTabelaRegC170.FieldByName('COD_ITEM').AsString);
                         RegistroC170.DESCR_COMPL      := Trim(FTabelaRegC170.FieldByName('DESCR_COMPL').AsString);
                         RegistroC170.QTD              := FTabelaRegC170.FieldByName('QTD').AsFloat;
                         RegistroC170.UNID             := Trim(UniMedida);
                         RegistroC170.VL_ITEM          := FTabelaRegC170.FieldByName('VL_ITEM').AsFloat;
                         RegistroC170.VL_DESC          := FTabelaRegC170.FieldByName('VL_DESC').AsFloat;
                         UniMedida:='';

                         if (FTabelaRegC170.FieldByName('IND_MOV').AsInteger = 0) then      // Movimentação fisica = 0.SIM  1.NÃO
                            RegistroC170.IND_MOV := mfSim
                         else
                            RegistroC170.IND_MOV := mfNao;


                         RegistroC170.CST_ICMS := Trim(FTabelaRegC170.FieldByName('CST_ICMS').AsString);
                         RegistroC170.CFOP     := Trim(FTabelaRegC170.FieldByName('CFOP').AsString);
                         RegistroC170.COD_NAT  := Trim(FTabelaRegC170.FieldByName('COD_NAT').AsString);


                         if (RegistroC100.IND_EMIT = edTerceiros) then
                            begin

                                if (RegistroC170.CST_ICMS = '00') or  // alterei todo o codigo em 24072024  inicio
                                   (RegistroC170.CST_ICMS = '20') then
                                   begin

                                      if Pos(RegistroC170.CFOP,'1102,1910,2102,2910') > 0  then
                                         begin
                                            RegistroC170.VL_BC_ICMS_ST := FTabelaRegC170.FieldByName('VL_BC_ICMS_ST').AsFloat;
                                            RegistroC170.VL_BC_ICMS    := FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat;
                                            RegistroC170.VL_ICMS_ST    := FTabelaRegC170.FieldByName('VL_ICMS_ST').AsFloat;
                                            RegistroC170.ALIQ_ST       := FTabelaRegC170.FieldByName('ALIQ_ST').AsFloat;
                                            RegistroC170.VL_ICMS       := RegistroC170.VL_ICMS  + FTabelaRegC170.FieldByName('VL_ICMS').AsFloat;
                                            RegistroC170.ALIQ_ICMS     := FTabelaRegC170.FieldByName('ALIQ_ICMS').AsFloat;
                                            RegistroC100.VL_ICMS       := RegistroC100.VL_ICMS    + RegistroC170.VL_ICMS ;
                                            RegistroC100.VL_BC_ICMS    := RegistroC100.VL_BC_ICMS + RegistroC170.VL_BC_ICMS;
                                            ValorIcmsC100              := ValorIcmsC100   + RegistroC170.VL_ICMS ;
                                            ValorBCIcmsC100            := ValorBCIcmsC100 + RegistroC170.VL_BC_ICMS;
                                         end
                                       else
                                         begin

                                            RegistroC170.VL_BC_ICMS_ST := 0;
                                            RegistroC170.VL_BC_ICMS    := 0;
                                            RegistroC170.VL_ICMS_ST    := 0;
                                            RegistroC170.ALIQ_ST       := 0;
                                            RegistroC170.VL_ICMS       := 0;
                                            RegistroC170.ALIQ_ICMS     := 0;

                                         end;

                                   end
                                else
                                    begin
                                     RegistroC170.VL_BC_ICMS_ST := 0;
                                     RegistroC170.VL_BC_ICMS    := 0;
                                     RegistroC170.VL_ICMS_ST    := 0;
                                     RegistroC170.VL_ICMS       := 0;
                                     RegistroC170.ALIQ_ICMS     := 0;
                                     RegistroC170.ALIQ_ST       := 0;
                                   end;


                               if (RegistroC100.IND_EMIT = edTerceiros) then
                                  begin
                                    RegistroC100.VL_BC_ICMS_ST := RegistroC100.VL_BC_ICMS_ST + RegistroC170.VL_BC_ICMS_ST;
                                    RegistroC100.VL_ICMS_ST    := RegistroC100.VL_ICMS_ST    + RegistroC170.VL_ICMS_ST;
                                  end;

                            end ;



                       {$REGION 'Credito}


    //                     { 30, 40, 41, 50, ou 60, então os valores dos campos VL_BC_ICMS, ALIQ_ICMS e VL_ICMS deverão ser iguais a “0” (zero)}
    //                     if (RegistroC170.CST_ICMS = '10') or
    //                        (RegistroC170.CST_ICMS = '30') or
    //                        (RegistroC170.CST_ICMS = '40') or
    //                        (RegistroC170.CST_ICMS = '41') or
    //                        (RegistroC170.CST_ICMS = '50') or
    //                        (RegistroC170.CST_ICMS = '60') then
    //                        begin
    //                           RegistroC170.VL_BC_ICMS := 0;
    //                           RegistroC170.ALIQ_ICMS  := 0;
    //                           RegistroC170.VL_ICMS    := 0;
    //                        end
    //                     else
    //                        begin
    //
    //                          if Pos(RegistroC170.CFOP, '1403') > 0  then
    //                              begin
    //                               RegistroC170.VL_BC_ICMS_ST := 0;
    //                               RegistroC170.VL_BC_ICMS    := 0;
    //                               RegistroC170.VL_ICMS_ST    := 0;
    //                               RegistroC170.VL_ICMS       := 0;
    //                               RegistroC170.ALIQ_ICMS     := 0;
    //                               RegistroC170.ALIQ_ST       := 0;
    //                               ValorIcmsC1001403          := 0;
    //                               ValorBCIcmsC1001403        := 0;
    //                              end
    //                           else
    //                              begin
    //
    //                               RegistroC170.VL_BC_ICMS := FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat;
    //                               RegistroC170.ALIQ_ICMS  := FTabelaRegC170.FieldByName('ALIQ_ICMS').AsFloat;    //aqui 1102
    //                               RegistroC170.VL_ICMS    := RegistroC170.VL_ICMS + FTabelaRegC170.FieldByName('VL_ICMS').AsFloat;
    //                               ValorIcmsC100           := ValorIcmsC100 + RegistroC170.VL_ICMS;
    //                               ValorBCIcmsC100         := RegistroC100.VL_BC_ICMS +FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat;
    //
    //                              end;
    //
    //                        end;
    //
    //
    //
    //                     {10, 30 ou 70, os valores dos campos VL_BC_ICMS_ST, ALIQ_ST e VL_ICMS_ST deverão ser maiores ou iguais a “0” (zero).}
    //                     if //(RegistroC170.CST_ICMS = '00') or
    //                        (RegistroC170.CST_ICMS = '10') or
    //                        (RegistroC170.CST_ICMS = '70') or
    //                        (RegistroC170.CST_ICMS = '30') then
    //                        begin
    //
    //                          if Pos(RegistroC170.CFOP, '1403,1910,1102,2910') > 0  then
    //                             begin
    //                               RegistroC170.VL_BC_ICMS_ST := 0;
    //                               RegistroC170.VL_BC_ICMS    := 0;
    //                               RegistroC170.VL_ICMS_ST    := 0;
    //                               RegistroC170.VL_ICMS       := 0;
    //                               RegistroC170.ALIQ_ICMS     := 0;
    //                               RegistroC170.ALIQ_ST       := 0;
    //                               RegistroC100.VL_ICMS       := 0;
    //                               RegistroC100.VL_BC_ICMS    := 0;
    //                               ValorIcmsC1001403          := 0;
    //                               ValorBCIcmsC1001403        := 0;
    //                             end
    //                          else
    //                            begin
    //                              RegistroC170.VL_BC_ICMS_ST := FTabelaRegC170.FieldByName('VL_BC_ICMS_ST').AsFloat;
    //                              RegistroC170.ALIQ_ST       := FTabelaRegC170.FieldByName('ALIQ_ST').AsFloat;
    //                              RegistroC170.VL_ICMS_ST    := FTabelaRegC170.FieldByName('VL_ICMS_ST').AsFloat;
    //                              RegistroC170.VL_ICMS       := RegistroC170.VL_ICMS  + FTabelaRegC170.FieldByName('VL_ICMS').AsFloat; // mau teste /// mau teste 24082024
    //                              ValorIcmsC100              := ValorIcmsC100 + RegistroC170.VL_ICMS;
    //                              ValorBCIcmsC100            := RegistroC100.VL_BC_ICMS +FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat;
    //                            end;
    //
    //
    //                         if (RegistroC100.IND_EMIT = edTerceiros) then
    //                            begin
    //                              RegistroC100.VL_BC_ICMS_ST := RegistroC100.VL_BC_ICMS_ST + RegistroC170.VL_BC_ICMS_ST;
    //                              RegistroC100.VL_ICMS_ST    := RegistroC100.VL_ICMS_ST    + RegistroC170.VL_ICMS_ST;
    //                            end;
    //                        end
    //                       else
    //                         begin
    //                           {Diferentes de 10, 30 ou 70, os valores dos campos VL_BC_ST, ALIQ_ST e VL_ICMS_ST deverão ser iguais a “0” (zero). }
    //                           RegistroC170.VL_BC_ICMS_ST := 0;
    //                           RegistroC170.ALIQ_ST       := 0;
    //                           RegistroC170.VL_ICMS_ST    := 0;
    //                        end;
    //
    //                      RegistroC100.VL_ICMS       := ValorIcmsC100 + ValorIcmsC1001403;
    //                      RegistroC100.VL_BC_ICMS    := ValorBCIcmsC100 + ValorBCIcmsC1001403;

    {$ENDREGION}


                          {Nota de entrada e fornecedor simples}
                         if (RegistroC100.IND_OPER = tpEntradaAquisicao) and
                            ( (RegistroC170.CST_ICMS = '101') or
                              (RegistroC170.CST_ICMS = '102') or
                              (RegistroC170.CST_ICMS = '103') or
                              (RegistroC170.CST_ICMS = '201') or
                              (RegistroC170.CST_ICMS = '202') or
                              (RegistroC170.CST_ICMS = '203') or
                              (RegistroC170.CST_ICMS = '300') or
                              (RegistroC170.CST_ICMS = '400') or
                              (RegistroC170.CST_ICMS = '500') or
                              (RegistroC170.CST_ICMS = '900') ) then
                            begin
                                //Validação CSOSN - Somente para entrada de Nota - ICMS Próprio
                                if (RegistroC170.CST_ICMS = '202') or
                                   (RegistroC170.CST_ICMS = '102') or
                                   (RegistroC170.CST_ICMS = '300') or
                                   (RegistroC170.CST_ICMS = '500') then
                                    begin
                                       RegistroC170.VL_BC_ICMS := 0;
                                       RegistroC170.ALIQ_ICMS  := 0;
                                       RegistroC170.VL_ICMS    := 0;
                                    end
                                else
                                    begin
                                       {Diferentes de 202(30), 102(40, 41), 300(50), e 500(60), então os valores dos campos VL_BC_ICMS, ALIQ_ICMS e VL_ICMS deverão ser maiores que “0” (zero);}
                                       RegistroC170.VL_BC_ICMS := FTabelaRegC170.FieldByName('VL_BC_ICMS').AsCurrency;
                                       RegistroC170.ALIQ_ICMS  := FTabelaRegC170.FieldByName('ALIQ_ICMS').AsCurrency;
                                       RegistroC170.VL_ICMS    := FTabelaRegC170.FieldByName('VL_ICMS').AsCurrency;
                                    end; {CSOSN Entrada - ICMS Proprio}

                                { Validação CSOSN - Somente para entrada de Nota - ICMS Substituição Tributaria
                                  201(10,70), 202(30) os valores dos campos VL_BC_ICMS_ST, ALIQ_ST e VL_ICMS_ST deverão ser maiores ou iguais a “0” (zero).}
                                if (RegistroC170.CST_ICMS = '201') or
                                   (RegistroC170.CST_ICMS = '202') then
                                   begin
                                       RegistroC170.VL_BC_ICMS_ST   := FTabelaRegC170.FieldByName('VL_BC_ICMS_ST').AsCurrency;
                                       RegistroC170.ALIQ_ST         := FTabelaRegC170.FieldByName('ALIQ_ST').AsCurrency;
                                       RegistroC170.VL_ICMS_ST      := FTabelaRegC170.FieldByName('VL_ICMS_ST').AsCurrency;
                                   end
                                else
                                    begin
                                      {Diferentes de 201(10,70), 202(30)  os valores dos campos VL_BC_ST, ALIQ_ST e VL_ICMS_ST deverão ser iguais a “0” (zero). }
                                      RegistroC170.VL_BC_ICMS_ST    := 0;
                                      RegistroC170.ALIQ_ST          := 0;
                                      RegistroC170.VL_ICMS_ST       := 0;
                                   end; {CSOSN Entrada - ICMS ST}
                             end; {if se nota de entrada e fornecedor simples}

                         if (FTabelaRegC170.FieldByName('IND_APUR').AsInteger = 0) then       // 0 mauricio
                            RegistroC170.IND_APUR := iaMensal
                         else
                            RegistroC170.IND_APUR := iaDecendial;

                         RegistroC170.CST_IPI := FTabelaRegC170.FieldByName('CST_IPI').AsString;
                         RegistroC170.COD_ENQ := ''; {Não preencher - segundo o manual}

                        RegistroC170.VL_BC_IPI        := FTabelaRegC170.FieldByName('VL_BC_IPI').AsCurrency;
                        RegistroC170.ALIQ_IPI         := FTabelaRegC170.FieldByName('ALIQ_IPI').AsCurrency;
                        RegistroC170.VL_IPI           := FTabelaRegC170.FieldByName('VL_IPI').AsCurrency;
                        RegistroC170.CST_PIS          := FTabelaRegC170.FieldByName('CST_PIS').AsString;
                        RegistroC170.VL_BC_PIS        := FTabelaRegC170.FieldByName('VL_BC_PIS').AsCurrency;
                        RegistroC170.ALIQ_PIS_PERC    := FTabelaRegC170.FieldByName('ALIQ_PIS_PERC').AsCurrency;
                        RegistroC170.QUANT_BC_PIS     := 0;
                        RegistroC170.ALIQ_PIS_R       := 0; {EM REAIS}
                        RegistroC170.VL_PIS           := FTabelaRegC170.FieldByName('VL_PIS').AsCurrency;
                        RegistroC170.CST_COFINS       := FTabelaRegC170.FieldByName('CST_COFINS').AsString;
                        RegistroC170.VL_BC_COFINS     := FTabelaRegC170.FieldByName('VL_BC_COFINS').AsCurrency;
                        RegistroC170.ALIQ_COFINS_PERC := FTabelaRegC170.FieldByName('ALIQ_COFINS_PERC').AsCurrency;
                        RegistroC170.QUANT_BC_COFINS  := 0;
                        RegistroC170.ALIQ_COFINS_R    := 0; {EM REAIS}
                        RegistroC170.VL_COFINS        := FTabelaRegC170.FieldByName('VL_COFINS').AsCurrency;
                        RegistroC170.COD_CTA          := '';

                        FTabelaRegC170.Next;
                      end; {while registro C170}
                end;{if bGerarItens}


               if (RegistroC100.IND_EMIT = edEmissaoPropria) and (RegistroC100.COD_MOD = '65')  then
                      begin

                          if ((FTabelaRegC170.FieldByName('CST_ICMS').AsString = '00') or
                              (FTabelaRegC170.FieldByName('CST_ICMS').AsString = '20')) then
                              begin

                                  FTabelaRegC170.First;
                                  while not  FTabelaRegC170.eof do
                                    begin
                                     ValorIcmsNC100              := ValorIcmsNC100   + FTabelaRegC170.FieldByName('VL_ICMS').AsFloat;
                                     ValorBCIcmsNC100            := ValorBCIcmsNC100 + FTabelaRegC170.FieldByName('VL_BC_ICMS').AsFloat;
                                     FTabelaRegC170.Next;
                                    end;

                              end;
                      end;

            if (RegistroC100.IND_EMIT = edTerceiros) then
                begin

                   RegistroC100.VL_ICMS   := ValorIcmsC100;
                   RegistroC100.VL_BC_ICMS:= ValorBCIcmsC100;

                end;

    //        if (RegistroC100.IND_EMIT = edEmissaoPropria) then
    //            begin
    //
    //              RegistroC100.VL_ICMS   := ValorIcmsNC100;
    //              RegistroC100.VL_BC_ICMS:= ValorBCIcmsNC100;
    //
    //            end;

          end;



         {Registro C190}
         FTabelaRegC190.Filtered := False;
         FTabelaRegC190.Filter   := 'NFID = ' + FTabelaRegC100.FieldByName('ID').AsString;
         FTabelaRegC190.Filtered := True;
         FTabelaRegC190.First;
         while not FTabelaRegC190.Eof do
            begin
               RegistroC190 := FcompSpedFiscal.Bloco_C.RegistroC190New;

               RegistroC190.VL_BC_ICMS    := FTabelaRegC190.FieldByName('VL_BC_ICMS').AsFloat;
               RegistroC190.VL_ICMS       := FTabelaRegC190.FieldByName('VL_ICMS').AsFloat;
               RegistroC190.ALIQ_ICMS     := FTabelaRegC190.FieldByName('ALIQ_ICMS').AsFloat;
               RegistroC190.CST_ICMS      := Trim(FTabelaRegC190.FieldByName('CST_ICMS').AsString);
               RegistroC190.CFOP          := Trim(FTabelaRegC190.FieldByName('CFOP').AsString);
               RegistroC190.VL_BC_ICMS_ST := FTabelaRegC190.FieldByName('VL_BC_ICMS_ST').AsFloat;
               RegistroC190.VL_ICMS_ST    := FTabelaRegC190.FieldByName('VL_ICMS_ST').AsFloat;

               RegistroC190.VL_OPR        := FTabelaRegC190.FieldByName('VL_OPR').AsFloat;
               RegistroC190.VL_RED_BC     := FTabelaRegC190.FieldByName('VL_RED_BC').AsCurrency;
               RegistroC190.VL_IPI        := FTabelaRegC190.FieldByName('VL_IPI').AsCurrency;
               RegistroC190.COD_OBS       := '';

               {10, 30 ou 70, os valores dos campos VL_BC_ICMS_ST e VL_ICMS_ST deverão ser maiores ou iguais a “0” (zero).}

                if (RegistroC100.IND_EMIT = edTerceiros) then
                   begin

                     if (RegistroC190.CST_ICMS = '00') or  // alterei todo o codigo em 24072024  inicio
                        (RegistroC190.CST_ICMS = '20') then
                        begin
                            if Pos(RegistroC190.CFOP, '1102,1910,2102,2910') > 0  then
                               begin
                                 RegistroC190.VL_BC_ICMS_ST := 0;
                                 RegistroC190.VL_ICMS_ST    := 0;
                               end
                               else
                               begin
                                  RegistroC190.VL_BC_ICMS_ST := 0;
                                  RegistroC190.VL_BC_ICMS    := 0;
                                  RegistroC190.VL_ICMS_ST    := 0;
                                  RegistroC190.ALIQ_ICMS     := 0;
                                  RegistroC190.VL_ICMS       := 0;
                               end;


                        end
                     else
                        begin
                           {Diferentes de 10, 30 ou 70, os valores dos campos VL_BC_ST e VL_ICMS_ST deverão ser iguais a “0” (zero). }
                           RegistroC190.VL_BC_ICMS_ST := 0;
                           RegistroC190.VL_ICMS_ST    := 0;
                           RegistroC190.VL_BC_ICMS    := 0;
                           RegistroC190.ALIQ_ICMS     := 0;
                           RegistroC190.VL_ICMS       := 0;
                        end;
                   end
               else
                   begin

                      if (RegistroC190.CST_ICMS = '10') or
                         (RegistroC190.CST_ICMS = '30') or
                         (RegistroC190.CST_ICMS = '70') then   //mauricio troquei pelo codigo comentando abaixo 2307204
                        begin

                         if Pos(RegistroC190.CFOP, '1410, 1411, 1414, 1415, 1660, 1661, 1662, 2410, 2411, 2414, 2415, 2660, 2661, 2662') > 0  then
                           begin
                             RegistroC190.VL_BC_ICMS_ST := FTabelaRegC190.FieldByName('VL_BC_ICMS_ST').AsFloat;
                             RegistroC190.VL_ICMS_ST    := FTabelaRegC190.FieldByName('VL_ICMS_ST').AsFloat;
                           end
                           else
                           begin
                             RegistroC190.VL_BC_ICMS_ST := 0;
                             RegistroC190.VL_BC_ICMS    := 0;
                             RegistroC190.VL_ICMS_ST    := 0;
                             RegistroC190.ALIQ_ICMS     := 0;
                             RegistroC190.VL_ICMS       := 0;
                           end;
                        end
                     else
                        begin
                           {Diferentes de 10, 30 ou 70, os valores dos campos VL_BC_ST e VL_ICMS_ST deverão ser iguais a “0” (zero). }
                           RegistroC190.VL_BC_ICMS_ST := 0;
                           RegistroC190.VL_ICMS_ST    := 0;
                           RegistroC190.VL_BC_ICMS    := 0;
                           RegistroC190.ALIQ_ICMS     := 0;
                           RegistroC190.VL_ICMS       := 0;
                        end;

                   end;


                if (RegistroC100.IND_EMIT = edEmissaoPropria)and (RegistroC100.COD_MOD = '65') then
                    begin

                          if (Pos(RegistroC190.CFOP,'5102')>0 ) and
                             ((RegistroC190.CST_ICMS = '00')
                           or( RegistroC190.CST_ICMS = '20')) then
                             begin

                               RegistroC190.VL_BC_ICMS_ST := FTabelaRegC190.FieldByName('VL_BC_ICMS_ST').AsFloat;
                               RegistroC190.VL_ICMS_ST    := FTabelaRegC190.FieldByName('VL_ICMS_ST').AsFloat;
                               RegistroC190.VL_BC_ICMS    := FTabelaRegC190.FieldByName('VL_BC_ICMS').AsFloat;  //mauricio 10092024
                               RegistroC190.VL_ICMS       := FTabelaRegC190.FieldByName('VL_ICMS').AsFloat;
                               RegistroC190.ALIQ_ICMS     := FTabelaRegC190.FieldByName('ALIQ_ICMS').AsFloat;

                             end;

                    end;


               {Se for nota de entrada e fornecedor simples}
               if (RegistroC100.IND_OPER = tpEntradaAquisicao) and
                  ( (RegistroC190.CST_ICMS = '101') or
                    (RegistroC190.CST_ICMS = '102') or
                    (RegistroC190.CST_ICMS = '103') or
                    (RegistroC190.CST_ICMS = '201') or
                    (RegistroC190.CST_ICMS = '202') or
                    (RegistroC190.CST_ICMS = '203') or
                    (RegistroC190.CST_ICMS = '300') or
                    (RegistroC190.CST_ICMS = '400') or
                    (RegistroC190.CST_ICMS = '500') or
                    (RegistroC190.CST_ICMS = '900')   ) then
                  begin
                     {CSOSN Entrada 202, 102, 300, ou 500, então os valores dos campos VL_BC_ICMS, ALIQ_ICMS e VL_ICMS deverão ser iguais a “0” (zero)}
                     if (RegistroC190.CST_ICMS = '202') or
                        (RegistroC190.CST_ICMS = '102') or
                        (RegistroC190.CST_ICMS = '300') or
                        (RegistroC190.CST_ICMS = '500') then
                        begin
                           RegistroC190.VL_BC_ICMS := 0;
                           RegistroC190.VL_ICMS    := 0;
                           RegistroC190.ALIQ_ICMS  := 0;
                        end
                     else
                        begin
                           {Diferentes de 202, 102, 300, ou 500, então os valores dos campos VL_BC_ICMS, ALIQ_ICMS e VL_ICMS deverão ser maiores que “0” (zero);}
                           RegistroC190.ALIQ_ICMS  := FTabelaRegC190.FieldByName('ALIQ_ICMS').AsFloat;
                           RegistroC190.VL_BC_ICMS := FTabelaRegC190.FieldByName('VL_BC_ICMS').AsFloat;
                           RegistroC190.VL_ICMS    := FTabelaRegC190.FieldByName('VL_ICMS').AsFloat;
                        end; {CSOSN - ICMS Proprio}

                     {201 ou 202 os valores dos campos VL_BC_ICMS_ST e VL_ICMS_ST deverão ser maiores ou iguais a “0” (zero).}
                     if (RegistroC190.CST_ICMS = '201') or
                        (RegistroC190.CST_ICMS = '202') then
                        begin
                           if Pos(RegistroC190.CFOP, '1403,1410, 1411, 1414, 1415, 1660, 1661, 1662, 2403,2410, 2411, 2414, 2415, 2660, 2661, 2662') > 0 then  //1403,2403 19072024
                           begin
                             RegistroC190.VL_BC_ICMS_ST := 0;
                             RegistroC190.VL_ICMS_ST    := 0;
                           end
                           else
                           begin
                             RegistroC190.VL_BC_ICMS_ST := FTabelaRegC190.FieldByName('VL_BC_ICMS_ST').AsFloat;
                             RegistroC190.VL_ICMS_ST    := FTabelaRegC190.FieldByName('VL_ICMS_ST').AsFloat;
                           end;
                        end
                     else
                        begin
                           {Diferentes de 201 e 202 os valores dos campos VL_BC_ST e VL_ICMS_ST deverão ser iguais a “0” (zero). }
                           RegistroC190.VL_BC_ICMS_ST := 0;
                           RegistroC190.VL_ICMS_ST    := 0;
                        end;

                  end; {Nota entrada Fornecedor Simples}

            
               // Usado no Bloco E
               if (RegistroC100.IND_OPER = tpEntradaAquisicao) then
                  begin
                     FTOT_VL_ICMS_CRE := FTOT_VL_ICMS_CRE + RegistroC190.VL_ICMS;

                     if (RegistroC190.VL_ICMS_ST > 0) then
                        begin
                           FVL_TOT_ICMS_ST_NF_ENTRADA := FVL_TOT_ICMS_ST_NF_ENTRADA + RegistroC190.VL_ICMS_ST;
                           // VL_DEVOL_ST - Soma do campo VL_ICMS_ST do registro C190, para CFOP = 1410, 1411, 1414, 1415, 1660, 1661, 1662, 2410, 2411, 2414, 2415, 2660, 2661 ou 2662
                           // VL_RESSARC_ST - Soma do campo VL_ICMS_ST do registro C190, para CFOP 1603 ou 2603.
                        end;
                  end
               else
                  begin
                     FTOT_VL_ICMS_DEB := FTOT_VL_ICMS_DEB + RegistroC190.VL_ICMS;

                     if (RegistroC190.VL_ICMS_ST > 0) then
                        begin
                           FVL_TOT_ICMS_ST_NF_SAIDA := FVL_TOT_ICMS_ST_NF_SAIDA + RegistroC190.VL_ICMS_ST;
                        end;
                  end;

               FTabelaRegC190.Next;
            end;{while C190}

         FTabelaRegC100.Next;
      end; {while C100}

   if (False) then
      begin
         if (FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400.Count = 0) then
            GerarLinhaMemoLog('Não encontrado movimentos de cupom fiscal para gerar! (RegistroC400.Count = 0)')
         else
            begin
               GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C400');
               GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C405');
               GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C420');
               GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C425');
               GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C460');
               GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C470');
               GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C490');

               RegistroC400List := FACBrSPEDECF.Bloco_C.RegistroC001.RegistroC400;
               for indxC400 := 0 to RegistroC400List.Count - 1 do
                  begin
                     RegistroC400 := FcompSpedFiscal.Bloco_C.RegistroC400New;

                     RegistroC400.COD_MOD := RegistroC400List.Items[indxC400].COD_MOD;
                     RegistroC400.ECF_MOD := RegistroC400List.Items[indxC400].ECF_MOD;
                     RegistroC400.ECF_FAB := RegistroC400List.Items[indxC400].ECF_FAB;
                     RegistroC400.ECF_CX  := RegistroC400List.Items[indxC400].ECF_CX;

                     {C405}
                     for indxC405 := 0 to RegistroC400List.items[indxC400].RegistroC405.Count - 1 do
                        begin
                           if (iCountLimite > 0) then
                              if ((indxC405 + 1) > iCountLimite) then
                                 Break;

                           RegistroC405 := FcompSpedFiscal.Bloco_C.RegistroC405New;

                           RegistroC405.DT_DOC      := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].DT_DOC;
                           RegistroC405.CRO         := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].CRO;
                           RegistroC405.CRZ         := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].CRZ;
                           RegistroC405.NUM_COO_FIN := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].NUM_COO_FIN;
                           RegistroC405.GT_FIN      := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].GT_FIN;
                           RegistroC405.VL_BRT      := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].VL_BRT;

                           {C420}
                           for indxC420 := 0 to RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC420.Count - 1 do
                              begin
                                 RegistroC420 := FcompSpedFiscal.Bloco_C.RegistroC420New;

                                 RegistroC420.COD_TOT_PAR  := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC420.items[indxC420].COD_TOT_PAR;
                                 RegistroC420.NR_TOT       := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC420.items[indxC420].NR_TOT;
                                 RegistroC420.DESCR_NR_TOT := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC420.items[indxC420].DESCR_NR_TOT;
                                 RegistroC420.VLR_ACUM_TOT := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC420.items[indxC420].VLR_ACUM_TOT;

                                 {C425}
                                 RegistroC425List := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC420.Items[indxC420].RegistroC425;
                                 for indxC425 := 0 to RegistroC425List.Count - 1 do
                                     begin
                                        RegistroC425 := FcompSpedFiscal.Bloco_C.RegistroC425New;

                                        RegistroC425.COD_ITEM  := RegistroC425List.Items[indxC425].COD_ITEM;
                                        RegistroC425.QTD       := RegistroC425List.Items[indxC425].QTD;
                                        RegistroC425.UNID      := RegistroC425List.Items[indxC425].UNID;
                                        RegistroC425.VL_ITEM   := RegistroC425List.Items[indxC425].VL_ITEM;
                                        RegistroC425.VL_PIS    := RegistroC425List.Items[indxC425].VL_PIS;
                                        RegistroC425.VL_COFINS := RegistroC425List.Items[indxC425].VL_COFINS;
                                     end; {for C425}
                              end; {for C420}

                           {C460}
                           RegistroC460List := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC460;
                           for indxC460 := 0 to RegistroC460List.Count - 1 do
                              begin
                                 RegistroC460 := FcompSpedFiscal.Bloco_C.RegistroC460New;

                                 RegistroC460.COD_MOD := RegistroC460List.Items[indxC460].COD_MOD;
                                 RegistroC460.COD_SIT := RegistroC460List.Items[indxC460].COD_SIT;
                                 RegistroC460.NUM_DOC := RegistroC460List.Items[indxC460].NUM_DOC;

                                 if (RegistroC460.COD_SIT = sdRegular) then
                                    begin
                                       {Cliente referenciado neste documento não precisa constar no registro 0150}
                                       RegistroC460.DT_DOC    := RegistroC460List.Items[indxC460].DT_DOC;
                                       RegistroC460.VL_DOC    := RegistroC460List.Items[indxC460].VL_DOC;
                                       RegistroC460.VL_PIS    := RegistroC460List.Items[indxC460].VL_PIS;
                                       RegistroC460.VL_COFINS := RegistroC460List.Items[indxC460].VL_COFINS;

                                       // Só informar CPF-CNPJ se for valido, senão vai em branco
                                       if CPFCNPJValido(RegistroC460List.Items[indxC460].CPF_CNPJ) then
                                          RegistroC460.CPF_CNPJ := RegistroC460List.Items[indxC460].CPF_CNPJ
                                       else
                                          RegistroC460.CPF_CNPJ := '';

                                       RegistroC460.NOM_ADQ := RegistroC460List.Items[indxC460].NOM_ADQ;
                                    end;

                                 {C470}
                                 for indxC470 := 0 to RegistroC460List.Items[indxC460].RegistroC470.Count - 1 do
                                    begin
                                       RegistroC470 := FcompSpedFiscal.Bloco_C.RegistroC470New;

                                       RegistroC470.COD_ITEM  := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].COD_ITEM;
                                       RegistroC470.QTD       := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].QTD;
                                       RegistroC470.QTD_CANC  := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].QTD_CANC;
                                       RegistroC470.UNID      := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].UNID;
                                       RegistroC470.VL_ITEM   := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].VL_ITEM;
                                       RegistroC470.CST_ICMS  := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].CST_ICMS;
                                       RegistroC470.CFOP      := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].CFOP;

                                       if (Copy(RegistroC470.CFOP, 1, 1) <> '5') then
                                          GerarLinhaMemoLog('O código CFOP deve iniciar-se por “5”. Cupom Nr: ' + RegistroC460.NUM_DOC);

                                       RegistroC470.ALIQ_ICMS := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].ALIQ_ICMS;
                                       RegistroC470.VL_PIS    := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].VL_PIS;
                                       RegistroC470.VL_COFINS := RegistroC460List.Items[indxC460].RegistroC470.Items[indxC470].VL_COFINS;
                                    end; {for C470}

                              end; {for C460}

                           {C490}
                           RegistroC490List := RegistroC400List.items[indxC400].RegistroC405.Items[indxC405].RegistroC490;
                           for indxC490 := 0 to RegistroC490List.Count - 1 do
                              begin
                                 RegistroC490 := FcompSpedFiscal.Bloco_C.RegistroC490New;

                                 RegistroC490.CST_ICMS   := RegistroC490List.Items[indxC490].CST_ICMS;
                                 RegistroC490.CFOP       := RegistroC490List.Items[indxC490].CFOP;
                                 RegistroC490.COD_OBS    := RegistroC490List.Items[indxC490].COD_OBS;
                                 RegistroC490.VL_OPR     := RegistroC490List.Items[indxC490].VL_OPR;
                                 RegistroC490.VL_BC_ICMS := RegistroC490List.Items[indxC490].VL_BC_ICMS;
                                 RegistroC490.ALIQ_ICMS  := RegistroC490List.Items[indxC490].ALIQ_ICMS;
                                 RegistroC490.VL_ICMS    := RegistroC490List.Items[indxC490].VL_ICMS;

                                 FTOT_VL_ICMS_DEB := FTOT_VL_ICMS_DEB + RegistroC490.VL_ICMS;
                              end; {for C490}
                        end; {for C405}

                  end;{for C400}
            end;
      end;

   // Registros C500 Agua, Luz e Gas
   if (FTabelaRegC500.Active and (FTabelaRegC500.RecordCount > 0)) then
      begin
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_C + ': Gerando Registros C500 - Energia (06), Água (29) e Gás (28) ');
         FTabelaRegC500.First;
         while (not FTabelaRegC500.Eof) do
            begin
               RegistroC500 := FcompSpedFiscal.Bloco_C.RegistroC500New;

               RegistroC500.IND_OPER := tpEntradaAquisicao;
               RegistroC500.IND_EMIT := edTerceiros;

               RegistroC500.COD_PART := 'CX_F' + Trim(FTabelaRegC500.FieldByName('COD_FORN').AsString);
               RegistroC500.COD_MOD := Trim(FTabelaRegC500.FieldByName('COD_MOD').AsString);
               RegistroC500.COD_SIT := sdRegular;
               RegistroC500.SER := Trim(FTabelaRegC500.FieldByName('SER').AsString);
               RegistroC500.SUB := Trim(FTabelaRegC500.FieldByName('SUB').AsString);

               RegistroC500.COD_CONS         := Trim(FTabelaRegC500.FieldByName('COD_CONS').AsString);
               RegistroC500.NUM_DOC          := Trim(FTabelaRegC500.FieldByName('NUM_DOC').AsString);
               RegistroC500.DT_DOC           := FTabelaRegC500.FieldByName('DT_DOC').AsDateTime;
               RegistroC500.DT_E_S           := FTabelaRegC500.FieldByName('DT_E_S').AsDateTime;
               RegistroC500.VL_DOC           := FTabelaRegC500.FieldByName('VL_DOC').AsCurrency;
               RegistroC500.VL_FORN          := FTabelaRegC500.FieldByName('VL_FORN').AsCurrency;
               RegistroC500.VL_SERV_NT       := FTabelaRegC500.FieldByName('VL_SERV_NT').AsCurrency;
               RegistroC500.VL_TERC          := FTabelaRegC500.FieldByName('VL_TERC').AsCurrency;
               RegistroC500.VL_DA            := FTabelaRegC500.FieldByName('VL_DA').AsCurrency;             //Despesas acessórias

               if (FTabelaRegC500.FieldByName('VL_ICMS').AsCurrency > 0) then
                  begin
                     RegistroC500.VL_BC_ICMS := FTabelaRegC500.FieldByName('VL_BC_ICMS').AsCurrency;
                     RegistroC500.VL_ICMS    := FTabelaRegC500.FieldByName('VL_ICMS').AsCurrency;
                  end
               else
                  begin
                     RegistroC500.VL_BC_ICMS := 0;
                     RegistroC500.VL_ICMS    := 0;
                  end;

               RegistroC500.VL_BC_ICMS_ST    := 0;
               RegistroC500.VL_ICMS_ST       := 0;
               RegistroC500.COD_INF          := '';
               RegistroC500.VL_PIS           := FTabelaRegC500.FieldByName('VL_PIS').AsCurrency;
               RegistroC500.VL_COFINS        := FTabelaRegC500.FieldByName('VL_COFINS').AsCurrency;
               RegistroC500.TP_LIGACAO       := StrToTpLigacao(Trim(FTabelaRegC500.FieldByName('TP_LIGACAO').AsString));
               RegistroC500.COD_GRUPO_TENSAO := StrToGrupoTensao(Trim(FTabelaRegC500.FieldByName('COD_GRUPO_TENSAO').AsString));

               if (RegistroC500.VL_DOC <= 0) then
                 GerarLinhaMemoLog('Erro: O valor do documento (VALOR - VL_DOC) deve ser maior que “0” (zero)' +
                    'Chave do registro (CHAVE_CAIXA) ' + FTabelaRegC500.FieldByName('CHAVE_CAIXA').AsString);

               {Itens da nota - C510 - Registro somente para emitentes do documento}

               {Registro C590 - Analitico}
               RegistroC590 := FcompSpedFiscal.Bloco_C.RegistroC590New;
               //RegistroC510

               RegistroC590.CFOP          := FTabelaRegC500.FieldByName('CFOP').AsString;
               RegistroC590.VL_OPR        := RegistroC500.VL_DOC;

               if (RegistroC500.VL_ICMS > 0) then
                  begin
                     RegistroC590.CST_ICMS   := '000';
                     RegistroC590.ALIQ_ICMS  := FTabelaRegC500.FieldByName('ALIQ_ICMS').AsCurrency;
                     RegistroC590.VL_BC_ICMS := RegistroC500.VL_BC_ICMS;
                     RegistroC590.VL_ICMS    := RegistroC500.VL_ICMS;
                  end
               else
                  begin
                     RegistroC590.CST_ICMS   := '040';
                     RegistroC590.ALIQ_ICMS  := 0;
                     RegistroC590.VL_BC_ICMS := 0;
                     RegistroC590.VL_ICMS    := 0;
                  end;

               FTOT_VL_ICMS_CRE := FTOT_VL_ICMS_CRE + RegistroC590.VL_ICMS;

               RegistroC590.VL_BC_ICMS_ST := 0;
               RegistroC590.VL_ICMS_ST    := 0;
               RegistroC590.VL_RED_BC     := 0;
               RegistroC590.COD_OBS       := '';

               FTabelaRegC500.Next; {proxima nota de consumo}
            end; {while}
      end; {if C500}

   // Continuar e fazer Registros cupom fiscal C400... C405...

   {Indica se o bloco C houve movimentação}
   if (FcompSpedFiscal.Bloco_C.RegistroC001.RegistroC100.Count > 0) or
      (FcompSpedFiscal.Bloco_C.RegistroC001.RegistroC400.Count > 0) or
      (FcompSpedFiscal.Bloco_C.RegistroC001.RegistroC500.Count > 0) then
      RegistroC001.IND_MOV := imComDados;

   Screen.Cursor := crDefault;
end;

procedure TSpedFiscal.GerarBloco_E;
var
  RegistroE100: TRegistroE100; // ICMS - Abertura
  RegistroE110: TRegistroE110; // ICMS - Apuração Operações Próprias
  RegistroE116: TRegistroE116; // ICMS - Obrigações do icms recolhido ou a recolher – operações próprias

  RegistroE200: TRegistroE200; // ICMS ST - Substituição tributária
  RegistroE210: TRegistroE210; // ICMS ST - Apuração do icms – Substituição tributária
  RegistroE250: TRegistroE250; // ICMS ST - Obrigações do icms recolhido ou a recolher – substituição tributária

  RegistroE500: TRegistroE500; // IPI - Abertura
  RegistroE510: TRegistroE510; // IPI - Consolidação dos valores do ipi.
  RegistroE520: TRegistroE520; // IPI - Apuração do ipi
  RegistroE300: TRegistroE300;
  RegistroE310: TRegistroE310;
  RegistroE311: TRegistroE311;
  RegistroE220: TRegistroE220;

  Registro0015: TRegistro0015;

  dSaldoApurado: Double;
  dTotalValorIPIEntradas: Double;
  dTotalValorIPISaidas: Double;

  dSaldoApuradoST: Double;
  ListaUF_ST: TStrings;
  idx: Integer;
begin

  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.Open;

   GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Apuração ICMS - ICMS ST - IPI');
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E100 - ICMS');

   FcompSpedFiscal.Bloco_E.RegistroE001.IND_MOV := imComDados;
   // ***** ICMS ***** //

   // Registro E100
   RegistroE100 := FcompSpedFiscal.Bloco_E.RegistroE100New;

   RegistroE100.DT_INI := FcompSpedFiscal.DT_INI;
   RegistroE100.DT_FIN := FcompSpedFiscal.DT_FIN;

   // Registro E110 - Apuração do ICMS - Operações Próprias
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E110 - ICMS');

   RegistroE110 := FcompSpedFiscal.Bloco_E.RegistroE110New;

   RegistroE110.VL_TOT_DEBITOS            := FTOT_VL_ICMS_DEB; {Soma dos campos VL_ICMS = C190, C320, C390, C490, C590, C790}

   RegistroE110.VL_AJ_DEBITOS             := 0.00;             {Somatório do campo VL_ICMS do registro C197,
                                                                se o terceiro caractere do campo COD_AJ do registro C197 for igual a ‘3’, ‘4’ ou ‘5’
                                                                e o quarto caractere for igual a “0”, “3”,“4” ou “5”.}

   RegistroE110.VL_TOT_AJ_DEBITOS         := 0.00;             {Somatório do campo VL_AJ_APUR dos registros E111,
                                                                se o terceiro caractere for igual a ‘0’
                                                                e o quarto caractere do campo COD_AJ_APUR do registro E111 for igual a ‘0’}

   RegistroE110.VL_ESTORNOS_CRED          := 0.00;             {Somatório do campo VL_AJ_APUR dos registros E111,
                                                                se o terceiro caractere for igual a ‘0’
                                                                e o quarto caractere do campo COD_AJ_APUR do registro E111 for igual a ‘1’}

   RegistroE110.VL_TOT_CREDITOS           := FTOT_VL_ICMS_CRE;  // {Soma dos VL_ICMS de todos os registros C190, C590, D190 e D590}

   RegistroE110.VL_AJ_CREDITOS            := 0.00;             {Somatório do campo VL_ICMS do registro C197,
                                                                se o terceiro caractere do código de ajuste do registro C197 for ‘0’, ‘1’ ou ‘2’
                                                                e o quarto caractere for ‘0’, “3”, “4” ou “5”}

   RegistroE110.VL_TOT_AJ_CREDITOS        := 0.00;              {Somatório dos valores constantes dos registros E111,
                                                                 quando o terceiro caractere for igual a ‘0’
                                                                 e o quarto caractere for igual a ‘2’, do COD_AJ_APUR do registro E111}

   RegistroE110.VL_ESTORNOS_DEB           := 0.00;              {Somatório do VL_AJ_APUR dos registros E111,
                                                                 quando o terceiro caractere for igual a ‘0’
                                                                 e o quarto caractere for igual a ‘3’, do COD_AJ_APUR do registro E111}

   RegistroE110.VL_SLD_CREDOR_ANT         := 0.00;

   { *** Saldo Apurado:

        (VL_TOT_DEBITOS)  + (VL_AJ_DEBITOS)   + (VL_TOT_AJ_DEBITOS)  + (VL_ESTORNOS_CRED)  -
        (VL_TOT_CREDITOS) + (VL_,AJ_CREDITOS) + (VL_TOT_AJ_CREDITOS) + (VL_ESTORNOS_DEB) + (VL_SLD_CREDOR_ANT)

       Se o valor da expressão for maior ou igual a “0” (zero), então o valor deve ser informado em
       (VL_SLD_APURADO) e o campo (VL_SLD_CREDOR_TRANSPORTAR) deve ser igual a “0” (zero).

       Se o valor da expressão for menor que “0” (zero), então (VL_SLD_APURADO) deve ser preenchido com “0” (zero) e o
       valor absoluto da expressão deve ser informado no campo (VL_SLD_CREDOR_TRANSPORTAR).
   }

   dSaldoApurado := (RegistroE110.VL_TOT_DEBITOS - RegistroE110.VL_TOT_CREDITOS );

   if (dSaldoApurado >= 0) then
      begin
         RegistroE110.VL_SLD_APURADO := dSaldoApurado;
         RegistroE110.VL_SLD_CREDOR_TRANSPORTAR := 0.00;
      end
   else
      begin
         RegistroE110.VL_SLD_APURADO := 0.00;
         RegistroE110.VL_SLD_CREDOR_TRANSPORTAR := ABS(dSaldoApurado);
      end;

   RegistroE110.VL_TOT_DED := 0.00;                                {Somatório do campo VL_ICMS do registro C197,
                                                                    se o terceiro caractere do código de ajuste do registro C197, for ‘6’
                                                                    e o quarto caractere for ‘0’,
                                                                    somado ao valor total informado nos registros E111,
                                                                    quando o terceiro caractere for igual a ‘0’
                                                                    e o quarto caractere for igual a ‘4’, do campo COD_AJ_APUR do registro E111}

   RegistroE110.VL_ICMS_RECOLHER := RegistroE110.VL_SLD_APURADO;    {Diferença entre o campo VL_SLD_APURADO e o campo VL_TOT_DED.
                                                                     Se o resultado dessa operação for negativo,
                                                                     informe o valor zero neste campo,
                                                                     e o valor absoluto correspondente no campo VL_SLD_CREDOR_TRANSPORTAR.
                                                                     Verificar se a legislação da UF permite que dedução seja maior que o saldo devedor.}

   RegistroE110.DEB_ESP := 0.00; {Valores recolhidos ou a recolher, extra apuração.}

   {E111 - AJUSTE/BENEFÍCIO/INCENTIVO DA APURAÇÃO DO ICMS.}


   {E116 - Obrigações do ICMS a Recolher – Operações Próprias}
   GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E116 - ICMS');
   RegistroE116 := FcompSpedFiscal.Bloco_E.RegistroE116New;

   RegistroE116.COD_OR    := '000';
   RegistroE116.VL_OR     := RegistroE110.VL_ICMS_RECOLHER;         {O valor da soma deste campo deve corresponder à soma dos campos VL_ICMS_RECOLHER e DEB_ESP do registro E110. }
   RegistroE116.DT_VCTO   := FcompSpedFiscal.DT_INI;
   RegistroE116.COD_REC   := '0213';
   if (FTabelaUFICMSST.FieldByName('UF').AsString ='MG' )  then
    begin
    RegistroE116.COD_REC  := '1123';
    end;
                                                                     // add mauricio 10052024 antes'1123';// {ICMS Normal - Regime mensal GIA};
   RegistroE116.NUM_PROC  := '';                                     {Número do processo ou auto de infração ao qual a obrigação está vinculada, se houver.
                                                                     Se existir valor, os campos IND_PROC e PROC também devem estar preenchidos.}
   RegistroE116.IND_PROC  := opNenhum;                               {Indicador da origem do processo}
   RegistroE116.PROC      := '';                                      {Descrição resumida do processo que embasou o lançamento}
   RegistroE116.TXT_COMPL := '';
   RegistroE116.MES_REF   := FormatDateTime('mmyyyy', FcompSpedFiscal.DT_INI);






   // ***** ICMS ST ***** //
   FExitemNotasComSubstituicaoTributaria := ((FVL_TOT_ICMS_ST_NF_ENTRADA + FVL_TOT_ICMS_ST_NF_SAIDA) > 0);

   if (FExitemNotasComSubstituicaoTributaria) then
      begin
        ListaUF_ST := TStringList.Create;
        try

         //a registro 0015 do bloco 0 (zero) com dados substituto tributario               add mauricio 14052024
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E115 - ICMS');
         Registro0015 := FcompSpedFiscal.Bloco_0.Registro0015New;
         Registro0015.UF_ST := dmPrincipal.cdsConsEmpresaUF.AsString;                     //ListaUF_ST.Names[idx];
         Registro0015.IE_ST := dmPrincipal.cdsConsEmpresaINSC_ESTADUAL.AsString;           //RemoveMascaraStr(ListaUF_ST.Values[ListaUF_ST.Names[idx]]);


         //  mauricio 13052024
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E200 - ICMS');
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E210 - ICMS');
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E250 - ICMS');
         FTabelaUFICMSST.First;
         while not FTabelaUFICMSST.Eof do
          begin

            // Gera Registro E200

            RegistroE200 := FcompSpedFiscal.Bloco_E.RegistroE200New;

            RegistroE200.UF := FTabelaUFICMSST.FieldByName('UF').AsString;
            RegistroE200.DT_INI := FDataInicial;
            RegistroE200.DT_FIN := FDataFinal;

            // Registro E210 add mauricio 14052024
           if (RegistroE200.UF = dmPrincipal.cdsConsEmpresaUF.AsString ) then
               begin

                  RegistroE210 := FcompSpedFiscal.Bloco_E.RegistroE210New;

                  RegistroE210.IND_MOV_ST := mstSemOperacaoST;

                  RegistroE210.VL_SLD_CRED_ANT_ST         := 0.00;
                  RegistroE210.VL_DEVOL_ST                := 0.00;
                  RegistroE210.VL_RESSARC_ST              := 0.00;
                  RegistroE210.VL_OUT_CRED_ST             := FTabelaUFICMSST.FieldByName('VL_ICMS_ST_E').AsFloat; { Soma do campo VL_ICMS_ST do registro C190 (demais CFOPs), quando o primeiro caractere do campo CFOP for ‘1’ ou ‘2’
                                                                                                                   exceto se o valor do campo CFOP for 1410, 1411, 1414, 1415, 1660, 1661, 1662, 2410, 2411, 2414, 2415, 2660, 2661 ou 2662. }
                  RegistroE210.VL_AJ_CREDITOS_ST          := 0.00;
                  RegistroE210.VL_RETENCAO_ST             := FTabelaUFICMSST.FieldByName('VL_ICMS_ST_S').AsFloat;
                  RegistroE210.VL_OUT_DEB_ST              := 0.00;
                  RegistroE210.VL_AJ_DEBITOS_ST           := 0.00;

                  dSaldoApuradoST := (RegistroE210.VL_RETENCAO_ST     +
                                      RegistroE210.VL_OUT_DEB_ST      +
                                      RegistroE210.VL_AJ_DEBITOS_ST)  -
                                     (RegistroE210.VL_SLD_CRED_ANT_ST +
                                      RegistroE210.VL_DEVOL_ST        +
                                      RegistroE210.VL_RESSARC_ST      +
                                      RegistroE210.VL_OUT_CRED_ST     +
                                      RegistroE210.VL_AJ_CREDITOS_ST  );

                  if (dSaldoApuradoST >= 0) then
                  begin
                    RegistroE210.VL_SLD_DEV_ANT_ST          := dSaldoApuradoST;
                    RegistroE210.VL_SLD_CRED_ST_TRANSPORTAR := 0.00;
                  end
                  else
                  begin
                    RegistroE210.VL_SLD_DEV_ANT_ST          := 0.00;
                    RegistroE210.VL_SLD_CRED_ST_TRANSPORTAR := ABS(dSaldoApuradoST);
                  end;

                  RegistroE210.VL_DEDUCOES_ST    := 0.00;       {Valor informado deve corresponder ao somatório do campo VL_AJ_APUR do registro E220}

                  RegistroE210.VL_ICMS_RECOL_ST  := (RegistroE210.VL_SLD_DEV_ANT_ST - RegistroE210.VL_DEDUCOES_ST);

                  if RegistroE210.VL_ICMS_RECOL_ST < 0 then
                    RegistroE210.VL_ICMS_RECOL_ST := 0;

                    RegistroE210.DEB_ESP_ST := 0.00;


                   // Registro E250  add mauricio 14052024
                  RegistroE250 := FcompSpedFiscal.Bloco_E.RegistroE250New;
                  RegistroE250.COD_OR    := '001';
                  RegistroE250.VL_OR     := (RegistroE210.VL_ICMS_RECOL_ST + RegistroE210.DEB_ESP_ST);
                  RegistroE250.DT_VCTO   := FDataFinal;
                  RegistroE250.COD_REC   := '0213';         {O Código da Receita, é o que se encontra na Guia de Recolhimento do imposto.}
                  RegistroE250.NUM_PROC  := '';
                  RegistroE250.IND_PROC  := opNenhum;
                  RegistroE250.PROC      := '';
                  RegistroE250.TXT_COMPL := '';
                  RegistroE250.MES_REF   := FormatDateTime('mmyyyy', FDataFinal);





               end
               else  if (RegistroE200.UF <> dmPrincipal.cdsConsEmpresaUF.AsString )  then
               begin

                  RegistroE210 := FcompSpedFiscal.Bloco_E.RegistroE210New;

                  RegistroE210.IND_MOV_ST := mstComOperacaoST;

                  RegistroE210.VL_SLD_CRED_ANT_ST         := 0.00;
                  RegistroE210.VL_DEVOL_ST                := 0.00;
                  RegistroE210.VL_RESSARC_ST              := 0.00;
                  RegistroE210.VL_OUT_CRED_ST             := FTabelaUFICMSST.FieldByName('VL_ICMS_ST_E').AsFloat; { Soma do campo VL_ICMS_ST do registro C190 (demais CFOPs), quando o primeiro caractere do campo CFOP for ‘1’ ou ‘2’
                                                                                                                   exceto se o valor do campo CFOP for 1410, 1411, 1414, 1415, 1660, 1661, 1662, 2410, 2411, 2414, 2415, 2660, 2661 ou 2662. }
                  RegistroE210.VL_AJ_CREDITOS_ST          := 0.00;
                  RegistroE210.VL_RETENCAO_ST             := FTabelaUFICMSST.FieldByName('VL_ICMS_ST_S').AsFloat;
                  RegistroE210.VL_OUT_DEB_ST              := RegistroE210.VL_OUT_CRED_ST ;
                  RegistroE210.VL_AJ_DEBITOS_ST           := 0.00;

                  dSaldoApuradoST := (RegistroE210.VL_RETENCAO_ST     +
                                      RegistroE210.VL_OUT_DEB_ST      +
                                      RegistroE210.VL_AJ_DEBITOS_ST)  -
                                     (RegistroE210.VL_SLD_CRED_ANT_ST +
                                      RegistroE210.VL_DEVOL_ST        +
                                      RegistroE210.VL_RESSARC_ST      +
                                      RegistroE210.VL_OUT_CRED_ST     +
                                      RegistroE210.VL_AJ_CREDITOS_ST  );

                  if (dSaldoApuradoST >= 0) then
                  begin
                    RegistroE210.VL_SLD_DEV_ANT_ST          := dSaldoApuradoST;
                    RegistroE210.VL_SLD_CRED_ST_TRANSPORTAR := 0.00;
                  end
                  else
                  begin
                    RegistroE210.VL_SLD_DEV_ANT_ST          := 0.00;
                    RegistroE210.VL_SLD_CRED_ST_TRANSPORTAR := ABS(dSaldoApuradoST);
                  end;

                  RegistroE210.VL_DEDUCOES_ST    := 0.00;                     {Valor informado deve corresponder ao somatório do campo VL_AJ_APUR do registro E220}

                  RegistroE210.VL_ICMS_RECOL_ST  := (RegistroE210.VL_SLD_DEV_ANT_ST - RegistroE210.VL_DEDUCOES_ST);

                  if RegistroE210.VL_ICMS_RECOL_ST < 0 then
                    RegistroE210.VL_ICMS_RECOL_ST := 0;

                  RegistroE210.DEB_ESP_ST := 0.00;
                  RegistroE250 := FcompSpedFiscal.Bloco_E.RegistroE250New;
                  RegistroE250.COD_OR    := '001';
                  RegistroE250.VL_OR     := (RegistroE210.VL_ICMS_RECOL_ST + RegistroE210.DEB_ESP_ST);
                  RegistroE250.DT_VCTO   := FDataFinal;

                  if dmPrincipal.cdsConsEmpresaUF.AsString <>'SC' then
                     RegistroE250.COD_REC   := '100048'
                  else
                     RegistroE250.COD_REC   := '100048'; {O Código da Receita, é o que se encontra na Guia de Recolhimento do imposto.}

                  RegistroE250.NUM_PROC  := '';
                  RegistroE250.IND_PROC  := opNenhum;
                  RegistroE250.PROC      := '';
                  RegistroE250.TXT_COMPL := '';
                  RegistroE250.MES_REF   := FormatDateTime('mmyyyy', FDataFinal);

                    //Registro E220 E200 E250 add mauricio 14052024
                  if (RegistroE200.UF <> dmPrincipal.cdsConsEmpresaUF.AsString ) then
                      begin

                       GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Registros E220 - ICMS ST outros estados' );

                       RegistroE220      := FcompSpedFiscal.Bloco_E.RegistroE220New;
                       with RegistroE220 do
                          begin

                            if FTabelaUFICMSST.FieldByName('UF').AsString <> 'SC' then
                               COD_AJ_APUR:=FTabelaUFICMSST.FieldByName('UF').AsString+'100299'
                            else
                               COD_AJ_APUR:=FTabelaUFICMSST.FieldByName('UF').AsString+'100002';
                               DESCR_COMPL_AJ:='';
                               VL_AJ_APUR:= RegistroE210.VL_OUT_CRED_ST ;
                          end;

                      end;

               end;

            FTabelaUFICMSST.Next;
          end; {while}

        finally
          //ListaUF_ST.Free;
        end;
        GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Registros E200 - ICMS ST ');
      end;



      //  add mauricio 14052024
     GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E300 - ICMS');

     RegistroE300:= FcompSpedFiscal.Bloco_E.RegistroE300New;
     RegistroE300.UF    := dmPrincipal.cdsConsEmpresaUF.AsString;
     RegistroE300.DT_INI:= FDataInicial;
     RegistroE300.DT_FIN:= FDataFinal;

     GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Gerando Registros E310 - ICMS');
     RegistroE310:= FcompSpedFiscal.Bloco_E.RegistroE310New;
     with RegistroE310 do
        begin
          IND_MOV_DIFAL:=mDifalSemOperacaoICMS;
          VL_SLD_CRED_ANT_DIF           := 0.00;
          VL_TOT_DEBITOS_DIFAL          := 0.00;
          VL_OUT_DEB_DIFAL              := 0.00;
          VL_TOT_DEB_FCP                := 0.00;
          VL_TOT_CREDITOS_DIFAL         := 0.00;
          VL_TOT_CRED_FCP               := 0.00;
          VL_OUT_CRED_DIFAL             := 0.00;
          VL_SLD_DEV_ANT_DIFAL          := 0.00;
          VL_DEDUCOES_DIFAL             := 0.00;
          VL_RECOL                      := 0.00;
          VL_SLD_CRED_TRANSPORTAR       := 0.00;
          DEB_ESP_DIFAL                 := 0.00;
          VL_SLD_DEV_ANT_FCP            := 0.00;
          VL_RECOL_DIFAL                := 0.00;
          VL_SLD_CRED_TRANSPORTAR_DIFAL := 0.00;
          VL_SLD_CRED_ANT_FCP           := 0.00;
          VL_RECOL_FCP                  := 0.00;
          VL_SLD_CRED_TRANSPORTAR_FCP   := 0.00;
          VL_OUT_CRED_FCP               := 0.00;
          VL_OUT_DEB_FCP                := 0.00;
          VL_DEDUCOES_FCP               := 0.00;
          DEB_ESP_FCP                   := 0.00;
        end;



   // ***** IPI ***** //
   if (FcompSpedFiscal.Bloco_0.Registro0000.IND_ATIV = atIndustrial) then
      begin
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_E + ': Registros E500 - Período IPI');

         RegistroE500        := FcompSpedFiscal.Bloco_E.RegistroE500New;
         RegistroE500.DT_INI := FcompSpedFiscal.DT_INI;
         RegistroE500.DT_FIN := FcompSpedFiscal.DT_FIN;

         if (FParamIndApurIPI = 'D') then
             RegistroE500.IND_APUR := iaDecendial
         else
             RegistroE500.IND_APUR := iaMensal;

         { E510 - Consolidação dos valores do IPI.
           Base das informações C170 (Entradas) e C100 (Saídas)
           Combinação de CFOP e código da situação tributária do IPI (CST_IPI) }

         dTotalValorIPIEntradas := 0;
         dTotalValorIPISaidas   := 0;

         FTabelaRegE510.Filtered := False;
         FTabelaRegE510.First;
         while not FTabelaRegE510.Eof do
            begin
               RegistroE510 := FcompSpedFiscal.Bloco_E.RegistroE510New;

               RegistroE510.CFOP        := FTabelaRegE510.FieldByName('CFOP').AsString;
               RegistroE510.CST_IPI     := FTabelaRegE510.FieldByName('CST_IPI').AsString;
               RegistroE510.VL_CONT_IPI := FTabelaRegE510.FieldByName('VL_CONT_IPI').AsFloat;
               RegistroE510.VL_BC_IPI   := FTabelaRegE510.FieldByName('VL_BC_IPI').AsFloat;
               RegistroE510.VL_IPI      := RoundTo(FTabelaRegE510.FieldByName('VL_IPI').AsFloat, -2);

               if (FTabelaRegE510.FieldByName('TIPO').AsString = 'E') then
                  dTotalValorIPIEntradas := dTotalValorIPIEntradas + RoundTo(FTabelaRegE510.FieldByName('VL_IPI_E').AsFloat, -2)
               else
                  dTotalValorIPISaidas   := dTotalValorIPISaidas + RoundTo(FTabelaRegE510.FieldByName('VL_IPI_S').AsFloat, -2);

               FTabelaRegE510.Next;
            end;// while

         {E520 - Apuração de IPI}
         RegistroE520 := FcompSpedFiscal.Bloco_E.RegistroE520New;

         RegistroE520.VL_SD_ANT_IPI := 0;                     { Saldo credor do IPI transferido do período anterior }

         RegistroE520.VL_DEB_IPI    := dTotalValorIPISaidas;     { Validação: o valor informado deve corresponder ao somatório do campo VL_IPI do registro E510,
                                                                  quando o CFOP iniciar por ‘5’ ou ‘6” dos registros C190.}

         RegistroE520.VL_CRED_IPI   := dTotalValorIPIEntradas;  { Validação: o valor informado deve corresponder ao somatório do campo VL_IPI do registro E510,
                                                                  quando o CFOP iniciar por ‘1’, ‘2’ ou ‘3’ dos registros C190.}

         RegistroE520.VL_OD_IPI     := 0;                         { Validação: o valor informado deve corresponder ao somatório do campo VL_AJ do registro E530,
                                                                  quando o campo IND_AJ do registro E530 for igual a ‘0’ }

         RegistroE520.VL_OC_IPI     := 0;                         { Validação: o valor informado deve corresponder ao somatório do campo VL_AJ do registro E530,
                                                                  quando o campo IND_AJ do registro E530 for igual a ‘1’}

         {Saldo}
         if (RoundTo((RegistroE520.VL_DEB_IPI + RegistroE520.VL_OD_IPI), -2) -
             RoundTo((RegistroE520.VL_SD_ANT_IPI + RegistroE520.VL_CRED_IPI + RegistroE520.VL_OC_IPI), -2) < 0) then
            begin
               RegistroE520.VL_SC_IPI := ABS(RoundTo((RegistroE520.VL_DEB_IPI + RegistroE520.VL_OD_IPI),-2) -
                                             RoundTo((RegistroE520.VL_SD_ANT_IPI + RegistroE520.VL_CRED_IPI + RegistroE520.VL_OC_IPI), -2)); // Deve ser igual ao valor absoluto da expressão
               RegistroE520.VL_SD_IPI := 0;
            end
         else
            begin
               RegistroE520.VL_SD_IPI := (RoundTo((RegistroE520.VL_DEB_IPI + RegistroE520.VL_OD_IPI), -2) -
                                          RoundTo((RegistroE520.VL_SD_ANT_IPI + RegistroE520.VL_CRED_IPI + RegistroE520.VL_OC_IPI), -2));
               RegistroE520.VL_SC_IPI := 0;
            end;
      end;
end;

procedure TSpedFiscal.GerarBloco_H;
var
   RegistroH005: TRegistroH005;
   RegistroH010: TRegistroH010;
   Registro0200: TRegistro0200;
   Registro0220: TRegistro0220;
   dTotalSaldoEstoque
  // , Novo_id
   : Double;
   Mes,Ano,vEan,parametros:String;
   AnoInvent,DataInvetario:TDate;
  // MaxCodIten: Integer;
    MaxCodIten: Int64;  // Use Int64 para suportar números maiores
  Novo_id: Int64;

begin




   if (Self.FGerarBlocoH) then
      begin

         dmprincipal.cdsConsEmpresa.Close;
         dmprincipal.cdsConsEmpresa.open;

         GerarLinhaMemoLog(_SPED_FIS_BLOCO_H + ': Gerando Registro H005');
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_H + ': Gerando Registro H010');
         if (FTabelaRegH010.RecordCount > 0) then
            begin
               dTotalSaldoEstoque := 0;
               FcompSpedFiscal.Bloco_H.RegistroH001.IND_MOV := imComDados;
               RegistroH005 := FcompSpedFiscal.Bloco_H.RegistroH005New;

               Mes := FormatDateTime('MM',FcompSpedFiscal.DT_FIN);
               Ano := FormatDateTime('YYYY',FcompSpedFiscal.DT_FIN);

               if (mes ='01') or (mes='02') then
                   begin
                    RegistroH005.DT_INV:= EncodeDate(StrToInt(Ano)-1,12,31);
                    AnoInvent:=EncodeDate(StrToInt(Ano)-1,12,31);
                   end
                else
                   begin
                     RegistroH005.DT_INV := FcompSpedFiscal.DT_FIN;
                   end;



             //=================== pegando inventario de posicao estoquedata farmax ==================

               AtualizarStatus('Verificando - Inventário Item');
               DataInvetario:= verificaDataInvetario(DateToStr(AnoInvent));


               if DataInvetario =0 then
                 begin

                   AtualizarStatus('Aguarde executanto SP_SUPORTE_POSICAOESTOQUEDATA');

                   try


                     dmPrincipal.FDQuery.SQL.Text := 'EXECUTE PROCEDURE SP_SUPORTE_POSICAOESTOQUEDATA(:CD_FILIAL, :DATA)';
                     dmPrincipal.FDQuery.ParamByName('CD_FILIAL').AsFloat := dmPrincipal.cdsConsEmpresaCD_FILIAL.Value;
                     dmPrincipal.FDQuery.ParamByName('DATA').AsDate := AnoInvent;
                     dmPrincipal.FDQuery.ExecSQL;



//                    dmPrincipal.FDStoredProc.StoredProcName:='EXECUTE PROCEDURE SP_SUPORTE_POSICAOESTOQUEDATA ('+parametros+')';
////                   dmPrincipal.FDStoredProc.ParamByName('CD_FILIAL').AsFloat   := dmPrincipal.cdsConsEmpresaCD_FILIAL.AsFloat;
////                   dmPrincipal.FDStoredProc.ParamByName('DATA').AsDate         := AnoInvent;
//                    dmPrincipal.FDStoredProc.Prepare;
//                    dmPrincipal.FDStoredProc.ExecProc;
                   except on e:exception do

                    GeraLog2( 'Erro ao executar PROCEDURE SP_SUPORTE_POSICAOESTOQUEDATA:'+e.Message );

                   end;

                 end;


               //  DataInvetario:= verificaDataInvetario(DateToStr(AnoInvent));

                if DataInvetario <> 0 then
                  begin
                   AtualizarStatus('Aguarde gerando registro 0200 bloco H');
                   dmprincipal.cdsConsInventario.Close;
                   dmprincipal.cdsConsInventario.ParamByName('DATA').value :=DataInvetario;
                   dmprincipal.cdsConsInventario.open;
                   dmprincipal.cdsConsInventario.First;

                   dmprincipal.cdsConsBlocoH.close;
                   dmprincipal.cdsConsBlocoH.Open;

                   IniciaBar(dmprincipal.cdsConsInventario.RecordCount);

                   if dmprincipal.cdsConsInventario.RecordCount >0 then
                     begin

                        while not dmprincipal.cdsConsInventario.Eof do
                          begin

                             dmprincipal.cdsConsBlocoH.Append;
                             dmprincipal.cdsConsBlocoHID_PRODUTO.Value  := '0' ;//dmprincipal.cdsConsInventarioID_PRODUTO.Value;
                             dmprincipal.cdsConsBlocoHNCM.Value         := dmprincipal.cdsConsInventarioNCM.Value;
                             dmprincipal.cdsConsBlocoHEAN.Value         := dmprincipal.cdsConsInventarioCODIGO_BARRAS_1.Value;
                             dmprincipal.cdsConsBlocoHDESCRICAO.Value   := dmprincipal.cdsConsInventarioDESCRICAO.Value;
                             dmprincipal.cdsConsBlocoHQUANTIDADE.Value  := dmprincipal.cdsConsInventarioQUANTIDADE.Value;
                             dmprincipal.cdsConsBlocoHVL_UNIT_ITEM.Value:= dmprincipal.cdsConsInventarioVL_UNIT_ITEM.Value;
                             dmprincipal.cdsConsBlocoHVL_ITEM.Value     := dmprincipal.cdsConsInventarioVL_ITEM.Value;
                             dmprincipal.cdsConsBlocoH.Post;

                             dmprincipal.cdsConsInventario.Next;
                             IncBar;
                             AtualizarStatus('gerando inventário Item');

                          end;

                     end;

                    AtualizarStatus('Aguarde salvando as informações.');
                    try
                      dmprincipal.cdsConsBlocoH.ApplyUpdates(0);
                    except on E: Exception do
                         begin
                           showmessage(e.Message);
                           GerarLinhaMemoLog('Erro ao salvar sped:'+e.Message);
                         end;
                    end;


                    dmprincipal.cdsConsBlocoH.close;
                    dmprincipal.cdsConsBlocoH.Open;

                    IniciaBar(dmprincipal.cdsConsBlocoH.RecordCount);

                    { comentei em 06032025 porqu estava recebendo codigo de item com letras
                       dmPrincipal.FDSQL.SQL.Clear;
                       dmPrincipal.FDSQL.sql.add(' SELECT MAX(CODIGO_ITEM) FROM TEMP_REG0200');
                       dmPrincipal.FDSQL.Open();


                       if dmPrincipal.FDSQL.RecordCount > 0 then
                          begin
                             MaxCodIten := dmPrincipal.FDSQL.Fields[0].Value;;
                          end; }


                 //   MaxCodIten := 0; // Inicializa com o menor valor possível para um inteiro
////
//                    FTabelaReg0200.first;
//                    while not FTabelaReg0200.Eof do
//                      begin
//                         if FTabelaReg0200.FieldByName('COD_ITEM').AsInteger > MaxCodIten then
//                            MaxCodIten := FTabelaReg0200.FieldByName('COD_ITEM').AsInteger;
//
//                            FTabelaReg0200.Next;
//                       end;  /
//
//
                    Novo_id := 1;
                   // Novo_id := MaxCodIten;

                    dmprincipal.cdsConsBlocoH.First;
                    while not dmprincipal.cdsConsBlocoH.eof do
                      begin

                        vEan:= dmprincipal.cdsConsBlocoHEAN.AsString;

                         IF  FTabelaReg0200.Locate('COD_BARRA',dmprincipal.cdsConsBlocoHEAN.AsString,[] ) then
                             begin

                                dmprincipal.cdsConsBlocoH.Edit;
                                dmprincipal.cdsConsBlocoHID_PRODUTO.Value := trim(FTabelaReg0200.FieldByName('COD_ITEM').value);
                                dmprincipal.cdsConsBlocoH.Post;
                             end
                          else
                             begin


                                 Novo_id:=  Novo_id + 1;

                                 Registro0200               := FcompSpedFiscal.Bloco_0.Registro0200New;
                                 Registro0200.COD_ITEM      := 'F-'+FloatToStr(Novo_id) ;//FloatToStr(dmprincipal.cdsConsBlocoHID_PRODUTO.Value);
                                 Registro0200.DESCR_ITEM    := Trim(dmprincipal.cdsConsBlocoHDESCRICAO.Value);
                                 Registro0200.COD_BARRA     := Trim(dmprincipal.cdsConsBlocoHEAN.Value);
                                 Registro0200.COD_ANT_ITEM  := '';
                                 Registro0200.UNID_INV      := Trim('UN');
                                 Registro0200.TIPO_ITEM     := tiMercadoriaRevenda;

                                 Registro0200.COD_NCM       := RemoveMascaraStr(dmprincipal.cdsConsBlocoHNCM.Value);
                                 Registro0200.EX_IPI        := '';
                                 Registro0200.COD_GEN       := '';
                                 Registro0200.COD_LST       := '';
                                 Registro0200.ALIQ_ICMS     := 0 ;

                                 // 0220 - Fatores de convesão de unidades
                                { FTabelaReg0220.Filtered := False;
                                 FTabelaReg0220.Filter := 'COD_ITEM = ' + QuotedStr(Registro0200.COD_ITEM);
                                 AtualizarStatus('Registro 0220 (Fatores de conversão de unidades): ');
                                 FTabelaReg0220.Filtered := True;
                                 FTabelaReg0220.First;
                                 while not FTabelaReg0220.Eof do
                                 begin

                                   Registro0220           := FcompSpedFiscal.Bloco_0.Registro0220New;
                                   Registro0220.UNID_CONV := FTabelaReg0220.FieldByName('UNID_CONV').AsString;
                                   Registro0220.FAT_CONV  := FTabelaReg0220.FieldByName('FAT_CONV').AsFloat;
                                   Registro0220.COD_BARRA := FTabelaReg0220.FieldByName('COD_BARRA').AsString;
                                 end;}

                                dmprincipal.cdsConsBlocoH.Edit;
                                dmprincipal.cdsConsBlocoHID_PRODUTO.Value :='F-'+FloatTostr(Novo_id);
                                dmprincipal.cdsConsBlocoH.Post;



                             end;


                        dmprincipal.cdsConsBlocoH.Next;

                        IncBar;
                        AtualizarStatus('gerando Consistência Inventario Item');

                      end;

                     dmprincipal.cdsConsBlocoH.ApplyUpdates(0);
                     dmprincipal.cdsConsBlocoH.close;
                     dmprincipal.cdsConsBlocoH.Open;
                     dmprincipal.cdsConsBlocoH.First;


                      begin

                           IniciaBar(dmprincipal.cdsConsBlocoH.RecordCount);

                           dmprincipal.cdsConsBlocoH.first;
                           while not dmprincipal.cdsConsBlocoH.Eof do
                              begin
                                 RegistroH010          := FcompSpedFiscal.Bloco_H.RegistroH010New;
                                 RegistroH010.COD_ITEM := trim(dmprincipal.cdsConsBlocoHID_PRODUTO.Value);
                                 RegistroH010.UNID     := 'UN';


                                 RegistroH010.QTD      := dmprincipal.cdsConsBlocoHQUANTIDADE.Value;
                                 RegistroH010.VL_UNIT  := dmprincipal.cdsConsBlocoHVL_UNIT_ITEM.Value;
                                 RegistroH010.VL_ITEM  := dmprincipal.cdsConsBlocoHVL_ITEM.Value;



                                 dTotalSaldoEstoque := dTotalSaldoEstoque + RegistroH010.VL_ITEM;

                                 RegistroH010.IND_PROP   := piInformante;
                                 RegistroH010.COD_PART   := ''; {Código do participante caso o campo IND_PROP seja 1 ou 2}
                                 RegistroH010.TXT_COMPL  := '';
                                 RegistroH010.COD_CTA    := '1';// Obrigatorio para perfil A ou B
                                 RegistroH010.VL_ITEM_IR := RegistroH010.VL_ITEM;//Valor do item para efeitos do Imposto de Renda.

                                 dmprincipal.cdsConsBlocoH.Next;

                                 IncBar;
                                 AtualizarStatus('Inventário Item');
                              end; {while itens}

                           {H005 - Total Inventario}
                           RegistroH005.VL_INV := dTotalSaldoEstoque;


                      end;


                  end;




             //=======================================================================================

               {Itens inventário}
//               IniciaBar(FTabelaRegH010.RecordCount);
//
//               FTabelaRegH010.First;
//               while not FTabelaRegH010.Eof do
//                  begin
//                     RegistroH010            := FcompSpedFiscal.Bloco_H.RegistroH010New;
//                     RegistroH010.COD_ITEM   := Trim(FTabelaRegH010.FieldByName('COD_ITEM').AsString);
//                     RegistroH010.UNID       := Trim(FTabelaRegH010.FieldByName('UNID').AsString);
//
//                     if (FTabelaRegH010.FieldByName('QTD').AsFloat > 0) then
//                        RegistroH010.QTD := FTabelaRegH010.FieldByName('QTD').AsFloat
//                     else
//                        RegistroH010.QTD := 0;
//
//                     RegistroH010.VL_UNIT := FTabelaRegH010.FieldByName('VL_UNIT').AsFloat;
//
//                     if (RegistroH010.QTD > 0) then
//                        RegistroH010.VL_ITEM := FTabelaRegH010.FieldByName('VL_ITEM').AsFloat
//                     else
//                        RegistroH010.VL_ITEM := 0;
//
//                    dTotalSaldoEstoque := dTotalSaldoEstoque + RegistroH010.VL_ITEM;
//
//                     RegistroH010.IND_PROP   := piInformante;
//                     RegistroH010.COD_PART   := ''; {Código do participante caso o campo IND_PROP seja 1 ou 2}
//                     RegistroH010.TXT_COMPL  := '';
//                     RegistroH010.COD_CTA    := '1';// Obrigatorio para perfil A ou B
//                     RegistroH010.VL_ITEM_IR := RegistroH010.VL_ITEM;//Valor do item para efeitos do Imposto de Renda.
//
//                     FTabelaRegH010.Next;
//                     IncBar;
//                     AtualizarStatus('Inventário Item');
//                  end; {while itens}
//
//               {H005 - Total Inventario}
//               RegistroH005.VL_INV := dTotalSaldoEstoque;
            end; {if}
      end; {if Gerar Inventario}
end;

procedure TSpedFiscal.GerarBloco_K;
var
    RegistroK001: TRegistroK001;
    RegistroK100: TRegistroK100;
    RegistroK200: TRegistroK200;
    RegistroK230: TRegistroK230;
    RegistroK235: TRegistroK235;
begin
   RegistroK001 := FcompSpedFiscal.Bloco_K.RegistroK001New;
   RegistroK001.IND_MOV := imSemDados;

   if (Self.FGerarBlocoK) then
      begin
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_K + ': Gerando Registro K001');
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_K + ': Gerando Registro K100');
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_K + ': Gerando Registro K200');
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_K + ': Gerando Registro K230');
         GerarLinhaMemoLog(_SPED_FIS_BLOCO_K + ': Gerando Registro K235');

         if (not FTabelaRegK200.IsEmpty) then
            begin
               RegistroK001.IND_MOV := imComDados;

               // K100
               RegistroK100        := FcompSpedFiscal.Bloco_K.RegistroK100New;
               RegistroK100.DT_INI := FcompSpedFiscal.DT_INI;
               RegistroK100.DT_FIN := FcompSpedFiscal.DT_FIN;

               // K200
               RegistroK200          := FcompSpedFiscal.Bloco_K.RegistroK200New;
               RegistroK200.DT_EST   := RegistroK100.DT_FIN; //A data do estoque deve ser igual a data final do periodo de apuração - DT_FIN do registro K100
               RegistroK200.COD_ITEM := FTabelaRegK200.FieldByName('COD_ITEM').AsString;
               RegistroK200.QTD      := FTabelaRegK200.FieldByName('QTD').AsFloat;

               RegistroK200.IND_EST  := estPropInformantePoder; {estPropInformantePoder:     0 = Estoque de propriedade do informante e em seu poder
                                                                 estPropInformanteTerceiros: 1 = Estoque de propriedade do informante e em posse de terceiros
                                                                 estPropTerceirosInformante: 2 = Estoque de propriedade de terceiros e em posse do informante}
               RegistroK200.COD_PART := '';

               // K230 - ITENS PRODUZIDOS
               FTabelaRegK230.First;
               while not FTabelaRegK230.Eof do
                  begin
                     RegistroK230            := FcompSpedFiscal.Bloco_K.RegistroK230New;
                     RegistroK230.DT_INI_OP  := FTabelaRegK230.FieldByName('DT_INI_OP').AsDateTime;
                     RegistroK230.DT_FIN_OP  := FTabelaRegK230.FieldByName('DT_FIN_OP').AsDateTime;
                     RegistroK230.COD_DOC_OP := FTabelaRegK230.FieldByName('COD_DOC_OP').AsString;
                     RegistroK230.COD_ITEM   := FTabelaRegK230.FieldByName('COD_ITEM').AsString;
                     RegistroK230.QTD_ENC    := FTabelaRegK230.FieldByName('QTD_ENC').AsFloat;

                     // K235 - INSUMOS CONSUMIDOS
                     FTabelaRegK235.Filtered := False;
                     FTabelaRegK235.Filter   := 'COD_ITEM_PRODUZIDO = ' + FTabelaRegK230.FieldByName('COD_ITEM').AsString;
                     FTabelaRegK235.Filtered := True;

                     while not FTabelaRegK235.Eof do
                        begin
                           RegistroK235          := FcompSpedFiscal.Bloco_K.RegistroK235New;
                           RegistroK235.DT_SAIDA := RegistroK230.DT_INI_OP;
                           RegistroK235.COD_ITEM := FTabelaRegK235.FieldByName('COD_ITEM').AsString;
                           RegistroK235.QTD := FTabelaRegK235.FieldByName('QTD').AsFloat;
                           RegistroK235.COD_INS_SUBST := '';

                           FTabelaRegK235.Next;
                        end;{while}

                     FTabelaRegK230.Next;
                  end;{while}
            end;
      end;
end;

procedure TSpedFiscal.GerarLinhaMemoLog(const LinhaLog: String);
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

function TSpedFiscal.GetCodNatReg0400ByCFOP(const CFOP: String): String;
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

function TSpedFiscal.GetCodPartByCnpjCpf(const CNPJCPF: String): String;
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

function TSpedFiscal.GetValorFieldDataSet(cds: TClientDataSet; const Campo: String): String;
begin
  cds.Filtered := False;
  cds.Filter := 'SECAO_CAMPO = ' + QuotedStr(Trim(Campo));
  cds.Filtered := True;
  Result := Trim(cds.FieldByName('CONTEUDO').AsString);
  cds.Filtered := False;
end;

procedure TSpedFiscal.IncBar;
begin
   if (Assigned(FProgressBar)) then
      begin
         FProgressBar.Position := FProgressBar.Position + 1;
         Application.ProcessMessages;
      end;
end;

procedure TSpedFiscal.IncluirCodItemProdReg0200(const CodProd, DescrProd, EAN, UnidM, NCM: String; const pIcms: Double);
var
 UniMedida:String;
begin
   if Trim(CodProd) = '' then
      Exit;

   try
      UniMedida :=  UpperCase(COPY(UnidM,1,2));
     if
       (UniMedida <>  'CX') AND
       (UniMedida <>  'UN') AND
       (UniMedida <>  'PC') AND
       (UniMedida <>  'BI') AND  //mauricio 05062024   mudANDça pra tratar erro de unidade de medida
       (UniMedida <>  'BL') AND
       (UniMedida <>  'CT') AND
       (UniMedida <>  'DP') AND
       (UniMedida <>  'DZ') AND
       (UniMedida <>  'EN') AND
       (UniMedida <>  'FD') AND
       (UniMedida <>  'FR') AND
       (UniMedida <>  'KG') AND
       (UniMedida <>  'LT') AND
       (UniMedida <>  'PO') AND
       (UniMedida <>  'TB') AND
       (UniMedida <>  'VD') then
        UniMedida :=  'UN';
      FTabelaReg0200.Filtered := False;
      FTabelaReg0200.Filter := 'COD_ITEM = ' + QuotedStr(CodProd);
      FTabelaReg0200.Filtered := True;
      if FTabelaReg0200.IsEmpty then
         begin
            FTabelaReg0200.Append;
            FTabelaReg0200.FieldByName('TIPO_ITEM').AsString := 'P'; // S = Serviços e P = Produtos
            FTabelaReg0200.FieldByName('COD_ITEM').AsString := CodProd;
            FTabelaReg0200.FieldByName('DESCR_ITEM').AsString := DescrProd;
            FTabelaReg0200.FieldByName('COD_BARRA').AsString := EAN;
            FTabelaReg0200.FieldByName('COD_ANT_ITEM').AsString := '';
            FTabelaReg0200.FieldByName('UNID_INV').AsString := UniMedida;
            FTabelaReg0200.FieldByName('COD_NCM').AsString := NCM;
            FTabelaReg0200.FieldByName('ALIQ_ICMS').AsFloat := pIcms;
            FTabelaReg0200.Post;
         end
      else
        if FTabelaReg0200.FieldByName('UNID_INV').AsString <> UniMedida then
           IncluirUnidFatConverReg0220(CodProd, UniMedida, EAN, 1);
   finally
      FTabelaReg0200.Filtered := False;
   end;
end;

procedure TSpedFiscal.IncluirUnidFatConverReg0220(const CodProd, UnidConv, EAN: String; const dFatConv: Double);
var
 UniMedida:String;
begin
   if Trim(CodProd) = '' then
      Exit;


      UniMedida := UpperCase(COPY(UnidConv,1,2));
     if
       (UniMedida <>  'CX') AND
       (UniMedida <>  'UN') AND
       (UniMedida <>  'PC') AND
       (UniMedida <>  'BI') AND  //mauricio 05062024   mudANDça pra tratar erro de unidade de medida
       (UniMedida <>  'BL') AND
       (UniMedida <>  'CT') AND
       (UniMedida <>  'DP') AND
       (UniMedida <>  'DZ') AND
       (UniMedida <>  'EN') AND
       (UniMedida <>  'FD') AND
       (UniMedida <>  'FR') AND
       (UniMedida <>  'KG') AND
       (UniMedida <>  'LT') AND
       (UniMedida <>  'PO') AND
       (UniMedida <>  'TB') AND
       (UniMedida <>  'VD') then
        UniMedida :=  'UN';

   try
      FTabelaReg0220.Filtered := False;
      FTabelaReg0220.Filter := 'UNID_CONV = ' + QuotedStr(UnidConv);
      FTabelaReg0220.Filtered := True;
      if FTabelaReg0220.IsEmpty then
         begin
            FTabelaReg0220.Append;
            FTabelaReg0220.FieldByName('COD_ITEM').AsString := CodProd;
            FTabelaReg0220.FieldByName('UNID_CONV').AsString :=UniMedida;
            FTabelaReg0220.FieldByName('COD_BARRA').AsString := EAN;
            FTabelaReg0220.FieldByName('FAT_CONV').AsFloat := dFatConv;
            FTabelaReg0220.Post;
         end;
   finally
      FTabelaReg0220.Filtered := False;
   end;
end;

procedure TSpedFiscal.IncluirUnidProdReg0190(const UnidMedProd: String);
VAR
 unidade :string;
begin
   if Trim(UnidMedProd) = '' then
      Exit;

   try
      unidade:='UN';// UpperCase(COPY(UnidMedProd,1,2));
      FTabelaReg0190.Filtered := False;
      FTabelaReg0190.Filter := 'UNID = ' + QuotedStr(unidade);
      FTabelaReg0190.Filtered := True;
      FTabelaReg0190.RecordCount;
      if (FTabelaReg0190.IsEmpty) then
         begin

             //unidade:= UpperCase(COPY(UnidMedProd,1,2));
            if     (unidade =  'CX') OR
                   (unidade =  'UN') OR
                   (unidade =  'PC') OR
                   (unidade =  'BI') OR
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
                FTabelaReg0190.FieldByName('UNID').AsString :=  unidade;
                FTabelaReg0190.FieldByName('DESCR').AsString := 'UNIDADE MEDIDA '+'UN';
                FTabelaReg0190.Post;
               end;


         end;
   finally
      FTabelaReg0190.Filtered := False;
   end;
end;

function TSpedFiscal.InformacoesNFeValidasParaEscriturar(Notas: TNotasFiscais; const docEntrada: Boolean = False): Boolean;
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

procedure TSpedFiscal.IniciaBar(const iValueMaxBar: Integer);
begin
   if (Assigned(FProgressBar)) then
      begin
         FProgressBar.Max := iValueMaxBar;
         FProgressBar.Position := 0;
      end;
end;

procedure TSpedFiscal.IniciarControles;
begin
   FListaArquivos.Clear;

   FECF_RequerZ := False;
   FTOT_VL_ICMS_DEB := 0; // C190 C320 C390 C490 C590 C790 - Saídas
   FTOT_VL_ICMS_CRE := 0; // C190, C590, D190 e D590 - Entradas

   FVL_TOT_ICMS_ST_NF_ENTRADA := 0;
   FVL_TOT_ICMS_ST_NF_SAIDA := 0;

   FExitemNotasComSubstituicaoTributaria := False;

   {Limpa Lista de erros}
   if Assigned(FMemoErro) then
      FMemoErro.Lines.Clear;

   IniciaBar(0);

   FTabelaRegE510.EmptyDataSet;
   FTabelaRegC190.EmptyDataSet;
   if (FACBrECF.Ativo) then
      FACBrECF.Desativar;
end;

procedure TSpedFiscal.LimparTabela;
begin
   dmPrincipal.FdQueryAuxiliar.sql.Clear;
   dmPrincipal.FdQueryAuxiliar.SQL.Text:='DELETE FROM BLOCO_H';
   dmPrincipal.FdQueryAuxiliar.ExecSQL;



    dmPrincipal.FDSQL.SQL.Clear;
    dmPrincipal.FDSQL.sql.add(' SELECT COUNT(*)');
    dmPrincipal.FDSQL.sql.add(' FROM  RDB$RELATIONS');
    dmPrincipal.FDSQL.sql.add(' WHERE RDB$FLAGS=1 and RDB$RELATION_NAME=''TEMP_REG0200'' ');
    dmPrincipal.FDSQL.Open();



   if  not dmPrincipal.FDSQL.fields[0].value=0 then
      begin
        dmPrincipal.FDSQL.SQL.Clear;
        dmPrincipal.FDSQL.sql.add(' DELETE FROM TEMP_REG0200');
        dmPrincipal.FDSQL.ExecSQL;
      end;




end;

function TSpedFiscal.NotaCancelada(const Chave: String): Boolean;
var
   oListaCanceladas: TStrings;
   idx: Integer;
begin
   Result := False;
//   Exit;

   // Lista NFe
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

   // Lista NFCe
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

procedure TSpedFiscal.OnErrorSpedFiscal(const MsgError: AnsiString);
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

procedure TSpedFiscal.OnErrorSpedFiscal(const MsgError: String);
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

procedure TSpedFiscal.SetCnpjEmpresa(const Value: String);
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

procedure TSpedFiscal.SetDataFinal(const Value: TDateTime);
begin
  FDataFinal := Value;
  Self.FcompSpedFiscal.DT_FIN := FDataFinal;
end;

procedure TSpedFiscal.SetDataInicial(const Value: TDateTime);
begin
  FDataInicial := Value;
  Self.FcompSpedFiscal.DT_INI := FDataInicial;
end;

procedure TSpedFiscal.SetEventoOnError;
begin
   FcompSpedFiscal.OnError := OnErrorSpedFiscal;
end;

procedure TSpedFiscal.SetLocalSalvar(const Value: String);
var
   sNomeArquivo: String;
begin

  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.open;


  FLocalSalvar := ExtractFilePath(Value);
  sNomeArquivo := 'SPED_FISCAL_EMP_' +  dmPrincipal.cdsConsEmpresaRAZAO.AsString + '_MES_' +
                                           FormatDateTime('mm_yyyy', Self.FcompSpedFiscal.DT_INI) + '.txt';
  Self.FcompSpedFiscal.Arquivo := AnsiString(FLocalSalvar + sNomeArquivo);
  Self.FcompSpedFiscal.Path := ExtractFilePath(FLocalSalvar);
  if (not DirectoryExists(String(Self.FcompSpedFiscal.Path))) then
     ForceDirectories(String(Self.FcompSpedFiscal.Path));
end;

procedure TSpedFiscal.SetMemoErro(const Value: TMemo);
begin
   FMemoErro := Value;
   SetEventoOnError;
end;

procedure TSpedFiscal.SetSpedFiscal(const Value: TACBrSPEDFiscal);
begin
  FcompSpedFiscal := Value;
  SetEventoOnError;
end;

function TSpedFiscal.verificaDataInvetario(Data : string):TDate;
var
 AnoAtual :Integer ;
 NovaData:Tdate;


begin

  dmPrincipal.cdsBD.Close;
  dmPrincipal.cdsBD.open;

  dmPrincipal.FDConnFarmax.Close;
  dmPrincipal.FDConnFarmax.Params.Values['DriverID']  :='FB';
  dmPrincipal.FDConnFarmax.Params.Values['Server']    := dmPrincipal.cdsBDSERVIDOR_FARMAX.Value;
  dmPrincipal.FDConnFarmax.Params.Values['Database']  := dmPrincipal.cdsBDBD_FARMAX.Value;
  dmPrincipal.FDConnFarmax.Params.Values['User_Name'] :='SYSDBA';
  dmPrincipal.FDConnFarmax.Params.Values['Password']  :='masterkey';
  dmPrincipal.FDConnFarmax.Params.Values['Port']      := DmPrincipal.cdsBDportafb_far.Value;
  dmPrincipal.FDConnFarmax.Params.Values['Protocol']  :='TCPIP';
  dmPrincipal.FDConnFarmax.Connected := true;




   dmPrincipal.FDQuery.Close;
   dmPrincipal.FDQuery.SQL.Clear;
   dmPrincipal.FDQuery.sql.Text:='SELECT DISTINCT(DATA)FROM POSICAOESTOQUEDATA WHERE DATA =:Data';   //mes 12 do dia anterior
   dmPrincipal.FDQuery.ParamByName('DATA').AsString := StringReplace(data,'/','.',[rfReplaceAll, rfIgnoreCase]);
   dmPrincipal.FDQuery.Open();
   if dmPrincipal.FDQuery.RecordCount > 0 then
      begin
       Result := StrTodate(dmPrincipal.FDQuery.Fields[0].Value);
      end
   else
      begin

        AnoAtual:= YearOf(now);
        NovaData:= EncodeDate(AnoAtual,1,1);// cria data 01/01 ano atual
        Data    := DateToStr(NovaData);

         dmPrincipal.FDQuery.Close;
         dmPrincipal.FDQuery.SQL.Clear;
         dmPrincipal.FDQuery.sql.Text:='SELECT DISTINCT(DATA)FROM POSICAOESTOQUEDATA WHERE DATA =:Data';   //mes 12 do dia anterior
         dmPrincipal.FDQuery.ParamByName('DATA').AsString :=StringReplace(data,'/','.',[rfReplaceAll, rfIgnoreCase]);
         dmPrincipal.FDQuery.Open();

         if dmPrincipal.FDQuery.RecordCount > 0  then
          begin
            Result := StrTodate(dmPrincipal.FDQuery.Fields[0].Value);
          end;
      end;
end;

end.
