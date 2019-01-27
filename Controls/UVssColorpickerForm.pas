unit UVssColorpickerForm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, VssScrollbar, AutoselectEdits;

type
  TVssColorPickerForm = class(TForm)
    pnlColorSolid: TPanel;
    pnlColorAlphaB: TPanel;
    lblColorSolid: TLabel;
    lblColorAlpha: TLabel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    pnl13: TPanel;
    pnl14: TPanel;
    pnl15: TPanel;
    pnl16: TPanel;
    pnl17: TPanel;
    pnl18: TPanel;
    pnl19: TPanel;
    pnl20: TPanel;
    pnl21: TPanel;
    pnl22: TPanel;
    pnl23: TPanel;
    pnl24: TPanel;
    pnl25: TPanel;
    pnl26: TPanel;
    pnl27: TPanel;
    pnl28: TPanel;
    pnl29: TPanel;
    pnl30: TPanel;
    pnl31: TPanel;
    pnl32: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    lblHexRGB: TLabel;
    lblHex: TLabel;
    pnlColorAlphaW: TPanel;
    procedure ScrollBarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    function GetSolidColor : TColor;
    function GetAlphaColor : TRGBQuad;
    procedure pnlColorClick(Sender: TObject);
    procedure txtValueChange(Sender: TObject);
    procedure txtValueExit(Sender: TObject);
    procedure txtValueKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FHasAlpha: Boolean;
    FOnlyGrayScale: Boolean;
    procedure SetHasAlpha(const Value: Boolean);
    procedure SetAlphaColor(const Value: TRGBQuad);
    procedure SetSolidColor(const Value: TColor);
    procedure SetOnlyGrayScale(const Value: Boolean);
    type
    TcontrolsEntry = record
      scr: TVssScrollbar;
      lblCaption: Tlabel;
      txtValue : TEditNumeric;
      color : TColor;
    end;
    var
    { Private declarations }
    ctls: array[0..3] of TcontrolsEntry;
    procedure UpdateEditTxt;
    procedure UpdateImage;
    procedure UpdateConfig;
  public
    { Public declarations }
    property HasAlpha : Boolean read FHasAlpha write SetHasAlpha;
    property OnlyGrayScale : Boolean read FOnlyGrayScale write SetOnlyGrayScale;
    property SolidColor : TColor read GetSolidColor write SetSolidColor;
    property AlphaColor : TRGBQuad read GetAlphaColor write SetAlphaColor;
  end;
var
  VssColorPickerForm: TVssColorPickerForm;

implementation

{$R *.dfm}

procedure TVssColorPickerForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := Low(ctls) to High(ctls) do begin

    with ctls[i] do begin
      scr := TVssScrollbar.Create(self);
      scr.Parent := Self;

      scr.SetBounds(4,150 + i*25, 250, 10);
      scr.SliderLineHeight := 10;
      scr.Min := 0;
      scr.Max := 255;
      scr.Position := 255;
      scr.Enabled := true;
      scr.BringToFront;
      scr.OnChange := ScrollBarChange;
      scr.Tag := i;
      case i of
        0:
          color := clRed;
        1:
          color := clLime;
        2:
          color := clBlue;
        3:
          color := clwhite;
      end;
      scr.ScrollButtonColor := color;
      scr.ScrollButtonDirectColor := True;

      txtValue := TEditNumeric.Create(self);
      txtValue.Parent := Self;
      txtValue.SetBounds(pnlColorSolid.Left,
                         scr.Top + (scr.Height - txtValue.Height) div 2
                         ,pnlColorSolid.Width, txtValue.Height );

      txtValue.SendToBack;
      txtValue.OnChange := txtValueChange;
      txtValue.OnExit := txtValueExit;
      txtValue.OnKeyUp := txtValueKeyUp;
      txtValue.Color := color;
      txtValue.Font.Color := clBlack;
      txtValue.Tag := i;

    end;

    FHasAlpha := False;
    FOnlyGrayscale := false;
    ModalResult := mrNone;
