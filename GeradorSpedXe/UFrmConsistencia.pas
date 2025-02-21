unit UFrmConsistencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmConsistencia = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Memo: TMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsistencia: TFrmConsistencia;

implementation

{$R *.dfm}

uses udmPrincipal;

procedure TFrmConsistencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key =vk_escape then close;

end;

procedure TFrmConsistencia.FormShow(Sender: TObject);
begin

  memo.Clear;

  dmPrincipal.cdsConsTributacaoErrada.first;
  while not dmPrincipal.cdsConsTributacaoErrada.Eof do
      begin
        Memo.Lines.Add('EAN :'+ dmPrincipal.cdsConsTributacaoErradaEAN.AsString+'- Pis:'+
                       dmPrincipal.cdsConsTributacaoErradaALIQPIS.AsString+'- Cofins:'+
                       dmPrincipal.cdsConsTributacaoErradaALIQCOF.AsString);
        dmPrincipal.cdsConsTributacaoErrada.Next;
      end;
end;

end.
