unit uFuncoesBasicas;

interface

uses
    Forms, Windows, SysUtils, ShellApi, Classes, ACBrValidador, {SWSystem,} IniFiles,
    System.IOUtils, Vcl.Controls;

   procedure MensagemAviso(const Msg: String);
   procedure MensagemInformacao(const Msg: String);
   procedure MensagemErro(const Msg: String);
   function MensagemConfirmacao(const Msg: String): Boolean;
   function RemoveMascaraStr(const sStrTexto: String): String;
   function ExecutarExterno(const Link: String; const Operation: String = 'open'; const Params: String = ''; const Directory: String = ''): Cardinal;
   procedure ObterListaAqruivosDiretorio(const Local, ExtFile: String;
     ListaArquivos: TStringList; const FilterFile: String = '*';
     const IncluirLocalNoNome: Boolean = False; const iLim: Integer = 0);
   function SomenteNumeros(const Sequencia: String): String;
   function MascaraCNPFCPF(const NrDoc: String): String;
   function CPFCNPJValido(const CPF_CNPJ: String): Boolean;
   function Desincriptar(senha : string): string;
   function VersaoExecutavel(const FilePathExe: WideString): String;
   function LerIni(const NomeIni, Sessao, Campo: String):String;
   function Crypt(Action, Src: String): String;
   procedure GeraLog2(Mensagem : String);
   procedure GeraINI;
   procedure ValidaBD;
   procedure DeletarArquivos(const diretorio :string);
   Procedure ExibeInformation(Texto : String);
   Procedure ExibeWarning(Texto : String);
   Function ExtractSystemDir : String;
   function FormatPath(path : String):string;

   procedure ExibeMensagem(Texto : String; Exibe : Boolean);

implementation

uses udmPrincipal, dxGDIPlusAPI, UMensagem;

Function ExtractSystemDir : String;
Var
  Buffer : Array[0..144] of Char;
Begin
  GetSystemDirectory(Buffer,144);
  Result := FormatPath(StrPas(Buffer));
End;

function FormatPath(path : String):string;
var i : integer;
begin
  Path := Trim(Path);
  for i := Length(Path) downto 1 do
   begin
      if Path[i] = '\' then
         Path := Copy(Path, 1, i - 1)
      else
         Break;
   end;
  Result := Path;
end;

procedure DeletarArquivos(const diretorio :string);
var
  sr: TSearchRec;
  arquivo: string;
begin
  // Procura o primeiro arquivo XML na pasta
  if FindFirst(TPath.Combine(diretorio, '*.xml'), faAnyFile, sr) = 0 then
  begin
    repeat
      arquivo := TPath.Combine(diretorio, sr.Name); // Caminho completo do arquivo

      // Verifica se é um arquivo XML
      if FileExists(arquivo) then
      begin
        // Deleta o arquivo XML
        DeleteFile(arquivo);
      end;
    until FindNext(sr) <> 0; // Procura pelo próximo arquivo
    FindClose(sr); // Fecha a busca
  end;


end;


Procedure ExibeWarning(Texto : String);
begin
  Application.MessageBox(PChar(Texto), 'Atenção', MB_ICONWARNING+MB_OK);
end;

Procedure ExibeInformation(Texto : String);
begin
  Application.MessageBox(PChar(Texto), 'Informação', MB_ICONINFORMATION+MB_OK);
end;

procedure MensagemAviso(const Msg: String);
begin
   Application.messagebox(PWideChar(Msg), 'Atenção', MB_OK + MB_ICONEXCLAMATION);
end;

procedure MensagemInformacao(const Msg: String);
begin
   Application.MessageBox(PWideChar(Msg), 'Informação', MB_OK + MB_ICONINFORMATION);
end;

procedure MensagemErro(const Msg: String);
begin
   Application.MessageBox(PWideChar(Msg), 'Erro', MB_OK + MB_ICONERROR);
end;

function MensagemConfirmacao(const Msg: String): Boolean;
begin
   Result := (Application.MessageBox(PWideChar(Msg), 'Confirmação', MB_YESNO + MB_ICONQUESTION) = ID_YES);
