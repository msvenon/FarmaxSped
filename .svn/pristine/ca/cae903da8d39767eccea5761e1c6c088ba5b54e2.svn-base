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
  System.NetEncoding,
  XMLDoc,
  XMLIntf;

 procedure GeraArquivosCompras;
 procedure CorrigirXML(const Arquivo: string);


implementation

uses udmPrincipal, uMenuPrincipal,UGerarArquivosFarmax, uFuncoesBasicas,
  uSpedFiscal;

procedure GeraArquivosCompras;
var
  chave_nf, datahoraemissao: string;
  msg, vteste: string;
  Arquivo: TStringList;
  CaminhoXML: string;
  log :TSpedFiscal;
begin

  log :=TSpedFiscal.Create(nil);

  FrmGerarArquivo.Timer1.Enabled := False;

  Arquivo := TStringList.Create;

  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\NFeRecebidas\') then
  begin
    CreateDir(ExtractFilePath(Application.ExeName) + 'NFeRecebidas\');
    FrmPrincipal.edtLocalXML_FORN.Text := '\NFeRecebidas\';
  end
  else
  begin
    uFuncoesBasicas.DeletarArquivos(ExtractFilePath(Application.ExeName) + 'NFeRecebidas\');
    Sleep(2000);
  end;

  Application.ProcessMessages;
  FrmGerarArquivo.lblStatus.Caption := 'Aguarde gerando xml de Fornecedor.';
  FrmGerarArquivo.pgbSpedFiscal.Min := 0;

  dmPrincipal.cdsBuscaNfePeriodo.Close;
  dmPrincipal.cdsBuscaNfePeriodo.ParamByName('DATA_INI').Value := FrmPrincipal.edtDataInicial.Date;
  dmPrincipal.cdsBuscaNfePeriodo.ParamByName('DATA_FIN').Value := FrmPrincipal.edtDataFinal.Date;
  dmPrincipal.cdsBuscaNfePeriodo.Open;

  FrmGerarArquivo.pgbSpedFiscal.Max := dmPrincipal.cdsBuscaNfePeriodo.RecordCount;

  if dmPrincipal.cdsBuscaNfePeriodo.RecordCount > 0 then
  begin
    Application.ProcessMessages;
    dmPrincipal.cdsBuscaNfePeriodo.First;
    while not dmPrincipal.cdsBuscaNfePeriodo.Eof do
    begin
      FrmGerarArquivo.pgbSpedFiscal.Position := FrmGerarArquivo.pgbSpedFiscal.Position + 1;

      Arquivo.Clear;
      dmPrincipal.cdsBuscaXmlNfe.Close;
      dmPrincipal.cdsBuscaXmlNfe.ParamByName('chavenfe').Value := dmPrincipal.cdsBuscaNfePeriodoCHAVENFE.AsString;
      dmPrincipal.cdsBuscaXmlNfe.Open;

      if dmPrincipal.cdsBuscaXmlNfe.RecordCount > 0 then
      begin
        Arquivo.clear;
        Arquivo.Text := dmPrincipal.cdsBuscaXmlNfeARQUIVO.Value;
        chave_nf := dmPrincipal.cdsBuscaXmlNfeCHAVE.AsString;

        CaminhoXML := ExtractFilePath(Application.ExeName) + 'NFeRecebidas\' + chave_nf ;
        Arquivo.SaveToFile(CaminhoXML);

        // 👉 Chamada para corrigir o XML salvo
        CorrigirXML(CaminhoXML);
      end
       else
      begin
        log.GravaLog('xml não encontrado na tabela NFes chave ['+dmPrincipal.cdsBuscaNfePeriodoCHAVENFE.AsString+']');
      end;

      dmPrincipal.cdsBuscaNfePeriodo.Next;
    end;
  end;


  Arquivo.Free;
  vteste:='ok';
end;

procedure CorrigirXML(const Arquivo: string);
var
  XMLDoc: IXMLDocument;
  RootNode, NFeNode, infNFe: IXMLNode;
  AssinaturaNode: IXMLNode;
  DetNode, NItemNode: IXMLNode;
  i: Integer;
  Alterado: Boolean;
  nItemValue: string;
begin
  Alterado := False;
  XMLDoc := TXMLDocument.Create(nil);
  try
    XMLDoc.LoadFromFile(Arquivo);
    XMLDoc.Active := True;

    RootNode := XMLDoc.DocumentElement; // <nfeProc>

    // Encontrar o nó <NFe> e depois <infNFe>
    NFeNode := RootNode.ChildNodes.FindNode('NFe');
    if Assigned(NFeNode) then
    begin
      infNFe := NFeNode.ChildNodes.FindNode('infNFe');
      if Assigned(infNFe) then
      begin
        // Corrigir atributo versao em infNFe
        if not infNFe.HasAttribute('versao') or (infNFe.Attributes['versao'] <> '4.00') then
        begin
          infNFe.Attributes['versao'] := '4.00';
          Alterado := True;
        end;

        // Corrigir o atributo nItem em cada <det>
        for i := 0 to infNFe.ChildNodes.Count - 1 do
        begin
          DetNode := infNFe.ChildNodes[i];
          if DetNode.NodeName = 'det' then
          begin
            if not DetNode.HasAttribute('nItem') then
            begin
              NItemNode := DetNode.ChildNodes.FindNode('nItem');
              if Assigned(NItemNode) then
              begin
                nItemValue := NItemNode.Text;
                // Remove o nó filho <nItem>
                DetNode.ChildNodes.Remove(NItemNode);
                // Adiciona atributo nItem no <det>
                DetNode.Attributes['nItem'] := nItemValue;
                Alterado := True;
              end;
            end;
          end;
        end;

      end;
    end;

    // Corrigir posição do nó <Signature>, se existir
    AssinaturaNode := RootNode.ChildNodes.FindNode('Signature');
    if Assigned(AssinaturaNode) and (RootNode.ChildNodes.Last <> AssinaturaNode) then
    begin
      RootNode.ChildNodes.Remove(AssinaturaNode);
      RootNode.ChildNodes.Add(AssinaturaNode);
      Alterado := True;
    end;

    if Alterado then
      XMLDoc.SaveToFile(Arquivo);

  finally
    XMLDoc := nil;
  end;
end;





{
procedure CorrigirXML(const Arquivo: string);
var
  XMLDoc: IXMLDocument;
  RootNode, NFeNode, infNFe: IXMLNode;
  AssinaturaNode: IXMLNode;
  Alterado: Boolean;
begin
  Alterado := False;
  XMLDoc := TXMLDocument.Create(nil);
  try
    XMLDoc.LoadFromFile(Arquivo);
    XMLDoc.Active := True;

    RootNode := XMLDoc.DocumentElement; // <nfeProc>

    // Encontrar o nó <NFe> e depois <infNFe>
    NFeNode := RootNode.ChildNodes.FindNode('NFe');
    if Assigned(NFeNode) then
    begin
      infNFe := NFeNode.ChildNodes.FindNode('infNFe');
      if Assigned(infNFe) then
      begin
        if not infNFe.HasAttribute('versao') or (infNFe.Attributes['versao'] <> '4.00') then
        begin
          infNFe.Attributes['versao'] := '4.00';
          Alterado := True;
        end;
      end;
    end;

    // Corrigir posição do nó <Signature>, se existir
    AssinaturaNode := RootNode.ChildNodes.FindNode('Signature');
    if Assigned(AssinaturaNode) and (RootNode.ChildNodes.Last <> AssinaturaNode) then
    begin
      RootNode.ChildNodes.Remove(AssinaturaNode);
      RootNode.ChildNodes.Add(AssinaturaNode);
      Alterado := True;
    end;

    if Alterado then
      XMLDoc.SaveToFile(Arquivo);

  finally
    XMLDoc := nil;
  end;
end; }



end.
