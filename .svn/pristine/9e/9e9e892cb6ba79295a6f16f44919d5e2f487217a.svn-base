object FrmConfigurarECF: TFrmConfigurarECF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Configurar ECF'
  ClientHeight = 469
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI Light'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 31
    Top = 57
    Width = 35
    Height = 13
    Caption = 'Modelo'
  end
  object Label4: TLabel
    Left = 31
    Top = 97
    Width = 23
    Height = 13
    Caption = 'Porta'
  end
  object Label5: TLabel
    Left = 31
    Top = 141
    Width = 131
    Height = 13
    Caption = '&Baud rate (Bits por Segundo)'
    FocusControl = cmbBaudRate
  end
  object Label6: TLabel
    Left = 31
    Top = 186
    Width = 108
    Height = 13
    Caption = '&Data Bits (Bits de Dados)'
    FocusControl = cmbDataBits
  end
  object Label7: TLabel
    Left = 31
    Top = 230
    Width = 72
    Height = 13
    Caption = '&Parity (Paridade)'
    FocusControl = cmbParity
  end
  object Label11: TLabel
    Left = 31
    Top = 273
    Width = 110
    Height = 13
    Caption = '&Stop Bits (Bits de Parada)'
    FocusControl = cmbStopBits
  end
  object Label8: TLabel
    Left = 31
    Top = 320
    Width = 149
    Height = 13
    Caption = '&Handshaking (Controle de Fluxo)'
    FocusControl = cmbHandShaking
  end
  object lblStatusPoucoPapel: TLabel
    Left = 31
    Top = 388
    Width = 192
    Height = 17
    AutoSize = False
    Caption = 'lblStatusPoucoPapel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Segoe UI Light'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 231
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 11
    object Label1: TLabel
      Left = 18
      Top = 3
      Width = 192
      Height = 48
      AutoSize = False
      Caption = 'Configura'#231#227'o da ECF  Impressora Fiscal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
  end
  object btSerial: TBitBtn
    Left = 130
    Top = 410
    Width = 88
    Height = 28
    Cancel = True
    Caption = 'Configurar'
    Default = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF323232
      3232323E3E3E565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF503200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      565656565656FFFFFFFFFFFF3232322626262626262626262626265032005032
      000000504873FFFFFFFFFFFFFFFFFFFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFF6E
      6E6E32323232323232323232323250320000005025AAFFFFFFFFFFFFFF565656
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5656563232323232326E6E6E5032005032
      008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFF50320050320056
      56564A4A4A5050003232325032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
      FFFFFF5656563E3E3E2626265032006262625656565050003232325032005032
      008FFF6B8ED4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5050005050006E
      6E6E5656565050003250005032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686865656565656563250005032005032
      008FFF6B48B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3232323E
      3E3EA4A0A08686866E6E6E565656503200C0C0C02557FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF5050004A4A4A3232323232323232323232325032
      00FFFFFF6B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ModalResult = 1
    TabOrder = 10
    OnClick = btSerialClick
  end
  object cbxModelo: TComboBox
    Left = 31
    Top = 74
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = cbxModeloChange
    Items.Strings = (
      'Procurar'
      'ecfNaoFiscal'
      'ecfBematech'
      'ecfSweda'
      'ecfDaruma'
      'ecfSchalter'
      'ecfMecaf'
      'ecfYanco'
      'ecfDataRegis'
      'ecfUrano'
      'ecfICash'
      'ecfQuattro')
  end
  object cbxPorta: TComboBox
    Left = 31
    Top = 114
    Width = 161
    Height = 21
    TabOrder = 1
    Text = 'Procurar'
  end
  object cmbBaudRate: TComboBox
    Left = 31
    Top = 159
    Width = 161
    Height = 21
    TabOrder = 2
    Text = '9600'
    OnChange = cmbBaudRateChange
    Items.Strings = (
      '110'
      '300'
      '600'
      '1200'
      '2400'
      '4800'
      '9600'
      '14400'
      '19200'
      '38400'
      '56000'
      '57600'
      '115200')
  end
  object cmbDataBits: TComboBox
    Left = 31
    Top = 202
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 3
    OnChange = cmbDataBitsChange
    Items.Strings = (
      '5'
      '6'
      '7'
      '8')
  end
  object cmbParity: TComboBox
    Left = 31
    Top = 247
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    OnChange = cmbParityChange
    Items.Strings = (
      'None'
      'Odd'
      'Even'
      'Mark'
      'Space')
  end
  object cmbStopBits: TComboBox
    Left = 31
    Top = 291
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 5
    OnChange = cmbStopBitsChange
    Items.Strings = (
      '1'
      '1,5'
      '2')
  end
  object cmbHandShaking: TComboBox
    Left = 31
    Top = 338
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 6
    OnChange = cmbHandShakingChange
    Items.Strings = (
      'Nenhum'
      'XON/XOFF'
      'RTS/CTS'
      'DTR/DSR')
  end
  object chHardFlow: TCheckBox
    Left = 31
    Top = 365
    Width = 89
    Height = 17
    Caption = 'HardFlow'
    TabOrder = 7
    OnClick = chHardFlowClick
  end
  object chSoftFlow: TCheckBox
    Left = 119
    Top = 365
    Width = 81
    Height = 17
    Caption = 'SoftFlow'
    TabOrder = 8
    OnClick = chSoftFlowClick
  end
  object btnTestar: TButton
    Left = 27
    Top = 410
    Width = 75
    Height = 25
    Caption = 'Testar...'
    TabOrder = 9
    OnClick = btnTestarClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 450
    Width = 231
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
  end
  object ActionList1: TActionList
    Left = 200
    Top = 360
    object actFechar: TAction
      Caption = 'actFechar'
      ShortCut = 27
      OnExecute = actFecharExecute
    end
  end
  object ACBrECF1: TACBrECF
    QuebraLinhaRodape = False
    Porta = 'COM1'
    MsgAguarde = 'Aguardando a resposta da Impressora: %d segundos'
    MsgTrabalhando = 'Impressora est'#225' trabalhando'
    MsgRelatorio = 'Imprimindo %s  %d'#170' Via '
    MsgPausaRelatorio = 'Destaque a %d'#170' via, <ENTER> proxima, %d seg.'
    PaginaDeCodigo = 0
    OnMsgAguarde = ACBrECF1MsgAguarde
    OnAguardandoRespostaChange = ACBrECF1AguardandoRespostaChange
    OnMsgPoucoPapel = ACBrECF1MsgPoucoPapel
    OnChangeEstado = ACBrECF1ChangeEstado
    MemoParams.Strings = (
      '[Cabecalho]'
      'LIN000=<center><b>Nome da Empresa</b></center>'
      'LIN001=<center>Nome da Rua , 1234  -  Bairro</center>'
      'LIN002=<center>Cidade  -  UF  -  99999-999</center>'
      
        'LIN003=<center>CNPJ: 01.234.567/0001-22    IE: 012.345.678.90</c' +
        'enter>'
      
        'LIN004=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>COO: <b><code>NumCupom</code' +
        '></b></td></tr></table>'
      'LIN005=<hr>'
      ' '
      '[Cabecalho_Item]'
      'LIN000=ITEM   CODIGO      DESCRICAO'
      'LIN001=QTD         x UNITARIO       Aliq     VALOR (R$)'
      'LIN002=<hr>'
      
        'MascaraItem=III CCCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDQQQQ' +
        'QQQQ UU x VVVVVVVVVVVVV AAAAAA TTTTTTTTTTTTT'
      ' '
      '[Rodape]'
      'LIN000=<hr>'
      
        'LIN001=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>Projeto ACBr: <b><code>ACBR<' +
        '/code></b></td></tr></table>'
      'LIN002=<center>Obrigado Volte Sempre</center>'
      'LIN003=<hr>'
      ' '
      '[Formato]'
      'Colunas=48'
      'HTML=1'
      'HTML_Title_Size=2'
      'HTML_Font=<font size="2" face="Lucida Console">')
    ConfigBarras.MostrarCodigo = True
    ConfigBarras.LarguraLinha = 0
    ConfigBarras.Altura = 0
    ConfigBarras.Margem = 0
    InfoRodapeCupom.Imposto.ModoCompacto = False
    Left = 192
    Top = 24
  end
end