//    imgPreview.SetBounds(ctls[0].scr.Left ,20 + 4*20,
//                         200, 60 );
  end;
end;

procedure TVssColorPickerForm.FormShow(Sender: TObject);
begin
  lblHexRGB.Font.Style :=  lblHexRGB.Font.Style + [fsBold];
  UpdateConfig;
  UpdateImage;
  UpdateEditTxt;
end;

function TVssColorPickerForm.GetAlphaColor: TRGBQuad;
begin
  if FOnlyGrayscale then begin
    Result.rgbRed := ctls[0].scr.Position;
    Result.rgbGreen := ctls[0].scr.Position;
    Result.rgbBlue := ctls[0].scr.Position;
  end else begin
    Result.rgbRed := ctls[0].scr.Position;
    Result.rgbGreen := ctls[1].scr.Position;
    Result.rgbBlue := ctls[2].scr.Position;
  end;
  if FHasAlpha then
    Result.rgbReserved := ctls[3].scr.Position
  else
    Result.rgbReserved := 255;
end;

function TVssColorPickerForm.GetSolidColor: TColor;
var
  rgba : TRGBQuad;
begin
  rgba := AlphaColor;
  Result := RGB(rgba.rgbRed, rgba.rgbGreen, rgba.rgbBlue);
end;

procedure TVssColorPickerForm.pnlColorClick(Sender: TObject);
begin
  if Sender is Tpanel then begin
    SolidColor := (Sender as TPanel).Color;
  end;
end;

procedure TVssColorPickerForm.ScrollBarChange(Sender: TObject);
var i: integer;
begin
   if sender <> nil  then begin
      i := (sender as TVssScrollbar).Tag;
      with ctls[i] do begin
        txtValue.Text := inttostr(scr.Position);
      end;
   end;
   UpdateImage;
end;


procedure TVssColorPickerForm.SetAlphaColor(const Value: TRGBQuad);
var grayval : Integer;
begin
  if FOnlyGrayScale then begin
    grayval := (Value.rgbRed + Value.rgbGreen + Value.rgbBlue) div 3;
    ctls[0].scr.Position := grayval;
    ctls[1].scr.Position := grayval;
    ctls[2].scr.Position := grayval;
  end else begin
    ctls[0].scr.Position := Value.rgbRed;
    ctls[1].scr.Position := Value.rgbGreen;
    ctls[2].scr.Position := Value.rgbBlue;
  end;
  ctls[3].scr.Position := Value.rgbReserved;
end;

procedure TVssColorPickerForm.SetHasAlpha(const Value: Boolean);
begin
  if FHasAlpha <> Value then begin
    FHasAlpha := Value;
    UpdateConfig;
    UpdateImage;
  end
end;

procedure TVssColorPickerForm.SetOnlyGrayScale(const Value: Boolean);
begin
  if FOnlyGrayScale <> Value then begin
    FOnlyGrayScale := Value;
    UpdateConfig;
    UpdateImage;
  end;
end;

procedure TVssColorPickerForm.SetSolidColor(const Value: TColor);
var
  rgba : TRGBQuad;
  rgbCol : Tcolor;
begin
  rgbCol := ColorToRGB(Value);
  rgba.rgbRed := GetRValue(rgbCol);
  rgba.rgbGreen := GetGValue(rgbCol);
  rgba.rgbBlue := GetBValue(rgbCol);

  if not FHasAlpha then
    rgba.rgbReserved := 255
  else
    rgba.rgbReserved := ctls[3].scr.Position;
    
  AlphaColor := rgba;
end;

procedure TVssColorPickerForm.txtValueChange(Sender: TObject);
var value : integer;
begin
  if Sender is TEditNumeric then begin
    try
      with (Sender as TEditNumeric) do begin
        value := StrToInt(Text);
        ctls[Tag].scr.Position := value;
      end;
    except

    end;
  end;
