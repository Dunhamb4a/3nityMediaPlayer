object frmHelp: TfrmHelp
  Left = 191
  Top = 430
  ActiveControl = BClose
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'frmHelp'
  ClientHeight = 85
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    310
    85)
  PixelsPerInch = 96
  TextHeight = 13
  object RefLabel: TLabel
    Left = 0
    Top = 64
    Width = 3
    Height = 13
  end
  object HelpText: TMemo
    Left = 4
    Top = 4
    Width = 303
    Height = 45
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object BClose: TButton
    Left = 230
    Top = 56
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'BClose'
    ModalResult = 1
    TabOrder = 1
    OnClick = BCloseClick
  end
end
