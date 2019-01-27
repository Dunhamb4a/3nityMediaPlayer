unit VssIniFiles;

interface
  uses Classes,INIFiles, NumUtils, Graphics, Windows;

  type
  TVssMemIniFile = class(TMemIniFile)
    public

      procedure LoadFromStream(Stream: TStream);
      function ReadRGBColor(const Section, Ident: string;Default: Tcolor): Tcolor;
      function ReadRGBAColor(const Section, Ident: string;Default: TRGBQuad): TRGBQuad;
      procedure WriteRGBColor(const Section, Ident: string; Value: TColor);
      procedure WriteRGBAColor(const Section, Ident: string; Value: TRGBQuad);
  end;

implementation

{ TVssMemIniFile }

function TVssMemIniFile.ReadRGBAColor(const Section, Ident: string;
  Default: TRGBQuad): TRGBQuad;
var
  ReadStr: string;
begin
  ReadStr := ReadString(Section, Ident, '');  //88
  try
    Result := StringRGBAToRGBA(ReadStr);
  except
    Result := Default;
  end;
end;

function TVssMemIniFile.ReadRGBColor(const Section, Ident: string;
  Default: Tcolor): Tcolor;
var
  ReadStr: string;
begin
  ReadStr := ReadString(Section, Ident, '');
  try
    Result := StringRGBToColor(ReadStr);
  except
    Result := Default;
  end;
end;

procedure TVssMemIniFile.WriteRGBAColor(const Section, Ident: string; Value: TRGBQuad);
begin
  WriteString(Section, Ident, RGBAToStringRGBA(Value));
end;

procedure TVssMemIniFile.WriteRGBColor(const Section, Ident: string;
  Value: TColor);
begin
  WriteString(Section, Ident, ColorToStringRGB(Value));
end;

procedure TVssMemIniFile.LoadFromStream(Stream: TStream);
var
  sl : TStringList;
begin

  sl:=TStringList.Create;
  try
     sl.LoadFromStream(Stream);
     SetStrings(sl);
  finally
     sl.Free;
  end;

end;

end.
