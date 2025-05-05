unit uMenuPrincipal;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, Menus, StdCtrls, Buttons, pngimage, ActnList, ComCtrls,
   DateUtils, ACBrSpedFiscal, System.Actions, ACBrBase, Vcl.Mask, Vcl.DBCtrls,
  dxGDIPlusClasses,midas, midaslib,System.IOUtils, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,ShellAPI,WinInet;

type
  TFrmPrincipal = class(TForm)
    pnlLeft: TPanel;
    pnlFundo: TPanel;
    ActionList1: TActionList;
    actFechar: TAction;
    actGerarArquivo: TAction;
    SaveDialog1: TSaveDialog;
    pnFundoShape: TPanel;
    Panel1: TPanel;
    pgcPrincipal: TPageControl;
    tabOpcoes: TTabSheet;
    grbEmpresa: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    txtEmpresa: TStaticText;
    txtCNPJ: TStaticText;
    txtEndereco: TStaticText;
    txtFone: TStaticText;
    txtEmail: TStaticText;
    txtCodIbgsUF: TStaticText;
    t: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnProcurarLocalSalvar: TSpeedButton;
    Label10: TLabel;
    btnProcurarLocalXML_NFE: TSpeedButton;
    Label12: TLabel;
    btnProcurarLocalXML_NFCE: TSpeedButton;
    Label13: TLabel;
    btnProcurarLocalXML_FORN: TSpeedButton;
    Label14: TLabel;
    btnProcurarMFDSPED: TSpeedButton;
    Label15: TLabel;
    btnProcurarLocalXML_NFSE: TSpeedButton;
    rgrFinalidadeArquivo: TRadioGroup;
    edtDataInicial: TDateTimePicker;
    edtDataFinal: TDateTimePicker;
    edtLocalArquivo: TEdit;
    rgrArquivosGerar: TRadioGroup;
    grbNrReciboAnt: TGroupBox;
    edtNrReciboAnt: TEdit;
    edtLocalXML_NFE: TEdit;
    edtLocalXML_NFCE: TEdit;
    edtLocalXML_FORN: TEdit;
    chkArqMFDCuponsLocal: TCheckBox;
    edtLocalMFDSPED: TEdit;
    grbBopcBlocosGerar: TGroupBox;
    chkGerarBlocoH: TCheckBox;
    chkGerarBlocoK: TCheckBox;
    edtLocalXML_NFSE: TEdit;
    tabLog: TTabSheet;
    mmLogSped: TMemo;
    tabCadastro: TTabSheet;
    PcEmpresa: TPageControl;
    tabEmpresa: TTabSheet;
    GroupBox1: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    SpbImPortar: TSpeedButton;
    SPbSalvar: TSpeedButton;
    Label32: TLabel;
    Label33: TLabel;
    Label17: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    EditRazao: TEdit;
    EditFantasia: TEdit;
    EditEndereco: TEdit;
    EditNumero: TEdit;
    Editbairro: TEdit;
    EditCidade: TEdit;
    EditUf: TEdit;
    EditEmail: TEdit;
    EditCnpj: TEdit;
    EditCodigoMunicipio: TEdit;
    EditTelefone: TEdit;
    CbbCrt: TComboBox;
    EditContadorPerfil: TEdit;
    EditIE: TEdit;
    EditIEMunicipal: TEdit;
    EditCep: TEdit;
    tabContador: TTabSheet;
    GroupBox2: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label36: TLabel;
    Label42: TLabel;
    EditContadorNome: TEdit;
    EditContadorCPF: TEdit;
    EditContadorEnderecoo: TEdit;
    EditContadorCompl: TEdit;
    EditContadorNumero: TEdit;
    EditContadorBairro: TEdit;
    EditContadorCodCidade: TEdit;
    EditContadorCEP: TEdit;
    EditContadorEmail: TEdit;
    EditContadorTelefon: TEdit;
    EditContadorFax: TEdit;
    EditContadorCNPJ: TEdit;
    EditContadorCRC: TEdit;
    tabHome: TTabSheet;
    pnHome: TPanel;
    OpenDialogServerFarmax: TOpenDialog;
    Label2: TLabel;
    SpbFechar: TSpeedButton;
    spbGerarArquivo: TSpeedButton;
    ShPesquisa: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpbConfiguracao: TSpeedButton;
    Shape1: TShape;
    Shape4: TShape;
    Image1: TImage;
    TabConfiguracao: TTabSheet;
    GroupBox3: TGroupBox;
    Label29: TLabel;
    CbbTipoAtividade: TComboBox;
    Label48: TLabel;
    CbbIncidenciaTributaria: TComboBox;
    Label51: TLabel;
    CbbNaturezaEmpresarial: TComboBox;
    Label49: TLabel;
    CbbMetododeApropriacao: TComboBox;
    Label50: TLabel;
    CbbTipoContribuicaoApurada: TComboBox;
    Label52: TLabel;
    CbbIndicadorRegimeCumulativo: TComboBox;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    LblServidor: TLabel;
    LblCaminho: TLabel;
    EdtServidorFarmax: TEdit;
    SpbServerFarmax: TSpeedButton;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    OpenDialogServerSped: TOpenDialog;
    EdtCaminhofarmax: TEdit;
    BitBtSalvarBdFX: TBitBtn;
    lblRegime: TLabel;
    LblCrt: TLabel;
    Label16: TLabel;
    Shape2: TShape;
    Label53: TLabel;
    Label1: TLabel;
    Label54: TLabel;
    CheckBGerarArquivoFarmax: TCheckBox;
    Image2: TImage;
    lblVersao: TLabel;
    EditPorta: TEdit;
    Label55: TLabel;
    Label56: TLabel;
    IdHTTP1: TIdHTTP;
    procedure Sobre1Click(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actGerarArquivoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgrFinalidadeArquivoClick(Sender: TObject);
    procedure btnProcurarLocalSalvarClick(Sender: TObject);
    procedure btnProcurarLocalXML_NFEClick(Sender: TObject);
    procedure edtDataInicialChange(Sender: TObject);
    procedure edtDataFinalChange(Sender: TObject);
    procedure ImpressoraFiscal1Click(Sender: TObject);
    procedure LerArquivodeTeste1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProcurarLocalXML_NFCEClick(Sender: TObject);
    procedure btnProcurarLocalXML_FORNClick(Sender: TObject);
    procedure btnProcurarMFDSPEDClick(Sender: TObject);
    procedure btnProcurarLocalXML_NFSEClick(Sender: TObject);
    procedure pgcPrincipalEnter(Sender: TObject);
    procedure pgcPrincipalChange(Sender: TObject);
    procedure SpbImPortarClick(Sender: TObject);
    procedure SPbSalvarClick(Sender: TObject);
    procedure edtDataInicialExit(Sender: TObject);
    procedure edtDataFinalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDataFinalExit(Sender: TObject);
    procedure edtDataFinalMouseLeave(Sender: TObject);
    procedure edtDataFinalEnter(Sender: TObject);
    procedure spbGerarArquivoClick(Sender: TObject);
    procedure SpbFecharClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpbConfiguracaoClick(Sender: TObject);
    procedure SpbServerFarmaxClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure edtDataInicialMouseLeave(Sender: TObject);
    procedure spbServidorSpedClick(Sender: TObject);
    procedure BitBtSalvarBdFXClick(Sender: TObject);
    procedure pnlFundoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CbbIndicadorRegimeCumulativoMouseLeave(Sender: TObject);
    procedure CbbTipoContribuicaoApuradaMouseLeave(Sender: TObject);
    procedure CbbIncidenciaTributariaMouseLeave(Sender: TObject);
    procedure CbbNaturezaEmpresarialMouseLeave(Sender: TObject);
    procedure CbbIncidenciaTributariaSelect(Sender: TObject);
    procedure CbbIncidenciaTributariaMouseEnter(Sender: TObject);

    procedure CheckBGerarArquivoFarmaxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image2Click(Sender: TObject);

  private
     FLogSalvo: Boolean;
     FSemLimAux: Boolean;

     procedure SalvarLog;
     procedure CarreDadosSped;
     function  ValidaBdFarmax:boolean;
     function  VersaoExe(const Filename: String): String;
     procedure ImportarDadosFarmax;
  public
     function  ObterNumeroVersaoLocal: smallint;
     function  ObterNumeroVersaoFTP: SmallInt;
     Function  VerificarArquivosXML(const Pasta: string):boolean;
     function  ConectadoInternet: boolean;
     procedure VerificaVersao;



   var
   enquadramentotributario,versao:string;

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
   udmPrincipal, uFrmGerarSpedFiscal, uFuncoesBasicas, uFrmConfigurarECF,
    uConstsGerais, uFrmGerarSpedPisCofins, uFrmSobre, System.IniFiles,
  UXmlCompras, UXmlVenda, UXmlNFeDanfe, UGerarArquivosFarmax, System.Types,
  ConfigServer;

{$R *.dfm}

procedure TFrmPrincipal.actFecharExecute(Sender: TObject);
begin
   if SpbFechar.Enabled then
      Self.Close;
end;

procedure TFrmPrincipal.actGerarArquivoExecute(Sender: TObject);
var
  Ano, Mes, Dia: Word;
begin

{$region}

//   dmPrincipal.cdsConsEmpresa.close;
//   dmPrincipal.cdsConsEmpresa.open;
//
//   if btnGerar.Enabled then
//    begin
//      if (edtLocalArquivo.Text = '') or (edtLocalArquivo.Text = 'C:\') then
//       begin
//         if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'C:\Exporta\') then
//          begin
//           CreateDir(ExtractFilePath(Application.ExeName) + 'C:\Exporta');
//           edtLocalArquivo.Text := 'C:\Exporta\';
//           ShowMessage('O arquivo será gerado na pasta C:\Exporta.');
//          end;
//       end;
//
//      ///
//      ///  Bloqueio de Junho/2023 para Angelo Testar.
//      ///
////      DecodeDate(edtDataFinal.DateTime, Ano, Mes, Dia);
////      if (Ano <> 2023) or (Mes <> 6) then
////      begin
////        ShowMessage('Período de apuração informado está fora do [intervalo]!');
////        Exit;
////      end;
////
////      DecodeDate(edtDataInicial.DateTime, Ano, Mes, Dia);
////      if (Ano <> 2023) or (Mes <> 6) then
////      begin
////        ShowMessage('Período de apuração informado está fora do [intervalo]!');
////        Exit;
////      end;
//
//       btnGerar.Enabled  := False;
//       btnFechar.Enabled := False;
//       try
//          mmLogSped.Lines.BeginUpdate;
//          Application.ProcessMessages;
//
//          SalvarLog;
//          FLogSalvo := False;
//
//          // Sped Fiscal
//          if (rgrArquivosGerar.ItemIndex = 0) or (rgrArquivosGerar.ItemIndex = 2) then
//             begin
//                FrmGerarSpedFiscal := TFrmGerarSpedFiscal.Create(Self);
//
//                FrmGerarSpedFiscal.CodigoEmpresa := dmPrincipal.cdsConsEmpresaCD_FILIAL.Value; //codigo filial da tabela filiais  / parametros
//                FrmGerarSpedFiscal.Original := (rgrFinalidadeArquivo.ItemIndex = 0);
//                FrmGerarSpedFiscal.GerarCupomFiscal := chkGerarCupomFiscal.Checked;
//                FrmGerarSpedFiscal.MemoErro := mmLogSped;
//                FrmGerarSpedFiscal.ConexaoBase := dmPrincipal.connBaseDados; //angelo conexão com a base de dados
//                FrmGerarSpedFiscal.DataInicial := edtDataInicial.DateTime;   //período inicial
//                FrmGerarSpedFiscal.DataFinal := edtDataFinal.DateTime;       //período final
//                FrmGerarSpedFiscal.LocalArquivo := edtLocalArquivo.Text;     //local exportação do arquivo
//                FrmGerarSpedFiscal.CodigIbgeUfEmpresa := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.AsInteger; //cd_uf da empresa
//                FrmGerarSpedFiscal.LocalDocXml_NFE := edtLocalXML_NFE.Text;
//                FrmGerarSpedFiscal.LocalDocXml_NFCE := edtLocalXML_NFCE.Text;
//                FrmGerarSpedFiscal.LocalDocXml_FORN := edtLocalXML_FORN.Text;
//                FrmGerarSpedFiscal.CnpjEmpresa := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaCGC.Value); //cnpc da tabela config / parametros
//                FrmGerarSpedFiscal.ArquivoMFDSPEDLocal := chkArqMFDCuponsLocal.Checked;
//                FrmGerarSpedFiscal.LocalArquivoMFDSPED := edtLocalMFDSPED.Text;
//                FrmGerarSpedFiscal.GerarBlocoH := chkGerarBlocoH.Checked;
//                FrmGerarSpedFiscal.GerarBlocoK := chkGerarBlocoK.Checked;
//
//                FrmGerarSpedFiscal.SemLimite := FSemLimAux;
//
//                FrmGerarSpedFiscal.ShowModal;
//                FreeAndNIl(FrmGerarSpedFiscal);
//             end;{Sped Fiscal}
//
//          // Sped Pis e Cofins
//          if (rgrArquivosGerar.ItemIndex = 1) or (rgrArquivosGerar.ItemIndex = 2) then
//             begin
//                FrmGerarSpedPisCofins := TFrmGerarSpedPisCofins.Create(Self);
//
//                FrmGerarSpedPisCofins.CodigoEmpresa := dmPrincipal.CodigoFilial;
//                FrmGerarSpedPisCofins.Original := (rgrFinalidadeArquivo.ItemIndex = 0);
//                FrmGerarSpedPisCofins.GerarCupomFiscal := chkGerarCupomFiscal.Checked;
//                FrmGerarSpedPisCofins.MemoErro := mmLogSped;
//                FrmGerarSpedPisCofins.ConexaoBase := dmPrincipal.connBaseDados; //angelo conexão com a base de dados
//                FrmGerarSpedPisCofins.DataInicial := edtDataInicial.DateTime;
//                FrmGerarSpedPisCofins.DataFinal := edtDataFinal.DateTime;
//                FrmGerarSpedPisCofins.LocalArquivo := edtLocalArquivo.Text;
//                FrmGerarSpedPisCofins.CodigIbgeUfEmpresa := StrToIntDef(txtCodIbgsUF.Caption, 0);
//                FrmGerarSpedPisCofins.LocalDocXml_NFE := edtLocalXML_NFE.Text;
//                FrmGerarSpedPisCofins.LocalDocXml_NFCE := edtLocalXML_NFCE.Text;
//                FrmGerarSpedPisCofins.LocalDocXml_FORN := edtLocalXML_FORN.Text;
//                FrmGerarSpedPisCofins.LocalDocXml_NFSE := edtLocalXML_NFSE.Text;
//                FrmGerarSpedPisCofins.CnpjEmpresa := RemoveMascaraStr(txtCNPJ.Caption);
//                FrmGerarSpedPisCofins.ArquivoMFDSPEDLocal := chkArqMFDCuponsLocal.Checked;
//                FrmGerarSpedPisCofins.LocalArquivoMFDSPED := edtLocalMFDSPED.Text;
//
//                FrmGerarSpedPisCofins.SemLimite := FSemLimAux;
//
//                FrmGerarSpedPisCofins.ShowModal;
//                FreeAndNIl(FrmGerarSpedPisCofins);
//             end;{Sped Pis e Cofins}
//          MensagemInformacao('Fim do processamento dos arquivos SPED!');
//       finally
//          btnGerar.Enabled := True;
//          btnFechar.Enabled := True;
//          mmLogSped.Lines.EndUpdate;
//          pgcPrincipal.ActivePage := tabLog;
//       end;
//    end;
{$EndRegion}
end;

procedure TFrmPrincipal.BitBtSalvarBdFXClick(Sender: TObject);
begin

 if EdtServidorFarmax.Text = '' then
     EdtServidorFarmax.Text := 'servidor';

  if EdtCaminhofarmax.Text = '' then
   begin
     EdtCaminhofarmax.SetFocus;
   end;

  dmPrincipal.cdsBD.Close;
  dmPrincipal.cdsBD.open;
  dmPrincipal.cdsBD.Edit;
  DmPrincipal.cdsBDSERVIDOR_FARMAX.Value:= EdtServidorFarmax.Text;
  dmPrincipal.cdsBDBD_FARMAX.Value      := EdtCaminhofarmax.Text;
  DmPrincipal.cdsBDPORTAFB_FAR.Value    := EditPorta.Text;
  dmPrincipal.cdsBD.ApplyUpdates(0);

  dmPrincipal.FDConnFarmax.Close;
  dmPrincipal.FDConnFarmax.Params.Values['DriverID']  := 'FB';
  dmPrincipal.FDConnFarmax.Params.Values['Server']    := EdtServidorFarmax.Text;
  dmPrincipal.FDConnFarmax.Params.Values['Database']  := EdtCaminhofarmax.Text;
  dmPrincipal.FDConnFarmax.Params.Values['User_Name'] := 'sysdba';
  dmPrincipal.FDConnFarmax.Params.Values['Password']  := 'masterkey';
  dmPrincipal.FDConnFarmax.Params.Values['Port']      := EditPorta.Text;
  dmPrincipal.FDConnFarmax.Params.Values['Protocol']  := 'TCPIP';


  try

   dmPrincipal.FDConnFarmax.Connected :=true;
   showmessage('Salvo com sucesso!'+sLineBreak +
              'verifique se as informaçoes foram salvo banco Sped.'+
                sLineBreak+'Na opção Empresa.');
   ImportarDadosFarmax;
   SPbSalvarClick(Sender);
   CarreDadosSped;
   pgcPrincipal.ActivePage := tabCadastro;

  except

   ExibeWarning('Servidor não localizado. '+EdtServidorFarmax.Text +'-'+ EdtCaminhofarmax.Text+'  Verifique as configurações.');

  end;

end;

procedure TFrmPrincipal.BtnOkClick(Sender: TObject);
var
 Existe : Boolean;
 Arquivo:TIniFile;
begin


   try
    Application.CreateForm(TFrmConfigServer, FrmConfigServer);
    FrmConfigServer.ShowModal;
    finally
    FrmConfigServer.Free;
   end;





//
//  if EditServidorSPed.Text = '' then
//     EditServidorSPed.Text := 'servidor';
//
//  if EditCaminhoBdSped.Text = '' then
//   begin
//
//     EditCaminhoBdSped.SetFocus;
//   end;
//
//   try
//
//    dmPrincipal.cdsBD.Close;
//    dmPrincipal.cdsBD.open;
//    dmPrincipal.cdsBD.Edit;
//    dmPrincipal.cdsBDSERVIDORSPED.Value:= EditServidorSPed.Text;
//    dmPrincipal.cdsBDBDSPED.Value      := EditCaminhoBdSped.Text;
//    DmPrincipal.cdsBDPORTAFB_FAR.Value := EditPorta.Text;
//    dmPrincipal.cdsBD.ApplyUpdates(0);
//
//    Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ConfigSped.ini');
//    Arquivo.WriteString('SERVIDOR','Servidor',EditServidorSPed.Text);
//    Arquivo.WriteString('SERVIDOR','Database',EditCaminhoBdSped.Text);
//    Arquivo.Free;
//
//    dmPrincipal.VAlidaBd;
//    txtEmpresa.Caption := dmPrincipal.NomeFilial;
//
//     showmessage('salvo com sucesso!');
//
//    except on E:Exception do
//    showmessage('Erro ao salvar Caminho BD'+e.Message);
//   end;
//

end;

procedure TFrmPrincipal.btnProcurarLocalSalvarClick(Sender: TObject);
begin
   SaveDialog1.FileName := 'Selecione o local para salvar os arquivos SPED';
   if SaveDialog1.Execute then
      edtLocalArquivo.Text := ExtractFilepath(SaveDialog1.FileName);
end;

procedure TFrmPrincipal.btnProcurarLocalXML_FORNClick(Sender: TObject);
begin
   SaveDialog1.FileName := 'Selecione o local do XML Fornecedor';
   if SaveDialog1.Execute then
      edtLocalXML_FORN.Text := ExtractFilepath(SaveDialog1.FileName);
end;

procedure TFrmPrincipal.btnProcurarLocalXML_NFCEClick(Sender: TObject);
begin
   SaveDialog1.FileName := 'Selecione o local da NFCE';
   if SaveDialog1.Execute then
      edtLocalXML_NFCE.Text := ExtractFilepath(SaveDialog1.FileName);
end;

procedure TFrmPrincipal.btnProcurarLocalXML_NFEClick(Sender: TObject);
begin
   SaveDialog1.FileName := 'Selecione o local da NFE Enviadas';
   if SaveDialog1.Execute then
      edtLocalXML_NFE.Text := ExtractFilepath(SaveDialog1.FileName);
end;

procedure TFrmPrincipal.btnProcurarLocalXML_NFSEClick(Sender: TObject);
begin
   SaveDialog1.FileName := 'Selecione o local do XML NFSE';
   if SaveDialog1.Execute then
      edtLocalXML_NFSE.Text := ExtractFilepath(SaveDialog1.FileName);
end;

procedure TFrmPrincipal.btnProcurarMFDSPEDClick(Sender: TObject);
begin
//   OpenDialog1.FileName := 'Selecione o arquvio MFD dos cupons';
//   OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
//   if OpenDialog1.Execute then
//      begin
//         edtLocalMFDSPED.Text := OpenDialog1.FileName;
//         if FileExists(edtLocalMFDSPED.Text) then
//            chkArqMFDCuponsLocal.Checked := True;
//      end;
end;


procedure TFrmPrincipal.CarreDadosSped;
var
  sEndereco: String;
begin

   txtEmpresa.Caption := dmPrincipal.NomeFilial;

   dmPrincipal.cdsConsEmpresa.close;
   dmPrincipal.cdsConsEmpresa.open;

   dmPrincipal.cdsConsDadosContador.close;
   dmPrincipal.cdsConsDadosContador.ParamByName('cd_filial').Value:= dmPrincipal.cdsConsEmpresaCD_FILIAL.Value;
   dmPrincipal.cdsConsDadosContador.Open;

   //mauricio
   sEndereco := dmPrincipal.cdsConsEmpresaENDERECO.Value;
   sEndereco := sEndereco + ', ' + dmPrincipal.cdsConsEmpresaNUMERO.Value;
   sEndereco := sEndereco + ', ' + dmPrincipal.cdsConsEmpresaCIDADE.Value + '-' + dmPrincipal.cdsConsEmpresaUF.Value;
   txtEndereco.Caption  := sEndereco;
   txtCNPJ.Caption      := dmPrincipal.cdsConsEmpresaCGC.Value;
   txtFone.Caption      := dmPrincipal.cdsConsEmpresaTELEFONE.Value;
   txtEmail.Caption     := dmPrincipal.cdsConsEmpresaEMAIL.Value;
   txtCodIbgsUF.Caption := dmPrincipal.cdsConsEmpresaUF.Value;
   edtLocalArquivo.Text := dmPrincipal.cdsConsEmpresaLOCAL_ARQUIVOS.Value;
   txtEmpresa.Caption   :=dmPrincipal.cdsConsEmpresaRAZAO.Value;



    case dmPrincipal.cdsConsEmpresaTIPO_ATIV.AsInteger + 1 of

     1 : LblCrt.Caption:='Simples Nacional';

     2 : LblCrt.Caption:='Simples Nacional - excesso de sublime';

     3 : LblCrt.Caption:='Regime Normal';

   end;


   if dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.value='S' then
      lblRegime.Caption:='Simples Nacional'
   else if dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.value='P' then
      lblRegime.Caption:='Lucro Presumido'
   else if dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.value='R' then
      lblRegime.Caption:='Lucro Real';


   if dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.value='P' then
      CbbIncidenciaTributaria.ItemIndex:= 1
   else
      CbbIncidenciaTributaria.ItemIndex:= 0;


  //mauricio abril 2024
   EditRazao.Text:= dmPrincipal.cdsConsEmpresaRAZAO.Value;
   EditFantasia.Text:= dmPrincipal.cdsConsEmpresaFANTASIA.Value;
   EditEndereco.Text:= dmPrincipal.cdsConsEmpresaENDERECO.Value;
   EditCidade.Text  := dmPrincipal.cdsConsEmpresacidade.Value;
   Editbairro.Text  := dmPrincipal.cdsConsEmpresaBAIRRO.Value;
   EditNumero.Text  := dmPrincipal.cdsConsEmpresaNUMERO.Value;
   EditUf.Text      := dmPrincipal.cdsConsEmpresaUF.Value;
   EditCnpj.Text    := dmPrincipal.cdsConsEmpresaCGC.Value;
   EditCodigoMunicipio.Text  := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.Value;
   EditTelefone.Text := dmPrincipal.cdsConsEmpresaTELEFONE.Value;
   EditEmail.Text  := dmPrincipal.cdsConsEmpresaEMAIL.Value;
   EditContadorPerfil.Text:=  dmPrincipal.cdsConsEmpresaPERFIL.Value;
   CbbCrt.ItemIndex  :=  dmPrincipal.cdsConsEmpresaTIPO_ATIV.AsInteger;
   EditIE.Text          :=  dmPrincipal.cdsConsEmpresaINSC_ESTADUAL.Value;
   EditIEMunicipal.Text :=  dmPrincipal.cdsConsEmpresaINSC_MUNICIPAL.Value;
   EditCep.Text     :=dmPrincipal.cdsConsEmpresaCEP.Value;

   EditContadorNome.Text        := dmPrincipal.cdsConsDadosContadorNOME.Value;
   EditContadorCPF.Text         := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorCPF.Value);
   EditContadorCRC.Text         := dmPrincipal.cdsConsDadosContadorCRC.Value;
   EditContadorCNPJ.Text        := dmPrincipal.cdsConsDadosContadorCNPJ.Value;
   EditContadorCEP.Text         := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorCEP.Value);
   EditContadorEnderecoo.Text   := dmPrincipal.cdsConsDadosContadorENDERECO.Value;
   EditContadorNumero.Text      := dmPrincipal.cdsConsDadosContadorNUMERO.Value;
   EditContadorCompl.Text       := '-';
   EditContadorBairro.Text      := dmPrincipal.cdsConsDadosContadorBAIRRO.Value;
   EditContadorTelefon.Text     := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorTELEFONE.Value);
   EditContadorFax.Text         := RemoveMascaraStr(dmPrincipal.cdsConsDadosContadorFAX.Value);
   EditContadorEmail.Text       := dmPrincipal.cdsConsDadosContadorEMAIL.Value;
   EditContadorCodCidade.Text   := dmPrincipal.cdsConsDadosContadorCOD_CIDADE.Value;

