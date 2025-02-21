object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 629
  ClientWidth = 998
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 857
    Height = 257
    Caption = 'com'
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 18
      Width = 26
      Height = 16
      Caption = 'Filial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 87
      Top = 18
      Width = 73
      Height = 16
      Caption = 'Raz'#227'o Social'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 445
      Top = 18
      Width = 48
      Height = 16
      Caption = 'Fantasia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 18
      Top = 66
      Width = 53
      Height = 16
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 18
      Top = 112
      Width = 14
      Height = 16
      Caption = 'N'#186
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 445
      Top = 66
      Width = 79
      Height = 16
      Caption = 'Complemento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 112
      Top = 112
      Width = 34
      Height = 16
      Caption = 'Bairro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 445
      Top = 112
      Width = 39
      Height = 16
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 18
      Top = 155
      Width = 15
      Height = 16
      Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 112
      Top = 155
      Width = 22
      Height = 16
      Caption = 'CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 264
      Top = 155
      Width = 35
      Height = 16
      Caption = 'E-Mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 18
      Top = 197
      Width = 28
      Height = 16
      Caption = 'CNPJ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 176
      Top = 197
      Width = 97
      Height = 16
      Caption = 'Incri'#231#227'o Estadual'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label25: TLabel
      Left = 330
      Top = 197
      Width = 83
      Height = 16
      Caption = 'Cod. Municipio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 704
      Top = 197
      Width = 29
      Height = 16
      Caption = 'Perfil'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditFilial: TEdit
      Left = 16
      Top = 35
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      Text = 'EditFilial'
    end
    object EditRazao: TEdit
      Left = 87
      Top = 35
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      Text = 'RAZAO'
    end
    object EditFantasia: TEdit
      Left = 445
      Top = 35
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      Text = 'FANTASIA'
    end
    object EditEndereco: TEdit
      Left = 16
      Top = 84
      Width = 408
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
      Text = 'ENDERECO'
    end
    object EditComplemento: TEdit
      Left = 445
      Top = 84
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
      Text = 'COMPLEMENTO'
    end
    object EditNumero: TEdit
      Left = 16
      Top = 129
      Width = 81
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
      Text = 'NUMERO'
    end
    object Editbairro: TEdit
      Left = 112
      Top = 129
      Width = 312
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 6
      Text = 'BAIRRO'
    end
    object EditCidade: TEdit
      Left = 445
      Top = 129
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 7
      Text = 'CIDADE'
    end
    object EditUf: TEdit
      Left = 16
      Top = 171
      Width = 33
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 8
      Text = 'UF'
    end
    object EditCep: TEdit
      Left = 112
      Top = 171
      Width = 137
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 9
      Text = 'CEP'
    end
    object EditEmail: TEdit
      Left = 264
      Top = 171
      Width = 518
      Height = 21
      CharCase = ecLowerCase
      TabOrder = 10
      Text = 'email'
    end
    object EditCnpj: TEdit
      Left = 16
      Top = 213
      Width = 137
      Height = 21
      CharCase = ecUpperCase
      NumbersOnly = True
      TabOrder = 11
      Text = 'CNPJ'
    end
    object EditIE: TEdit
      Left = 176
      Top = 213
      Width = 137
      Height = 21
      CharCase = ecUpperCase
      NumbersOnly = True
      TabOrder = 12
      Text = 'CNPJ'
    end
    object EditCodigoMunicipio: TEdit
      Left = 330
      Top = 213
      Width = 137
      Height = 21
      CharCase = ecUpperCase
      NumbersOnly = True
      TabOrder = 13
      Text = 'CNPJ'
    end
    object CbbPerfil: TComboBox
      Left = 706
      Top = 213
      Width = 76
      Height = 21
      Style = csDropDownList
      TabOrder = 14
      Items.Strings = (
        'A'
        'B'
        'C')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 331
    Width = 857
    Height = 217
    Caption = 'DADOS DO CONTADOR'
    TabOrder = 1
    object Label12: TLabel
      Left = 18
      Top = 13
      Width = 26
      Height = 16
      Caption = 'Filial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 87
      Top = 13
      Width = 73
      Height = 16
      Caption = 'Raz'#227'o Social'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 445
      Top = 13
      Width = 48
      Height = 16
      Caption = 'Fantasia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 18
      Top = 62
      Width = 53
      Height = 16
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 18
      Top = 105
      Width = 14
      Height = 16
      Caption = 'N'#186
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 445
      Top = 62
      Width = 79
      Height = 16
      Caption = 'Complemento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 112
      Top = 105
      Width = 34
      Height = 16
      Caption = 'Bairro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 445
      Top = 105
      Width = 39
      Height = 16
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 18
      Top = 147
      Width = 15
      Height = 16
      Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 116
      Top = 147
      Width = 22
      Height = 16
      Caption = 'CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 264
      Top = 147
      Width = 35
      Height = 16
      Caption = 'E-Mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 16
      Top = 30
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      Text = 'EditFilial'
    end
    object Edit2: TEdit
      Left = 87
      Top = 30
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      Text = 'RAZAO'
    end
    object Edit3: TEdit
      Left = 445
      Top = 30
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      Text = 'FANTASIA'
    end
    object Edit4: TEdit
      Left = 16
      Top = 78
      Width = 408
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
      Text = 'ENDERECO'
    end
    object Edit5: TEdit
      Left = 445
      Top = 78
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
      Text = 'COMPLEMENTO'
    end
    object Edit6: TEdit
      Left = 16
      Top = 122
      Width = 81
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
      Text = 'NUMERO'
    end
    object Edit7: TEdit
      Left = 112
      Top = 122
      Width = 312
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 6
      Text = 'BAIRRO'
    end
    object Edit8: TEdit
      Left = 445
      Top = 122
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 7
      Text = 'CIDADE'
    end
    object Edit9: TEdit
      Left = 16
      Top = 163
      Width = 33
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 8
      Text = 'UF'
    end
    object Edit10: TEdit
      Left = 112
      Top = 163
      Width = 137
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 9
      Text = 'CEP'
    end
    object Edit11: TEdit
      Left = 264
      Top = 163
      Width = 518
      Height = 21
      CharCase = ecLowerCase
      TabOrder = 10
      Text = 'email'
    end
  end
end
