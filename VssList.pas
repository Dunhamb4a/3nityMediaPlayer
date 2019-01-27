unit VssList;

interface

uses sysUtils,classes;

type
  TVssList = class
  private
    Fl : TList;
    function GetCount: Integer;
    procedure SetCount(const Value: Integer);
  protected
    function GetItems(Index: Integer): TObject;
    procedure SetItems(Index: Integer; item: TObject);
  public
    constructor Create();
    destructor Destroy; override;
    function Add(Item: TObject): Integer;
    procedure Delete(index: integer); Virtual;
    function Remove(Item: TObject): Integer;
    procedure Insert(index: integer; item: TObject);
    procedure Clear();
    function IndexOf(item: TObject): Integer;
    property Items[Index: Integer]: TObject read GetItems write SetItems; default;
    property Count : Integer read GetCount write SetCount;
  end;
implementation

{ TVssList }

function TVssList.Add(Item: TObject): Integer;
begin
  Result := Fl.Add(Item); 
end;

procedure TVssList.Clear;
begin
  Fl.Clear;
end;

constructor TVssList.Create;
begin
  Fl := TList.Create;
end;

procedure TVssList.Delete(index: integer);
begin
  Fl.Delete(Index); 
end;

destructor TVssList.Destroy;
begin
  FreeAndNil(Fl);
  inherited;
end;

function TVssList.GetCount: Integer;
begin
  Result := Fl.Count;
end;

function TVssList.GetItems(Index: Integer): TObject;
begin
  Result := Fl.Items[Index];
end;

function TVssList.IndexOf(item: TObject): Integer;
begin
  Result := Fl.IndexOf(item);
end;


procedure TVssList.Insert(index: integer; item: TObject);
begin
  Fl.Insert(index,Item);
end;

function TVssList.Remove(Item: TObject): Integer;
begin
  Result := IndexOf(Item);
  if Result >= 0 then
    Delete(Result);
end;

procedure TVssList.SetCount(const Value: Integer);
begin
  Fl.Count := Value;
end;

procedure TVssList.SetItems(Index: Integer; item: TObject);
begin
  Fl.Items[index]:= item;
end;
end.
