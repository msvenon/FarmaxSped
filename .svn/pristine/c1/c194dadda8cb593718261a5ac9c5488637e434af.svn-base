unit uFrmGerarSpedFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
   ComCtrls, ExtCtrls, StdCtrls, uSpedFiscal, SQLExpr;

type
  TFrmGerarSpedFiscal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pgbSpedFiscal: TProgressBar;
    btnCancelar: TButton;
    TimerIniciar: TTimer;
    lblStatus: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerIniciarTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCancelou: Boolean;
    FSPEDFiscal: TSpedFiscal;
    FConexaoBase: TSQLconnection;
    FDataFinal: TDateTime;
    FOriginal: Boolean;
    FMemoErro: TMemo;
    FDataInicial: TDateTime;
    FCodigoEmpresa: Integer;
    FLocalArquivo: String;
    FCodigIbgeUfEmpresa: Integer;
    FLocalDocXml_NFE: String;
    FCnpjEmpresa: String;
    FGerarCupomFiscal: Boolean;
    FLocalDocXml_NFCE: String;
    FLocalDocXml_FORN: String;
    FLocalArquivoMFDSPED: String;
    FArquivoMFDSPEDLocal: Boolean;
    FGerarBlocoK: Boolean;
    FGerarBlocoH: Boolean;
    FSemLimite: Boolean;
    procedure SetMemoErro(const Value: TMemo);

  public
     property Cancelou: Boolean read FCancelou;
     property CodigoEmpresa: Integer read FCodigoEmpresa write FCodigoEmpresa;
     property Original: Boolean read FOriginal write FOriginal; {False = Substituto}
     property GerarCupomFiscal: Boolean read FGerarCupomFiscal write FGerarCupomFiscal;
     property MemoErro: TMemo read FMemoErro write SetMemoErro;
     property ConexaoBase: TSQLconnection read FConexaoBase write FConexaoBase;
     property DataInicial: TDateTime read FDataInicial write FDataInicial;
     property DataFinal: TDateTime read FDataFinal write FDataFinal;
     property LocalArquivo: String read FLocalArquivo write FLocalArquivo;
     property LocalDocXml_NFE: String read FLocalDocXml_NFE write FLocalDocXml_NFE;
     property LocalDocXml_NFCE: String read FLocalDocXml_NFCE write FLocalDocXml_NFCE;
     property LocalDocXml_FORN: String read FLocalDocXml_FORN write FLocalDocXml_FORN;
     property CnpjEmpresa: String read FCnpjEmpresa write FCnpjEmpresa;
     property CodigIbgeUfEmpresa: Integer read FCodigIbgeUfEmpresa write FCodigIbgeUfEmpresa;
     property ArquivoMFDSPEDLocal: Boolean read FArquivoMFDSPEDLocal write FArquivoMFDSPEDLocal;
     property LocalArquivoMFDSPED: String read FLocalArquivoMFDSPED write FLocalArquivoMFDSPED;
     property GerarBlocoK: Boolean read FGerarBlocoK write FGerarBlocoK;
     property GerarBlocoH: Boolean read FGerarBlocoH write FGerarBlocoH;
     property SemLimite: Boolean read FSemLimite write FSemLimite;
  end;

var
  FrmGerarSpedFiscal: TFrmGerarSpedFiscal;

implementation

{$R *.dfm}

uses udmPrincipal;

procedure TFrmGerarSpedFiscal.btnCancelarClick(Sender: TObject);
begin
   Self.FCancelou := True;
   btnCancelar.Enabled := False;
   Self.Close;
   Abort;
end;

procedure TFrmGerarSpedFiscal.FormCreate(Sender: TObject);
begin
   FCancelou := False;
   FSPEDFiscal := TSpedFiscal.Create(Self);
end;

procedure TFrmGerarSpedFiscal.FormDestroy(Sender: TObject);
begin
   FreeAndNil(FSPEDFiscal);
end;

procedure TFrmGerarSpedFiscal.FormShow(Sender: TObject);
begin
   lblStatus.Caption:='Aguarde...!';
   TimerIniciar.Enabled := True;
end;

procedure TFrmGerarSpedFiscal.SetMemoErro(const Value: TMemo);
begin
  FMemoErro := Value;
end;

procedure TFrmGerarSpedFiscal.TimerIniciarTimer(Sender: TObject);
begin

   dmPrincipal.cdsConsEmpresa.close;
   dmPrincipal.cdsConsEmpresa.open;


   TimerIniciar.Enabled := False;
   if (not Self.Cancelou) then
      begin
         Self.FSPEDFiscal.CodigoEmpresa      := Self.CodigoEmpresa;
         Self.FSPEDFiscal.Original           := Self.Original;
         Self.FSPEDFiscal.GerarCupomFiscal   := Self.GerarCupomFiscal;
         Self.FSPEDFiscal.MemoErro           := Self.MemoErro;
         Self.FSPEDFiscal.ProgressBar        := Self.pgbSpedFiscal;
         Self.FSPEDFiscal.ConexaoBase        := Self.ConexaoBase;
         Self.FSPEDFiscal.DataInicial        := Self.DataInicial;
         Self.FSPEDFiscal.DataFinal          := Self.DataFinal;
         Self.FSPEDFiscal.LocalSalvar        := Self.LocalArquivo;
         Self.FSPEDFiscal.CodigIbgeUfEmpresa := dmPrincipal.cdsConsEmpresaCODIGO_CIDADE.AsInteger;
         Self.FSPEDFiscal.LocalDocXml_NFE    := Self.LocalDocXml_NFE;
         Self.FSPEDFiscal.LocalDocXml_NFCE   := Self.LocalDocXml_NFCE;
         Self.FSPEDFiscal.LocalDocXml_FORN   := Self.LocalDocXml_FORN;
         Self.FSPEDFiscal.CnpjEmpresa        := dmPrincipal.cdsConsEmpresaCGC.Value;
         Self.FSPEDFiscal.lblStatus          := Self.lblStatus;
         Self.FSPEDFiscal.ArquivoMFDSPEDLocal:= Self.ArquivoMFDSPEDLocal;
         Self.FSPEDFiscal.LocalArquivoMFDSPED:= Self.LocalArquivoMFDSPED;
         Self.FSPEDFiscal.GerarBlocoK        := Self.FGerarBlocoK;
         Self.FSPEDFiscal.GerarBlocoH        := Self.FGerarBlocoH;
         Self.FSPEDFiscal.SemLimite          := Self.SemLimite;
         Self.FSPEDFiscal.GerarAquivo;
         Self.Close;
      end;
end;

end.
