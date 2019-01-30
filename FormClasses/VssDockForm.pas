unit VssDockForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, 
  VssList, Formlocal;

type

  TVssDockForm = class;   // forward declarations
  TVssDockFormList = class;

  TVssDockedStyle = record
    DockLR : integer;
    DockTB : integer;
    DockPos : integer;
    DockForm : TVssDockForm;

    RelX : Integer;
    RelY : Integer;
    Width : Integer;
    Height : Integer;

    LinkSize : Boolean;
    SetSize : Boolean;
  end;

  TVssDockForm = class(TFormLocal)
  private
    { Private declarations }
    FDocking : boolean;
    LastDockedForm : TVssDockForm;
    FormList : TVssDockFormList;

    IsUserMoving : Boolean;
    procedure WmEnterSizeMove(var Msg : TMsg); message WM_ENTERSIZEMOVE;
    procedure WmExitSizeMove(var Msg : TMsg); message WM_EXITSIZEMOVE;
    procedure WmWindowposChanging(var Msg: TWMWINDOWPOSCHANGING) ; message WM_WINDOWPOSCHANGING;
    procedure WmWindowposChanged(var Msg: TWMWINDOWPOSCHANGED); message WM_WINDOWPOSCHANGED;

    function CheckWindowDocking(pWp: PWindowPos;sizing : boolean; Moving : boolean;DockDist : integer): boolean;

    procedure UpdateDockedWindows();
    function IsFormMovingWithMe(f : TVssDockForm) : boolean;
  public
    { Public declarations }
    Dock :  TVssDockedStyle;
    MasterForm : boolean;
    constructor Create(AOwner: TComponent); override;
    function GetWindowPositionString : string;
    function SetWindowPositionString( value : string): boolean;
    procedure DockTo();
  end;


  TVssDockFormList = class(TVssList)
  protected
    function GetItems(Index: Integer): TVssDockForm;
    procedure SetItems(Index: Integer; item: TVssDockForm);
  public
    destructor Destroy; override;
    function Add(Item: TVssDockForm): Integer;
    procedure Delete(index: integer); Override;
    function Remove(Item: TVssDockForm): Integer;
    procedure Insert(index: integer; item: TVssDockForm);
    function IndexOf(itemName : string) : Integer; overload;
    function GetMaster() : TVssDockForm;
    procedure Clear();
    property Items[Index: Integer]: TVssDockForm read GetItems write SetItems; default;
    procedure SetAllWindowsPos(sl : TStringList);
    procedure GetAllWindowsPos(sl : TStringList);
  end;


implementation

const
  DOCKDIST_A : integer = 15;

  DOCK_SF_FORM = 'F';
  DOCK_SF_LR = 'LR';
  DOCK_SF_TB = 'TB';
  DOCK_SF_POS = 'P';

  DOCK_SF_RX = 'RX';
  DOCK_SF_RY = 'RY';

  DOCK_SF_W = 'W';
  DOCK_SF_H = 'H';

  DOCK_SF_LS = 'LS';

  DOCK_SF_VALUE_DELIMITER = ':';
  DOCK_SF_FIELD_DELIMITER = ',';


constructor TVssDockForm.Create(AOwner: TComponent);
begin
  FDocking := False;
  MasterForm := False;
  Dock.LinkSize := False;
  Dock.DockForm := nil;
  Dock.DockLR := 0;
  Dock.DockTB := 0;
  Dock.DockPos := 0;
  Dock.RelX := 0;
  Dock.RelY := 0;
  Dock.Width := 0;
  Dock.Height := 0;
  Dock.SetSize := False;
  FormList := nil;
  IsUserMoving := False;
  inherited;
end;

procedure TVssDockForm.DockTo;
var
   wP : array[0..1] of integer;
   wW : array[0..1] of integer;

   dwP : array[0..1] of integer;
   dwW : array[0..1] of integer;

   ds : array[0..1] of integer;
   d : integer;
   mf : TVssDockForm;