end;


procedure TFrmPrincipal.CbbIncidenciaTributariaMouseEnter(Sender: TObject);
begin
  if CbbIncidenciaTributaria.ItemIndex >=0 then
   begin
    CbbIncidenciaTributaria.Hint:=CbbIncidenciaTributaria.Items[CbbIncidenciaTributaria.ItemIndex];
   end;

end;

procedure TFrmPrincipal.CbbIncidenciaTributariaMouseLeave(Sender: TObject);
begin
 if CbbIncidenciaTributaria.ItemIndex >=0 then
   begin
    CbbIncidenciaTributaria.Hint:=CbbIncidenciaTributaria.Items[CbbIncidenciaTributaria.ItemIndex];
   end;
end;

procedure TFrmPrincipal.CbbIncidenciaTributariaSelect(Sender: TObject);
begin
  if CbbIncidenciaTributaria.ItemIndex >=0 then
   begin
    CbbIncidenciaTributaria.Hint:=CbbIncidenciaTributaria.Items[CbbIncidenciaTributaria.ItemIndex];
   end;
end;

procedure TFrmPrincipal.CbbIndicadorRegimeCumulativoMouseLeave(Sender: TObject);
begin
 if CbbIndicadorRegimeCumulativo.ItemIndex >=0 then
   begin
    CbbIndicadorRegimeCumulativo.Hint:=CbbIndicadorRegimeCumulativo.Items[CbbIndicadorRegimeCumulativo.ItemIndex];
   end;


