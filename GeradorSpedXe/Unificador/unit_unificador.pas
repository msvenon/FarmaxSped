unit unit_unificador;

//{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls;

type

  { TfrmUnificador }

  TfrmUnificador = class(TForm)
    Button1: TButton;
    Button2: TButton;
    btnSped: TButton;
    edtArquivo: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    memoFiliais: TMemo;
    dialogSped: TOpenDialog;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnSpedClick(Sender: TObject);
    procedure IdentificacaoDaEmpresa(arquivo: TStringList; var final: TStringList);
    procedure LinhasBloco0(arquivo: TStringList; var final: TStringList);
    procedure LinhasBloco(bloco: String; arquivo: TStringList; var final: TStringList);
    procedure MontaBloco(bloco: String; var ArqFinal: TStringList);
    procedure TotalizaLinhas(var ArqFinal: TStringList);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmUnificador: TfrmUnificador;

implementation

uses


{$R *.lfm}

{ TfrmUnificador }

procedure TfrmUnificador.Button1Click(Sender: TObject);
begin
  if dialogSped.Execute then
    edtArquivo.Text := dialogSped.FileName;
end;

procedure TfrmUnificador.Button2Click(Sender: TObject);
begin
  if dialogSped.Execute then
    memoFiliais.Lines.Add(dialogSped.FileName);
end;

procedure TfrmUnificador.btnSpedClick(Sender: TObject);
var ArqFinal, ArqTemp : TStringList;
    i : Integer;
begin
  if edtArquivo.Text = '' then
    Exit;

  if memoFiliais.Lines.Count = 0 then
    Exit;

  try
    btnSped.Enabled := False;

    ArqFinal := TStringList.Create;
    ArqTemp  := TStringList.Create;

    {Bloco 0 - Início}
    {Matriz}
    ArqTemp.LoadFromFile(edtArquivo.Text);
    IdentificacaoDaEmpresa(ArqTemp, ArqFinal);
    LinhasBloco0(ArqTemp, ArqFinal);

    {Filiais}
    for i := 0 to memoFiliais.Lines.Count - 1 do
      begin
        ArqTemp.LoadFromFile(memoFiliais.Lines[i]);
        LinhasBloco0(ArqTemp, ArqFinal);
      end;

    ArqFinal.Add('|0990|' + IntToStr(ArqFinal.Count+1) + '|');
    {Bloco 0 - Final}

    MontaBloco('A', ArqFinal);
    MontaBloco('C', ArqFinal);
    MontaBloco('D', ArqFinal);
    MontaBloco('F', ArqFinal);
    ArqFinal.Add('|M001|1|');
    ArqFinal.Add('|M990|2|');
    MontaBloco('1', ArqFinal);

    TotalizaLinhas(ArqFinal);

    dialogSped.Title := 'Salvar arquivo Unificado';

    if dialogSped.Execute then
      ArqFinal.SaveToFile(dialogSped.FileName);
  finally
    btnSped.Enabled := True;
    ArqTemp.Free;
    ArqFinal.Free;
  end;
end;

procedure TfrmUnificador.IdentificacaoDaEmpresa(arquivo: TStringList; var final: TStringList);
var i : Integer;
    linha : String;
begin
  for i := 0 to arquivo.Count-1 do
    begin
      linha := copy(arquivo[i], 2, 4);
      if ((linha = '0000') or (linha = '0001') or (linha = '0100') or (linha = '0110')) then
        final.Add(arquivo[i]);
    end;
end;

procedure TfrmUnificador.LinhasBloco0(arquivo: TStringList; var final: TStringList);
var i : Integer;
    linha : String;
begin
  for i := 0 to arquivo.Count-1 do
    begin
      linha := copy(arquivo[i], 2, 4);
      if ((linha = '0140') or (linha = '0150') or (linha = '0190') or (linha = '0200')) then
        final.Add(arquivo[i]);
    end;
end;

procedure TfrmUnificador.LinhasBloco(bloco: String; arquivo: TStringList; var final: TStringList);
var i : Integer;
    linha, linhaBloco, Str1, Str2 : String;
