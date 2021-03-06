unit AutoselectEdits;

interface

uses
  Windows, Messages, Classes, Controls, StdCtrls, sEdit;
type
  TEditAutoselect = class(Tsedit)
  public
    constructor Create(AOwner: TComponent); override;
  private
    Firsttime : boolean;
    Allselected : boolean;
    lastX : integer;
    lastY : integer;

    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure DoEnter; override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  end;

  TEditNumeric = class(TEditAutoselect)
  private
    FAllowedchars: string;
    procedure SetAllowedchars(const Value: string);
  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure NewChar(var msg:TMessage); message WM_CHAR;
  public
    property Allowedchars : string read FAllowedchars write SetAllowedchars;
  end;

implementation

{ TEditAutoselect }

constructor TEditAutoselect.Create(AOwner: TComponent);
begin
  Firsttime := false;
  Allselected := false;
  inherited;
end;

procedure TEditAutoselect.DoEnter;
begin
  Firsttime := true;
  Allselected := false;
  inherited;
end;

procedure TEditAutoselect.KeyUp(var Key: Word; Shift: TShiftState);
begin
  Firsttime := false;
  Allselected := false;
  inherited;
end;

procedure TEditAutoselect.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Firsttime then begin
    self.SelectAll;
    Allselected := true;
  end;
  inherited;
end;
procedure TEditAutoselect.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Firsttime := false;
  Allselected := false;
  inherited;
end;

procedure TEditAutoselect.WMMouseMove(var Message: TWMMouseMove);
begin
  if Firsttime then begin
    lastX := message.XPos;
    lastY := message.YPos;
    Firsttime := false;
  end;

  if (not Allselected) or
     (((message.XPos - lastX) > 5) or  ((message.YPos - lastY)> 5)) then begin
    Allselected := false;
    inherited;
  end;

end;
procedure TEditNumeric.CreateParams(var Params: TCreateParams);
//const Alignments: array[TAlignment] of Longint =
//      (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);

  //Params.Style := Params.Style or ES_RIGHT; //or ES_NUMBER;

  //could be multiline with ES_MULTILINE
end;
procedure TEditNumeric.NewChar(var msg: TMessage);
var numberZero: integer;
begin
  msg.Result := 0;
  numberZero := integer('0');


    if (msg.WParam <> integer('-')) and
       ((msg.WParam < numberZero) or (msg.WParam > numberZero+9)) and
       (msg.WParam <> VK_BACK) and
       (pos(chr(msg.WParam),FallowedChars) <= 0)  then
      msg.wParam := 0;
  inherited;
end;


procedure TEditNumeric.SetAllowedchars(const Value: string);
begin
  FAllowedchars := Value;
end;

end.
