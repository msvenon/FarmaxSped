object FrmConsistencia: TFrmConsistencia
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 350
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 57
    Align = alTop
    Caption = 'PRODUTOS COM DIVERG'#202'NCIAS DE PIS E COFINS'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 537
    Height = 293
    Align = alClient
    Caption = 'Panel2'
    Color = clRed
    ParentBackground = False
    TabOrder = 1
    object Memo: TMemo
      Left = 1
      Top = 1
      Width = 535
      Height = 283
      Align = alClient
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 541
      ExplicitHeight = 264
    end
  end
end
