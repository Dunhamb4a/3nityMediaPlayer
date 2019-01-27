unit NumUtils;

interface

uses Graphics, Windows;

function CorrectRound(x: Extended): LongInt;
function SecondsToTimeHMS(Seconds:integer):string;
procedure CopySwapEndLongword(src : Pointer;dest : Pointer);
function GetSizeString(value : int64; pow1000 : int64 = 1; kilobinary : boolean = true) : string;

function ColorToStringRGB(Color: TColor): string;
function StringRGBToColor(S: string): TColor;
function RGBAToStringRGBA(Color: tagRGBQUAD): string;
function StringRGBAToRGBA(S: string): tagRGBQUAD;

implementation
uses sysutils, strUtils;
function CorrectRound(x: Extended): LongInt;
begin
  Result := Trunc(x);
  if (x - result) >= 0.5 then
    Result := Result + 1;
end;
function SecondsToTimeHMS(Seconds:integer):string;
var m,s:integer;
begin
  if Seconds<0 then Seconds:=0;
  m:=(Seconds DIV 60) MOD 60;
  s:= Seconds MOD 60;
  Result:=IntToStr(Seconds DIV 3600)
          +':'+char(48+m DIV 10)+char(48+m MOD 10)
          +':'+char(48+s DIV 10)+char(48+s MOD 10);
end;
procedure CopySwapEndLongword(src : Pointer;dest : Pointer);
var i : integer;
begin
  inc(Pbyte(src),3);
  for i := 0 to 3 do begin
    byte(dest^) := byte(src^);
    inc(Pbyte(dest));
    dec(Pbyte(src));
  end;
end;
function GetSizeString(value : int64; pow1000 : int64 = 1; kilobinary : boolean = true) : string;
var
  minvalue : int64;
  divvalue : int64;
  scale : integer;
  fvalue : single;
  fvaluetest : single;
const
  scalestrings : array[0..5] of string =('','K','M','G','T','P');
begin
  minvalue := 1;
  if kilobinary then
    divvalue := 1024
  else
    divvalue := 1000;

  while pow1000 > 0 do begin
    minvalue := minvalue*divvalue;
    dec(pow1000);
  end;
  fvalue := value;
  scale :=  0;
  if minvalue > 1 then
    while (fvalue >= minvalue) and ((scale+1) < sizeof(scalestrings)) do begin
      inc(scale);
      fvalue := fvalue / divvalue;
    end;

  fvaluetest := fvalue;
  divvalue := 3; // use divvalue variable to store decimal places
  // calculate number of decimals required to quet 3 digits in total
  while (trunc(fvaluetest) > 0) and (divvalue > 0) do begin
     fvaluetest := fvaluetest/10;
     dec(divvalue);
  end;
  if divvalue < 0 then
    divvalue := 0;

  str(fvalue:0:divvalue,Result);
  Result := Result  + ' ' + scalestrings[scale];
end;


function ColorToStringRGB(Color: TColor): string;
begin
  Result := Format('%.2x%.2x%.2x',
                                 [GetRValue(Color),
                                  GetGValue(Color),
                                  GetBValue(Color)])
end;

function StringRGBToColor(S: string): TColor;
var
  Rvalue,Gvalue, Bvalue : Integer;
begin
  S := Trim(S);
  if Length(S) > 2 then begin
    if (lowercase(LeftStr(S,2)) = 'cl') or (LeftStr(S,1) = '$') then begin
      Result := StringToColor(S)
    end else begin
      if Length(S) = 6 then begin
        Rvalue := StrToInt('$'+ MidStr(S,1,2));
        Gvalue := StrToInt('$'+ MidStr(S,3,2));
        Bvalue := StrToInt('$'+ MidStr(S,5,2));
        Result := RGB(Rvalue,Gvalue,Bvalue);
      end else begin
        //Raise Exception.Create('Invalid Hex color Value (Length)');
      end;
    end;
  end else begin
    //Raise Exception.Create('Invalid Hex color Value (Length)');
  end;
end;

function RGBAToStringRGBA(Color: tagRGBQUAD): string;
begin
  Result := Format('%.2x%.2x%.2x%.2x',
                                 [Color.rgbRed,
                                  Color.rgbGreen,
                                  Color.rgbBlue,
                                  Color.rgbReserved])
end;

function StringRGBAToRGBA(S: string): tagRGBQUAD;
begin
  S := Trim(S);
  
  if Length(S) = 8 then begin
    Result.rgbRed      := StrToInt('$'+ MidStr(S,1,2));
    Result.rgbGreen    := StrToInt('$'+ MidStr(S,3,2));
    Result.rgbBlue     := StrToInt('$'+ MidStr(S,5,2));
    Result.rgbReserved := StrToInt('$'+ MidStr(S,7,2));
  end else begin
    //Raise Exception.Create('Invalid Hex RGBA Value (Length)')
  end;
end;

end.