end;

procedure TFrmPrincipal.CbbNaturezaEmpresarialMouseLeave(Sender: TObject);
begin
 if CbbNaturezaEmpresarial.ItemIndex >=0 then
   begin
    CbbNaturezaEmpresarial.Hint:=CbbNaturezaEmpresarial.Items[CbbNaturezaEmpresarial.ItemIndex];
   end;
end;

procedure TFrmPrincipal.CbbTipoContribuicaoApuradaMouseLeave(Sender: TObject);
begin
  if CbbTipoContribuicaoApurada.ItemIndex >=0 then
   begin
    CbbTipoContribuicaoApurada.Hint:=CbbTipoContribuicaoApurada.Items[CbbTipoContribuicaoApurada.ItemIndex];
   end;
end;

procedure TFrmPrincipal.CheckBGerarArquivoFarmaxClick(Sender: TObject);
begin
//
// if CheckBGerarArquivoFarmax.Checked then
//   begin
//
//    try
//     dmPrincipal.FDConnFarmax.Connected :=true;
//    except
//     ExibeWarning('Servidor não localizado. '+EdtServidorFarmax.Text +'-'+ EdtCaminhofarmax.Text+'  Verifique as configurações.');
//    end;
//   end;
end;

function TFrmPrincipal.ConectadoInternet: boolean;
var
 Internet :DWORD;