begin
  HandleNeeded;
  if (Dock.Width <= 0) or (not Dock.SetSize) then
    Dock.Width := Width;
  if (Dock.Height <= 0) or (not Dock.SetSize) then
    Dock.Height := Height;

  if (Dock.DockForm <> nil) and( (Dock.DockLR <> 0) or (Dock.DockTB <> 0)) then begin

    ds[0] := Dock.DockLR;
    ds[1] := Dock.DockTB;

    wP[0] := Left;
    wP[1] := Top;
    wW[0] := Dock.Width;
    wW[1] := Dock.Height;
    with Dock.DockForm do begin
      dwP[0] := Left;
      dwP[1] := Top;
      dwW[0] := Width;
      dwW[1] := Height;
    end;


    for d := 0 to 1 do begin
      case ds[d] of
        -2:
           wP[d] := dwP[d] - wW[d];
        -1: begin
           wP[d] := dwP[d];
           if Dock.LinkSize then begin
             wW[d] := dwW[d];
           end;
        end;
        1:
           wP[d] := dwP[d] + dwW[d] - wW[d];
        2:
           wP[d] := dwP[d] + dwW[d];
        else
          wP[d] := dwP[d] + Dock.DockPos;
      end;
    end;
    

    FDocking := True;
    
    SetBounds(wP[0], wP[1],wW[0],wW[1]);
    FDocking := False;
  end else begin
    mf := FormList.GetMaster;
    if mf <> nil then begin   // set position and size
      setbounds(mf.Left+ Dock.RelX, mf.Top + Dock.RelY, Dock.Width, Dock.Height);
    end else begin // set only size
      SetBounds(Left,top,Dock.Width, Dock.Height);
    end;
  end;
end;

function TVssDockForm.GetWindowPositionString: string;
  procedure AddStr( field: string ; value : integer);
  begin
    if Result <> '' then
      Result := Result + DOCK_SF_FIELD_DELIMITER;

    Result := Result + field + DOCK_SF_VALUE_DELIMITER + IntToStr(value);
  end;
var
  mf : TVssDockForm;
  intValue : Integer;
begin

  Dock.Width := Width;
  Dock.Height := Height;

  mf := FormList.GetMaster;
  if mf <> nil then begin
    Dock.RelX := Left - mf.Left;
    Dock.RelY := Top - mf.Top;
  end else begin
    Dock.RelX := 0;
    Dock.RelY := 0;
  end;

  Result := '';
  Result := DOCK_SF_FORM + DOCK_SF_VALUE_DELIMITER;
  if (Dock.DockForm <>nil) and (FormList <> nil) then begin
    Result := Result + Dock.DockForm.Name;
  end;

  AddStr(DOCK_SF_LR, Dock.DockLR);
  AddStr(DOCK_SF_TB, Dock.DockTB);
  AddStr(DOCK_SF_POS, Dock.DockPos);
  AddStr(DOCK_SF_RX, Dock.RelX);
  AddStr(DOCK_SF_RY, Dock.RelY);
  AddStr(DOCK_SF_W, Dock.Width);
  AddStr(DOCK_SF_H, Dock.Height);

  intValue := 0;
  if Dock.LinkSize then
    intValue := 1;
  AddStr(DOCK_SF_LS, intValue);
end;

function TVssDockForm.SetWindowPositionString(value: string): boolean;
var
  sl,vl : TstringList;
  i,intValue, f : integer;
  fName : string;
begin
  result := false;

  sl := Tstringlist.Create;
  sl.Delimiter := DOCK_SF_FIELD_DELIMITER;
  sl.DelimitedText := value;

  vl := TStringList.Create;
  vl.Delimiter := DOCK_SF_VALUE_DELIMITER;

  if sl.Count >= 1 then begin
    for I := 0 to sl.Count - 1 do begin
      vl.Clear;
      vl.DelimitedText := sl[i];
      if vl.Count = 2 then begin
        try
          intValue := StrToInt(vl[1]);
        except
          intValue := 0;
        end;
        fName := vl[0];

        if fName = DOCK_SF_FORM then begin
            dock.DockForm := nil;
            f := FormList.IndexOf(vl[1]);
            if f >= 0 then
              Dock.DockForm := FormList[f];
        end else if fName = DOCK_SF_LR then begin
          dock.DockLR := intValue;
        end else if fName = DOCK_SF_TB then begin
          dock.DockTB := intValue;
        end else if fName = DOCK_SF_POS then begin
          dock.DockPos := intValue;
        end else if fName = DOCK_SF_RX then begin
          Dock.RelX := intValue;
        end else if fName = DOCK_SF_RY then begin
          Dock.RelY := intValue;
        end else if fName = DOCK_SF_W then begin
          Dock.Width := intValue;
        end else if fName = DOCK_SF_H then begin
          Dock.Height := intValue;
        end else if fName = DOCK_SF_LS then begin
          Dock.LinkSize := intValue <> 0;
        end;
      end;
    end;
  end;
  FreeAndNil(vl);
  FreeAndNil(sl);
end;

