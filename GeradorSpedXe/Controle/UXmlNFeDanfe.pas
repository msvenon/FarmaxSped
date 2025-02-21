unit UXmlNFeDanfe;

interface
 uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,System.NetEncoding;

 procedure GerarArquivosDanfe;


implementation

uses Vcl.Forms, Vcl.Dialogs, uMenuPrincipal, udmPrincipal,UGerarArquivosFarmax,
  Winapi.ActiveX, uFuncoesBasicas;

procedure GerarArquivosDanfe;
var
  chave_nf :string;
  Arquivo:Tstringlist;
begin

 if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\NFeEnviadas\') then
    begin
     CreateDir(ExtractFilePath(Application.ExeName) +'NFeEnviadas\');
     FrmPrincipal.edtLocalXML_NFE.Text :='\NFeEnviadas\';
    end
    else
    begin
      uFuncoesBasicas.DeletarArquivos(ExtractFilePath(Application.ExeName) +'NFeEnviadas\');
      sleep(2000);
    end;


 FrmGerarArquivo.lblStatus.Caption:='Aguarde Gerando xml de NFe Enviadas (Danfe).';

 Application.ProcessMessages;
 dmPrincipal.cdsbuscaDanfe.Close;
 dmPrincipal.cdsbuscaDanfe.ParamByName('DATA_INI').Value:= FrmPrincipal.edtDataInicial.Date;
 dmPrincipal.cdsbuscaDanfe.ParamByName('DATA_FIN').Value:= FrmPrincipal.edtDataFinal.Date;
 dmPrincipal.cdsbuscaDanfe.open;

 Arquivo:=Tstringlist.Create;

 FrmGerarArquivo.pgbSpedFiscal.Min:=0;
 FrmGerarArquivo.pgbSpedFiscal.Max:= dmPrincipal.cdsbuscaDanfe.RecordCount;

 if dmPrincipal.cdsbuscaDanfe.RecordCount>0 then
    begin

      dmPrincipal.cdsbuscaDanfe.First;
      while not dmPrincipal.cdsbuscaDanfe.eof do
        begin

         FrmGerarArquivo.pgbSpedFiscal.Position:=FrmGerarArquivo.pgbSpedFiscal.Position+1;
         Application.ProcessMessages;

         Arquivo.Text:= dmPrincipal.cdsbuscaDanfeARQUIVO.Value;
         chave_nf    := dmPrincipal.cdsbuscaDanfeCHAVE.AsString;
         Arquivo.SaveToFile(ExtractFilePath(Application.ExeName) +'\NFeEnviadas\'+ chave_nf + '.xml');
         dmPrincipal.cdsbuscaDanfe.Next;
         end;
    end;

 Arquivo.Free;

end;

end.
