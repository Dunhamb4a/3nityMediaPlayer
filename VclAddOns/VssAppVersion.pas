unit VssAppVersion;

interface

uses Windows, SysUtils;

type
  // version numbers
  TVssVersionNumbers = class
    private
      FMajor : Integer;
      FMinor : Integer;
      FRelease : Integer;
      FBuild : Integer;
      procedure SetFromDWords(hdw : DWORD; ldw : DWORD);
    public
      constructor Create();
      property Major : Integer read FMajor;
      property Minor : Integer read FMinor;
      property Release : Integer read FRelease;
      property Build : Integer read FBuild;
      function GetString : string;
  end;

  // translations
  TVssAppVersionTranslation = class
    private
      FLangCode : Word;
      FCharSet : Word;
      Fstrings : array[0..11] of string;
    function GetCode: string;
    function GetStringCount: Integer;

    public
      property LangCode : Word read FLangCode;
      property CharSet : Word read FCharSet;
      function GetString(const Index: Integer): string;
      function GetStringName(const Index: Integer): string;

      property Comments : string index 0 read GetString;
      property CompanyName : string index 1 read GetString;
      property FileDescription : string index 2 read GetString;
      property FileVersion : string index 3 read GetString;
      property InternalName : string index 4 read GetString;
      property LegalCopyright : string index 5 read GetString;
      property LegalTrademarks : string index 6 read GetString;
      property OriginalFilename : string index 7 read GetString;
      property PrivateBuild : string index 8 read GetString;
      property ProductName : string index 9 read GetString;
      property ProductVersion : string index 10 read GetString;
      property SpecialBuild : string index 11 read GetString;
      property Code : string read GetCode;
      property StringCount : Integer read GetStringCount;
  end;
  // list of Translations
  TVssAppVersionTranslationList = class
    private
      FItems : array of  TVssAppVersionTranslation;
      function GetItems(Index: integer): TVssAppVersionTranslation;
      function GetCount: Integer;
    public
      constructor Create(Size : integer);
      destructor Destroy; override;
      property Items[Index: integer] : TVssAppVersionTranslation read GetItems; default;
      property Count : Integer read GetCount;
  end;
  // application version object
  TVssAppVersion = class
    private
      FTranslations : TVssAppVersionTranslationList; // translations list
      fFixedInfo: TVSFixedFileInfo; // fixed file info record
      fHasVersionInfo : Boolean;
      fHasFixedInfo : Boolean;
      fProductVersion : TVssVersionNumbers;
      fFileVersion : TVssVersionNumbers;
      function ReadFixedFileInfo(pBuffer : Pointer) : Boolean;
      function ReadTranslations(pBuffer : Pointer) : Boolean;
      procedure ReadTranslationsStrings(pBuffer : Pointer);
    public
      constructor Create(const filename : string);
      destructor Destroy; override;
      property FixedInfo :TVSFixedFileInfo read fFixedInfo;
      property Translations :TVssAppVersionTranslationList  read Ftranslations;
      property HasVersionInfo : Boolean read fHasVersionInfo;
      property HasFixedInfo : Boolean read fHasFixedInfo;
      property ProductVersion : TVssVersionNumbers read fProductVersion;
      property FileVersion : TVssVersionNumbers read fFileVersion;
  end;

implementation
const
  MAX_TRANSLATION_STRINGS = 11;
  // List of all standard string name
  cStrNames: array[0..MAX_TRANSLATION_STRINGS] of string = (
    'Comments','CompanyName','FileDescription','FileVersion','InternalName',
    'LegalCopyright','LegalTrademarks','OriginalFilename','PrivateBuild',
    'ProductName','ProductVersion','SpecialBuild'
    );
 type
 {Translation record: stores language code and character set (code page).}
  TTransRec = packed record
    Lang,             // language code
    CharSet: Word;    // character set (code page)
  end;
  PTransRec = ^TTransRec;



{ TVsVersion }

constructor TVssVersionNumbers.Create;
begin
  inherited;
  FMajor := 0;
  FMinor := 0;
  FRelease := 0;
  FBuild := 0;
end;

function TVssVersionNumbers.GetString: string;
begin
  Result := Format('%d.%d.%d.%d',[FMajor, FMinor, FRelease, FBuild]);
end;

procedure TVssVersionNumbers.SetFromDWords(hdw : DWORD; ldw : DWORD);
begin
  FMajor := HiWord(hdw);
  FMinor := LoWord(hdw);
  FRelease := HiWord(ldw);
  FBuild := LoWord(ldw);
end;


{ TVssAppVersionTranslation }

function TVssAppVersionTranslation.GetCode: string;
begin
  Result := Format('%4.4x%4.4x', [LangCode, CharSet]);
end;

function TVssAppVersionTranslation.GetString(const Index: Integer): string;
begin
  Result := Fstrings[Index];
end;

