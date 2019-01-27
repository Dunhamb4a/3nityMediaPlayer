object VssColorPicker: TVssColorPicker
  Left = 0
  Top = 0
  Width = 134
  Height = 25
  TabOrder = 0
  OnClick = lblColorClick
  OnResize = FrameResize
  object shpColorSolid: TShape
    Tag = -98
    Left = 0
    Top = 0
    Width = 25
    Height = 25
    OnMouseUp = shpColorSolidMouseUp
  end
  object lblColor: TLabel
    Left = 31
    Top = 3
    Width = 64
    Height = 19
    AutoSize = False
    Caption = 'FFFFFF'
    Layout = tlCenter
    OnClick = lblColorClick
  end
  object shpColorAlphaB: TShape
    Tag = -98
    Left = 101
    Top = 0
    Width = 25
    Height = 9
    OnMouseUp = shpColorSolidMouseUp
  end
  object shpColorAlphaW: TShape
    Tag = -98
    Left = 109
    Top = 8
    Width = 25
    Height = 9
    OnMouseUp = shpColorSolidMouseUp
  end
end
