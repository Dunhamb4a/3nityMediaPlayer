unit mp3parser;

interface
 uses sysutils,FileClasses, NumUtils;

 type
   TMp3Channelmode=(mp3cmStereo,mp3cmJoint,mp3cmDual,mp3cmSingle);
   TMp3Emphasis=(mp3emNone,mp3em5015,mp3emReserved, mp3emCCIT);

   TMp3Info=record
    Version : integer;
    Layer : integer;
    HasCRC : boolean;
    Bitrate : integer;
    VbrBitRate : integer;
    SampleRate : integer;
    Privatebit : boolean;
    Mode : TMp3Channelmode;
    ModeExt : integer;
    Copyright : boolean;
    Original : boolean;
    Emphasis : TMp3Emphasis;
    Duration : integer;
  end;

 function GetMp3Info(mp3file : string; var info : TMp3Info): boolean;
implementation
const

  tabsel_bitrate : array[0..1, 0..2 , 0..15] of integer = (
   ( (0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,-1),
     (0,32,48,56, 64, 80, 96,112,128,160,192,224,256,320,384,-1),
     (0,32,40,48, 56, 64, 80, 96,112,128,160,192,224,256,320,-1) ),

   ( (0,32,48,56,64,80,96,112,128,144,160,176,192,224,256,-1),
     (0,8,16,24,32,40,48,56,64,80,96,112,128,144,160,-1),
     (0,8,16,24,32,40,48,56,64,80,96,112,128,144,160,-1) )
  );

  tabSamplerate : array[0..3] of integer =
       (44100, 48000, 32000,-1);	// MPEG 1.0
//			 (22050, 24000, 16000),   // MPEG 2.0
//			 (11025, 12000,  8000) );  // MPEG 2.5
  tabSamplesize : array [0..1, 0..2] of integer = (
       (384,1152,1152),
       (384,1152, 576)
  );
  tabSideLength : array [0..1,0..1] of integer = (
      (17,32),
      (9,17) );
type

  TMp3frameHeader=record
    Header :  Longword;
    Version : integer;
    SubVersion : integer;
    Layer : integer;
    HasCRC : boolean;
    Bitrate : integer;
    SampleRate : integer;
    Padding : boolean;
    Privatebit : boolean;
    Mode : TMp3Channelmode;
    ModeExt : integer;
    Copyright : boolean;
    Original : boolean;
    Emphasis : TMp3Emphasis;
    FrameLength : integer;
    SideLength : integer;
    Samplesize : integer;
  end;


function isValidLayer2(var mp3fr : TMp3frameHeader): boolean;
begin
  if mp3fr.layer=2 then begin
    case mp3fr.Bitrate of
      0, 64,96..192: result := true;
      32..56,80: result := mp3fr.mode = mp3cmSingle;
      224..384: result :=mp3fr.Mode <> mp3cmSingle;
      else result := false;
    end;
  end else
    result:= true;
end;
function GetFrameLength(var mp3fr : TMP3frameHeader): integer;
  var Pad: integer;
    smp : integer;
begin
  with mp3fr do begin
    if padding then Pad:=1 else Pad:=0;
    smp := samplesize div 8;
    if Layer = 1 then begin
      smp := smp div 4;
      result := ((smp * BitRate*1000) div SampleRate + Pad) * 4
    end else
      result := (smp * BitRate*1000) div SampleRate + Pad
  end;
end;
function GetSideLength(var mp3fr : TMP3frameHeader): integer;
  var i : integer;
begin
  with mp3fr do begin
      if Mode=mp3cmSingle then i :=0 else i := 1;
      Result := tabSideLength[Version-1][i];
  end;
end;