function TVssDockForm.IsFormMovingWithMe(f: TVssDockForm) : boolean;
var i: integer;
begin
  i := 0;
  Result := false;
  while f <> nil  do begin

    if f.Dock.DockForm = self then begin
      Result := not f.MasterForm;
      break;
    end else begin
      f := f.Dock.DockForm;
    end;
    Inc(i);
    if i > screen.FormCount then // something went wrong
      Break;
  end;
end;

procedure TVssDockForm.UpdateDockedWindows;
var
  f : integer;
begin
  for f := 0 to FormList.Count - 1 do begin
    if FormList[f] <> self then
      if FormList[f].Dock.DockForm = self then
        FormList[f].DockTo;
  end;
end;


procedure TVssDockForm.WmEnterSizeMove(var Msg: TMsg);
begin
  LastDockedForm := nil;
  IsUserMoving := True;
  inherited;
end;

procedure TVssDockForm.WmExitSizeMove(var Msg: TMsg);
var
  wp : TwindowPos;
begin

  if(Dock.DockLR<> 0) or
    (Dock.DockTB<> 0) then begin

    if LastDockedForm <> nil then
      if MasterForm then begin
        if LastDockedForm.CheckWindowDocking(addr(wp) ,false, false,0) then
          LastDockedForm.SetBounds(wp.x, wp.y, wp.cx, wp.cy);
      end else begin
        if Dock.LinkSize then
          DockTo;
      end;
  end;
  IsUserMoving := false;
  inherited;
end;

procedure TVssDockForm.WmWindowposChanged(var Msg: TWMWINDOWPOSCHANGED);
begin
  inherited;
  if FormList = nil then exit;
  
  if ((msg.WindowPos.flags and SWP_NOSIZE)= 0) OR
     ((msg.WindowPos.flags and SWP_NOMOVE)= 0) then begin
     UpdateDockedWindows();
     Dock.Width := Width;
     Dock.Height := Height;
  end;
end;

procedure TVssDockForm.WmWindowposChanging(var Msg: TWMWINDOWPOSCHANGING);
var
   Moving : boolean;
   Sizing : boolean;
begin
  Sizing := (msg.WindowPos.flags and SWP_NOSIZE)= 0;
  Moving := (msg.WindowPos.flags and SWP_NOMOVE)= 0;
  if Moving or Sizing then begin
    CheckWindowDocking(msg.WindowPos,Sizing,Moving,DOCKDIST_A);
  end;
  inherited;
end;


function TVssDockForm.CheckWindowDocking(pWp: PWindowPos; sizing : boolean; Moving : boolean;DockDist : integer) : boolean;
  function OverlapPoints(P11: Integer; P12:integer;P21: Integer; P22:integer) : integer;
  var
    L : integer;
    R : integer;
  begin
    if P11 > P21 then
      L := P11
    else
      L := P21;

    if P12 < P22 then
      R := P12
    else
      R := P22;

    Result := R-L;
  end;
var
  rWorkArea: TRect;

  dP1 : integer;
  dP2 : integer;

  DockP : array[0..1] of integer;
  wP : array[0..1] of integer;
  wW : array[0..1] of integer;
  oP: array[0..1] of integer;

  d : integer; // dimension, 0-x or 1-y
  f : Integer; // form index
  i : Integer; // distance loop
  minDist: integer; // minimum distance

  dist : array[-2..2] of integer;