end;

function RemoveMascaraStr(const sStrTexto: String): String;
begin
   Result := Trim(sStrTexto);
   Result := StringReplace(Result, '.', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '-', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '/', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '(', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, ')', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, '_', '', [rfReplaceAll, rfIgnoreCase]);
   Result := StringReplace(Result, ',', '', [rfReplaceAll, rfIgnoreCase]);
end;

function ExecutarExterno(const Link: String; const Operation: String = 'open'; const Params: String = ''; const Directory: String = ''): Cardinal;

var
   pw1,
   pw2: PWideChar;
begin
  pw1 := nil;
  pw2 := nil;

  if Params <> '' then
     pw1 := PWideChar(Params);
  if Directory <> '' then
     pw2 := PWideChar(Directory);

  Result := ShellExecute(GetDesktopWindow,PWideChar(Operation),PWideChar(Link),pw1,pw2,SW_SHOWNORMAL);
end;

procedure ObterListaAqruivosDiretorio(const Local, ExtFile: String;
  ListaArquivos: TStringList; const FilterFile: String = '*';
  const IncluirLocalNoNome: Boolean = False; const iLim: Integer = 0);
var
   srFile: TSearchRec;
   iFile: Integer;
   iCount: Integer;
   sLocalTmp: String;
begin
   iCount := 0;
   sLocalTmp := Local;
   if (Copy(sLocalTmp, Length(sLocalTmp), 1) <> '\') then
      sLocalTmp := sLocalTmp + '\';

   iFile := FindFirst(sLocalTmp + FilterFile +'.' + ExtFile, faArchive, srFile);
   try
      while iFile = 0 do
      begin
         Inc(iCount);

         if (IncluirLocalNoNome) then
            ListaArquivos.Add(sLocalTmp + srFile.Name)
         else
            ListaArquivos.Add(srFile.Name);

         if (iLim > 0) then
            if (iCount >= iLim) then
               Break;

         iFile := FindNext(srFile);
      end; { while }
   finally
      FindClose(srFile);
   end;
end;

function SomenteNumeros(const Sequencia: String): String;
var
  I : Integer ;
  LenValue : Integer;

  function CharEhNumero(const C: Char): Boolean;
  begin
     Result := ( C in ['0'..'9'] );
  end;

begin
  Result   := '' ;
  LenValue := Length( Sequencia ) ;
  For I := 1 to LenValue  do
  begin
     if CharEhNumero( Sequencia[I] ) then
        Result := Result + Sequencia[I];
  end;
end;

function MascaraCNPFCPF(const NrDoc: String): String;
var
   sNrDocAux: String;
begin
   sNrDocAux := RemoveMascaraStr(NrDoc);
   if (Length(NrDoc) = 14) then
      Result := Copy(sNrDocAux, 0, 2) + '.' + Copy(sNrDocAux, 3, 3) + '.' + Copy(sNrDocAux, 6, 3) + '/' + Copy(sNrDocAux, 9, 4) + '-' + Copy(sNrDocAux, 13, 2)
   else
       Result := Copy(sNrDocAux, 0, 3) + '.' + Copy(sNrDocAux, 4, 3) + '.' + Copy(sNrDocAux, 7, 3) + '-' + Copy(sNrDocAux, 10, 2);
end;

function CPFCNPJValido(const CPF_CNPJ: String): Boolean;
var
   sDocAux: String;
   oACBrValidador: TACBrValidador;
begin
   sDocAux := RemoveMascaraStr(CPF_CNPJ);

   Result := ((Length(sDocAux) = 11) or (Length(sDocAux) = 14));

   if Result then
      begin
        if ((sDocAux = '00000000000') or (sDocAux = '00000000000000')) then
           Result := False
        else
           begin
              oACBrValidador := TACBrValidador.Create(nil);
               try
                  if (Length(sDocAux) = 11) then
                     oACBrValidador.TipoDocto := docCPF
                  else
                     oACBrValidador.TipoDocto := docCNPJ;

                  oACBrValidador.Documento := sDocAux;
                  Result := oACBrValidador.Validar;
               finally
                  FreeAndNil(oACBrValidador);
               end;
           end;
      end;
end;

{Função enviada pelo Mateus}
function Desincriptar(senha : string): string;
var Senha2 : string;
    tam,i,j : Integer;
    vet : array [1..100] of char;
begin
  tam := Length(Senha);
  j := tam * tam;
  Senha2 := Senha;
  for i := 1 to tam do
    vet[i] := Chr(Ord(Senha[i]) - j);
  for i := 1 to tam do
    Senha2[i] := vet[i];
  result := Senha2;
end;

function VersaoExecutavel(const FilePathExe: WideString): String;
type
   PFFI = ^vs_FixedFileInfo;
var
   F: PFFI;
   Handle: Dword;
   Len: Longint;
   Data: Pchar;
   Buffer: Pointer;
   Tamanho: Dword;
   Parquivo: Pchar;
   Arquivo: WideString;
begin
   Arquivo := FilePathExe;
   Parquivo := StrAlloc(Length(Arquivo) + 1);
   StrPcopy(Parquivo, Arquivo);
   Len := GetFileVersionInfoSize(Parquivo, Handle);
   Result := '';
   if Len > 0 then
      begin
         Data := StrAlloc(Len + 1);
         if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
            begin
              VerQueryValue(Data, '', Buffer, Tamanho);
              F := PFFI(Buffer);
              Result := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs), LoWord
                  (F^.dwFileVersionMs), HiWord(F^.dwFileVersionLs), LoWord
                  (F^.dwFileVersionLs)]);
            end;
         StrDispose(Data);
      end;
   StrDispose(Parquivo);
