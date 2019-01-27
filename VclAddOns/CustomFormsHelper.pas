unit CustomFormsHelper;

interface
uses Forms;

type
  TVsCustomFormHelper = class helper for TCustomForm
    private
      procedure SetWindowParent(const Value: TCustomForm);
      function GetWindowParent() : TCustomForm;
    public
      property WindowParent : TCustomForm read GetWindowParent write SetWindowParent;
      function GetMonitorIndex(MonitorNum : integer) : integer;
  end;

implementation

{ TMyClassHelper }

function TVsCustomFormHelper.GetMonitorIndex(MonitorNum: integer): integer;
var i : integer;
begin
     Result := -1;
     for  I:= 0 to screen.MonitorCount - 1 do begin
      if screen.Monitors[I].MonitorNum = MonitorNum then begin
          Result := I;
          break;
      end;
     end;
end;

function TVsCustomFormHelper.GetWindowParent: TCustomForm;
begin
  Result := PopupParent;
end;

procedure TVsCustomFormHelper.SetWindowParent(const Value: TCustomForm);
begin
  PopupMode := pmExplicit;
  PopupParent := Value;
end;

end.

