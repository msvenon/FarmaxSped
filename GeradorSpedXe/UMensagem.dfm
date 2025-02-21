object FrmMensagem: TFrmMensagem
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FrmMensagem'
  ClientHeight = 90
  ClientWidth = 611
  Color = 8662541
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindow
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  TextHeight = 13
  object LabelMensagem: TLabel
    Left = 0
    Top = 0
    Width = 611
    Height = 90
    Align = alClient
    Alignment = taCenter
    Caption = 'LabelMensagem'
    Color = 8662541
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    ExplicitWidth = 155
    ExplicitHeight = 30
  end
end