begin
  Str1 := bloco + '001';
  Str2 := bloco + '990';

  for i := 0 to arquivo.Count-1 do
    begin
      linha      := copy(arquivo[i], 2, 4);
      linhaBloco := copy(arquivo[i], 2, 1);

      if (((linha <> Str1) and (linha <> Str2)) and (linhaBloco = bloco)) then
        final.Add(arquivo[i]);
    end;
end;

procedure TfrmUnificador.MontaBloco(bloco: String; var ArqFinal: TStringList);
var arquivo, arqTemp : TStringList;
    i : Integer;
begin
  try
    arquivo  := TStringList.Create;
    arqTemp  := TStringList.Create;

    {Matriz}
    arquivo.LoadFromFile(edtArquivo.Text);
    LinhasBloco(bloco, arquivo, arqTemp);

    {Filiais}
    for i := 0 to memoFiliais.Lines.Count - 1 do
      begin
        arquivo.LoadFromFile(memoFiliais.Lines[i]);
        LinhasBloco(bloco, arquivo, arqTemp);
        arquivo.Clear;
      end;

    if arqTemp.Count > 0 then
      begin
        ArqFinal.Add('|' + bloco + '001|0|');
        for i := 0 to arqTemp.Count-1 do
          ArqFinal.Add(arqTemp[i]);
        ArqFinal.Add('|' + bloco + '990|' + IntToStr(arqTemp.Count+2) + '|');
      end
    else
      begin
        ArqFinal.Add('|' + bloco + '001|1|');
        ArqFinal.Add('|' + bloco + '990|2|');
      end;
  finally
    arqTemp.Free;
  end;
end;

procedure TfrmUnificador.TotalizaLinhas(var ArqFinal: TStringList);
var linha : String;
    i, j, cont : Integer;
    ArqTemp : TStringList;
    bloco : Array[1..100] of String = ('9001', '0000', '0001', '0100', '0110',
    '0111', '0120', '0140', '0145', '0150', '0190', '0200', '0205', '0206', '0208',
    '0400', '0450', '0500', '0600', '0990', 'A001', 'A010', 'A100', 'A110', 'A111',
    'A120', 'A170', 'A990', 'C001', 'C010', 'C100', 'C110', 'C111', 'C120', 'C170',
    'C180', 'C181', 'C185', 'C188', 'C190', 'C191', 'C195', 'C198', 'C199', 'C380',
    'C381', 'C385', 'C395', 'C396', 'C400', 'C405', 'C481', 'C485', 'C489', 'C490',
    'C491', 'C495', 'C499', 'C500', 'C501', 'C505', 'C509', 'C600', 'C601', 'C605',
    'C609', 'C990', 'D001', 'D010', 'D100', 'D101', 'D105', 'D111', 'D200', 'D201',
    'D205', 'D209', 'D300', 'D309', 'D350', 'D359', 'D500', 'D501', 'D505', 'D509',
    'D600', 'D601', 'D605', 'D609', 'D990', 'F001', 'F010', 'F550', 'F990', 'M001',
    'M990', '1001', '1900', '1990', '9900');
begin
  ArqTemp := TStringList.Create;

  ArqFinal.Add('|9001|0|');

  for j := 1 to 100 do
    begin
      cont := 0;
      for i := 0 to ArqFinal.Count-1 do
        begin
          linha      := copy(ArqFinal[i], 2, 4);
          if linha = bloco[j] then
            inc(cont);
        end;

      if cont > 0 then
        ArqTemp.Add('|9900|' + bloco[j] + '|' + IntToStr(cont) + '|');
    end;

  ArqTemp.Add('|9900|9900|' + IntToStr(ArqTemp.Count) + '|');
  ArqTemp.Add('|9900|9990|1|');
  ArqTemp.Add('|9900|9999|1|');
  ArqTemp.Add('|9990|' + IntToStr(ArqTemp.Count+3) + '|');

  for i := 0 to ArqTemp.Count-1 do
    ArqFinal.Add(ArqTemp[i]);

  ArqFinal.Add('|9999|' + IntToStr(ArqFinal.Count+1) + '|');
end;

end.