begin

  Result := False;

 if InternetGetConnectedState(@internet,0) then
    begin
      Result := True;
    end;

end;

procedure TFrmPrincipal.edtDataFinalChange(Sender: TObject);
begin
   if not (edtDataFinal.DroppedDown) then
      keybd_event(39,0,0,0);
end;

procedure TFrmPrincipal.edtDataFinalEnter(Sender: TObject);
begin
 edtDataFinal.Date:= EndofTheMonth(edtDataInicial.Date);
end;

procedure TFrmPrincipal.edtDataFinalExit(Sender: TObject);
begin
 edtDataFinal.Date:= EndofTheMonth(edtDataInicial.Date);
end;

procedure TFrmPrincipal.edtDataFinalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edtDataFinal.Date:= EndofTheMonth(edtDataInicial.Date);
end;

procedure TFrmPrincipal.edtDataFinalMouseLeave(Sender: TObject);
begin
 edtDataFinal.Date:= EndofTheMonth(edtDataInicial.Date);
end;

procedure TFrmPrincipal.edtDataInicialChange(Sender: TObject);
begin
   if not (edtDataInicial.DroppedDown) then
      keybd_event(39,0,0,0);
end;

procedure TFrmPrincipal.edtDataInicialExit(Sender: TObject);
begin
 edtDataFinal.Date:= EndofTheMonth(edtDataInicial.Date);
end;

procedure TFrmPrincipal.edtDataInicialMouseLeave(Sender: TObject);
begin
 edtDataFinal.Date:= EndofTheMonth(edtDataInicial.Date);
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   SalvarLog;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
   FLogSalvo := False;
   txtEmpresa.Caption := dmPrincipal.NomeFilial;

    versao:= VersaoExe(Application.ExeName);


 if ConectadoInternet then
    begin

       if dmPrincipal.VerificaFtpFarmaxOnline then
         begin

           VerificaVersao;

         end;

    end;




end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key =VK_F10 then spbGerarArquivo.Click;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
   DateTmp: TDate;
   sEndereco: String;
   i:integer;
