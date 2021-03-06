unit ufrmAudioEqu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,VssDockForm, ExtCtrls, sTrackBar, StdCtrls, sLabel,
  sCheckBox, Buttons, sBitBtn;

type
  TfrmAudioEqu = class(TVssDockForm)
    Equ0: TsTrackBar;
    Equ1: TsTrackBar;
    Equ2: TsTrackBar;
    Equ3: TsTrackBar;
    Equ4: TsTrackBar;
    Equ5: TsTrackBar;
    Equ6: TsTrackBar;
    Equ7: TsTrackBar;
    Equ8: TsTrackBar;
    Equ9: TsTrackBar;
    Label1: TsLabel;
    Label2: TsLabel;
    Label0: TsLabel;
    Label3: TsLabel;
    Label4: TsLabel;
    Label5: TsLabel;
    Label6: TsLabel;
    Label7: TsLabel;
    Label8: TsLabel;
    Label9: TsLabel;
    CheckActive: TsCheckBox;
    LabelP12dB: TsLabel;
    LabelM12dB: TsLabel;
    btnreset: TButton;
    procedure FormCreate(Sender: TObject);
    procedure EquMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure CheckActiveClick(Sender: TObject);
     procedure CalculeCommande(bcreate:boolean);
    procedure btnresetClick(Sender: TObject);
    procedure ResetAEEqu ;
    procedure RAZTrackBars;
    procedure FormHide(Sender: TObject);
    procedure EquChange(Sender: TObject);
    procedure EquKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Equ8MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ9MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ7MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ4MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ3MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ0MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Equ6MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure CreateEqu ;
  private
    { Private declarations }
    NotSendingCommand:boolean;
    _Equ0:real;
    _Equ1:real;
    _Equ2:real;
    _Equ3:real;
    _Equ4:real;
    _Equ5:real;
    _Equ6:real;
    _Equ7:real;
    _Equ8:real;
    _Equ9:real;

    chaineAE:string;

    timestart, timestop, timeelapsed : cardinal;
  public
    { Public declarations }
    procedure DoLocalize ; override;

  end;

var
  frmAudioEqu: TfrmAudioEqu;

implementation
uses locale, UfrmMain;
{$R *.dfm}

procedure TfrmAudioEqu.DoLocalize;
begin
  inherited;
  Font.Charset:=CurrentLocaleCharset;
  Caption:=LOCstr.AudioEqu;

end;

procedure TfrmAudioEqu.FormCreate(Sender: TObject);
begin
NotSendingCommand:=true;

equ0.OnMouseUp:= EquMouseUp;
equ1.OnMouseUp:= EquMouseUp;
equ2.OnMouseUp:= EquMouseUp;
equ3.OnMouseUp:= EquMouseUp;
equ4.OnMouseUp:= EquMouseUp;
equ5.OnMouseUp:= EquMouseUp;
equ6.OnMouseUp:= EquMouseUp;
equ7.OnMouseUp:= EquMouseUp;
equ8.OnMouseUp:= EquMouseUp;
equ9.OnMouseUp:= EquMouseUp;

equ0.OnKeyUp  := EquKeyUp;
equ1.OnKeyUp := EquKeyUp;
equ2.OnKeyUp := EquKeyUp;
equ3.OnKeyUp := EquKeyUp;
equ4.OnKeyUp := EquKeyUp;
equ5.OnKeyUp := EquKeyUp;
equ6.OnKeyUp := EquKeyUp;
equ7.OnKeyUp := EquKeyUp;
equ8.OnKeyUp := EquKeyUp;
equ9.OnKeyUp := EquKeyUp;
height:=208;
   width:=427;
end;

procedure TfrmAudioEqu.FormHide(Sender: TObject);
begin
   // frmMain.MStreamInfo.Checked:=False;
  frmMain.BAudioEqu.Down :=False;
end;

procedure TfrmAudioEqu.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
timestop := GetTickCount;
timeelapsed := timestop - timestart; //milliseconds
if (timeelapsed>120) then
          CalculeCommande(false);
end;

procedure TfrmAudioEqu.CheckActiveClick(Sender: TObject);
begin
if checkactive.Checked then
begin
  equ0.Enabled:=true;
  equ1.Enabled:=true;
  equ2.Enabled:=true;
  equ3.Enabled:=true;
  equ4.Enabled:=true;
  equ5.Enabled:=true;
  equ6.Enabled:=true;
  equ7.Enabled:=true;
  equ8.Enabled:=true;
  equ9.Enabled:=true;
  
  CalculeCommande(true);
end
else
begin
  equ0.Enabled:=false;
  equ1.Enabled:=false;
  equ2.Enabled:=false;
  equ3.Enabled:=false;
  equ4.Enabled:=false;
  equ5.Enabled:=false;
  equ6.Enabled:=false;
  equ7.Enabled:=false;
  equ8.Enabled:=false;
  equ9.Enabled:=false;

  //frmmain.mpo.Params :='';
if NotSendingCommand then
 begin
   ResetAEEqu;
 end;
end;
end;

procedure TfrmAudioEqu.EquKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
CalculeCommande(false);
end;

procedure TfrmAudioEqu.Equ0MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ0.Focused  then
   equ0.SetFocus;
end;

procedure TfrmAudioEqu.Equ1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ1.Focused  then
   equ1.SetFocus;