end;

function LerIni(const NomeIni, Sessao, Campo: String):String;
var
   ini: TIniFile;
   gsAppPath: String;
begin
   gsAppPath := ExtractFilePath( Application.ExeName );
   ini := TIniFile.Create( gsAppPath + NomeIni );
   try
      Result := Ini.ReadString(Sessao, Campo, '');
   finally
      Ini.Free;
   end;
end;


function Crypt(Action, Src: String): String;
var KeyLen : Integer;
  KeyPos : Integer;
  OffSet : Integer;
  Dest, Key : String;
  SrcPos : Integer;
  SrcAsc : Integer;
  TmpSrcAsc : Integer;
  Range : Integer;
begin
  if (Src = '') Then
  begin
    Result:= '';
    Exit;
  end;
  Key :=
'YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x',[OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x',[SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToIntDef('$'+ copy(Src,1,2),0);
    SrcPos := 3;
  repeat
    SrcAsc := StrToIntDef('$'+ copy(Src,SrcPos,2),0);
    if (KeyPos < KeyLen) Then KeyPos := KeyPos + 1 else KeyPos := 1;
    TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
    if TmpSrcAsc <= OffSet then TmpSrcAsc := 255 + TmpSrcAsc - OffSet
    else TmpSrcAsc := TmpSrcAsc - OffSet;
    Dest := Dest + Chr(TmpSrcAsc);
    OffSet := SrcAsc;
    SrcPos := SrcPos + 2;
  until (SrcPos >= Length(Src));
  end;
  Result:= Dest;
end;

procedure GeraLog2(Mensagem : String);
var Log : TextFile;
begin

  if not DirectoryExists(ExtractFilePath(Application.ExeName)+'LogsSPed\FarmaxSped') then
    ForceDirectories(ExtractFilePath(Application.ExeName) + 'LogsSPed\FarmaxSped');

  AssignFile(Log, ExtractFilePath(Application.ExeName) + 'LogsSPed\FarmaxSped\LogErro' + FormatDateTime('ddmmyyyy',Date) + '.txt');

  if FileExists(ExtractFilePath(Application.ExeName) + 'LogsSPed\FarmaxSped\LogErro' + FormatDateTime('ddmmyyyy',Date) + '.txt') then
   begin
    Append(Log);
    Writeln(Log, FormatDateTime('dd/mm/yyyy - hh:mm:ss', Now) + ' - ' + Application.ExeName + ' - ' + Mensagem);
    CloseFile(Log);

   end
   else
   begin

    AssignFile(Log, ExtractFilePath(Application.ExeName) + 'LogsSPed\FarmaxSped\LogErro' + FormatDateTime('ddmmyyyy',Date) + '.txt');

    Rewrite(Log);
    Append(Log);
    Writeln(Log, FormatDateTime('dd/mm/yyyy - hh:mm:ss', Now) + ' - ' + Application.ExeName + ' - ' + Mensagem);
    CloseFile(Log);

   end;

end;

procedure GeraINI;
begin
//    try
//      Application.CreateForm(TFrmConfigServer, FrmConfigServer);
//      FrmConfigServer.ShowModal;
//    finally
//      FrmConfigServer.Free;
//    end;
end;

procedure ValidaBD;
begin
  // mauricio
//  if not FileExists(ExtractFilePath(Application.ExeName) + 'CaminhoBD.ini') then
//     GeraIni;
//
//  if FileExists(ExtractFilePath(Application.ExeName) + 'CaminhoBD.ini') then
//    begin
//
//      Ini := TiniFile.Create(ExtractFilePath(Application.ExeName) + 'CaminhoBD.ini');
//      CaminhoBD    := Crypt('D', ini.ReadString('CAMINHO','CAMINHO','Caminho'));
//      NomeServidor := Crypt('D', ini.ReadString('NOME','NOME','NomedoServidorDB'));
//      GeraLog2('Caminho do banco ' + NomeServidor + ' ' + CaminhoBD);
//      Ini.Free;
//
//      dmPrincipal.connBaseDados.Connected := False;
//
//      dmPrincipal.connBaseDados.Close;
//      dmPrincipal.connBaseDados.Params.Values['DriverID']  := 'FB';
//      dmPrincipal.connBaseDados.Params.Values['Server']    := NomeServidor;
//      dmPrincipal.connBaseDados.Params.Values['Database']  := CaminhoBD;
//      dmPrincipal.connBaseDados.Params.Values['User_Name'] := 'sysdba';
//      dmPrincipal.connBaseDados.Params.Values['Password']  := 'masterkey';
//      dmPrincipal.connBaseDados.Params.Values['Port']      := '3050';
//      dmPrincipal.connBaseDados.Params.Values['Protocol']  := 'TCPIP';
//
//    end;

  // sLocalConfig := ExtractFilePath(Application.ExeName) + 'CaminhoBD.ini';

    sLocalConfig := ExtractFilePath(Application.ExeName) + 'ConfigFB.ini';


   if not FileExists(sLocalConfig) then
      raise Exception.Create('Arquivo de configuração não encontrado em: "' + sLocalConfig + '"');

//      Comentado por Angelo 19122023

   dmPrincipal.connBaseDados.Connected := False;
   Ini := TIniFile.Create(sLocalConfig);
   try

//      Seção DRIVER comentado por Angelo 15122023
      dmPrincipal.connBaseDados.ConnectionName      := Ini.ReadString('DRIVER', 'ConnectionName','FbConnection');
      dmPrincipal.connBaseDados.DriverName          := Ini.ReadString('DRIVER', 'DriverName','Firebird');
      dmPrincipal.connBaseDados.GetDriverFunc       := Ini.ReadString('DRIVER', 'GetDriverFunc','getSQLDriverINTERBASE');
      dmPrincipal.connBaseDados.LoginPrompt         := Ini.ReadBool('DRIVER', 'LoginPrompt',False);
      dmPrincipal.connBaseDados.LoadParamsOnConnect := Ini.ReadBool('DRIVER', 'LoadParamsOnConnect',False);
      dmPrincipal.connBaseDados.KeepConnection      := Ini.ReadBool('DRIVER', 'KeepConnection',True);
      dmPrincipal.connBaseDados.SQLHourGlass        := Ini.ReadBool('DRIVER', 'SQLHourGlass',True);
      dmPrincipal.connBaseDados.LibraryName         := Ini.ReadString('DRIVER', 'LibraryName','dbxfb.dll');
      dmPrincipal.connBaseDados.VendorLib           := Ini.ReadString('DRIVER', 'VendorLib','fbclient.dll');

//      Seção PARAMS
      dmPrincipal.connBaseDados.Params.Values['User_Name']  := 'SYSDBA';
      dmPrincipal.connBaseDados.Params.Values['Password']   := 'masterkey';
      dmPrincipal.connBaseDados.Params.Values['Database']   := Ini.ReadString('PARAMS', 'Database', '');

      dmPrincipal.connBaseDados.Params.Values['RoleName']          := Ini.ReadString('PARAMS', 'RoleName', 'RoleName');
      dmPrincipal.connBaseDados.Params.Values['BlobSize']          := Ini.ReadString('PARAMS', 'BlobSize', '-1');
      dmPrincipal.connBaseDados.Params.Values['ServerCharSet']     := Ini.ReadString('PARAMS', 'ServerCharSet', '');
      dmPrincipal.connBaseDados.Params.Values['ErrorResourceFile'] := Ini.ReadString('PARAMS', 'ErrorResourceFile', '');
      dmPrincipal.connBaseDados.Params.Values['LocaleCode']        := Ini.ReadString('PARAMS', 'LocaleCode', '0000');
      dmPrincipal.connBaseDados.Params.Values['CommitRetain']      := Ini.ReadString('PARAMS', 'CommitRetain', 'False');
      dmPrincipal.connBaseDados.Params.Values['WaitOnLocks']       := Ini.ReadString('PARAMS', 'WaitOnLocks', 'True');
      dmPrincipal.connBaseDados.Params.Values['IsolationLevel']    := Ini.ReadString('PARAMS', 'IsolationLevel', 'ReadCommitted');
      dmPrincipal.connBaseDados.Params.Values['UseUnicode']        := Ini.ReadString('PARAMS', 'UseUnicode', '');
      dmPrincipal.connBaseDados.Params.Values['EnableBCD']         := Ini.ReadString('PARAMS', 'EnableBCD', 'True');
      dmPrincipal.connBaseDados.Params.Values['OptimizedNumerics'] := Ini.ReadString('PARAMS', 'OptimizedNumerics', 'True');
      dmPrincipal.connBaseDados.Params.Values['LongStrings']       := Ini.ReadString('PARAMS', 'LongStrings', 'True');
      dmPrincipal.connBaseDados.Params.Values['UseQuoteChar']      := Ini.ReadString('PARAMS', 'UseQuoteChar', 'False');
      dmPrincipal.connBaseDados.Params.Values['FetchAll']          := Ini.ReadString('PARAMS', 'FetchAll', 'False');
      dmPrincipal.connBaseDados.Params.Values['DeferredBlobRead']  := Ini.ReadString('PARAMS', 'DeferredBlobRead', 'False');
      dmPrincipal.connBaseDados.Params.Values['DeferredArrayRead'] := Ini.ReadString('PARAMS', 'DeferredArrayRead', 'False');
      dmPrincipal.connBaseDados.Params.Values['Trim Char']         := Ini.ReadString('PARAMS', 'Trim Char', 'True');
      dmPrincipal.connBaseDados.Params.Values['SQLDialect']        := Ini.ReadString('PARAMS', 'SQLDialect', '3');
   finally
      Ini.Free;
   end;

end;


procedure ExibeMensagem(Texto : String; Exibe : Boolean);
begin

    Application.ProcessMessages;

if Exibe then
   begin
     FrmMensagem.LabelMensagem.Caption := Texto;
     FrmMensagem.Width := FrmMensagem.LabelMensagem.Width + 10;
     FrmMensagem.Left := StrtoInt(FloattoStr(Int((Screen.Width / 2) - (FrmMensagem.Width / 2))));
     Screen.Cursor := crHourGlass;
     FrmMensagem.Show;
   end
 else
   begin
     Screen.Cursor := crDefault;
     FrmMensagem.ModalResult := mrOk;
     FrmMensagem.Close;
   end;
  Application.ProcessMessages;
  SetForegroundWindow(Application.Handle);


end;



end.
