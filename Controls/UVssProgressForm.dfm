object VssProgressForm: TVssProgressForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 129
  ClientWidth = 456
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 8
    Top = 8
    Width = 441
    Height = 33
    AutoSize = False
    WordWrap = True
  end
  object btnCancel: TButton
    Left = 168
    Top = 80
    Width = 113
    Height = 41
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object pbProgress: TProgressBar
    Left = 8
    Top = 48
    Width = 440
    Height = 25
    Smooth = True
    TabOrder = 1
  end
end