begin


 if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\NFCeEnviadas\') then
    begin
     CreateDir(ExtractFilePath(Application.ExeName) +'NFCeEnviadas\');
     FrmPrincipal.edtLocalXML_NFCE.Text :='\NFCeEnviadas\';
    end;



 if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\NFeRecebidas\') then
    begin
     CreateDir(ExtractFilePath(Application.ExeName) +'NFeRecebidas\');
     FrmPrincipal.edtLocalXML_FORN.Text :='\NFeRecebidas\';
    end;

 if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\NFeEnviadas\') then
    begin
     CreateDir(ExtractFilePath(Application.ExeName) +'NFeEnviadas\');
     FrmPrincipal.edtLocalXML_NFE.Text :='\NFeEnviadas\';
    end;



   lblVersao.Caption:='Ver.:'+ VersaoExe(Application.ExeName);

   for I := 0 to pgcPrincipal.PageCount -1 do
     begin
       pgcPrincipal.Pages[i].TabVisible :=false;
     end;


   pgcPrincipal.ActivePage := tabHome;

   FSemLimAux := True; /// True = Liberado, False = Com limitação de leitura de 5 registros.

   DateTmp := IncMonth(Now, -1);

   edtDataInicial.Date := TDate(StartOfTheMonth(DateTmp));
   edtDataFinal.Date := TDate(EndOfTheMonth(DateTmp));

   CarreDadosSped;

end;

procedure TFrmPrincipal.Image2Click(Sender: TObject);
begin
 FrmPrincipal.WindowState:=wsMinimized;
end;

procedure TFrmPrincipal.ImportarDadosFarmax;
begin

 if ValidaBdFarmax then
    begin

       dmPrincipal.cdsBD.Close;
       dmPrincipal.cdsBD.open;

       dmPrincipal.cdsConsParametros.Close;
       dmPrincipal.cdsConsParametros.open;

       EditRazao.Text           := dmPrincipal.cdsConsParametrosRAZAO.Value;
       EditFantasia.Text        := dmPrincipal.cdsConsParametrosNOMEFANTASIA.Value;
       EditEndereco.Text        := dmPrincipal.cdsConsParametrosENDERECO.Value;
       EditCidade.Text          := dmPrincipal.cdsConsParametroscidade.Value;
       Editbairro.Text          := dmPrincipal.cdsConsParametrosBAIRRO.Value;
       EditNumero.Text          := dmPrincipal.cdsConsParametrosNUMERO.Value;
       EditUf.Text              := dmPrincipal.cdsConsParametrosUF.Value;
       EditCnpj.Text            := dmPrincipal.cdsConsParametrosCGC.Value;
       EditCodigoMunicipio.Text := dmPrincipal.cdsConsParametrosCD_MUNICIPIO.Value;
       EditTelefone.Text        := dmPrincipal.cdsConsParametrosFONE.Value;
       EditEmail.Text           := dmPrincipal.cdsConsParametrosEMAIL.Value;
       EditContadorPerfil.Text  := dmPrincipal.cdsConsParametrosPERFIL.Value;
       EditIE.Text              := dmPrincipal.cdsConsParametrosINSCRICAO.Value;
       EditIEMunicipal.Text     := dmPrincipal.cdsConsParametrosINSC_MUNICIPAL.Value;
       CbbCrt.ItemIndex         := (dmPrincipal.cdsConsParametrosCRT.AsInteger)-1;
       EditCep.Text             := dmPrincipal.cdsConsParametrosCEP.Value;
       enquadramentotributario  := dmPrincipal.cdsConsParametrosenquadramentotributario.Value;


       EditContadorNome.Text    := dmPrincipal.cdsConsParametrosCONTADORNOME.Value;
       EditContadorCPF.Text     := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORCPF.Value);
       EditContadorCNPJ.Text    := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORCNPJ.Value);
       EditContadorCRC.Text     := dmPrincipal.cdsConsParametrosCONTADORCRC.Value;
       EditContadorCEP.Text     := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORCEP.Value);
       EditContadorEnderecoo.Text:= dmPrincipal.cdsConsParametrosCONTADORENDERECO.Value;
       EditContadorNumero.Text  := dmPrincipal.cdsConsParametrosCONTADORNUMERO.Value;
       EditContadorCompl.Text   := '-';
       EditContadorBairro.Text  := dmPrincipal.cdsConsParametrosCONTADORBAIRRO.Value;
       EditContadorTelefon.Text := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORTELEFONE.Value);
       EditContadorFax.Text     := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORFAX.Value);
       EditContadorEmail.Text   := dmPrincipal.cdsConsParametrosCONTADOREMAIL.Value;
       EditContadorCodCidade.Text:= dmPrincipal.cdsConsParametrosCONTADORCD_MUNICIPIO.Value;


    end;

end;

procedure TFrmPrincipal.ImpressoraFiscal1Click(Sender: TObject);
begin
   FrmConfigurarECF := TFrmConfigurarECF.Create(Self);
   try
      FrmConfigurarECF.ShowModal;
    //  chkGerarCupomFiscal.Checked := FileExists(ExtractFilePath(Application.ExeName) + _ARQUIVO_CONFIG_INI_ECF);
   finally
      FreeAndNil(FrmConfigurarECF);
   end;
end;

procedure TFrmPrincipal.LerArquivodeTeste1Click(Sender: TObject);
begin
//   ACBrSPEDFiscal1.Path := ExtractFilePath('C:\SPED_IMPRESSORA_CUPONS.txt');
//   ACBrSPEDFiscal1.Arquivo := ExtractFileName('C:\SPED_IMPRESSORA_CUPONS.txt');
//
//   ShowMessage('Total 0200: ' + IntToStr(ACBrSPEDFiscal1.Bloco_0.Registro0001.Registro0200.Count) + sLineBreak + sLineBreak +
//               'Total C400: ' + IntToStr(ACBrSPEDFiscal1.Bloco_C.RegistroC001.RegistroC400.Count) + sLineBreak +
//               'Total C405: ' + IntToStr(ACBrSPEDFiscal1.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Count) + sLineBreak +
//               'Total C420: ' + IntToStr(ACBrSPEDFiscal1.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Items[0].RegistroC420.Count) + sLineBreak +
//               'Total C460: ' + IntToStr(ACBrSPEDFiscal1.Bloco_C.RegistroC001.RegistroC400.items[0].RegistroC405.Items[0].RegistroC460.Count) );
end;

function TFrmPrincipal.ObterNumeroVersaoFTP: SmallInt;
var
 sNumeroVersaoFtp,DirExecutavel,arquivo:string;
 oArquivoIni:TIniFile;
begin
 Application.ProcessMessages;

    begin
      oArquivoIni:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Versoes.ini');

      try
        //le o numero da versao
        sNumeroVersaoFtp:= oArquivoIni.ReadString('VERSOES','FarmaxSped',EmptyStr);
        //retira os pontos ex 1.0.0 para 100
        sNumeroVersaoFtp :=StringReplace(sNumeroVersaoFtp,'.',EmptyStr,[rfReplaceAll]);
        //converte o numero da versao
        result:=StrToIntDef(sNumeroVersaoFtp,0);

      finally
        FreeAndNil(oArquivoIni);
      end;
    end;


end;

function TFrmPrincipal.ObterNumeroVersaoLocal: smallint;
var
 sNumeroVersao:string;
 oArquivoIni:TIniFile;
begin
   // abre o arquivo "VersaoLocal.ini"
 oArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'VersaoLocal.ini');
  try
    // lê o número da versão
    sNumeroVersao := oArquivoINI.ReadString('VERSAOLOCAL', 'numero', EmptyStr);
   // retira os pontos (exemplo: de "1.0.0" para "100")
    sNumeroVersao := StringReplace(sNumeroVersao, '.', EmptyStr, [rfReplaceAll]);
   // converte o número da versão para número
    result := StrToIntDef(sNumeroVersao, 0);
  finally
    FreeAndNil(oArquivoIni);
  end;

end;

