object frmPlayList: TfrmPlayList
  Left = 492
  Top = 112
  BorderIcons = [biSystemMenu]
  Caption = 'frmPlayList'
  ClientHeight = 258
  ClientWidth = 404
  Color = clBtnFace
  Constraints.MinHeight = 215
  Constraints.MinWidth = 310
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnMouseDown = FormMouseDown
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    404
    258)
  PixelsPerInch = 96
  TextHeight = 13
  object PlaylistBox: TsListBox
    Left = 5
    Top = 14
    Width = 300
    Height = 238
    Style = lbVirtualOwnerDraw
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiSelect = True
    ParentFont = False
    TabOrder = 0
    OnDblClick = BPlayClick
    OnDragOver = PlaylistBoxDragOver
    OnDrawItem = PlaylistBoxDrawItem
    OnKeyUp = PlaylistBoxKeyUp
    OnMouseUp = PlaylistBoxMouseUp
    OnStartDrag = PlaylistBoxStartDrag
    BoundLabel.ParentFont = False
    SkinData.SkinSection = 'EDIT'
  end
  object BPlay: TBitBtn
    Left = 311
    Top = 30
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Play'
    TabOrder = 1
    WordWrap = True
    OnClick = BPlayClick
  end
  object BAdd: TBitBtn
    Left = 311
    Top = 60
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Add'
    TabOrder = 2
    WordWrap = True
    OnClick = BAddClick
  end
  object BMoveUp: TBitBtn
    Tag = 1
    Left = 311
    Top = 90
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Move up'
    TabOrder = 3
    WordWrap = True
    OnClick = BMoveClick
  end
  object BMoveDown: TBitBtn
    Left = 311
    Top = 120
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Move down'
    TabOrder = 4
    WordWrap = True
    OnClick = BMoveClick
  end
  object BDelete: TBitBtn
    Left = 311
    Top = 150
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete'
    TabOrder = 5
    WordWrap = True
    OnClick = BDeleteClick
  end
  object CShuffle: TCheckBox
    Left = 311
    Top = 217
    Width = 87
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Shuffle'
    TabOrder = 6
    WordWrap = True
    OnClick = CShuffleClick
  end
  object CLoop: TCheckBox
    Left = 311
    Top = 237
    Width = 87
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Repeat'
    TabOrder = 7
    WordWrap = True
    OnClick = CLoopClick
  end
  object BSave: TBitBtn
    Left = 311
    Top = 180
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save'
    TabOrder = 8
    WordWrap = True
    OnClick = BSaveClick
  end
  object btnClose: TBitBtn
    Left = 375
    Top = 2
    Width = 25
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btnCloseClick
  end
  object SavePlaylistDialog: TSaveDialog
    DefaultExt = 'm3u'
    Filter = 'M3U Playlist (*.m3u)|*.m3u|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save Playlist ...'
    Left = 368
  end
end