end;

procedure TfrmAudioEqu.Equ2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ2.Focused  then
   equ2.SetFocus;
end;

procedure TfrmAudioEqu.Equ3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ3.Focused  then
   equ3.SetFocus;
end;

procedure TfrmAudioEqu.Equ4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ4.Focused  then
   equ4.SetFocus;
end;

procedure TfrmAudioEqu.Equ5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ5.Focused  then
   equ5.SetFocus;
end;



procedure TfrmAudioEqu.Equ6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
        if not equ6.Focused  then
   equ6.SetFocus;
end;

procedure TfrmAudioEqu.Equ7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ7.Focused  then
   equ7.SetFocus;
end;

procedure TfrmAudioEqu.Equ8MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if not equ8.Focused  then
   equ8.SetFocus;
end;

procedure TfrmAudioEqu.Equ9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if not equ9.Focused  then
   equ9.SetFocus;
end;

procedure TfrmAudioEqu.EquChange(Sender: TObject);
begin
CalculeCommande(false);
end;

procedure TfrmAudioEqu.EquMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
CalculeCommande(false);

end;
procedure TfrmAudioEqu.btnresetClick(Sender: TObject);
begin
if  NotSendingCommand then
 begin
   ResetAEEqu;
   RAZTrackBars;
 end;
end;



procedure TfrmAudioEqu.CalculeCommande(bcreate:boolean);
begin
  if  NotSendingCommand then
 begin
 NotSendingCommand:=false;
 timestart := GetTickCount;
    if equ0.Position<0 then
    _Equ0:=Abs(equ0.Position)
    else
    _Equ0:=-Abs(equ0.Position);

    if equ1.Position<0 then
    _Equ1:=Abs(equ1.Position)
    else
    _Equ1:=-Abs(equ1.Position);

    if equ2.Position<0 then
    _Equ2:=Abs(equ2.Position)
    else
    _Equ2:=-Abs(equ2.Position);

    if equ3.Position<0 then
    _Equ3:=Abs(equ3.Position)
    else
    _Equ3:=-Abs(equ3.Position);

    if equ4.Position<0 then
    _Equ4:=Abs(equ4.Position)
    else
    _Equ4:=-Abs(equ4.Position);

    if equ5.Position<0 then
    _Equ5:=Abs(equ5.Position)
    else
    _Equ5:=-Abs(equ5.Position);

    if equ6.Position<0 then
    _Equ6:=Abs(equ6.Position)
    else
    _Equ6:=-Abs(equ6.Position);

    if equ7.Position<0 then
    _Equ7:=Abs(equ7.Position)
    else
    _Equ7:=-Abs(equ7.Position);

    if equ8.Position<0 then
    _Equ8:=Abs(equ8.Position)
    else
    _Equ8:=-Abs(equ8.Position);

    if equ9.Position<0 then
    _Equ9:=Abs(equ9.Position)
    else
    _Equ9:=-Abs(equ9.Position);

_Equ0:=_Equ0/10;
_Equ1:=_Equ1/10;
_Equ2:=_Equ2/10;
_Equ3:=_Equ3/10;
_Equ4:=_Equ4/10;
_Equ5:=_Equ5/10;
_Equ6:=_Equ6/10;
_Equ7:=_Equ7/10;
_Equ8:=_Equ8/10;
_Equ9:=_Equ9/10;



// formatfloat('0.####',value)
//FloatToStrF(amount1, ffgeneral, 4, 4));
chaineAE:=FloatToStrF(_Equ0, ffgeneral, 4, 1)+':'+FloatToStrF(_Equ1, ffgeneral, 4, 1)+':'+FloatToStrF(_Equ2, ffgeneral, 4, 1)+
':'+FloatToStrF(_Equ3, ffgeneral, 4, 1)+':'+FloatToStrF(_Equ4, ffgeneral, 4, 1)+':'+FloatToStrF(_Equ5, ffgeneral, 4, 1)+
':'+FloatToStrF(_Equ6, ffgeneral, 4, 1)+':'+FloatToStrF(_Equ7, ffgeneral, 4, 1)+':'+FloatToStrF(_Equ8, ffgeneral, 4, 1)+':'+FloatToStrF(_Equ9, ffgeneral, 4, 1)  ;

try
if bcreate then
begin
  frmmain.mpo.sendae(chaineAE);
  frmmain.mpo.sendae2(chaineAE);
end
else
begin
  frmmain.mpo.sendae2(chaineAE);
end;

NotSendingCommand:=true;

except
NotSendingCommand:=true;
end;

 end;
end;
procedure TfrmAudioEqu.ResetAEEqu ;
begin
 frmmain.mpo.sendae2('0:0:0:0:0:0:0:0:0:0');

end;
procedure TfrmAudioEqu.CreateEqu ;
begin
 frmmain.mpo.sendae('0:0:0:0:0:0:0:0:0:0');

end;
procedure TfrmAudioEqu.RAZTrackBars;
begin
 equ0.Position:=0;
 equ1.Position:=0;
 equ2.Position:=0;
 equ3.Position:=0;
 equ4.Position:=0;
 equ5.Position:=0;
 equ6.Position:=0;
 equ7.Position:=0;
 equ8.Position:=0;
 equ9.Position:=0;
end;

end.