procedure TFrmPrincipal.pgcPrincipalChange(Sender: TObject);
begin
 PcEmpresa.ActivePage:=tabEmpresa;
end;

procedure TFrmPrincipal.pgcPrincipalEnter(Sender: TObject);
begin
 if pgcPrincipal.TabIndex <> 0 then
    spbGerarArquivo.Enabled := False
   else
    spbGerarArquivo.Enabled := True;
end;

procedure TFrmPrincipal.pnlFundoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmPrincipal.rgrFinalidadeArquivoClick(Sender: TObject);
begin
   if rgrFinalidadeArquivo.ItemIndex = 0 then
     grbNrReciboAnt.Enabled := False
  else
     grbNrReciboAnt.Enabled := True;
end;

procedure TFrmPrincipal.SalvarLog;
var
   sLocalDirLog: String;
begin
   if (not FLogSalvo) then
      begin
         if (mmLogSped.Lines.Count > 0) then
            begin
               sLocalDirLog := ExtractFilePath(Application.ExeName) + 'LogsSped\';
               if (not DirectoryExists(sLocalDirLog)) then
                  ForceDirectories(sLocalDirLog);

               mmLogSped.Lines.SaveToFile(sLocalDirLog + 'LOG_SPED_MES_ANO_' + FormatDateTime('mm_yyyy', edtDataInicial.DateTime) +
                 '_' + FormatDateTime('ddmmyyy_hhnnss', Now) + '.txt');
            end;
      end;
end;

procedure TFrmPrincipal.Sobre1Click(Sender: TObject);
begin
   FrmSobre := TFrmSobre.Create(Self);
   FrmSobre.ShowModal;
   FreeAndNil(FrmSobre);
end;

procedure TFrmPrincipal.SpbFecharClick(Sender: TObject);
begin
  if SpbFechar.Enabled then
      Self.Close;
end;

procedure TFrmPrincipal.spbGerarArquivoClick(Sender: TObject);
var
  Ano, Mes, Dia: Word;
  FListaArquivos:String;
  iCount:integer;
begin


   dmPrincipal.cdsConsEmpresa.close;
   dmPrincipal.cdsConsEmpresa.open;

   if spbGerarArquivo.Enabled then
    begin

      Screen.Cursor := crHourGlass;

     if CheckBGerarArquivoFarmax.Checked then
       begin

        edtLocalXML_FORN.Text :=ExtractFilePath(Application.ExeName)+'NFeRecebidas\';
        edtLocalXML_NFE.Text  :=ExtractFilePath(Application.ExeName)+'NFeEnviadas\';
        edtLocalXML_NFCE.Text :=ExtractFilePath(Application.ExeName)+'NFCeEnviadas\';


        if VerificarArquivosXML(edtLocalXML_NFCE.Text)then
           begin
                 //MessageDlg('Foi Encontrado Arquivo XML na pasta deseja Gerar Novamente?',mtConfirmation,[mbyes,mbno],0)=mrYes

             if MessageBox(Handle, 'Foi Encontrado Arquivo XML na pasta deseja Gerar Novamente?', 'Confirmacão', MB_YESNO or MB_ICONQUESTION)=IDYES  then
               begin
                  FrmGerarArquivo := TFrmGerarArquivo.Create(self);
                  FrmGerarArquivo.ShowModal;
                  FreeAndNIl(FrmGerarArquivo);
               end;

           end
        else
           begin
             FrmGerarArquivo := TFrmGerarArquivo.Create(self);
             FrmGerarArquivo.ShowModal;
             FreeAndNIl(FrmGerarArquivo);
           end;

       end
       else
      if (edtLocalArquivo.Text = '') or (edtLocalArquivo.Text = 'C:\') then
       begin

         if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'C:\Exporta\') then
          begin
           CreateDir(ExtractFilePath(Application.ExeName) + 'C:\Exporta');
           //edtLocalArquivo.Text := 'C:\Exporta\';
           ShowMessage('O arquivo será gerado na pasta C:\Exporta.');
          end;
       end
       else if edtLocalArquivo.Text<>'' then
       begin
         dmPrincipal.cdsConsEmpresa.close;
         dmPrincipal.cdsConsEmpresa.open;
         dmPrincipal.cdsConsEmpresa.edit;
         dmPrincipal.cdsConsEmpresaLOCAL_ARQUIVOS.Value:=edtLocalArquivo.Text;
         dmPrincipal.cdsConsEmpresa.ApplyUpdates(0);
         dmPrincipal.cdsConsEmpresa.close;
         dmPrincipal.cdsConsEmpresa.open;
       end
       else
       if (edtLocalXML_FORN.Text='') or (edtLocalXML_NFCE.Text ='') then
        begin
           showmessage('Verifique os diretórios dos arquivo de xml.'+sLineBreak +
                       'Arquivo "xml NFCe" , Arquivo "xml Fornecedor".'+sLineBreak+
                       'Não foi direcionado.');
           abort;
        end;



     {gerar o bloco H em março }
     DecodeDate(edtDataFinal.DateTime, Ano, Mes, Dia);
     if Mes = 3  then
      chkGerarBlocoH.Checked:=true;

       spbGerarArquivo.Enabled  := False;
       SpbFechar.Enabled := False;
       try
          mmLogSped.Lines.BeginUpdate;
          Application.ProcessMessages;

          SalvarLog;
          FLogSalvo := False;

          // Sped Fiscal
          if (rgrArquivosGerar.ItemIndex = 0) or (rgrArquivosGerar.ItemIndex = 2) then
             begin
                FrmGerarSpedFiscal := TFrmGerarSpedFiscal.Create(Self);

                FrmGerarSpedFiscal.CodigoEmpresa      := dmPrincipal.cdsConsEmpresaCD_FILIAL.Value;
                FrmGerarSpedFiscal.Original           := (rgrFinalidadeArquivo.ItemIndex = 0);
                FrmGerarSpedFiscal.MemoErro           := mmLogSped;
                FrmGerarSpedFiscal.ConexaoBase        := dmPrincipal.connBaseDados;
                FrmGerarSpedFiscal.DataInicial        := edtDataInicial.DateTime;
                FrmGerarSpedFiscal.DataFinal          := edtDataFinal.DateTime;
                FrmGerarSpedFiscal.LocalArquivo       := edtLocalArquivo.Text;
                FrmGerarSpedFiscal.CodigIbgeUfEmpresa := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.AsInteger;
                FrmGerarSpedFiscal.LocalDocXml_NFE    := edtLocalXML_NFE.Text;
                FrmGerarSpedFiscal.LocalDocXml_NFCE   := edtLocalXML_NFCE.Text;
                FrmGerarSpedFiscal.LocalDocXml_FORN   := edtLocalXML_FORN.Text;
                FrmGerarSpedFiscal.CnpjEmpresa        := RemoveMascaraStr(dmPrincipal.cdsConsEmpresaCGC.Value);
                FrmGerarSpedFiscal.ArquivoMFDSPEDLocal:= chkArqMFDCuponsLocal.Checked;
                FrmGerarSpedFiscal.LocalArquivoMFDSPED:= edtLocalMFDSPED.Text;
                FrmGerarSpedFiscal.GerarBlocoH        := chkGerarBlocoH.Checked;
                FrmGerarSpedFiscal.GerarBlocoK        := chkGerarBlocoK.Checked;
                FrmGerarSpedFiscal.SemLimite          := FSemLimAux;

                FrmGerarSpedFiscal.ShowModal;
                FreeAndNIl(FrmGerarSpedFiscal);
             end;{Sped Fiscal}

          // Sped Pis e Cofins
          if (rgrArquivosGerar.ItemIndex = 1) or (rgrArquivosGerar.ItemIndex = 2) then
             begin
                FrmGerarSpedPisCofins := TFrmGerarSpedPisCofins.Create(Self);

                FrmGerarSpedPisCofins.CodigoEmpresa      := dmPrincipal.CodigoFilial;
                FrmGerarSpedPisCofins.Original           := (rgrFinalidadeArquivo.ItemIndex = 0);
                FrmGerarSpedPisCofins.MemoErro           := mmLogSped;
                FrmGerarSpedPisCofins.ConexaoBase        := dmPrincipal.connBaseDados;
                FrmGerarSpedPisCofins.DataInicial        := edtDataInicial.DateTime;
                FrmGerarSpedPisCofins.DataFinal          := edtDataFinal.DateTime;
                FrmGerarSpedPisCofins.LocalArquivo       := edtLocalArquivo.Text;
                FrmGerarSpedPisCofins.CodigIbgeUfEmpresa := StrToIntDef(txtCodIbgsUF.Caption, 0);
                FrmGerarSpedPisCofins.LocalDocXml_NFE    := edtLocalXML_NFE.Text;
                FrmGerarSpedPisCofins.LocalDocXml_NFCE   := edtLocalXML_NFCE.Text;
                FrmGerarSpedPisCofins.LocalDocXml_FORN   := edtLocalXML_FORN.Text;
                FrmGerarSpedPisCofins.LocalDocXml_NFSE   := edtLocalXML_NFSE.Text;
                FrmGerarSpedPisCofins.CnpjEmpresa        := RemoveMascaraStr(txtCNPJ.Caption);
                FrmGerarSpedPisCofins.ArquivoMFDSPEDLocal:= chkArqMFDCuponsLocal.Checked;
                FrmGerarSpedPisCofins.LocalArquivoMFDSPED:= edtLocalMFDSPED.Text;
                FrmGerarSpedPisCofins.SemLimite          := FSemLimAux;

                FrmGerarSpedPisCofins.ShowModal;
                FreeAndNIl(FrmGerarSpedPisCofins);
             end;{Sped Pis e Cofins}
          MensagemInformacao('Fim do processamento dos arquivos SPED!');
       finally
          spbGerarArquivo.Enabled := True;
          SpbFechar.Enabled := True;
          mmLogSped.Lines.EndUpdate;
          pgcPrincipal.ActivePage := tabLog;
       end;

     Screen.Cursor := crDefault;

    end;

end;

procedure TFrmPrincipal.SpbImPortarClick(Sender: TObject);

begin

 if ValidaBdFarmax then
    begin

       dmPrincipal.cdsBD.Close;
       dmPrincipal.cdsBD.open;

       dmPrincipal.cdsConsParametros.Close;
       dmPrincipal.cdsConsParametros.open;

       EditRazao.Text    := dmPrincipal.cdsConsParametrosRAZAO.Value;
       EditFantasia.Text := dmPrincipal.cdsConsParametrosNOMEFANTASIA.Value;
       EditEndereco.Text := dmPrincipal.cdsConsParametrosENDERECO.Value;
       EditCidade.Text   := dmPrincipal.cdsConsParametroscidade.Value;
       Editbairro.Text   := dmPrincipal.cdsConsParametrosBAIRRO.Value;
       EditNumero.Text   := dmPrincipal.cdsConsParametrosNUMERO.Value;
       EditUf.Text       := dmPrincipal.cdsConsParametrosUF.Value;
       EditCnpj.Text     := dmPrincipal.cdsConsParametrosCGC.Value;
       EditCodigoMunicipio.Text  := dmPrincipal.cdsConsParametrosCD_MUNICIPIO.Value;
       EditTelefone.Text := dmPrincipal.cdsConsParametrosFONE.Value;
       EditEmail.Text    := dmPrincipal.cdsConsParametrosEMAIL.Value;
       EditContadorPerfil.Text:= dmPrincipal.cdsConsParametrosPERFIL.Value;
       EditIE.Text       :=  dmPrincipal.cdsConsParametrosINSCRICAO.Value;
       EditIEMunicipal.Text :=  dmPrincipal.cdsConsParametrosINSC_MUNICIPAL.Value;
       CbbCrt.ItemIndex  :=  (dmPrincipal.cdsConsParametrosCRT.AsInteger)-1;
       EditCep.Text      := dmPrincipal.cdsConsParametrosCEP.Value;
       enquadramentotributario  := dmPrincipal.cdsConsParametrosenquadramentotributario.Value;


       EditContadorNome.Text        := dmPrincipal.cdsConsParametrosCONTADORNOME.Value;
       EditContadorCPF.Text         := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORCPF.Value);
       EditContadorCNPJ.Text        := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORCNPJ.Value);
       EditContadorCRC.Text         := dmPrincipal.cdsConsParametrosCONTADORCRC.Value;
       EditContadorCEP.Text         := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORCEP.Value);
       EditContadorEnderecoo.Text   := dmPrincipal.cdsConsParametrosCONTADORENDERECO.Value;
       EditContadorNumero.Text      := dmPrincipal.cdsConsParametrosCONTADORNUMERO.Value;
       EditContadorCompl.Text       := '-';
       EditContadorBairro.Text      := dmPrincipal.cdsConsParametrosCONTADORBAIRRO.Value;
       EditContadorTelefon.Text     := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORTELEFONE.Value);
       EditContadorFax.Text         := RemoveMascaraStr(dmPrincipal.cdsConsParametrosCONTADORFAX.Value);
       EditContadorEmail.Text       := dmPrincipal.cdsConsParametrosCONTADOREMAIL.Value;
       EditContadorCodCidade.Text   := dmPrincipal.cdsConsParametrosCONTADORCD_MUNICIPIO.Value;
       showmessage('Dados Importado!');

    end;


