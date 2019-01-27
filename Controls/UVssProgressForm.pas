unit UVssProgressForm;

interface

uses
  Classes, Controls, Forms,
  ComCtrls, StdCtrls;

type
  TVssProgressForm = class(TForm)
    btnCancel: TButton;
    lblInfo: TLabel;
    pbProgress: TProgressBar;

    procedure btnCancelClick(Sender: TObject);
  private
    FCanceled: boolean;

    function GetInfoText: string;
    procedure SetInfoText(const Value: string);
    procedure SetPercent(const Value: integer);
    function GetPercent: integer;
    { Private declarations }

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create( AOwner: TComponent;
                        FormCaption : string;
                        InitialInfo : string;
                        HasProgressBar : Boolean;
                        HasCancelButton : Boolean); reintroduce ; overload;

    property InfoText : string read GetInfoText write SetInfoText;
    property Percent : integer read GetPercent write SetPercent;
    property Canceled : Boolean read fCanceled;
    procedure CicleProgress;
  end;

var
  VssProgressForm: TVssProgressForm;

implementation

{$R *.dfm}

{ TProgressForm }
constructor TVssProgressForm.Create(AOwner: TComponent);
begin
  inherited;
  pbProgress.Visible := False;
  btnCancel.Visible := False;
  btnCancel.Enabled := false;
  FCanceled := False;
end;
procedure TVssProgressForm.CicleProgress;
begin
  if pbProgress.Position = pbProgress.Max then
    pbProgress.Position := 0
  else
    pbProgress.StepIt;
end;

constructor TVssProgressForm.Create(AOwner: TComponent;
                        FormCaption : string;
                        InitialInfo : string;
                        HasProgressBar : Boolean;
                        HasCancelButton : Boolean);
begin
  inherited Create(AOwner);
  pbProgress.Visible := HasProgressBar;
  btnCancel.Visible := HasCancelButton;
  btnCancel.Enabled := HasCancelButton;
  Caption := FormCaption;
  lblInfo.Caption := InitialInfo;
end;

procedure TVssProgressForm.btnCancelClick(Sender: TObject);
begin
  btnCancel.Enabled := False;
  FCanceled := True;
end;

function TVssProgressForm.GetInfoText: string;
begin
  Result := lblInfo.Caption;
end;


function TVssProgressForm.GetPercent: integer;
begin
  Result := pbProgress.Position;
end;

procedure TVssProgressForm.SetInfoText(const Value: string);
begin
  lblInfo.Caption := Value;
end;

procedure TVssProgressForm.SetPercent(const Value: integer);
begin
  pbProgress.Position := Value;
end;

end.
