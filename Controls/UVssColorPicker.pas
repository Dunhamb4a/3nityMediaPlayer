unit UVssColorPicker;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls;

type
  TVssColorPicker = class(TFrame)
    shpColorSolid: TShape;
    lblColor: TLabel;
    shpColorAlphaB: TShape;
    shpColorAlphaW: TShape;
    procedure FrameResize(Sender: TObject);
    procedure shpColorSolidMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblColorClick(Sender: TObject);
  private
    { Private declarations }
    FOnChange: TNotifyEvent;
    FAlphaColor: TRGBQuad;
    FHasAlpha: Boolean;
    FOnlyGrayScale: Boolean;
    procedure UpdateImage;
    procedure UpdateConfig;
    procedure SetSolidColor(const Value: TColor);
    procedure SetAlphaColor(Value: TRGBQuad);
    function GetSolidColor: TColor;
    function GetAlphaColor: TRGBQuad;
    procedure SetHasAlpha(const Value: Boolean);
    procedure SetOnlyGrayScale(const Value: Boolean);
  protected
    procedure Change; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    function GetColorAsHexString : string;
    function GetColorAsRGBString : string;
  published
    property HasAlpha : Boolean read FHasAlpha write SetHasAlpha;
    property OnlyGrayScale : Boolean read FOnlyGrayScale write SetOnlyGrayScale;
    property SolidColor : TColor read GetSolidColor write SetSolidColor;
    property AlphaColor : TRGBQuad read GetAlphaColor write SetAlphaColor;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation
uses UVssColorpickerForm;

{$R *.dfm}

procedure TVssColorPicker.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

constructor TVssColorPicker.Create(AOwner: TComponent);
begin
  inherited;
  FAlphaColor.rgbRed := 0;
  FAlphaColor.rgbGreen := 0;
  FAlphaColor.rgbBlue := 0;
  FAlphaColor.rgbReserved := 0;
  FHasAlpha := False;
  FOnlyGrayScale := False;
  UpdateConfig;
  //UpdateImage;
end;

procedure TVssColorPicker.FrameResize(Sender: TObject);
begin
  UpdateConfig;
end;

function TVssColorPicker.GetColorAsRGBString: string;
begin
  if FOnlyGrayScale then
    Result := Format('%.3d',
                                 [FAlphaColor.rgbRed])
  else
    Result := Format('R: %.3d  G: %.3d  B: %.3d',
                                 [FAlphaColor.rgbRed,
                                 FAlphaColor.rgbGreen,
                                 FAlphaColor.rgbBlue]);
  if FHasAlpha then
    Result := Result + Format(' A: %.3d',[FAlphaColor.rgbReserved]);
end;

function TVssColorPicker.GetSolidColor: TColor;
var
  rgba : TRGBQuad;
begin
  rgba := AlphaColor;
  Result := RGB(rgba.rgbRed, rgba.rgbGreen, rgba.rgbBlue);
end;

function TVssColorPicker.GetAlphaColor: TRGBQuad;
var
  grayval : Integer;
begin
  Result := FAlphaColor;
  if not FHasAlpha then
    Result.rgbReserved := 255;
  if FOnlyGrayScale then begin
    grayval := (Result.rgbRed + Result.rgbGreen + Result.rgbBlue) div 3;
    Result.rgbRed := grayval;
    Result.rgbGreen := grayval;
    Result.rgbBlue := grayval;
  end;
end;

function TVssColorPicker.GetColorAsHexString: string;
begin
  Result := Format('%.2x%.2x%.2x',
                                 [FAlphaColor.rgbRed,
                                 FAlphaColor.rgbGreen,
                                 FAlphaColor.rgbBlue])
end;

procedure TVssColorPicker.lblColorClick(Sender: TObject);
  function FindOwnerForm : TForm;
  var
    comp : TComponent;
  begin
    comp := self;
    repeat
      comp := comp.Owner;
    until (comp = nil) or (comp is TForm);
    if comp = nil then
      Result := nil
    else
      Result := TForm(comp);
  end;
  var cp : TVssColorPickerForm;
