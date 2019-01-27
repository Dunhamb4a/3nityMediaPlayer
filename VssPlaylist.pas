unit VssPlaylist;

interface
  uses Classes;
  type
    TVssPlayListFile = class
    private
      Ffiles : TStringList;
      FbasePath : string;
      function LoadM3U(const fileName : string) : Boolean;
      function LoadPLS(const fileName : string) : Boolean;
    function GetFullPathFiles(Index: Integer): string;
    protected

    public
      constructor Create();
      destructor Destroy; override;
      function LoadFromFile(const fileName : string) : Boolean;
      property Files : TStringList read Ffiles;
      property FullPathFiles[Index: Integer] : string read GetFullPathFiles;
      function SaveToFile(
                      const FileName: string; RelativePath : boolean): Boolean;
      class function IsValidPlaylistFile(const FileName : string) : Boolean;
    end;


implementation
  uses SysUtils, StrUtils, FileUtils, VssIniFiles, Forms, ExtActns;

{ TVssPlayListFile }

constructor TVssPlayListFile.Create;
begin
  FbasePath := '';
  Ffiles := TStringList.Create;
end;

destructor TVssPlayListFile.Destroy;
begin
  Ffiles.Free;
  inherited;
end;

function TVssPlayListFile.GetFullPathFiles(Index: Integer): string;
begin
  Result := Ffiles[Index];
  if Pos(':',Result)>0  then Exit;
  if (length(Result)>1) AND ((Result[1]='/') OR (Result[1]='\')) then Exit;
  Result:=ExpandUNCFileName(FBasePath+Result);
end;

class function TVssPlayListFile.IsValidPlaylistFile(const FileName : string): Boolean;
var
  fileExt : string;
begin
  fileExt := '|'+ UpperCase(ExtractFileExtNoDot(fileName)) + '|';
  Result := Pos(fileExt,'|M3U|PLS|RAM|') > 0;
end;

function TVssPlayListFile.LoadFromFile(const fileName: string): Boolean;
var
  fileExt : string;
  Downloader : TDownloadURL;
  localFile : string;
begin
  Result := False;
  Ffiles.Clear;

  FBasePath:=ExtractFilePathWithSlash(fileName);
  fileExt := UpperCase(ExtractFileExtNoDot(fileName));

  localFile := fileName;

  if Pos('//',FbasePath) > 0 then begin

    localFile := IncludeTrailingPathDelimiter(
                    ExtractFileDir(ExpandFileName(ParamStr(0)))
                  ) + 'Dlist.---';
    Downloader := nil;
    try
      Downloader := TDownloadURL.Create(application);
      Downloader.URL := fileName;
      Downloader.FileName := localFile;
      Downloader.ExecuteTarget(nil) ;
    except
      localFile := '';
    end;
    Downloader.Free;
  end;


  if localFile <> '' then begin
    if fileExt = 'PLS' then begin
      Result := LoadPLS(localFile)
    end else if (fileExt = 'M3U') or (fileExt = 'RAM') then begin
      Result := LoadM3U(localFile)
    end;
  end;

end;

function TVssPlayListFile.LoadPLS(const fileName: string): Boolean;
var
  iniFile : TVssMemIniFile;
  entryCount, i : Integer;
  newEntry : string;
const
  SECTIONNAME = 'playlist';
begin
  Result := False;
  
  try iniFile:=TVssMemIniFile.Create(fileName); except exit; end;

  entryCount := iniFile.ReadInteger(SECTIONNAME,'NumberOfEntries',-1);
  if entryCount > 0 then begin
    for i := 1 to entryCount do begin
      newEntry := iniFile.ReadString(SECTIONNAME,'File' + IntToStr(i),'');
      if newEntry <> '' then
        Ffiles.Add(newEntry)
      else
        Break;
    end;
    Result := True;
  end else begin
    Result := entryCount <> -1;
  end;
  iniFile.Free;
end;


function TVssPlayListFile.LoadM3U(const fileName: string): Boolean;
var
  slTxtFile: TStringList;
  i : Integer;
begin
  slTxtFile := TStringList.Create;
  try
    slTxtFile.LoadFromFile(fileName);
    for i := 0 to slTxtFile.Count-1 do begin
      if slTxtFile[i][1]<> '#' then begin
        Ffiles.Add(slTxtFile[i])
      end;
    end;
    Result := True;
  except
    Result := Ffiles.Count <= 0;
  end;
  slTxtFile.Free;
end;

function TVssPlayListFile.SaveToFile(
                      const FileName: string; RelativePath : boolean): Boolean;
var
  stream : TStream;
  i: Integer;
  sLine : string;
begin
  Result := True;
  FbasePath := ExtractFilePathWithSlash(FileName);
  stream := nil;
  try
    Stream := TFileStream.Create(FileName, fmCreate);
    for i := 0 to Ffiles.Count-1 do begin
      sLine := Ffiles[i] + #13#10;
      if Pos(FbasePath,sLine) = 1 then begin
        sLine := RightStr(sLine, Length(sLine)- Length(FbasePath));
      end;

      Stream.WriteBuffer(Pointer(sLine)^, Length(sLine));
    end;
  except
    Result := False;
  end;
  stream.Free;  
end;


end.
