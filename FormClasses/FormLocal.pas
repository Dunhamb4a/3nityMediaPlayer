unit FormLocal;

interface

uses
  Classes, Forms, FormsFixed;

type
  TFormlocal = class(TForm)
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
  private
    { Private declarations }
    localized : boolean;
  protected
  public
    { Public declarations }
    procedure DoLocalize(); dynamic; //do localize of inherited forms
    procedure NotifyLocalize();
    procedure DoShow(); override;
  end;

implementation

constructor TFormlocal.Create(AOwner: TComponent);
begin
  localized := false;
  inherited;
end;
destructor TFormlocal.Destroy();
begin
  inherited;
end;

procedure TFormlocal.DoLocalize;
begin
  localized := true;
end;

procedure TFormlocal.DoShow;
begin
  if not localized then
    DoLocalize;
  inherited;
end;
procedure TFormlocal.NotifyLocalize;
begin
  if self.Visible then begin
    DoLocalize;
  end else begin
    localized := false;
  end;
end;

end.
