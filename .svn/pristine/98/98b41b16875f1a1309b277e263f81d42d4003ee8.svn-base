unit UGerarArquivosFarmax;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmGerarArquivo = class(TForm)
    Panel1: TPanel;
    lblStatus: TLabel;
    pgbSpedFiscal: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGerarArquivo: TFrmGerarArquivo;

implementation

{$R *.dfm}

uses UXmlCompras, UXmlNFeDanfe, UXmlVenda, udmPrincipal, uFuncoesBasicas;

procedure TFrmGerarArquivo.FormShow(Sender: TObject);
begin

  dmPrincipal.cdsBD.Close;
  dmPrincipal.cdsBD.open;
  dmPrincipal.cdsBD.Edit;
  dmPrincipal.FDConnFarmax.Close;
  dmPrincipal.FDConnFarmax.Params.Values['DriverID']  :='FB';
  dmPrincipal.FDConnFarmax.Params.Values['Server']    := DmPrincipal.cdsBDSERVIDOR_FARMAX.Value;
  dmPrincipal.FDConnFarmax.Params.Values['Database']  := dmPrincipal.cdsBDBD_FARMAX.Value;
  dmPrincipal.FDConnFarmax.Params.Values['User_Name'] :='sysdba';
  dmPrincipal.FDConnFarmax.Params.Values['Password']  :='masterkey';
  dmPrincipal.FDConnFarmax.Params.Values['Port']      := DmPrincipal.cdsBDPORTAFB_FAR.Value;
  dmPrincipal.FDConnFarmax.Params.Values['Protocol']  :='TCPIP';


  try

   dmPrincipal.FDConnFarmax.Connected :=true;
   Timer1.Enabled:=true;
  except

   uFuncoesBasicas.ExibeWarning('Servidor não localizado. '+
                                sLineBreak +
                                dmPrincipal.cdsBDBD_FARMAX.AsString +
                                sLineBreak +
                                'Verifique as configurações.');

   Timer1.Enabled:=false;
   Close;
  end;


end;

procedure TFrmGerarArquivo.Timer1Timer(Sender: TObject);
begin
 GeraArquivosCompras;
 GerarArquivosVenda;
 GerarArquivosDanfe;
 self.Close;
end;

end.
