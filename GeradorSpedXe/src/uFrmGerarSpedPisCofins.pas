unit uFrmGerarSpedPisCofins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls, uSpedPisCofins, SQLExpr;

type
  TFrmGerarSpedPisCofins = class(TForm)
    Panel1: TPanel;
    lblStatus: TLabel;
    pgbSpedFiscal: TProgressBar;
    Panel2: TPanel;
    btnCancelar: TButton;
    TimerIniciar: TTimer;
    procedure TimerIniciarTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FSPEDPisCofins: TSpedPisCofins;
    FLocalDocXml_NFE: String;
    FCodigIbgeUfEmpresa: Integer;
    FLocalDocXml_NFCE: String;
    FLocalDocXml_FORN: String;
    FCancelou: Boolean;
    FConexaoBase: TSQLconnection;
    FCnpjEmpresa: String;
    FGerarCupomFiscal: Boolean;
    FLocalArquivo: String;
    FDataFinal: TDateTime;
    FOriginal: Boolean;
    FDataInicial: TDateTime;
    FMemoErro: TMemo;
    FCodigoEmpresa: Integer;
    FLocalArquivoMFDSPED: String;
    FArquivoMFDSPEDLocal: Boolean;
    FSemLimite: Boolean;
    FLocalDocXml_NFSE: String;
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
     property LocalDocXml_NFSE: String read FLocalDocXml_NFSE write FLocalDocXml_NFSE;
     property CnpjEmpresa: String read FCnpjEmpresa write FCnpjEmpresa;
     property CodigIbgeUfEmpresa: Integer read FCodigIbgeUfEmpresa write FCodigIbgeUfEmpresa;
     property ArquivoMFDSPEDLocal: Boolean read FArquivoMFDSPEDLocal write FArquivoMFDSPEDLocal;
     property LocalArquivoMFDSPED: String read FLocalArquivoMFDSPED write FLocalArquivoMFDSPED;
     property SemLimite: Boolean read FSemLimite write FSemLimite;
  end;

var
  FrmGerarSpedPisCofins: TFrmGerarSpedPisCofins;

implementation


{$R *.dfm}

procedure TFrmGerarSpedPisCofins.btnCancelarClick(Sender: TObject);
begin
   Self.FCancelou := True;
   btnCancelar.Enabled := False;
   Self.Close;
   Abort;
end;

procedure TFrmGerarSpedPisCofins.FormCreate(Sender: TObject);
begin
   FCancelou := False;
   FSPEDPisCofins := TSpedPisCofins.Create(Self);
end;

procedure TFrmGerarSpedPisCofins.FormDestroy(Sender: TObject);
begin
   FreeAndNil(FSPEDPisCofins);
end;

procedure TFrmGerarSpedPisCofins.FormShow(Sender: TObject);
begin
   TimerIniciar.Enabled := True;
end;

procedure TFrmGerarSpedPisCofins.SetMemoErro(const Value: TMemo);
begin
  FMemoErro := Value;
end;

procedure TFrmGerarSpedPisCofins.TimerIniciarTimer(Sender: TObject);
begin
   TimerIniciar.Enabled := False;
   if (not Self.Cancelou) then
      begin
         Self.FSPEDPisCofins.CodigoEmpresa := Self.CodigoEmpresa;
         Self.FSPEDPisCofins.Original := Self.Original;
         Self.FSPEDPisCofins.GerarCupomFiscal := Self.GerarCupomFiscal;
         Self.FSPEDPisCofins.MemoErro := Self.MemoErro;
         Self.FSPEDPisCofins.ProgressBar := Self.pgbSpedFiscal;
         Self.FSPEDPisCofins.ConexaoBase := Self.ConexaoBase;
         Self.FSPEDPisCofins.DataInicial := Self.DataInicial;
         Self.FSPEDPisCofins.DataFinal := Self.DataFinal;
         Self.FSPEDPisCofins.LocalSalvar := Self.LocalArquivo;
         Self.FSPEDPisCofins.CodigIbgeUfEmpresa := Self.CodigIbgeUfEmpresa;
         Self.FSPEDPisCofins.LocalDocXml_NFE := Self.LocalDocXml_NFE;
         Self.FSPEDPisCofins.LocalDocXml_NFCE := Self.LocalDocXml_NFCE;
         Self.FSPEDPisCofins.LocalDocXml_FORN := Self.LocalDocXml_FORN;
         Self.FSPEDPisCofins.LocalDocXml_NFSE := Self.LocalDocXml_NFSE;
         Self.FSPEDPisCofins.CnpjEmpresa := Self.CnpjEmpresa;
         Self.FSPEDPisCofins.lblStatus := Self.lblStatus;
         Self.FSPEDPisCofins.ArquivoMFDSPEDLocal := Self.ArquivoMFDSPEDLocal;
         Self.FSPEDPisCofins.LocalArquivoMFDSPED := Self.LocalArquivoMFDSPED;
         Self.FSPEDPisCofins.SemLimite := Self.SemLimite;
         Self.FSPEDPisCofins.GerarAquivo;
         Self.Close;
      end;
end;

end.
