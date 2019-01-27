unit FileClasses;

interface
 uses sysUtils,FileUtils;

type
   TCacheFileRead=class
    private
     const
     BUFLEN = 131072; //16 test
     BLOCKLEN = 16384; //8
     var
     readBuf : array[0..BUFLEN-1] of byte;
     blockBuf : array[0..BLOCKLEN-1] of byte;
     FTailP, FHeadP, FReadP : int64;
     FBufferP : integer;
     FFile    : File;
     FFilename : string;
     FIsOpen : boolean;
     FFileLength : int64;
    public
     constructor Create();
     Destructor Destroy(); override;
     function Open(filename : string) : boolean;
     procedure Close();
     procedure ReadBlock(buffer: Pointer; recCnt: Integer; var recsRead: Integer);
     function SeekTo(pos : int64): boolean;
     Property Position : int64  read FReadP;
     property Length : int64 read FFileLength;
     //function Read(var f: TFileRec; buffer: Pointer; recCnt: Longint; var recsRead: Longint): Longint;
   end;

implementation


{ TCacheFileRead }

procedure TCacheFileRead.Close;
begin
  if FIsOpen then
    Closefile(FFile);
  FTailP := 0;
  FHeadP := 0;
  FReadP := 0;
  FBufferP := 0;
end;

constructor TCacheFileRead.Create;
begin
  FIsOpen := false;
  self.Close;
end;

destructor TCacheFileRead.Destroy;
begin
  self.Close;
  inherited;
end;

function TCacheFileRead.Open(filename: string): boolean;
begin
  self.Close;
  AssignFile(FFile, filename);
  FileMode := fmOpenRead or fmShareDenyNone;
  try
    Reset(FFile,  1);
    try
      FFileLength := getFilelen64(filename);
      FFilename := filename;
      FIsOpen := true;
    except
      CloseFile(FFile);
    end;
  except
  end;
  Result := FIsOpen;
end;


procedure TCacheFileRead.ReadBlock(buffer: Pointer;
  recCnt: Integer; var recsRead: Integer);
  procedure incHeadPointer(value : integer);
  var actH,endcount : integer;
  begin
    //get current buffer position
    actH := FBufferP+(FHeadP-FReadP) mod BUFLEN;
    //copy data from read block
    if (actH + value) > BUFLEN  then begin // crosses end
      endcount := BUFLEN - actH;
      move(BlockBuf,readBuf[actH], endcount);
      move(BlockBuf[endcount],readBuf[0], value-endcount );
    end else //doesn't cross end
      move(BlockBuf,readBuf[actH],value);

    //update head and tail pointers
    FHeadP := fHeadP + value;
    if (FHeadP - FTailP) > (BUFLEN-1)  then
      FTailP := FHeadP - (BUFLEN-1);
  end;
  procedure incReadPointer(b : Pointer; value : integer);
  begin
    //copy data from read buffer
    if value = 1 then begin //make it fast
      byte(b^) := readBuf[FBufferP];
    end else begin
      if (FBufferP + value) > BUFLEN  then begin // crosses end
        move(readBuf[FBufferP],b^, BUFLEN - FBufferP);
        b := pointer(longInt(b)+ longInt(BUFLEN - FBufferP));
        move(readBuf[0],b^, value -(BUFLEN - FBufferP) );
      end else begin //doesn't cross end
        move(readBuf[FBufferP],b^,value);
      end;
    end;

    //update read pointers
    FReadP := fReadP + value;
    FBufferP := (FBufferP + value) mod BUFLEN;
  end;
var
  movesize : integer;
  bytesRead : integer;
begin
 RecsRead := 0;
 if FIsOpen then begin
  bytesRead := -1;
  while (RecsRead < recCnt) and (bytesRead <> 0) do begin
    if FHeadP > FReadP then begin
      movesize := FHeadP - fReadP;
      if movesize > recCnt then
        movesize := recCnt;
      incReadPointer(buffer,movesize);
      RecsRead := RecsRead + movesize;
    end else begin
      BlockRead(Ffile,BlockBuf,BLOCKLEN,bytesRead);
      incHeadPointer(bytesRead);
    end;
  end;
 end;

end;

function TCacheFileRead.SeekTo(pos: int64) : boolean;
begin
 Result := false;
 if FIsOpen then begin
  if (Pos <= FHeadP) and (Pos >= FTailP) then begin
    FBufferP := (FBufferP + (Pos-FReadP) + BUFLEN) mod BUFLEN;
    FReadP := Pos;
    Result := true;
  end else begin
    try
      seek(FFile,Pos);
      result := true
    except
      Pos := FilePos(Ffile);
    end;
    FReadP := Pos;
    FTailP := Pos;
    FHeadP := Pos;
  end;
 end;
end;

end.
