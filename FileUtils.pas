unit FileUtils;

interface
  function getFilelen64(FileName : string) : int64;
  function ExtractFileExtNoDot(const FileName : string) : string;
  function ExtractFilePathWithSlash(const FileName : string) : string;
  function StringToCaseSelect(Selector : string;CaseList: array of string): Integer;
implementation
  uses Classes, SysUtils, StrUtils;

function getFilelen64(FileName : string) : int64;
var
  Stream : TFileStream;
begin
  Result := -1;
  Try
    Stream := nil;
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    Result := stream.Size;
  Except //try reading file
  end;
  FreeAndNil(stream);
end;
{
Usage:

case StringToCaseSelect('Delphi',
      ['About','Borland','Delphi']) of
   0:ShowMessage('You''ve picked About') ;
   1:ShowMessage('You''ve picked Borland') ;
   2:ShowMessage('You''ve picked Delphi') ;
end;
}
function StringToCaseSelect
   (Selector : string;
CaseList: array of string): Integer;
var cnt: integer;
begin
   Result:=-1;
   for cnt:=0 to Length(CaseList)-1 do
begin
     if CompareText(Selector, CaseList[cnt]) = 0 then
     begin
       Result:=cnt;
       Break;
     end;
   end;
end;

function ExtractFileExtNoDot(const FileName : string) : string;
begin
  Result := ExtractFileExt(FileName);
  if Result <> '' then
    Result := RightStr(Result,Length(Result)-1);
end;

function ExtractFilePathWithSlash(const FileName : string) : string;
var
  i : Integer;
  endSlash : string;
begin
  Result := '';
  if Length(FileName) > 0 then begin
    if Pos('/', FileName) > 0 then
      endSlash := '/'
    else
      endSlash := '\';
    i := LastDelimiter(endSlash,FileName);
    if i > 0 then begin
      if i = Length(FileName) then begin
        Result := FileName;  // is a path with an slash
      end else begin
        Result := LeftStr(FileName,i); // get only path
      end;
    end;
  end;
end;
end.
