unit uFrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, System.Actions;

type
  TFrmLogin = class(TForm)
    lstbxEmpresas: TListBox;
    Label1: TLabel;
    edtSenha: TEdit;
    ActionList1: TActionList;
    actSetaPraCima: TAction;
    actSetaPraBaixo: TAction;
    Label2: TLabel;
    actConfirmar: TAction;
    actCancelar: TAction;
    Label3: TLabel;
    procedure actSetaPraCimaExecute(Sender: TObject);
    procedure actSetaPraBaixoExecute(Sender: TObject);
    procedure actConfirmarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FConfirmou: Boolean;

     procedure Carregar_Filiais();
  public
    property Confirmou: Boolean read FConfirmou;
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses udmPrincipal;

{$R *.dfm}

procedure TFrmLogin.actCancelarExecute(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmLogin.actConfirmarExecute(Sender: TObject);
begin
   dmPrincipal.NomeFilial   := lstbxEmpresas.Items[lstbxEmpresas.ItemIndex];
   dmPrincipal.CodigoFilial := StrToIntDef(Copy(lstbxEmpresas.Items[lstbxEmpresas.ItemIndex],1,3),0);
   dmPrincipal.Usuario := 'USUARIO_LOGADO';
   FConfirmou := True;
   Self.Close;
end;

procedure TFrmLogin.actSetaPraBaixoExecute(Sender: TObject);
begin
   if (lstbxEmpresas.ItemIndex = (lstbxEmpresas.Items.Count -1)) then
      begin
         lstbxEmpresas.ItemIndex := 0;

         edtSenha.SelectAll;
      end
   else
      begin
         lstbxEmpresas.ItemIndex := lstbxEmpresas.ItemIndex + 1;

         edtSenha.SelectAll;
      end;
end;

procedure TFrmLogin.actSetaPraCimaExecute(Sender: TObject);
begin
   if (lstbxEmpresas.ItemIndex = 0) then
      begin
         lstbxEmpresas.ItemIndex := (lstbxEmpresas.Items.Count -1);

         edtSenha.SelectAll;
      end
   else
      begin
         lstbxEmpresas.ItemIndex := lstbxEmpresas.ItemIndex - 1;

         edtSenha.SelectAll;
      end;
end;

procedure TFrmLogin.Carregar_Filiais();
var
   sFilial: String;
   idxFilial: Integer;
begin
  // dmPrincipal.ExecSQL('SELECT CODIGO, NOME FROM FILIAIS');
   lstbxEmpresas.Clear;
   idxFilial := 0;
  // dmPrincipal.cdsConsultaAux1.First;
//   while not dmPrincipal.cdsConsultaAux1.eof do
//      begin
////         if dmPrincipal.cdsConsultaAux1.FieldByName('CODIGO').AsInteger = 1 then
////         begin
////           dmPrincipal.cdsConsultaAux1.Next;
////           Continue;
////         end;
//
//         sFilial := FormatFloat('000', dmPrincipal.cdsConsultaAux1.FieldByName('CODIGO').AsInteger) + ' - ' +
//                    dmPrincipal.cdsConsultaAux1.FieldByName('NOME').AsString;
//
//         lstbxEmpresas.Items.Add(sFilial);
//
//         dmPrincipal.cdsConsultaAux1.Next;
//      end;

  dmPrincipal.cdsConsEmpresa.Close;
  dmPrincipal.cdsConsEmpresa.open;

  sFilial := dmPrincipal.cdsConsEmpresaCD_FILIAL.AsString + ' - ' +
             dmPrincipal.cdsConsEmpresaRAZAO.Value;
  lstbxEmpresas.Items.Add(sFilial);


   if (lstbxEmpresas.Items.Count > 0) then
      lstbxEmpresas.ItemIndex := idxFilial;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
   FConfirmou := False;
   lstbxEmpresas.Items.Clear;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
   Carregar_Filiais();

   edtSenha.SelectAll;
end;

end.