end;
procedure TFrmPrincipal.SpbConfiguracaoClick(Sender: TObject);
var
 Arquivo : TIniFile;
begin
  pgcPrincipal.ActivePage := TabConfiguracao;


  Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ConfigSped.ini');
 // EditServidorSPed.Text:= Arquivo.ReadString('SERVIDOR','Servidor','');
 // EditCaminhoBdSped.Text := Arquivo.ReadString('SERVIDOR','Database','');
  Arquivo.Free;


  dmPrincipal.cdsBD.Close;
  dmPrincipal.cdsBD.open ;
  EdtServidorFarmax.Text:= dmPrincipal.cdsBDSERVIDOR_FARMAX.Value;
  EdtCaminhofarmax.Text := dmPrincipal.cdsBDBD_FARMAX.Value;
  EditPorta.Text        := dmPrincipal.cdsBDPORTAFB_FAR.Value;




end;

procedure TFrmPrincipal.SPbSalvarClick(Sender: TObject);
begin

   dmPrincipal.cdsConsEmpresa.close;
   dmPrincipal.cdsConsEmpresa.open;
   dmPrincipal.cdsConsEmpresa.edit;

   dmPrincipal.cdsConsEmpresaCD_FILIAL.Value:= 1;
   dmPrincipal.cdsConsEmpresaRAZAO.Value    :=  EditRazao.Text;
   dmPrincipal.cdsConsEmpresaFANTASIA.Value :=  EditFantasia.Text;
   dmPrincipal.cdsConsEmpresaENDERECO.Value :=  EditEndereco.Text;
   dmPrincipal.cdsConsEmpresacidade.Value   :=  EditCidade.Text;
   dmPrincipal.cdsConsEmpresaBAIRRO.Value   :=  Editbairro.Text;
   dmPrincipal.cdsConsEmpresaNUMERO.Value   :=  EditNumero.Text;
   dmPrincipal.cdsConsEmpresaUF.Value       :=  EditUf.Text;
   dmPrincipal.cdsConsEmpresaCGC.Value      :=  EditCnpj.Text;
   dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.Value:=EditCodigoMunicipio.Text;
   dmPrincipal.cdsConsEmpresaTELEFONE.Value :=  EditTelefone.Text;
   dmPrincipal.cdsConsEmpresaEMAIL.Value    :=  EditEmail.Text;
   dmPrincipal.cdsConsEmpresaPERFIL.Value   :=  EditContadorPerfil.Text;
   dmPrincipal.cdsConsEmpresaTIPO_ATIV.AsInteger  := CbbCrt.ItemIndex ;
   dmPrincipal.cdsConsEmpresaINSC_ESTADUAL.Value  := EditIE.Text;
   dmPrincipal.cdsConsEmpresaINSC_MUNICIPAL.Value := EditIEMunicipal.Text;
   dmPrincipal.cdsConsEmpresaLOCAL_ARQUIVOS.Value := edtLocalArquivo.Text;
   dmPrincipal.cdsConsEmpresaCEP.Value      :=EditCep.Text;
   dmPrincipal.cdsConsEmpresaLOCAL_ARQUIVOS.Value := edtLocalArquivo.Text;
   dmPrincipal.cdsConsEmpresaENQUADRAMENTO_TRIBUTARIO.Value:=enquadramentotributario;



   dmPrincipal.cdsConsDadosContador.close;
   dmPrincipal.cdsConsDadosContador.ParamByName('cd_filial').Value:= dmPrincipal.cdsConsEmpresaCD_FILIAL.Value ;
   dmPrincipal.cdsConsDadosContador.open;
   dmPrincipal.cdsConsDadosContador.edit;

   dmPrincipal.cdsConsDadosContadorCD_FILIAL.Value := dmPrincipal.cdsConsEmpresaCD_FILIAL.Value;
   dmPrincipal.cdsConsDadosContadorNOME.Value:= EditContadorNome.Text;
   dmPrincipal.cdsConsDadosContadorCPF.Value := RemoveMascaraStr(EditContadorCPF.Text);
   dmPrincipal.cdsConsDadosContadorCRC.Value := EditContadorCRC.Text;
   dmPrincipal.cdsConsDadosContadorCNPJ.Value := EditContadorCNPJ.Text;
   dmPrincipal.cdsConsDadosContadorCEP.Value := RemoveMascaraStr(EditContadorCEP.Text);
   dmPrincipal.cdsConsDadosContadorENDERECO.Value := EditContadorEnderecoo.Text;
   dmPrincipal.cdsConsDadosContadorNUMERO.Value   := EditContadorNumero.Text;
   dmPrincipal.cdsConsDadosContadorCOMPLEMENTO.Value := '-';
   dmPrincipal.cdsConsDadosContadorBAIRRO.Value   := EditContadorBairro.Text;
   dmPrincipal.cdsConsDadosContadorTELEFONE.Value := RemoveMascaraStr(EditContadorTelefon.Text );
   dmPrincipal.cdsConsDadosContadorFAX.Value      := RemoveMascaraStr(EditContadorFax.Text);
   dmPrincipal.cdsConsDadosContadorEMAIL.Value    := EditContadorEmail.Text;
   dmPrincipal.cdsConsDadosContadorCOD_CIDADE.Value := EditContadorCodCidade.Text;



   dmPrincipal.cdsConsEmpresa.ApplyUpdates(0);
   dmPrincipal.cdsConsDadosContador.ApplyUpdates(0);

   showmessage('Dados Salvo.');

   CarreDadosSped;

   pgcPrincipal.ActivePage := tabOpcoes;



