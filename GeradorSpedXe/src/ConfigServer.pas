unit ConfigServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, IniFiles, ShellAPI, ComCtrls,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array[0..100] of TNetResource;

type
  TFrmConfigServer = class(TForm)
    Panel1: TPanel;
    LblServidor: TLabel;
    LblCaminho: TLabel;
    SpeedButton1: TSpeedButton;
    EdtServidor: TEdit;
    EdtCaminho: TEdit;
    OpenDialog1: TOpenDialog;
    BtnOk: TBitBtn;
    PnPrincipal: TPanel;
    Edit1: TEdit;
    EditPortaFb: TEdit;
    Label1: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BtAlterarCaminhoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FrmConfigServer: TFrmConfigServer;
   Ini : TIniFile;
implementation

{$R *.DFM}

uses udmPrincipal, uFuncoesBasicas, Datasnap.DBClient, Data.DB;



function CreateNetResourceList(ResourceType: DWord;
                              NetResource: PNetResource;
                              out Entries: DWord;
                              out List: PNetResourceArray): Boolean;
var
  EnumHandle: THandle;
  BufSize: DWord;
  Res: DWord;
begin
  Result := False;
  List := Nil;
  Entries := 0;
  if WNetOpenEnum(RESOURCE_GLOBALNET,
                  ResourceType,
                  0,
                  NetResource,
                  EnumHandle) = NO_ERROR then begin
    try
      BufSize := $4000;  // 16 kByte
      GetMem(List, BufSize);
      try
        repeat
          Entries := DWord(-1);
          FillChar(List^, BufSize, 0);
          Res := WNetEnumResource(EnumHandle, Entries, List, BufSize);
          if Res = ERROR_MORE_DATA then
          begin
            ReAllocMem(List, BufSize);
          end;
        until Res <> ERROR_MORE_DATA;

        Result := Res = NO_ERROR;
        if not Result then
        begin
          FreeMem(List);
          List := Nil;
          Entries := 0;
        end;
      except
        FreeMem(List);
        raise;
      end;
    finally
      WNetCloseEnum(EnumHandle);
    end;
  end;
end;

procedure ScanNetworkResources(ResourceType, DisplayType: DWord; List: TStrings);

  procedure ScanLevel(NetResource: PNetResource);
  var
    Entries: DWord;
    NetResourceList: PNetResourceArray;
    i: Integer;
  begin
    if CreateNetResourceList(ResourceType, NetResource, Entries, NetResourceList) then try
      for i := 0 to Integer(Entries) - 1 do
      begin
        if (DisplayType = RESOURCEDISPLAYTYPE_GENERIC) or
          (NetResourceList[i].dwDisplayType = DisplayType) then begin
          List.AddObject(NetResourceList[i].lpRemoteName,
                        Pointer(NetResourceList[i].dwDisplayType));
        end;
        if (NetResourceList[i].dwUsage and RESOURCEUSAGE_CONTAINER) <> 0 then
          ScanLevel(@NetResourceList[i]);
      end;
    finally
      FreeMem(NetResourceList);
    end;
  end;

begin
  ScanLevel(Nil);
end;

procedure TFrmConfigServer.SpeedButton1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(EdtCaminho.Text);
  if OpenDialog1.Execute then
      EdtCaminho.Text := OpenDialog1.FileName;
end;

procedure TFrmConfigServer.BtnOkClick(Sender: TObject);
var
 Existe : Boolean;
 cdsBd :TClientDataSet;
 Arquivo:TIniFile;
begin

  if EdtServidor.Text = '' then
     EdtServidor.Text := 'servidor';

  if EdtCaminho.Text = '' then
   begin
     Close;
     Exit;
   end;

   Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ConfigSped.ini');
   Arquivo.WriteString('SERVIDOR','Servidor',EdtServidor.Text);
   Arquivo.WriteString('SERVIDOR','Database',EdtCaminho.Text);
   Arquivo.WriteString('SERVIDOR','portafb',EditPortaFb.Text);
   Arquivo.Free;


  dmPrincipal.cdsBD.Close;
  dmPrincipal.cdsBD.open;
  dmPrincipal.cdsBD.Edit;
  DmPrincipal.cdsBDSERVIDORSPED.Value   := EdtServidor.Text;
  dmPrincipal.cdsBDBDSPED.Value         := EdtCaminho.Text;
  DmPrincipal.cdsBDPORTAFB_SPED.Value   := EditPortaFb.Text;
  dmPrincipal.cdsBD.ApplyUpdates(0);



   try
    dmPrincipal.FDConnSped.Params.Values['DriverID']  :='FB';
    dmPrincipal.FDConnSped.Params.Values['Server']    := EdtServidor.Text;
    dmPrincipal.FDConnSped.Params.Values['Database']  := EdtCaminho.Text;
    dmPrincipal.FDConnSped.Params.Values['User_Name'] :='SYSDBA';
    dmPrincipal.FDConnSped.Params.Values['Password']  :='masterkey';
    dmPrincipal.FDConnSped.Params.Values['Port']      := EditPortaFb.Text;
    dmPrincipal.FDConnSped.Params.Values['Protocol']  :='TCPIP';
    dmPrincipal.FDConnSped.Connected :=true;
   except

     ExibeWarning('Servidor não localizado.'+sLineBreak+' Verifique as configurações.');
     EdtServidor.SetFocus;
     abort
    end;

   Close;
end;

procedure TFrmConfigServer.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var Existe : Boolean;
begin
  if Key = VK_ESCAPE then close;
end;

procedure TFrmConfigServer.FormShow(Sender: TObject);
var
Arquivo:TIniFile;
porta:string;
begin
  Arquivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ConfigSped.ini');
  EdtServidor.Text := Arquivo.ReadString('SERVIDOR','Servidor','');
  EdtCaminho.Text  := Arquivo.ReadString('SERVIDOR','Database','');
  porta            := Arquivo.ReadString('SERVIDOR','portafb','');

  if porta <>'' then
    begin
      EditPortaFb.Text := porta;
    end
  else
    begin
      EditPortaFb.Text:='3050';
    end;

  Arquivo.Free;

end;

procedure TFrmConfigServer.BtAlterarCaminhoClick(Sender: TObject);
begin

 Panel1.Enabled := True;
 EdtServidor.SetFocus;

end;

end.
