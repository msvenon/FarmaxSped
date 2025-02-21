unit uFrmSobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, uFuncoesBasicas;

type
  TFrmSobre = class(TForm)
    pgcSobre: TPageControl;
    tabSpedFiscal: TTabSheet;
    tabSpedContribuicoes: TTabSheet;
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    pnlTopo: TPanel;
    Label1: TLabel;
    lblLinkSite: TLabel;
    lblFonesContato: TLabel;
    Label5: TLabel;
    lblVersao: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure lblLinkSiteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmSobre: TFrmSobre;

implementation

{$R *.dfm}

procedure TFrmSobre.Button1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TFrmSobre.FormShow(Sender: TObject);
begin
   lblVersao.Caption := VersaoExecutavel(Application.ExeName);
end;

procedure TFrmSobre.lblLinkSiteClick(Sender: TObject);
begin
   ExecutarExterno('www.farmax.far.br');
end;

end.
