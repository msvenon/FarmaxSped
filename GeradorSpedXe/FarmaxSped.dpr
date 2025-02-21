program FarmaxSped;

uses
  Forms,
  SysUtils,
  uMenuPrincipal in 'src\uMenuPrincipal.pas' {TFrmPrincipal},
  uFrmSobre in 'src\uFrmSobre.pas' {FrmSobre},
  uFrmLogin in 'src\uFrmLogin.pas' {FrmLogin},
  udmPrincipal in 'src\udmPrincipal.pas' {dmPrincipal: TDataModule},
  uFuncoesBasicas in 'src\uFuncoesBasicas.pas',
  uSpedFiscal in 'src\uSpedFiscal.pas',
  uConstsGerais in 'src\uConstsGerais.pas',
  uFrmGerarSpedFiscal in 'src\uFrmGerarSpedFiscal.pas' {FrmGerarSpedFiscal},
  uFrmConfigurarECF in 'src\uFrmConfigurarECF.pas' {FrmConfigurarECF},
  uSpedPisCofins in 'src\uSpedPisCofins.pas',
  uFrmGerarSpedPisCofins in 'src\uFrmGerarSpedPisCofins.pas' {FrmGerarSpedPisCofins},
  UCadFiliais in 'src\UCadFiliais.pas' {uFrmCadFiliais},
  ConfigServer in 'src\ConfigServer.pas' {FrmConfigServer},
  UXmlCompras in 'Controle\UXmlCompras.pas',
  UXmlNFeDanfe in 'Controle\UXmlNFeDanfe.pas',
  UXmlVenda in 'Controle\UXmlVenda.pas',
  UGerarArquivosFarmax in 'UGerarArquivosFarmax.pas' {FrmGerarArquivo},
  UFrmConsistencia in 'UFrmConsistencia.pas' {FrmConsistencia};

{$R *.res}

//var
//  bContinuarSistema: Boolean;

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;

end.
