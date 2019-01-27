object frmInfo: TfrmInfo
  Left = 606
  Top = 117
  BorderIcons = [biSystemMenu]
  Caption = 'frmInfo'
  ClientHeight = 435
  ClientWidth = 354
  Color = clBtnFace
  Constraints.MinHeight = 200
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    354
    435)
  PixelsPerInch = 96
  TextHeight = 13
  object InfoBox: TListBox
    Left = 4
    Top = 4
    Width = 346
    Height = 426
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 16
    PopupMenu = pmList
    TabOrder = 0
    OnDrawItem = InfoBoxDrawItem
  end
  object pmList: TPopupMenu
    OnPopup = pmListPopup
    Left = 136
    Top = 248
    object mpeCopy: TMenuItem
      Caption = 'Copy'
      OnClick = mpeCopyClick
    end
    object mpeCopyAll: TMenuItem
      Caption = 'Copy All'
      OnClick = mpeCopyAllClick
    end
  end
end