begin
  cp := nil;
  try
    cp := TVssColorPickerForm.Create(FindOwnerForm);
    cp.AlphaColor := AlphaColor;
    cp.HasAlpha := FHasAlpha;
    cp.OnlyGrayScale := FOnlyGrayScale;
    cp.PopupMode := pmAuto;

    if cp.ShowModal = mrOk then
      AlphaColor := cp.AlphaColor;
  except
  end;
  FreeAndNil(cp);
end;

procedure TVssColorPicker.SetAlphaColor( Value: TRGBQuad);
var grayval : Integer;
begin

  if FOnlyGrayScale then begin
    grayval := (Value.rgbRed + Value.rgbGreen + Value.rgbBlue) div 3;
    Value.rgbRed := grayval;
    Value.rgbGreen := grayval;
    Value.rgbBlue := grayval;
  end;
  if not FHasAlpha then
    Value.rgbReserved := 255;

  if (FAlphaColor.rgbRed <> Value.rgbRed) or
     (FAlphaColor.rgbGreen <> Value.rgbGreen) or
     (FAlphaColor.rgbBlue <> Value.rgbBlue) or
     (FAlphaColor.rgbReserved <> Value.rgbReserved) then begin

    FAlphaColor := Value;
    UpdateImage;
    Change;
  end;
end;

procedure TVssColorPicker.SetHasAlpha(const Value: Boolean);
begin
  if FHasAlpha <> Value then begin
    FHasAlpha := Value;
    UpdateConfig;
    SolidColor := GetSolidColor;
  end;
end;

procedure TVssColorPicker.SetOnlyGrayScale(const Value: Boolean);
begin
  if FOnlyGrayScale <> Value then begin
    FOnlyGrayScale := Value;
    UpdateConfig;
    SolidColor := GetSolidColor;
  end;
end;

procedure TVssColorPicker.SetSolidColor(const Value: TColor);
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
    rgba.rgbReserved := FAlphaColor.rgbReserved;

  AlphaColor := rgba;
end;

procedure TVssColorPicker.shpColorSolidMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  lblColorClick(Sender);
end;


procedure TVssColorPicker.UpdateConfig;
var
  lblLeft , shpLeft, shpTop : Integer;
begin
  shpColorAlphaB.Visible := FHasAlpha;
  shpColorAlphaW.Visible := FHasAlpha;

  if FHasAlpha then begin
    shpColorSolid.SetBounds(0,0,ClientHeight div 2,ClientHeight);
    shpLeft := shpColorSolid.Left + shpColorSolid.Width;
    shpColorAlphaB.SetBounds(shpLeft-1,0,ClientHeight div 2 ,ClientHeight div 2);
    shpTop := shpColorAlphaB.Top + shpColorAlphaB.Height;

    shpColorAlphaW.SetBounds(shpColorAlphaB.Left, shpTop-1 ,
                             shpColorAlphaB.Width, ClientHeight - (shpTop-1) );

    lblLeft := shpColorAlphaB.Left;
  end else begin
    shpColorSolid.SetBounds(0,0,ClientHeight,ClientHeight);
    lblLeft := shpColorSolid.Left;
  end;

  lblLeft := lblLeft+(ClientHeight*3) div 2;
  lblColor.SetBounds(lblLeft,0,ClientWidth - lblLeft ,ClientHeight);
  UpdateImage;
end;

procedure TVssColorPicker.UpdateImage;
var
  GrayAlpha, GrayAlphaInv : integer;
begin
  shpColorSolid.Brush.Color := SolidColor;
  lblColor.Caption := GetColorAsRGBString;
  GrayAlpha := FAlphaColor.rgbReserved;
  GrayAlphaInv := (255-GrayAlpha)*255;

  shpColorAlphaB.Brush.Color := RGB( (FAlphaColor.rgbRed * GrayAlpha) div 255,
                              (FAlphaColor.rgbGreen * GrayAlpha) div 255,
                              (FAlphaColor.rgbBlue * GrayAlpha) div 255);

  shpColorAlphaW.Brush.Color := RGB(
                    (FAlphaColor.rgbRed * GrayAlpha + GrayAlphaInv) div 255,
                    (FAlphaColor.rgbGreen * GrayAlpha + GrayAlphaInv) div 255,
                    (FAlphaColor.rgbBlue * GrayAlpha + GrayAlphaInv) div 255);
  //shpColorAlpha.Brush.Color := FAlphaColor.rgbRed
end;

end.