end;

procedure TVssColorPickerForm.txtValueExit(Sender: TObject);
begin
  UpdateEditTxt;
end;

procedure TVssColorPickerForm.txtValueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i : Integer;
begin
   if sender <> nil  then begin
      i := (sender as TEditNumeric).Tag;
      with ctls[i] do begin
        if Key = VK_UP then
          ctls[i].scr.Position := ctls[i].scr.Position +1
        else if Key = VK_DOWN then
          ctls[i].scr.Position := ctls[i].scr.Position -1
      end;
   end;
end;

procedure TVssColorPickerForm.UpdateConfig;
var
  i: Integer;
  pnl : TPanel;
begin
  pnlColorAlphaB.Visible := FHasAlpha;
  pnlColorAlphaW.Visible := FHasAlpha;
  lblColorAlpha.Visible := FHasAlpha;
  with ctls[3] do begin
    scr.Visible := FHasAlpha;
    txtValue.Visible := FHasAlpha;
  end;

  for i := 0 to ControlCount - 1 do begin
    if controls[i] is TPanel then begin
      pnl := Controls[i] as TPanel;
      if Length(pnl.Name) <= 5 then begin
        if (
            (GetRValue(pnl.Color) <>  GetGValue(pnl.Color)) or
            (GetGValue(pnl.Color) <>  GetBValue(pnl.Color)) 
           ) and FOnlyGrayscale then begin
          pnl.Visible := False;
        end else begin
          pnl.Visible := True;
        end;
      end;
    end;
  end;

  with ctls[1] do begin
    scr.Visible := not FOnlyGrayscale;
    txtValue.Visible := not FOnlyGrayscale;
  end;
  with ctls[2] do begin
    scr.Visible := not FOnlyGrayscale;
    txtValue.Visible := not FOnlyGrayscale;
  end;

  with ctls[0] do begin
    if FOnlyGrayscale then begin
      scr.ScrollButtonColor := clWhite;
      txtValue.Color := clWhite;
    end else begin
      scr.ScrollButtonColor := clRed;
      txtValue.Color := clRed;
    end;
  end;
end;

procedure TVssColorPickerForm.UpdateEditTxt;
var i : Integer;
begin

  for i := Low(ctls) to High(ctls) do
    with ctls[i] do
      txtValue.Text := inttostr(scr.Position);
end;

procedure TVssColorPickerForm.UpdateImage;
var
  GrayAlpha, GrayAlphaInv : integer;
  rgba : TRGBQuad;
begin

  pnlColorSolid.Color := GetSolidColor;

  rgba := GetAlphaColor;
  GrayAlpha := rgba.rgbReserved;
  GrayAlphaInv := (255-GrayAlpha)*255;
  pnlColorAlphaB.Color := RGB( (rgba.rgbRed * GrayAlpha) div 255,
                              (rgba.rgbGreen * GrayAlpha) div 255,
                              (rgba.rgbBlue * GrayAlpha) div 255);

  pnlColorAlphaW.Color := RGB((rgba.rgbRed * GrayAlpha + GrayAlphaInv) div 255,
                              (rgba.rgbGreen * GrayAlpha + GrayAlphaInv) div 255,
                              (rgba.rgbBlue * GrayAlpha + GrayAlphaInv) div 255);

  if FHasAlpha then begin
    lblHexRGB.Caption := 'RGBA HEX:';
    lblHex.Caption :=   Format('%.2x %.2x %.2x %.2x',
                               [rgba.rgbRed,
                               rgba.rgbGreen,
                               rgba.rgbBlue,
                               GrayAlpha]);
  end else begin
    lblHexRGB.Caption := 'RGB HEX:';
    lblHex.Caption :=   Format('%.2x %.2x %.2x',
                               [rgba.rgbRed,
                               rgba.rgbGreen,
                               rgba.rgbBlue]);
  end;

end;

end.
