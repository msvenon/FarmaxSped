unit UXmlCompras;

interface
 uses

  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Forms,
  system.json,
  System.NetEncoding;

 procedure GeraArquivosCompras;


implementation

uses udmPrincipal, uMenuPrincipal,UGerarArquivosFarmax, uFuncoesBasicas;

procedure GeraArquivosCompras;
var
  chave_nf ,datahoraemissao:string;
  msg :string;
 Arquivo:Tstringlist;
begin
  FrmGerarArquivo.Timer1.Enabled:=false;

  Arquivo:=Tstringlist.Create;

 if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\NFeRecebidas\') then
    begin
     CreateDir(ExtractFilePath(Application.ExeName) +'NFeRecebidas\');
     FrmPrincipal.edtLocalXML_FORN.Text :='\NFeRecebidas\';
    end
    else
    begin
      uFuncoesBasicas.DeletarArquivos(ExtractFilePath(Application.ExeName) +'NFeRecebidas\');
      sleep(2000);
    end;

  Application.ProcessMessages;
  FrmGerarArquivo.lblStatus.Caption:='Aguarde gerando xml de Fornecedor.';
  FrmGerarArquivo.pgbSpedFiscal.Min:=0;

  dmPrincipal.cdsBuscaNfePeriodo.Close;
  dmPrincipal.cdsBuscaNfePeriodo.ParamByName('DATA_INI').Value:= FrmPrincipal.edtDataInicial.Date;
  dmPrincipal.cdsBuscaNfePeriodo.ParamByName('DATA_FIN').Value:= FrmPrincipal.edtDataFinal.Date;
  dmPrincipal.cdsBuscaNfePeriodo.open;


  FrmGerarArquivo.pgbSpedFiscal.Max:= dmPrincipal.cdsBuscaNfePeriodo.RecordCount;

  if dmPrincipal.cdsBuscaNfePeriodo.RecordCount>0 then
    begin
      Application.ProcessMessages;
      dmPrincipal.cdsBuscaNfePeriodo.First;
      while not dmPrincipal.cdsBuscaNfePeriodo.eof do
        begin

          FrmGerarArquivo.pgbSpedFiscal.Position:=FrmGerarArquivo.pgbSpedFiscal.Position+1;



          Arquivo.Clear;
          dmPrincipal.cdsBuscaXmlNfe.Close;
          dmPrincipal.cdsBuscaXmlNfe.ParamByName('chavenfe').Value := dmPrincipal.cdsBuscaNfePeriodoCHAVENFE.AsString;
          dmPrincipal.cdsBuscaXmlNfe.Open;

         if dmPrincipal.cdsBuscaXmlNfe.RecordCount >0 then
              begin
               Arquivo.Text  :=dmPrincipal.cdsBuscaXmlNfeARQUIVO.Value;
               chave_nf :=dmPrincipal.cdsBuscaXmlNfeCHAVE.AsString;
               Arquivo.SaveToFile(ExtractFilePath(Application.ExeName) +'\NFeRecebidas\'+chave_nf);
            end;
         dmPrincipal.cdsBuscaNfePeriodo.Next;

         end;
    end;

  Arquivo.Free;
end;

end.