begin
  Result := false;

  if FDocking then exit;
  if (not IsUserMoving) and (DockDist <> 0) then Exit;  
  if FormList = nil  then exit;
  

  Dock.DockLR:=0;
  Dock.DockTB:=0;
  Dock.DockPos := 0;
  Dock.DockForm := nil;


  //self.Caption := inttostr(pWp.x) + ' - ' + inttostr(pWp.y);

  for f := 0 to FormList.Count - 1 do begin

    if (FormList[f] <> self) and FormList[f].Visible and
      (FormList[f].Dock.DockForm <> self) and
      (not IsFormMovingWithMe(FormList[f])) and
      ((FormList[f].MasterForm) or (DockDist > 0))  then begin

      rWorkArea := Rect(FormList[f].Left,
                        FormList[f].Top,
                        FormList[f].Left + FormList[f].Width,
                        FormList[f].Top  + FormList[f].Height);

      for d := 0 to 1 do begin

        if d = 0 then begin
          if Moving then
            wP[d] := pWp.x
          else
            wP[d] := self.Left;

          if Sizing then
            wW[d] := pWp.cx
          else
            wW[d] := self.Width;

          dP1 := rWorkArea.Left;
          dP2 := rWorkArea.Right;
        end else begin
          if Moving then
            wP[d] := pWp.y
          else
            wP[d] := self.Top;

          if Sizing then
            wW[d] := pWp.cy
          else
            wW[d] := self.Height;

          dP1 := rWorkArea.Top;
          dP2 := rWorkArea.Bottom;
        end;
        DockP[d] := 0;

        if wW[d] > 0 then begin

          oP[d] := OverlapPoints(dP1,dP2,wP[d], wP[d]+wW[d]);

          dist[-2] := abs(wP[d] + wW[d] - dP1);
          dist[-1] := abs(wP[d] - dP1);
          dist[1]  := abs(wP[d] + wW[d] - dP2);
          dist[2]  := abs(wP[d] - dP2);

          MinDist := DOCKDIST+1;
          for i := -2 to 2 do begin
            if i <> 0 then begin
              if dist[i] < MinDist then begin
                MinDist := dist[i];
                DockP[d] := i;
              end;
            end;
          end;

          case DockP[d] of
            -2:
              wP[d] := dP1 -wW[d];
            -1:
              wP[d] := dP1;
            1:
              wP[d] := dP2 - wW[d];
            2:
              wP[d] := dP2;
          end;

        end;
      end;


      if ((DockP[0] <> 0) and (oP[1] > DOCKDIST)) or
         ((DockP[1] <> 0) and (oP[0] > DOCKDIST)) then begin // dock if near and overlapped
        if (oP[0] <= DOCKDIST) or (oP[1] <= DOCKDIST) then begin // dock only by outside

          Result := true;
          pWp.x := wP[0];
          pWp.y := wP[1];
          pWp.cx := wW[0];
          pWp.cy := wW[1];

          if not MasterForm then
            Dock.DockForm := FormList[f];

          LastDockedForm := FormList[f] ;

          Dock.DockLR:=DockP[0];
          Dock.DockTB:=DockP[1];
          if DockP[0] = 0 then
            Dock.DockPos := wP[0] -  FormList[f].left;
          if DockP[1] = 0 then
            Dock.DockPos := wP[1] -  FormList[f].top;


          if (DockP[0]<>0) and (DockP[1]<>0) then
            Break;
        end;
      end;
    end;
  end;
end;

{ TVssDockFormList }

function TVssDockFormList.Add(Item: TVssDockForm): Integer;
begin
  Result := inherited Add(Item);
  Item.FormList := self;
end;

procedure TVssDockFormList.Clear;
var i : integer;
begin
  for i := 0 to Count - 1 do begin
    Items[i].FormList := nil;
  end;
  inherited;
end;

procedure TVssDockFormList.Delete(index: integer);
begin
  Items[index].FormList := nil;
  inherited;
end;

destructor TVssDockFormList.Destroy;
begin
  Clear;
  inherited;
end;

function TVssDockFormList.GetItems(Index: Integer): TVssDockForm;
begin
  Result := TVssDockForm(inherited GetItems(Index));
end;

function TVssDockFormList.GetMaster: TVssDockForm;
var
  i : integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].MasterForm then begin
      Result :=  Items[I];
      break;
    end;
end;

function TVssDockFormList.IndexOf(itemName: string): Integer;
var
  i : integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].Name = itemName then begin
      Result := I;
      break;
    end;
end;

procedure TVssDockFormList.Insert(index: integer; item: TVssDockForm);
begin
  inherited Insert(index,Item);
  Item.FormList := self;
end;

function TVssDockFormList.Remove(Item: TVssDockForm): Integer;
begin
  Result := inherited Remove(Item);
end;

procedure TVssDockFormList.SetItems(Index: Integer; item: TVssDockForm);
begin
  inherited SetItems(Index,item);
end;


procedure TVssDockFormList.SetAllWindowsPos(sl: TStringList);
var
  i,f: integer;
  vsl : TStringList;
begin
  vsl := TStringList.Create;
  vsl.Delimiter := '=';
  for i := 0 to sl.Count  - 1 do begin
    vsl.Clear;
    vsl.DelimitedText := sl[i];
    if vsl.Count >= 2 then begin
      f := IndexOf(vsl[0]);
      if f >= 0 then begin
        try
        Items[f].SetWindowPositionString(vsl[1]);
        except

        end;
        //Items[f].SetWindowPositionString(vsl[1]);
      end;
    end;
  end;
  FreeAndNil(vsl);
end;

procedure TVssDockFormList.GetAllWindowsPos(sl : TStringList);
var
  i: integer;
begin
  sl.Clear;
  for i := 0 to Count  - 1 do begin
    sl.Add(Items[i].Name + '=' + Items[i].GetWindowPositionString  );
  end;
end;



end.
