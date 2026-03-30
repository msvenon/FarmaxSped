unit UFrmFundo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrmFundo = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFundo: TFrmFundo;

implementation

{$R *.dfm}

procedure TFrmFundo.FormShow(Sender: TObject);
begin
 if FrmFundo.Tag=1 then
  begin

  FrmFundo.AlphaBlendValue:=1;
  end
  else
  begin

   FrmFundo.AlphaBlendValue:=180;
  end;

end;

end.
