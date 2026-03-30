unit uFrmConfigurarECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  Dialogs, StdCtrls, ExtCtrls, Buttons, ActnList, ACBrBase, ACBrECF, TypInfo,
  IniFiles, ACBrDevice, ComCtrls, System.Actions;

type
  TFrmConfigurarECF = class(TForm)
    pnlTopo: TPanel;
    Label1: TLabel;
    btSerial: TBitBtn;
    Label2: TLabel;
    Label4: TLabel;
    cbxModelo: TComboBox;
    cbxPorta: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    cmbBaudRate: TComboBox;
    cmbDataBits: TComboBox;
    cmbParity: TComboBox;
    cmbStopBits: TComboBox;
    cmbHandShaking: TComboBox;
    chHardFlow: TCheckBox;
    chSoftFlow: TCheckBox;
    ActionList1: TActionList;
    actFechar: TAction;
    btnTestar: TButton;
    ACBrECF1: TACBrECF;
    lblStatusPoucoPapel: TLabel;
    StatusBar1: TStatusBar;
    procedure actFecharExecute(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxModeloChange(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure cmbBaudRateChange(Sender: TObject);
    procedure cmbDataBitsChange(Sender: TObject);
    procedure cmbParityChange(Sender: TObject);
    procedure cmbStopBitsChange(Sender: TObject);
    procedure cmbHandShakingChange(Sender: TObject);
    procedure chHardFlowClick(Sender: TObject);
    procedure chSoftFlowClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ACBrECF1MsgPoucoPapel(Sender: TObject);
    procedure ACBrECF1MsgAguarde(const Mensagem: string);
    procedure ACBrECF1AguardandoRespostaChange(Sender: TObject);
    procedure ACBrECF1ChangeEstado(const EstadoAnterior, EstadoAtual: TACBrECFEstado);
  private

    procedure CarregarConfiguracoesModeloPorta;
    procedure LerINI;
    procedure GravarINI;
    procedure VerificarFlow;
  public

  end;

var
  FrmConfigurarECF: TFrmConfigurarECF;

implementation

uses uConstsGerais;

{$R *.dfm}

procedure TFrmConfigurarECF.ACBrECF1AguardandoRespostaChange(Sender: TObject);
begin
   if ACBrECF1.AguardandoResposta then
      StatusBar1.Panels[0].Text := 'Processando...'
   else
      StatusBar1.Panels[0].Text := '';

   StatusBar1.Hint := StatusBar1.Panels[0].Text;
end;

procedure TFrmConfigurarECF.ACBrECF1ChangeEstado(const EstadoAnterior, EstadoAtual: TACBrECFEstado);
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

  StatusBar1.Panels[0].Text := Format('Anterior: %s - Atual: %s', [sEstAnterior, sEstAtual]);
  StatusBar1.Hint := StatusBar1.Panels[0].Text;
end;

procedure TFrmConfigurarECF.ACBrECF1MsgAguarde(const Mensagem: string);
begin
   StatusBar1.Panels[0].Text := StringReplace(Mensagem,#10,' ',[rfReplaceAll]);
   StatusBar1.Hint := StatusBar1.Panels[0].Text;
end;

procedure TFrmConfigurarECF.ACBrECF1MsgPoucoPapel(Sender: TObject);
begin
   lblStatusPoucoPapel.Caption := _MSG_POUCO_PAPEL;
   lblStatusPoucoPapel.Visible := True;
   StatusBar1.Panels[0].Text := _MSG_POUCO_PAPEL;
   StatusBar1.Hint := StatusBar1.Panels[0].Text;
end;

procedure TFrmConfigurarECF.actFecharExecute(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmConfigurarECF.btnTestarClick(Sender: TObject);
begin
   try
     Self.Enabled := False;
     ACBrECF1.Porta := cbxPorta.Text;

     if (cbxModelo.ItemIndex = 0) then
        if not ACBrECF1.AcharECF(true,False) then
           begin
              MessageDlg('Nenhum ECF encontrado.',mtInformation,[mbOk],0);
              Exit;
           end;

     ACBrECF1.Ativar;
     if (ACBrECF1.Ativo) then
        begin
           MessageDlg('ECF conectada com sucesso!', mtInformation,[mbOk],0);
           GravarINI;
        end;
  finally
     Self.Enabled := True;
     cbxModelo.ItemIndex := Integer(ACBrECF1.Modelo) ;
     cbxPorta.Text := ACBrECF1.Porta;
  end ;
end;

procedure TFrmConfigurarECF.btSerialClick(Sender: TObject);
begin
   GravarINI;
end;

procedure TFrmConfigurarECF.CarregarConfiguracoesModeloPorta;
var
    indx : TACBrECFModelo ;
begin
  cbxModelo.Items.Clear;
  for indx := Low(TACBrECFModelo) to High(TACBrECFModelo) do
     cbxModelo.Items.Add(GetEnumName(TypeInfo(TACBrECFModelo), Integer(indx)));

  cbxModelo.Items[0] := 'Procurar';
  cbxModelo.ItemIndex := 0;

  cbxPorta.Items.Clear;
  ACBrECF1.Device.AcharPortasSeriais( cbxPorta.Items );
  cbxPorta.Items.Insert(0, 'Procurar') ;
  cbxPorta.Items.Add('USB');
  cbxPorta.Items.Add('LPT1');
  cbxPorta.Items.Add('LPT2');
  cbxPorta.Items.Add('LPT3');
  cbxPorta.Items.Add('/dev/ttyS0');
  cbxPorta.Items.Add('/dev/ttyS1');
  cbxPorta.Items.Add('/dev/ttyUSB0');
  cbxPorta.Items.Add('/dev/ttyUSB1');
  cbxPorta.Items.Add('c:\temp\ecf.txt');
  cbxPorta.Items.Add('/tmp/ecf.txt');
end;

procedure TFrmConfigurarECF.cbxModeloChange(Sender: TObject);
begin
   try
     ACBrECF1.Modelo := TACBrECFModelo( cbxModelo.ItemIndex );
  except
     cbxModelo.ItemIndex := Integer( ACBrECF1.Modelo );
  end;
end;

procedure TFrmConfigurarECF.chHardFlowClick(Sender: TObject);
begin
   ACBrECF1.Device.HardFlow := chHardFlow.Checked;
   VerificarFlow;
end;

procedure TFrmConfigurarECF.chSoftFlowClick(Sender: TObject);
begin
   ACBrECF1.Device.SoftFlow := chSoftFlow.Checked;
   VerificarFlow;
end;

procedure TFrmConfigurarECF.cmbBaudRateChange(Sender: TObject);
begin
   ACBrECF1.Device.Baud := StrToInt(cmbBaudRate.Text);
end;

procedure TFrmConfigurarECF.cmbDataBitsChange(Sender: TObject);
begin
   ACBrECF1.Device.Data := StrToInt(cmbDataBits.Text);
end;

procedure TFrmConfigurarECF.cmbHandShakingChange(Sender: TObject);
begin
   //ACBrECF1.Device.HandShake := TACBrHandShake(cmbHandShaking.ItemIndex);
   VerificarFlow;
end;

procedure TFrmConfigurarECF.cmbParityChange(Sender: TObject);
begin
   //ACBrECF1.Device.Parity := TACBrSerialParity(cmbParity.ItemIndex);
end;

procedure TFrmConfigurarECF.cmbStopBitsChange(Sender: TObject);
begin
   //ACBrECF1.Device.Stop := TACBrSerialStop(cmbStopBits.ItemIndex);
end;

procedure TFrmConfigurarECF.FormCreate(Sender: TObject);
begin
   CarregarConfiguracoesModeloPorta;
   LerINI;
end;

procedure TFrmConfigurarECF.FormShow(Sender: TObject);
begin
   cmbBaudRate.ItemIndex    := cmbBaudRate.Items.IndexOf(IntToStr( ACBrECF1.Device.Baud ));
   cmbDataBits.ItemIndex    := cmbDataBits.Items.IndexOf(IntToStr( ACBrECF1.Device.Data ));
   cmbParity.ItemIndex      := Integer( ACBrECF1.Device.Parity );
   cmbStopBits.ItemIndex    := Integer( ACBrECF1.Device.Stop );
   chHardFlow.Checked       := ACBrECF1.Device.HardFlow;
   chSoftFlow.Checked       := ACBrECF1.Device.SoftFlow;
   cmbHandShaking.ItemIndex := Integer( ACBrECF1.Device.HandShake );
end;

procedure TFrmConfigurarECF.GravarINI;
var
   INI: TIniFile;
begin
  INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + _ARQUIVO_CONFIG_INI_ECF);
  try
     INI.WriteInteger('ECF','Modelo',cbxModelo.ItemIndex);
     INI.WriteString('ECF','Porta',cbxPorta.Text);
     INI.WriteString('ECF','SerialParams',ACBrECF1.Device.ParamsString);
  finally
     INI.Free;
  end;
end;

procedure TFrmConfigurarECF.LerINI;
var
   INI: TIniFile;
begin
  INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + _ARQUIVO_CONFIG_INI_ECF);
  try
     cbxModelo.ItemIndex := INI.ReadInteger('ECF','Modelo',cbxModelo.ItemIndex);
     cbxModeloChange(nil);
     cbxPorta.Text := INI.ReadString('ECF','Porta',cbxPorta.Text);
     ACBrECF1.Device.ParamsString := INI.ReadString('ECF','SerialParams','');
  finally
     INI.Free;
  end;
end;

procedure TFrmConfigurarECF.VerificarFlow;
begin
   cmbHandShaking.ItemIndex := Integer(ACBrECF1.Device.HandShake);
   chHardFlow.Checked := ACBrECF1.Device.HardFlow;
   chSoftFlow.Checked := ACBrECF1.Device.SoftFlow;
end;

end.
