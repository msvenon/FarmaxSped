unit UXmlVenda;

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
  system.json,
  System.NetEncoding;

 procedure GerarArquivosVenda;


implementation

uses  Vcl.Forms, Vcl.Dialogs, uMenuPrincipal, udmPrincipal,
  UGerarArquivosFarmax, uFuncoesBasicas;

procedure GerarArquivosVenda;
 var
 ArquivoUrl,
 chave_nf:string;
  Arquivo:Tstringlist;

begin

 if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\NFCeEnviadas\') then
    begin
     CreateDir(ExtractFilePath(Application.ExeName) +'NFCeEnviadas\');
     FrmPrincipal.edtLocalXML_NFCE.Text :='\NFCeEnviadas\';
    end
    else
    begin
     uFuncoesBasicas.DeletarArquivos(ExtractFilePath(Application.ExeName) +'NFCeEnviadas\');
     sleep(2000);
    end;


   FrmGerarArquivo.lblStatus.Caption:='Aguarde gerando xml de NFce.';
   FrmGerarArquivo.pgbSpedFiscal.Min:=0;

   Application.ProcessMessages;
   dmPrincipal.CDSBuscarNfce.Close;
   dmPrincipal.CDSBuscarNfce.ParamByName('DATA_INI').Value:= FrmPrincipal.edtDataInicial.Date;;
   dmPrincipal.CDSBuscarNfce.ParamByName('DATA_FIN').Value:= FrmPrincipal.edtDataFinal.Date;
   dmPrincipal.CDSBuscarNfce.Open;

   Arquivo:=Tstringlist.Create;
   FrmGerarArquivo.pgbSpedFiscal.Max:=dmPrincipal.CDSBuscarNfce.RecordCount;

  if dmPrincipal.CDSBuscarNfce.RecordCount >0 then
    begin


      FrmGerarArquivo.pgbSpedFiscal.Position:=FrmGerarArquivo.pgbSpedFiscal.Position+1;

      dmPrincipal.CDSBuscarNfce.First;
      while not dmPrincipal.CDSBuscarNfce.eof do
        begin

         chave_nf :=dmPrincipal.CDSBuscarNfceCHAVE.Value;
         Arquivo.Text  :=dmPrincipal.CDSBuscarNfceARQUIVO.Value;
         Arquivo.SaveToFile(ExtractFilePath(Application.ExeName) +'\NFCeEnviadas\'+ chave_nf+'.xml');  //'TempNFes \' +
         dmPrincipal.CdsBuscarNfce.Next;
         end;
     end;

  Arquivo.Free;
end;




end.