function Checkmp3Header(var mp3fr : TMp3frameHeader): boolean;
var  i : integer;
begin
  result := false;
  with mp3fr do begin
    if (Header and $FFE00000)=$FFE00000 then begin
      i := (Header shr 19) and $3;
      if (i <> 1) then begin //not reserved id
        if i = 3 then begin
          Version := 1;
          SubVersion := 0;
        end else begin
          Version := 2;
          if i=2 then
            SubVersion := 0
          else
            SubVersion := 5;
        end;

        i := (Header shr 17) and $3;
        if i <> 0 then begin // not reserved id
          Layer := 4-i;
          HasCRC := (Header and $00010000) = 0;
          mp3fr.Bitrate := tabsel_bitrate[Version-1][Layer-1][(Header shr 12) and $F];
          if mp3fr.Bitrate >=0 then begin
            if isValidLayer2(mp3fr) then begin
              SampleRate := tabSampleRate[(Header shr 10) and $3];
              if SampleRate > 0 then begin
                if Version = 2 then begin
                  SampleRate := SampleRate div 2;
                  if SubVersion > 0 then
                    SampleRate := SampleRate div 2;
                end;
                Padding := (Header and $00000200) > 0;
                Privatebit := (Header and $00000100) > 0;
                Mode := TMp3Channelmode ((Header shr 6) and $3);
                ModeExt := (Header shr 4) and $3;
                Copyright := (Header and $08) > 0;
                Original := (Header and $04) > 0;
                Emphasis := TMp3Emphasis(Header and $03);
                Samplesize := tabSamplesize[Version-1][Layer-1];
                FrameLength := GetFrameLength(mp3fr);
                SideLength :=  GetSideLength(mp3fr);
                Result := true;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


function GetMp3Info(mp3file : string; var info : TMp3Info) : boolean;
  const
   MAXREAD = 100000;
  var
   readFrame : array[0..4096] of byte;
   readByte   : array[0..3] of byte;

   rMaxRead : integer;

   readCount : integer;

   cr : TCacheFileRead;
   mp3fr : TMp3frameHeader;

   framecount : Longint;
   bytecount : Longint;
   framesread : integer;
   pos : integer;
   flags : longword;
begin
  readCount := 0;
  Result := false;
  framesread := 0;

  info.VbrBitRate := 0;
  info.Duration :=0;

  cr := TCacheFileRead.Create();
  if cr.Open(mp3file) then begin
    if cr.Length < maxread then
      rMaxRead := cr.Length
    else
      rMaxRead := MAXREAD;

    while (cr.Position+128) < rMaxRead do begin
      cr.ReadBlock(@readByte[0],1,readCount);

      if readByte[0] = $FF then begin
        cr.ReadBlock(@readByte[1],1,readCount);
        if (readByte[1] and $E0) = $E0 then begin
          cr.ReadBlock(@readByte[2],2,readCount);
          CopySwapEndLongword(@readByte[0],@mp3fr.Header);
          if Checkmp3Header(mp3fr) then begin
            cr.ReadBlock(@readFrame,mp3fr.FrameLength-4, readCount);
            inc(framesread);
            if readcount = mp3fr.FrameLength-4  then begin
              info.Version := mp3fr.Version*10+ mp3fr.SubVersion;
              info.Layer := mp3fr.Version;
              info.HasCRC := mp3fr.HasCRC;
              info.Bitrate := mp3fr.Bitrate;
              info.SampleRate := mp3fr.SampleRate;
              info.Privatebit := mp3fr.Privatebit;
              info.Mode := mp3fr.Mode;
              info.ModeExt := mp3fr.ModeExt;
              info.Copyright := mp3fr.Copyright;
              info.Original := mp3fr.Original;
              info.Emphasis := mp3fr.Emphasis;
              if (readFrame[mp3fr.SideLength+0] = byte('X')) and
                 (readFrame[mp3fr.SideLength+1] = byte('i')) and
                 (readFrame[mp3fr.SideLength+2] = byte('n')) and
                 (readFrame[mp3fr.SideLength+3] = byte('g')) then begin

                pos := 8;
                CopySwapEndLongword(@readFrame[mp3fr.SideLength+4],@flags);
                if (flags and $1) > 0  then begin
                  CopySwapEndLongword(@readFrame[mp3fr.SideLength+pos],@framecount);
                  info.Duration := framecount*mp3fr.Samplesize div mp3fr.SampleRate;
                  inc(pos,4);
                end;
                bytecount := -1;
                if (flags and $2) > 0  then begin
                  CopySwapEndLongword(@readFrame[mp3fr.SideLength+pos],@bytecount);
                end;
                if bytecount < 0 then begin
                  if cr.Length <= 2147483647 then
                    bytecount := cr.Length
                  else
                    bytecount := 2147483647;
                end;

                if info.Duration > 0 then
                  info.vbrbitrate := (bytecount*8) div (info.Duration);

                result := true;
                break;
              end else begin
                info.Duration := 0;
              end;
            end;
            if (framesRead > 10) then begin
             result :=true;
             break;
            end;
          end else begin
            cr.SeekTo(cr.Position-3);
          end;
        end else begin
          cr.SeekTo(cr.Position-1);
        end;
      end;
    end;
  end;
  freeandnil(cr);
end;


end.