function TVssAppVersionTranslation.GetStringCount: Integer;
begin
  Result := MAX_TRANSLATION_STRINGS+1;
end;

function TVssAppVersionTranslation.GetStringName(const Index: Integer): string;
begin
  Result := cStrNames[Index];
end;


{ TVssAppVersionTranslationList }

constructor TVssAppVersionTranslationList.Create(Size: integer);
var
  I : Integer;
begin
  inherited Create;
  SetLength(FItems,Size);
  for I := 0 to Count - 1 do
    FItems[I] := TVssAppVersionTranslation.Create;
end;

destructor TVssAppVersionTranslationList.Destroy;
var
  I : Integer;
begin
  for I := 0 to Count - 1 do
    FItems[I].Free;

  SetLength(FItems,0);
  inherited;
end;

function TVssAppVersionTranslationList.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TVssAppVersionTranslationList.GetItems(
                                  Index: integer): TVssAppVersionTranslation;
begin
  Result := FItems[Index];
end;


{ TVssAppVersion }

constructor TVssAppVersion.Create(const filename: string);
var
  BufSize: Integer;     // size of ver info buffer
  Dummy : DWORD;
  pVerInfo : Pointer;
begin
  inherited Create;
  
  FTranslations := nil;
  fHasFixedInfo := false;

  BufSize := GetFileVersionInfoSize(PChar(filename), Dummy);
  fHasVersionInfo := BufSize > 0;

  
  if fHasVersionInfo then
  begin
    // Read ver info into buffer
    GetMem(pVerInfo, BufSize);
    fHasVersionInfo := GetFileVersionInfo(PChar(FileName), 0, BufSize, pVerInfo);
    if fHasVersionInfo then begin
      // Read fixed file info and translation table
      fHasFixedInfo := ReadFixedFileInfo(pVerInfo);
      ReadTranslations(pVerInfo);
      ReadTranslationsStrings(pVerInfo);
    end;
    FreeMem(pVerInfo);
  end;
  if FTranslations = nil then // create empty list
    FTranslations := TVssAppVersionTranslationList.Create(0);

  fFileVersion := TVssVersionNumbers.Create;
  fProductVersion := TVssVersionNumbers.Create;
  if fHasFixedInfo then begin
    fFileVersion.SetFromDWords(fFixedInfo.dwFileVersionMS,
                               fFixedInfo.dwFileVersionLS);
    fProductVersion.SetFromDWords(fFixedInfo.dwProductVersionMS,
                                  fFixedInfo.dwProductVersionLS);
  end;

end;

destructor TVssAppVersion.Destroy;
begin
  FTranslations.Free;
  fFileVersion.Free;
  fProductVersion.Free;
  inherited;
end;

function TVssAppVersion.ReadFixedFileInfo(pBuffer : Pointer): Boolean;
var
  Size: DWORD;  // Size of fixed file info read
  Ptr: Pointer; // Pointer read data
begin
  // Read the fixed file info
  Result := VerQueryValue(pBuffer, '\', Ptr, Size);
  // Check read data
  if Result then begin
    if Size <> SizeOf(TVSFixedFileInfo) then
      Result := False;
    fFixedInfo := PVSFixedFileInfo(Ptr)^;
  end;
end;


function TVssAppVersion.ReadTranslations(pBuffer: Pointer): Boolean;
var
  TransRec: PTransRec;  // pointer to a translation record
  Size: DWORD;          // size of data read
  RecCount: Integer;    // number of translation records
  I: Integer;         // loops thru translation records
begin
  // Read translation data
  Result := VerQueryValue(pBuffer, '\VarFileInfo\Translation', Pointer(TransRec), Size);
  // Get record count and set length of array
  if Result then
    RecCount := Size div SizeOf(TTransRec)
  else
    RecCount := 0;
  // create translation list
  FTranslations := TVssAppVersionTranslationList.Create(RecCount);
  // store data in translation list
  for I := 0 to RecCount-1 do
  begin
    FTranslations[I].FLangCode := TransRec^.Lang;
    FTranslations[I].FCharSet := TransRec^.CharSet;
    Inc(TransRec);
  end;
end;


procedure TVssAppVersion.ReadTranslationsStrings(pBuffer: Pointer);
var
  I, S : Integer;
  TransPath : string;
  StringPath : string;
  Value: PChar;   // the string value data
  Dummy: DWORD;   // size of value data (unused)
begin
  for I := 0 to FTranslations.Count - 1 do begin
    TransPath := '\StringFileInfo\' + FTranslations[I].Code + '\';
    for S := low(cStrNames) to  High(cStrNames) do begin
      StringPath := TransPath + cStrNames[S];
      if VerQueryValue(pBuffer, PChar(StringPath), Pointer(Value), Dummy) then
        FTranslations[I].Fstrings[S]:= Value
      else
        FTranslations[I].Fstrings[S] := '';
    end;   
  end;
end;

end.
