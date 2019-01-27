unit FormsFixed;

interface

uses
  Messages,Classes,Controls, Forms;


type
  TForm = class(Forms.TForm)

  private
    { Private declarations }
  protected
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
  public
    { Public declarations }
  end;

implementation


{ TForm }

procedure TForm.CMShowingChanged(var Message: TMessage);
var parentForm : TCustomForm;
begin
  if not (csDesigning in ComponentState) and (fsShowing in FFormState) then begin
    inherited;
    // this will raise exception in inherited code
  end else begin
    if not (csDesigning in ComponentState) then
    begin
      if not Showing then
      begin
        if (FormStyle <> fsMDIChild) and not(fsModal in FFormState) then
        begin
          inherited;
          // try to bringtofront parent form
          parentForm := nil;
          if PopupMode = pmExplicit then
            parentForm := PopupParent;
          if PopupMode = pmAuto then
            parentForm := Application.MainForm;

          if parentForm <> nil then begin
            parentForm.BringToFront;
          end;
          Exit;
        end;
      end;
    end;
    inherited;
  end;

end;



end.
