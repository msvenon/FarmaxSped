object FrmSobre: TFrmSobre
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Sobre'
  ClientHeight = 373
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcSobre: TPageControl
    Left = 0
    Top = 95
    Width = 612
    Height = 249
    ActivePage = tabSpedFiscal
    Align = alClient
    TabOrder = 0
    TabStop = False
    object tabSpedFiscal: TTabSheet
      Caption = 'SPED Fiscal'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 604
        Height = 221
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Lines.Strings = (
          ' '
          'Escritura'#231#227'o Fiscal Digital - EFD '
          ''
          
            '    '#201' um arquivo digital, que se constitui de um conjunto de esc' +
            'ritura'#231#245'es de '
          
            'documentos fiscais e de outras informa'#231#245'es de interesse dos Fisc' +
            'os das unidades '
          
            'federadas e da Secretaria da Receita Federal do Brasil, bem como' +
            ' de registros de '
          
            'apura'#231#227'o de impostos referentes '#224's opera'#231#245'es e presta'#231#245'es pratic' +
            'adas pelo '
          'contribuinte.'
          ''
          
            'Este arquivo dever'#225' ser assinado digitalmente e transmitido, via' +
            ' Internet, ao '
          'ambiente Sped.')
        ReadOnly = True
        TabOrder = 0
      end
    end
    object tabSpedContribuicoes: TTabSheet
      Caption = 'SPED Contribui'#231#245'es'
      ImageIndex = 1
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 604
        Height = 221
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Ctl3D = False
        Lines.Strings = (
          ''
          'A EFD-Contribui'#231#245'es '
          ''
          
            #201' um arquivo digital institu'#237'do no Sistema Publico de Escritura'#231 +
            #227'o Digital '#8211' SPED, a '
          
            'ser utilizado pelas pessoas jur'#237'dicas de direito privado na escr' +
            'itura'#231#227'o da '
          
            'Contribui'#231#227'o para o PIS/Pasep e da Cofins, nos regimes de apura'#231 +
            #227'o n'#227'o-'
          
            'cumulativo e/ou cumulativo, com base no conjunto de documentos e' +
            ' opera'#231#245'es '
          
            'representativos das receitas auferidas, bem como dos custos, des' +
            'pesas, encargos '
          'e aquisi'#231#245'es geradores de cr'#233'ditos da n'#227'o cumulatividade.'
          ''
          
            'Este arquivo dever'#225' ser assinado digitalmente e transmitido, via' +
            ' Internet, ao '
          'ambiente Sped.')
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 344
    Width = 612
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      612
      29)
    object Button1: TButton
      Left = 533
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 612
    Height = 95
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 131
      Height = 17
      Caption = 'Direitos Reservados:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblLinkSite: TLabel
      Left = 152
      Top = 4
      Width = 94
      Height = 17
      Cursor = crHandPoint
      Caption = 'www.farmax.far.br'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
      OnClick = lblLinkSiteClick
    end
    object lblFonesContato: TLabel
      Left = 152
      Top = 25
      Width = 95
      Height = 17
      Caption = 'Fones :26093000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 68
      Width = 46
      Height = 17
      Caption = 'Vers'#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVersao: TLabel
      Left = 152
      Top = 68
      Width = 49
      Height = 21
      Caption = '1.0.0.0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 25
      Width = 60
      Height = 17
      Caption = 'Contatos:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