end;

procedure TFrmPrincipal.SpbServerFarmaxClick(Sender: TObject);
begin
  OpenDialogServerFarmax.FileName :='Farmax FDB';
   if OpenDialogServerFarmax.Execute then
      EdtCaminhofarmax.Text := OpenDialogServerFarmax.FileName;
end;

procedure TFrmPrincipal.spbServidorSpedClick(Sender: TObject);
begin
// OpenDialogServerSped.FileName := 'banco de dados Farmax';
//   if OpenDialogServerSped.Execute then
//      EditCaminhoBdSped.Text := OpenDialogServerSped.FileName;
end;

procedure TFrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
   pgcPrincipal.ActivePage := tabHome
end;

procedure TFrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
   pgcPrincipal.ActivePage := tabCadastro;
end;

procedure TFrmPrincipal.SpeedButton3Click(Sender: TObject);
begin
  pgcPrincipal.ActivePage := tabOpcoes;
end;

function TFrmPrincipal.ValidaBdFarmax: boolean;
begin
  result:=false;
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



  try

   dmPrincipal.FDConnFarmax.Connected :=true;
     result:=true;
  except
   result:=false;
   ExibeWarning('Servidor não localizado!'+DmPrincipal.cdsBDSERVIDOR_FARMAX.Value +' - '+
                  dmPrincipal.cdsBDBD_FARMAX.Value   +'  Verifique as configurações.');

  end;

end;

function TFrmPrincipal.VerificarArquivosXML(const Pasta: string): boolean;
var
  Arquivos: TStringDynArray;
 // Arquivo: string;
begin
  // Obtém todos os arquivos XML na pasta especificada
  Arquivos := TDirectory.GetFiles(Pasta, '*.xml');

  // Verifica se existem arquivos XML
  if Length(Arquivos) = 0 then
    result:=false
  else
  begin
    result:=true;
  end;

end;

procedure TFrmPrincipal.VerificaVersao;
var
UrlArquivo,SalvarEm,DirExecutavel,DirSalvar,Arquivo: String;
 Ini,oArquiviIni : TIniFile;
 nNumeroVersaoLocal,nNumeroVersaoFTP:SmallInt;
 MyFile: TFileStream;
begin

   Application.ProcessMessages;
   DirExecutavel:=ExtractFilePath(Application.ExeName);
   versao:= VersaoExe(Application.ExeName);

  if FileExists(ExtractFilePath(Application.ExeName)+'AtualizaVersao.exe') then
     DeleteFile(Pchar(ExtractFilePath(Application.ExeName)+'AtualizaVersao.exe'));

  if not FileExists(DirExecutavel+'AtualizaVersao.exe') then
     begin

       try

         DirSalvar:=ExtractFilePath(Application.ExeName);
         UrlArquivo:='http://www.farmax.far.br/download/';
         Arquivo  :='AtualizaVersao.exe';
         MyFile := TFileStream.Create(DirSalvar+Arquivo, fmCreate);

         try

            IdHTTP1.Get(UrlArquivo+arquivo, MyFile); // fazendo o download do arquivo

          finally

            MyFile.Free;

          end;

       except on E:Exception do
         dmPrincipal.GeraLog('Erro ao baixar AtualizaVersao.exe:'+E.Message );
       end;

     end;


  if not FileExists(DirExecutavel+'VersaoLocal.ini') then
     begin

      ini := TiniFile.Create(ExtractFilePath(Application.ExeName)+'VersaoLocal.ini');
      ini.WriteString('VERSAOLOCAL','numero ',versao );
      ini.Free;

     end;

     begin

      nNumeroVersaoFTP  := ObterNumeroVersaoFTP;
      nNumeroVersaoLocal:= ObterNumeroVersaoLocal;

       if nNumeroVersaoLocal < nNumeroVersaoFTP then
          begin
           ShellExecute(Handle,nil, PChar('AtualizaVersao.exe'), 'FarmaxSped', nil, SW_SHOWNORMAL);
              //XXXXX VERIFICAR/CRIAR PARAMETRO NO ARQUIVO VERSOES.INI DO SITE
                    //O AtualizaVersao recebe parametro e executa um processo próprio para o sistema que está sendo atualizado
           Application.Terminate;
          end;

     end;

end;

function TFrmPrincipal.VersaoExe(const Filename: String): String;
   type
     TVersionInfo = packed record
     Dummy: array[0..7] of Byte;
     V2, V1, V4, V3: Word;
   end;
var
 Zero, Size: Cardinal;
 Data: Pointer;
 VersionInfo: ^TVersionInfo;
begin
 Size := GetFileVersionInfoSize
 (Pointer(Filename), Zero);
 if Size = 0 then
    Result := '0'
 else
  begin
   GetMem(Data, Size);
   try
    GetFileVersionInfo(Pointer(Filename), 0, Size, Data);
    VerQueryValue(Data, '\', Pointer(VersionInfo), Size);
    Result := Format('%d.%d.%d.%d', [VersionInfo.V1, VersionInfo.V2, VersionInfo.V3, VersionInfo.V4]);
   finally
    FreeMem(Data);
   end;
  end;
end;

end.

