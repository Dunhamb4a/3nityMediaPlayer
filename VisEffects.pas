unit VisEffects;

{
  Copyright (C) 2008-2010 Visenri
  Based On:
  Original Title:  Pixelated Gravity <uGravityWindow.pas>
  Original Author: Gerben Wijnja <gerben@gerbs.net>

  Date:   February 2008

  This unit may seem really lenghty at first, but there's
  just a lot of comment!
}

interface

uses
  Classes, SysUtils, Windows, Graphics, Math;

type

  TAdvBitmap = class(TBitmap)
    public
      Constructor Create(); overload; override;
      constructor Create(W, H: integer; pf: TPixelFormat); reintroduce;  overload;
      procedure SetSize(AWidth, AHeight: Integer); override;
      var
      Rows: array of PByteArray;
  end;

  TVisEffectProp = class(TObject)
  private
    FadeCount : integer;
    Drawn : boolean;
    FName : string;
  Public
    Enabled : boolean;
    Blur : boolean;
    property Name : string read  FName;
  end;


  TVisEffects = class(TObject)
  private
    type

    TRealPoint = record
      X, Y: Real;
    end;

    TARGB = packed record
      B, G, R, A: Byte;
    end;

  { I know there's the TRGBQuad type, but the TRGBQuad type has the
    variables 'rgbRed', 'rgbGreen', 'rgbBlue' and 'rgbReserved'. But
    A, R, G and B are much more readable, don't you think? :)
  }

    PMyPixel = ^TMyPixel;
    TMyPixel = record
      Position, Speed: TRealPoint;
      OriginalColor, FilteredColor: TARGB;
    end;
    const
    PIXEL_COUNT = 500;
    NUM_VIS_BARS = 15;

    var
    FVis : array[0..1] of TVisEffectProp; // visualization status and propertys

    FbmL : array[0..2] of TAdvBitmap; // bitmap layers for rendering
    FbmExt : Tbitmap;   // external bitmap

    FWidth : integer;  //render size
    FHeight : integer;

    // variables for Particles vis
    FPixels: array[0..PIXEL_COUNT - 1] of TMyPixel;
    FLastTime: Integer;
    FCursor: TPoint;
    Lastblur : integer; //blur effects rotation counters
    cnt : integer;
    // end variables for Particles vis

    bmResult : Tbitmap; // pointer to result bitmap
    FEnabled: boolean;  // enabled vis

    procedure SetEnabled(const Value: boolean);
    function GetVis(Index: integer): TVisEffectProp;
    function GetVisCount : integer;

    // Init
    procedure InitPixels;
    procedure Freebitmaps(active : boolean);
    // Draw
    procedure DrawPixels(bm : TadvBitmap);
    procedure ApplyColorFilter;
    procedure SetPixel(Location, Value: DWORD);

    procedure DrawVisBars(bm : Tbitmap);

    procedure DoVis(Index: integer; bmInd : integer);
    // Move
    procedure MovePixels;
    procedure MoveBars;
    procedure UpdatePixel(const Pixel: PMyPixel; const ElapsedTime: Real);

    procedure BlurFade(bm : TAdvBitmap);
    procedure BlurBitmap(bm: TAdvBitmap);
    procedure BlurRow(ThisRow, NextRow: Pointer; Width: Integer);
    procedure BlurFadeRows(ThisRow, NextRow: Pointer; Width: Integer; FadeDivisor: integer);

    const
//  cmSrcErase
    mergemodes : array[0..1] of Integer = ( cmSrcInvert, cmSrcPaint);
  public
    constructor Create(Width, height : integer);
    destructor Destroy; override;
    procedure Resize(Width, height : integer);


    procedure RenderNewFrame;
    procedure DrawToBitmap;
    property bmExt : TBitmap read FbmExt write FbmExt;
    property Vis[Index:integer] : TVisEffectProp read GetVis;
    property Enabled : boolean read FEnabled write SetEnabled;
    property VisCount : integer read GetVisCount;
    var
    VisBarValues : array[0..NUM_VIS_BARS-1] of integer;
    DirectRender: boolean;
  end;

implementation

const
  VIS_EFF_BARS = 0;
  VIS_EFF_PART = 1;

{============================ Helper functions ==============================}

procedure ZeroBitmap(Bitmap: Pointer; Count: Integer); assembler;
asm
  { I think this is the fastest way to clear a bitmap.
    EDX holds the pointer to the bitmap. ECX hold the Count value. }

  mov edi, eax
  mov ecx, edx
  xor eax, eax
  rep stosd

  { "mov edi, edx" (move Bitmap -> EDI)
      This stores the Bitmap pointer in EDI (Destination Index).

    "xor eax, eax" (eXclusive OR of EAX and EAX)
      An exclusive or of a number on itself always results in 0.
      This is faster than 'mov eax, 0'. We only do this once for
      clearing the whole frame, so you will not notice ANY change in
      speed whatsoever in this application, but this is just for
      educational purposes. We are working with graphics here, and
      working with graphics demands any optimization you can find.
      Besides, there's no reason why we would not use this
      method, right?

    "rep stosd" (repeat store string double)
      This is where the magic happens. REP STOSD does multiple
      things: it stores EAX into [EDI], then it increases EDI by 4,
      then it decreases ECX (the counter) and finally if the counter
      is not 0, it repeats itself. Great all-in-one instruction!

    Basically REP STOSD is the same as this:

      repeat
        Integer(Bitmap^) := 0;
        inc(Integer(Bitmap), 4);
        dec(Count);
      until (Count = 0);

    Or in ASM:

      @myLoop:          Label of the start of the loop
        mov [edx], 0    Put 0 in [edx]
        inc edx, 4      Move 4 bytes forward to the next pixel,
        dec ecx         decrease the counter by 1,
        jnz @myLoop     and repeat, as long as ECX is not zero.

    Or this:

      @myLoop:
        mov [edx], 0
        inc edx, 4
        loop @myLoop    'loop' takes care of decreasing the counter.

    But using REP STOSD is easier to read and faster for big chunks
    of memory. Here is an interesting discussion and test of
    different approaches for zero-ing a piece of memory:

    http://www.masm32.com/board/index.php?topic=6576.0
  }
end;

procedure ClearBitmap(bm : Tbitmap);
var b : TAdvBitmap;
begin

  if (bm is TAdvBitmap) and (bm.PixelFormat = pf32bit) then begin
    b := (bm as TAdvBitmap);
    ZeroBitmap(b.Rows[bm.Height - 1], bm.Width * bm.Height);
  end else begin
      bm.Canvas.Brush.Color := clblack;
      bm.Canvas.FillRect(rect(0,0,bm.Width,bm.Height));
  end;
end;

{ TAdvBitmap }

constructor TAdvBitmap.Create(W, H: integer; pf: TPixelFormat);
begin
  inherited Create;
  PixelFormat := pf32bit;
  SetLength(Rows, 0);
  SetSize(W,H);
end;

constructor TAdvBitmap.Create;
begin
  inherited;
  PixelFormat := pf32bit;
  SetLength(Rows, 0);
  SetSize(Width,Height);
end;

procedure TAdvBitmap.SetSize(AWidth, AHeight: Integer);
var i : integer;
begin
  if AHeight <> Height  then begin
    SetLength(Rows, AHeight);
  end;
  inherited;
  for i := 0 to Height - 1 do
    Rows[i] := ScanLine[i];
  Clearbitmap(self);
end;

{ TVisEffects }
{============================ CREATE/DESTROY ================================}

constructor TVisEffects.Create(Width, height : integer);
var i: integer;
begin
  inherited Create;
  FWidth := Width;  FHeight := height;

  FbmExt := nil;
  bmResult := nil;

  for i := 0 to length(FbmL) - 1 do
    FbmL[i] := nil;                  //memory for bitmaps is allocated as needed
  for i := 0 to length(FVis) - 1 do
    FVis[i] := TVisEffectProp.Create();

  FVis[VIS_EFF_BARS].FName := 'Bars';
  FVis[VIS_EFF_PART].Fname := 'Particles';
  FVis[VIS_EFF_BARS].Enabled := true;

  FEnabled := true;
  InitPixels;
  MoveBars;
end;

destructor TVisEffects.Destroy;
var i: integer;
begin
  for i := 0 to length(FbmL) - 1 do
    freeandnil(FbmL[i]);
  for i := 0 to length(FVis) - 1 do
    freeandnil(FVis[i]);
  inherited;
end;

{============================ PROP GET SET ================================}

function TVisEffects.GetVis(Index: integer): TVisEffectProp;
begin
  Result := FVis[Index];
end;
function TVisEffects.GetVisCount : integer;
begin
  result := Length(FVis);
end;

procedure TVisEffects.SetEnabled(const Value: boolean);
begin
  if FEnabled <> Value  then begin
    FEnabled := Value;
    if not FEnabled then begin
      Freebitmaps(false);
    end;
    if FbmExt <> nil then
      ClearBitmap(FbmExt);
  end;
end;

{============================ DRAW ================================}
procedure TVisEffects.Resize(Width, height : integer);
var i: integer;
begin
  FWidth := Width;  FHeight := height;

  for i := 0 to length(FbmL) - 1 do
    FbmL[i].SetSize(Width,Height);
end;

procedure TVisEffects.DoVis(Index: integer; bmInd : integer);
begin

  if bmInd >= 0 then begin
    if not FVis[index].Enabled then begin
      if FVis[index].FadeCount > 0 then begin
         BlurFade(FbmL[bmInd]);
         dec(FVis[index].FadeCount);
      end;
    end else begin
      FVis[index].FadeCount := 100;
    end;

    if index = VIS_EFF_BARS then begin
      if FVis[index].Enabled then begin
        if FVis[index].Blur then
          BlurFade(FbmL[bmInd])
        else
          ClearBitmap(FbmL[bmInd]);
        MoveBars;
        DrawVisBars(FbmL[bmInd]);
      end;
    end;
    if index = Vis_EFF_PART then begin

      if FVis[index].Enabled then begin
        if FVis[index].Blur then
          BlurBitmap(FbmL[bmInd])
        else
          ClearBitmap(FbmL[bmInd]);
        MovePixels;
        DrawPixels(FbmL[bmInd]);
      end;
    end;
  end else begin
    if index = VIS_EFF_BARS then begin
      MoveBars;
      ClearBitmap(FbmExt);
      DrawVisBars(FbmExt);
    end;
  end;
end;

procedure TVisEffects.DrawToBitmap;
begin
  if not FEnabled then exit;
  if not directrender then begin
    if (bmResult = nil) then exit;

    bmExt.Canvas.CopyMode := cmSrcCopy;
    if (bmExt.Width <>bmResult.Width) or (bmExt.Height <> bmResult.Height)  then begin
      bmExt.Canvas.StretchDraw( rect(0,0,bmExt.Width,bmExt.Height) , bmResult);
    end else
      bmExt.Canvas.Draw(0,0,bmResult);
  end else begin
    if FVis[VIS_EFF_BARS].Enabled then // analyzer bars
      DoVis(VIS_EFF_BARS,-1);
  end;

end;

procedure TVisEffects.Freebitmaps(active : boolean); // destroy bitmaps not needed
var i , c: integer;
begin
  c := 0;
  for i := 0 to length(FVis) - 1 do begin
    if  (FVis[i].Enabled  or FVis[i].Drawn) and active then begin
      inc(c);
    end else begin
      if FbmL[i+1] <> nil then begin
        if bmResult = FbmL[i+1] then
          bmResult := nil;
        freeandnil(FbmL[i+1]);
      end;
    end;
  end;
  if c <= 1 then
    if FbmL[0] <> nil then begin
      if bmResult = FbmL[0] then
        bmResult := nil;
      freeandnil(FbmL[0]);
    end;

end;

procedure TVisEffects.RenderNewFrame;
var i, l : integer;
  firstdraw : integer;
begin
  bmResult := nil;
  if not FEnabled then exit;
  if not directrender then begin

    l := 0;
    for i := 0 to length(FVis) - 1 do begin
      FVis[i].Drawn  :=  false;
      if FVis[i].Enabled  or (FVis[i].FadeCount > 0) then begin
        if FbmL[i+1] = nil then begin
          FbmL[i+1] := TAdvBitmap.Create(FWidth,FHeight, pf32bit);
          clearbitmap(FbmL[i+1]);
        end;
        bmResult := FbmL[i+1];
        FVis[i].Drawn  :=  true;
        DoVis(i,i+1);
        inc(l);
      end;
    end;
    Freebitmaps(true);

    if l > 1 then begin
      bmResult := FbmL[0];
      if FbmL[0] = nil then begin
        FbmL[0] := TAdvBitmap.Create(FWidth,FHeight, pf32bit);
        clearbitmap(FbmL[0]);
      end;

      firstdraw := 1;
      FbmL[0].canvas.CopyMode := cmSrcCopy;
      for i := 1 to length(FbmL)-1 do begin
        if FbmL[i] <> nil then begin
          FbmL[0].Canvas.Draw(0, 0, FbmL[i]);
          firstdraw := 0;
        end;
        dec(l);
        if (l> 0) and (firstdraw = 0) then begin
          FbmL[0].canvas.CopyMode := mergemodes[1];
          firstdraw := -1;
        end;
      end;
    end;

    DrawToBitmap;
  end else begin
    Freebitmaps(false);
    if FVis[VIS_EFF_BARS].Enabled then begin
      FVis[VIS_EFF_BARS].FadeCount := 1;
      DoVis(VIS_EFF_BARS,-1);
    end else begin
      //testy
      //DoVis(2,1);
      if FVis[VIS_EFF_BARS].FadeCount > 0 then begin
        ClearBitmap(FbmExt);
        FVis[VIS_EFF_BARS].FadeCount := 0;
      end;
    end;
  end;

end;


{============================ INITIALIZATION ========================}

procedure TVisEffects.InitPixels;
var
  i: Integer;
begin
  Randomize;

  FCursor.X := Fwidth div 2;
  FCursor.Y := Fheight div 2;

  for i := 0 to PIXEL_COUNT - 1 do
    with FPixels[i] do
    begin
      Position.X := Fwidth div 2;//  Random(FbmL1.Width div 2) + FbmL1.Width div 2;
      Position.Y := Fheight div 2;// Random(FbmL1.Height div 2) + FbmL1.Height div 2;

      Speed.X := 0;//Random(100) - 50;
      Speed.Y := 0;//Random(100) - 50;

      FilteredColor.A := 0; // Alpha-channels, not used
      OriginalColor.A := 0;


      OriginalColor.R := 255;//Random(255);
      OriginalColor.G := 255;
      OriginalColor.B := 255;
    end;
end;

{============================ MOVEMENT ==============================}

procedure TVisEffects.MovePixels;
var
  now: Integer; // Current time in milliseconds
  elapsedTime: Real; // Elapsed time since last frame in seconds
  i: Integer;
begin
  //GetCursorPos(FCursor);
  Fcursor.X := Fcursor.X + (random(FWidth) - FWidth div 2) div 8 ;
  Fcursor.Y := Fcursor.Y + (random(FHeight) - FHeight div 2)div 8 ;
  if Fcursor.X < 0 then
    Fcursor.X := 0;
  if Fcursor.X > FWidth  then
    Fcursor.X := FWidth;
  if Fcursor.Y < 0 then
    Fcursor.Y := 0;
  if Fcursor.Y > FHeight  then
    Fcursor.Y := FHeight;
  

  now := GetTickCount;
  elapsedTime := (now - FLastTime) / 1000;
  FLastTime := now;

  if elapsedTime > 0.1 then //limit this time to get better animation with pauses
    elapsedTime := 0.1;

  { Now we know the gravity target (the cursor position) and the
    elapsed time. Let's move the pixels around! }

  for i := 0 to PIXEL_COUNT - 1 do
    UpdatePixel(@FPixels[i], elapsedTime);
end;

procedure TVisEffects.UpdatePixel(const Pixel: PMyPixel; const ElapsedTime: Real);
var
  vector: TRealPoint;
begin
  { Determine direction to move in. In other words, a vector from
    the pixel to the cursor. }

  vector.X := FCursor.X - Pixel.Position.X;
  vector.Y := FCursor.Y - Pixel.Position.Y;

  { Increase the speed in that direction. This change in speed
    depends on the elapsed time. }

  Pixel.Speed.X := Pixel.Speed.X + vector.X * ElapsedTime;
  Pixel.Speed.Y := Pixel.Speed.Y + vector.Y * ElapsedTime;

  { Add some randomness to the speed, this makes the pixels swirl
    around a bit. :) }

  Pixel.Speed.X := Pixel.Speed.X + 100 * (Random - 0.5) * ElapsedTime;
  Pixel.Speed.Y := Pixel.Speed.Y + 100 * (Random - 0.5) * ElapsedTime;

  { Slow them down a little, otherwise they would keep rotating
    around the center of gravity or keep bouncing against walls.
    This also depends on the elapsed time since the last frame. }

  Pixel.Speed.X := (1 - 0.1 * ElapsedTime) * Pixel.Speed.X;
  Pixel.Speed.Y := (1 - 0.1 * ElapsedTime) * Pixel.Speed.Y;

  { Alright, now we know the new speed of this pixel. Time to move
    the pixel to it's new position! Of course this movement also
    depends on the elapsed time. }

  Pixel.Position.X := Pixel.Position.X + Pixel.Speed.X * ElapsedTime;
  Pixel.Position.Y := Pixel.Position.Y + Pixel.Speed.Y * ElapsedTime;

  { Now let's see if we have bounced against a wall... If the pixel went
    for example 20 pixels past a side, we put the pixel back 20 pixels
    inside the wall, plus we reverse the speed. }

  if Pixel.Position.X < 0 then { Left border }
  begin
    Pixel.Position.X := -Pixel.Position.X;

    { Let's change the speed when a pixel hits a wall! By applying a
      random factor of -50% to +50%, it either slows down to half
      its original speed, or it speeds up by 50%, or anything in
      between. This looks really explosive when pixels hit a wall.
      They will fly everywhere! }
      
    Pixel.Speed.X := -1 * (0.5 + Random) * Pixel.Speed.X;
  end;

  if Pixel.Position.Y < 0 then { Top border }
  begin
    Pixel.Position.Y := -Pixel.Position.Y;
    Pixel.Speed.Y := -1 * (0.5 + Random) * Pixel.Speed.Y;
  end;

  if Pixel.Position.X >= FWidth then { Right border }
  begin
    Pixel.Position.X := -Pixel.Position.X + 2 * FWidth;
    Pixel.Speed.X := -1 * (0.5 + Random) * Pixel.Speed.X;
  end;

  if Pixel.Position.Y >= FHeight then { Bottom border }
  begin
    Pixel.Position.Y := -Pixel.Position.Y + 2 * FHeight;
    Pixel.Speed.Y := -1 * (0.5 + Random) * Pixel.Speed.Y;
  end;
end;



{============================ DRAWING ===============================}


procedure TVisEffects.DrawPixels(bm : TadvBitmap);
var
  i, x, y, w, h: Cardinal;
  p: PMyPixel;
  location, color: DWORD;
begin
  { You can choose between ClearBitmap and BlurBitmap. }


  w := bm.Width;
  h := bm.Height;

  ApplyColorFilter;

  for i := 0 to PIXEL_COUNT - 1 do
  begin
    p := @FPixels[i];

    { This assigns a pointer to the pixel. We call it 'p'. Using a
      simple pointer like this instead of using the full
      'FPixels[i]' all the time, makes the code much more readable.
      Next we check if the pixel is within the frame borders, just
      to be sure. Resizing the window to a smaller size may put
      pixels outside the window. Even when we would not resize the
      window, it never hurts to double-check the position of each
      pixel. All this checking does have impact on the speed of the
      application of course and there is probably a faster solution.
      In the ideal situation, I would convert the whole application
      to assembler, but this a delphi contest and I want to leave
      some actual pascal in here. ;) }

    if (p.Position.X < 0) or (p.Position.X >= w) or
      (p.Position.Y < 0) or (p.Position.Y >= h) then continue;

    y := Floor(p.Position.Y);
    x := Floor(p.Position.X);

    { We need the exact memory location of the pixel. FRows[y]
      points to the start of the row. Every pixel uses 4 bytes, so
      the actual memory offset is 4 times X. To multiply by 4, we
      can simply shift 2 bits to the left. I typecast our own
      packed color record to a DWORD, because that's what this
      packed color record actually is in the bitmap, a double word. }

    location := DWORD(bm.Rows[y]) + x shl 2;
    color := DWORD(p.FilteredColor);
    SetPixel(location, color);

    { We can not simply do something like 'location^ := color'
      because that only sets 1 byte. And we want to set 4 bytes at
      once. We could do something like:

      FRows[y][x shl 2 +0] := p.Color.A;
      FRows[y][x shl 2 +1] := p.Color.R;
      FRows[y][x shl 2 +2] := p.Color.G;
      FRows[y][x shl 2 +3] := p.Color.B;

      But I can't imagine that that's faster. So I use a really
      small asm routine to set 4 bytes at once. }
  end;
end;


procedure TVisEffects.ApplyColorFilter;
var
  tc, interval, fraction, i: Integer;
  MaxCount: integer;
  StartCount : integer;
begin
  tc := GetTickCount;
  interval := (tc and (4 * 16384 - 1)) shr 14; // 4 intervals of 16 seconds
  fraction := tc and 16383; // time within an interval

 StartCount := 0;
 MaxCount := 0;

 while MaxCOunt < PIXEL_COUNT do begin
  MaxCount := MaxCount +250;
  if MaxCount > PIXEL_COUNT then
    MaxCount := PIXEL_COUNT;
  
  if interval = 0 then // First interval, red/green --> blue/green
    for i := StartCount to MaxCount - 1 do
      with FPixels[i] do
      begin
        FilteredColor.R := (OriginalColor.R * (16384 - fraction)) shr 14;
        FilteredColor.G := OriginalColor.G; // fixed
        FilteredColor.B := (OriginalColor.B * fraction) shr 14;
      end;

  if interval = 1 then // Second interval, blue/green --> blue/red
    for i := StartCount to MaxCount - 1 do
      with FPixels[i] do
      begin
        FilteredColor.R := (OriginalColor.R * fraction) shr 14;
        FilteredColor.G := (OriginalColor.G * (16384 - fraction)) shr 14;
        FilteredColor.B := OriginalColor.B; // fixed
      end;

  if interval = 2 then // Third interval, blue/red --> all colors
    for i := StartCount to MaxCount - 1 do
      with FPixels[i] do
      begin
        FilteredColor.R := OriginalColor.R;
        FilteredColor.G := (OriginalColor.G * fraction) shr 14;
        FilteredColor.B := OriginalColor.B;
      end;

  if interval = 3 then // Fourth interval, all colors --> red/green
    for i := StartCount to MaxCount - 1 do
      with FPixels[i] do
      begin
        FilteredColor.R := OriginalColor.R;
        FilteredColor.G := OriginalColor.G;
        FilteredColor.B := (OriginalColor.B * (16384 - fraction)) shr 14;
      end;
  StartCount := MaxCount;
  inc(interval);
  if interval > 3 then interval := 0;
 end;
end;



procedure TVisEffects.SetPixel(Location, Value: DWORD); assembler;
asm
  mov [edx], ecx
end;


procedure TVisEffects.MoveBars ();
var i,val, divi,incr: integer;
begin
  for i := 0 to NUM_VIS_BARS-1 do begin
    val := Random(256);

    case i of
      0..4 : divi := 2;
      10..NUM_VIS_BARS-1 : divi := 2;
      else  divi := 5;
    end;

    incr := (val - VisBarValues[i]);
    if incr > 0 then begin
//      if visValues[i] < 128 then incr := incr div 2;
      incr := incr div divi;
      if incr = 0 then incr := 1;
    end else begin
//      if visValues[i] > 128 then incr := incr div 2;
      incr := incr div divi;
      if incr = 0 then incr := -1;
    end;
    VisBarValues[i] := VisBarValues[i] + incr;
    if VisBarValues[i] > 255 then
      VisBarValues[i] := 255
    else if VisBarValues[i] < 0 then
      VisBarValues[i] := 0;

  end;
end;

procedure TVisEffects.DrawVisBars (bm : Tbitmap);
  procedure drawvertbar(bm : Tbitmap ;pos: integer;hsize : integer; vsize : integer);
  var
    l : integer;
    t : integer;
    rec : Trect;
    center : integer;
  begin
    center := bm.Height div 2;
    l := pos*hsize*2 + hsize + ((bm.Width - FWidth) div 2);
    t := center - (((FHeight div 2) * vsize) div 511);
    rec := rect(l, t, l+ hsize-2,center-t + center);

    bm.Canvas.Brush.Color := clred;
    bm.Canvas.FillRect(rec);

    rec.top := (center + rec.top) div 2;
    rec.Bottom := (center + rec.bottom) div 2;
    rec.Left := rec.Left + hsize div 4;
    rec.right := rec.right - hsize div 4;
    bm.Canvas.Brush.Color := rgb(255,vsize,0);
    bm.Canvas.FillRect(rec);
  end;
  var
  i : integer;
begin

  for i := 0 to NUM_VIS_BARS-1 do begin
    drawvertbar(bm,i, FWidth  div (NUM_VIS_BARS*2), VisBarValues[i]);
  end;
end;


{============================ BLUR FX ===============================}
procedure TVisEffects.BlurFade(bm : TAdvBitmap);
var
  h,w: integer;
  off, i : cardinal;
begin

  h:= bm.Height;
  w:= bm.Width;
  off := h div 2;
  {for i := 0 to h-1 do begin
    p:= bm.ScanLine[i];

    if i < off then begin
      p2 := bm.ScanLine[i+1];
    end else begin
      p2 := bm.ScanLine[i-1];
    end;
    BlurFadeRows(p, p2, w);
  end;}
  for i := 0 to off-1 do begin
    BlurFadeRows(bm.Rows[i], bm.Rows[i+1], w, 4);
  end;
  for i := h-1 downto off  do begin
    BlurFadeRows(bm.Rows[i], bm.Rows[i-1], w, 4);
  end;

  // Make the left and right  borders black
  off := 4 * (w - 1); // the x value of the right border
  for i := 0 to h - 2 do
  begin
    SetPixel(DWORD(bm.Rows[i]), 0); // left
    SetPixel(DWORD(bm.Rows[i]) + off, 0); // right
  end;
end;


procedure TVisEffects.BlurBitmap(bm: TAdvBitmap);
var
  y, offset: Cardinal;
  w, h: Cardinal;
begin
  w := bm.Width;
  h := bm.Height;

  { We take 1 pixel, plus the 3 pixels below this top pixel, like this...

        +---+
        | 1 |
    +---+---+---+
    | 2 | 3 | 4 |
    +---+---+---+

    ...and then we take the average and put that back in the top
    pixel. We skip the bottom row of the bitmap (because obviously
    there are no pixels to average below the bottom row) and we skip
    the left and right column, because they have no pixels left and
    right of them. }
  //lastblur := 76; //test
  //ZeroBitmap(FRows[0], w);

  if Lastblur > 100  then begin
    if lastblur > 135 then begin
      for y := 0 to h - 3 do
        BlurRow(bm.Rows[y], bm.Rows[y + 1], w); //move up
    end else begin
      for y := 1 to h-2  do
        BlurRow(bm.Rows[y-1],bm.Rows[y+1] , w); //fade
    end;
    dec(cnt);
    y := h-2;
    if cnt < 0 then begin
      BlurRow(bm.Rows[y], bm.Rows[y-10], w); //fade bottom row
      cnt := 10;
    end;

    if random(100) > 30 then
      dec(LastBlur)
    else
      inc(LastBlur);
    if LastBlur <= 100 then begin
      LastBlur := 50;
    end;
  end else begin
    if lastblur < 75 then begin
      for y := 0 to h - 2 do // original blur, falling
        BlurRow(bm.Rows[y+1], bm.Rows[y], w);
      //FForm.Caption := '2';
    end else begin
      for y := 1 to h-1  do
        BlurRow(bm.Rows[y], bm.Rows[y], w); // no move
      //FForm.Caption := '3';
    end;

    if random(100) > 30 then
      inc(LastBlur)
    else
      dec(LastBlur);
    if LastBlur > 100 then begin
      LastBlur := 150;
    end;
  end;


  // Make the left, right and bottom borders black
  offset := 4 * (w - 1); // the x value of the right border
  for y := 0 to h - 2 do
  begin
    SetPixel(DWORD(bm.Rows[y]), 0); // left
    SetPixel(DWORD(bm.Rows[y]) + offset, 0); // right
  end;

  ZeroBitmap(bm.Rows[0], w);
  ZeroBitmap(bm.Rows[h - 1], w);
end;

procedure TVisEffects.BlurRow(ThisRow, NextRow: Pointer; Width: Integer); assembler;
asm
  { The first and second arguments are always put in the
    registers EDX and ECX. The rest is accessible through their
    variable names as we will see in a moment.

    So EAX = available, EBX = reserved, EDX = ThisRow, ECX = NextRow.

    At the end of this procedure, EBX must still contain the same
    value as EBX had at the start. That's a requirement in pure
    assembler functions, because EBX contains the memory location to
    where the application should jump back to, once this procedure
    has ended. But we need EBX for ourselves! So we push EBX onto the
    stack to save it. At the end of this procedure, we will pull
    this original value of EBX off the stack, so that EBX has its
    original value again. }

  push ebx

  { Now EAX = available, EBX = available, ECX = row 2, EDX = row 1.
    We need ECX as the counter register, so we move the current
    contents of EBX (which is the pointer to row 2) onto EBX. }

  mov ebx, ecx

  { Now EAX = available, EBX = row 2, ECX = available, EDX = row 1.
    Now we will put the Width argument of this procedure into ECX.
    That's our pixel counter for the loop. }

  mov ecx, Width

  //  |    Pixel 1    |    Pixel 2    |    Pixel 3    |

  //  +---+---+---+---+---+---+---+---+---+---+---+---+
  //  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |10 |11 |12 |  Row 1 ('ThisRow')
  //  +---+---+---+---+---+---+---+---+---+---+---+---+
  //  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |10 |11 |12 |  Row 2 ('NextRow')
  //  +---+---+---+---+---+---+---+---+---+---+---+---+
  //
  //    A   B   G   R   A   B   G   R   A   B   G   R

  { These are the first 3 pixels of 2 lines (or rows, whatever you
    wanna call them.) Every pixel takes up 4 bytes: Red, green, blue
    and an alpha channel. The order is ABGR. The alpha channel is
    not being used. So we have have 4 bytes per pixel, which means
    this is a 32 bits bitmap. (4 * 8 bits = 32 bits.) We could have
    used a 24 bits bitmap (with 3 bytes per pixel), but 32 bits
    bitmaps are often easier to handle, because working with 4 bytes
    is often easier/faster than 3 bytes. For example, dividing by 4
    is easier and faster than dividing by 3. Dividing by 4 can
    simply be done by shifting a value 2 bits to the right, whereas
    dividing by 3 takes an actual calculation. There are more
    examples to think of, so working with 32 bits bitmaps is usually
    easier and faster to work with when you do graphics.

    The idea is to average 4 pixels: Pixel 2 from row 1, and the 3
    pixels from row 2. Why are we adding the center pixel from
    row 1? Because then we have 4 pixels and like I just explained,
    averaging 4 pixels (dividing by 4) is much faster than dividing
    by 3. This difference in speed will not make much of a
    difference, if you use it for just a handful divisions, but when
    you're having like a 1280x1024 screen and you want to reach at
    least 25 FPS, then we're facing about 98 million divisions per
    second. Do the math. ;)

        +---+
        | 1 |
    +---+---+---+
    | 2 | 3 | 4 |
    +---+---+---+

    So that is what we do. We calculate take the average of these 4
    values and put that average back into byte 1, the top pixel. The
    leftmost pixel in a row does not have a pixel at its bottom
    left (that would lay outside of the bitmap), which is why we
    skip the leftmost pixel in reach row. The same counts for the
    rightmost pixel in each row. So we will loop through all the
    pixels in the row, except the leftmost and rightmost pixel.
    Therefore, we need to subtract 2 from the counter. }

  sub ecx, 2

  { EAX = available, EBX = row 2, ECX = counter, EDX = row 1.

    The pointer in row 1 is still pointing to the pixel left of
    byte 1 so we need to move the pointer forward by 1 pixel.
    That's 4 bytes of course: RGBA. }

  add edx, 4

  { Alright, we're all set. Time to start the blurring loop! Or
    actually I should say loops. We have an 'outer loop' and
    an 'inner loop'. The outer loop walks through all the pixels,
    one by one. The inner loop repeats 3 times for every pixel: once
    for red, for green and for blue. We skip the alpha channel. }

  @outerLoop:                 { the start of the 'pixel loop' }

    push ecx                  { Save the pixel counter, we
                                need ECX for the inner loop. }

    mov ecx, 3                { Set the counter to 3. }

  @innerLoop:                 { start of the 'RGB loop' }

    xor eax, eax              { We will use EAX to calculate the
                                sum of the 4 bytes. First we set EAX
                                to 0. We could do 'mov eax, 0' but
                                it is usual to do that with xor. }

  { Now we will calculate the sum of the 4 bytes.

        +---+
        | 1 |
    +---+---+---+
    | 2 | 3 | 4 |
    +---+---+---+
  }

    mov byte ptr al, [edx]    { Move byte 1 into AL. EAX is a DWORD,
                                a 4 byte register, but we only want
                                to copy 1 byte. That is why we copy
                                [EDX] to AL (the first byte of EAX)
                                instead of EAX. If we would copy
                                [EDX] to EAX, then 4 bytes would
                                be copied. }

    { |   Extra 16 bits   | High (AH) | Low  (AL) |
      +---------+---------+-----------+-----------+
      |         |         |           |           |
      |    4    |    3    |     2     |     1     |
      |         |         |           |           |
      +---------+---------+-----------+-----------+

       4 * 8 bits = 32 bits register EAX
    }


    add byte ptr al, [ebx]    { And add byte 2... }

    { Now because we have put another byte in AL, AL could overflow.
      Remember, a byte value can be 255 max! What happens if AL
      overflows 255? Then the so-called 'carry bit' is set. We check
      for that. If the carry bit is set, then we need to add 1 to
      the byte next to AL, called AH. (AL and AH stand for
      Accumulator Low and High.) In fact, we check if the carry bit
      is NOT set. If that is the case, then we skip the code
      for adding 1 to that byte, by jumping over it! }

    jnc @cont1                { Jump Not Carry, to label @cont1. }
    inc ah                    { Otherwise increase AH by 1.. }
    clc                       { ..and clear the carry bit again. }

  @cont1:                     { (cont as in continue) }

    add byte ptr al, [ebx+4]  { Now add byte 3. That's 4 bytes
                                offset from EBX. }
    jnc @cont2                { Same carry checks again... }
    inc ah
    clc

  @cont2:

    add byte ptr al, [ebx+8]  { Add byte 4... }
    jnc @cont3                { bla bla }
    inc ah
    clc

  @cont3:

    shr eax, 2                { Alright, we have all 4 bytes summed
                                up in EAX! Now we divide EAX by 4,
                                simply by shifting the whole
                                register 2 bits to the right. }

    mov byte ptr [edx], al    { And put the result back in byte 1! }


    inc edx                   { Time for the next color of the 3.. }
    inc ebx                   { ..by increasing the pointers of
                                both rows by 1 byte. }

    loop @innerLoop           { Ok, next color! This loops back to the
                                label @innerLoop until ECX is 0.
                                This loop function automatically
                                decreases ECX by 1 everytime. }

  { Ok, at this point the loop seems to be done because 'loop' hasn't
    jumped back to @innerLoop. So all 3 colors are averaged in this
    pixel. Next would be the alpha channel, but we skip that because
    it doesn't do anything. Move both pointers another byte forward.. }

    inc edx                   { row 1, increase pointer by 1 byte }
    inc ebx                   { row 2, increase pointer by 1 byte }

  { Retrieve the pixel counter, that we had put on the stack,
    just before the inner loop started. }

    pop ecx

    loop @outerLoop           { Alright, next pixel! That completes
                                the outer loop. }

  { And remember that we put EBX on the stack, at the start of the
    procedure? Now we pop EBX back from the stack. }

    pop ebx                   { That's all! }
end;

procedure TVisEffects.BlurFadeRows(ThisRow, NextRow: Pointer; Width: Integer; FadeDivisor: integer); assembler;
asm
  { The first and second arguments are always put in the
    registers EDX and ECX. The rest is accessible through their
    variable names as we will see in a moment.

    So EAX = available, EBX = reserved, EDX = ThisRow, ECX = NextRow.

    At the end of this procedure, EBX must still contain the same
    value as EBX had at the start. That's a requirement in pure
    assembler functions, because EBX contains the memory location to
    where the application should jump back to, once this procedure
    has ended. But we need EBX for ourselves! So we push EBX onto the
    stack to save it. At the end of this procedure, we will pull
    this original value of EBX off the stack, so that EBX has its
    original value again. }

  push ebx

  { Now EAX = available, EBX = available, ECX = row 2, EDX = row 1.
    We need ECX as the counter register, so we move the current
    contents of EBX (which is the pointer to row 2) onto EBX. }

  mov ebx, ecx

  { Now EAX = available, EBX = row 2, ECX = available, EDX = row 1.
    Now we will put the Width argument of this procedure into ECX.
    That's our pixel counter for the loop. }

  mov ecx, Width

  { We will loop through all the
    pixels in the row, except the leftmost and rightmost pixel.
    Therefore, we need to subtract 2 from the counter. }

  sub ecx, 2

  { EAX = available, EBX = row 2, ECX = counter, EDX = row 1.

    The pointer in row 1 is still pointing to the pixel left of
    byte 1 so we need to move the pointer forward by 1 pixel.
    That's 4 bytes of course: RGBA. }

  add edx, 4

  { Alright, we're all set. Time to start the blurring loop! Or
    actually I should say loops. We have an 'outer loop' and
    an 'inner loop'. The outer loop walks through all the pixels,
    one by one. The inner loop repeats 3 times for every pixel: once
    for red, for green and for blue. We skip the alpha channel. }

  @outerLoop:                 { the start of the 'pixel loop' }

    push ecx                  { Save the pixel counter, we
                                need ECX for the inner loop. }

    mov ecx, 3                { Set the counter to 3. }

  @innerLoop:                 { start of the 'RGB loop' }

    xor eax, eax              { We will use EAX to calculate the
                                sum of the 4 bytes. First we set EAX
                                to 0. We could do 'mov eax, 0' but
                                it is usual to do that with xor. }

  { Now we will calculate the sum of the 4 bytes.

        +---+
        | 1 |
    +---+---+---+
    | 2 | 3 | 4 |
    +---+---+---+
  }

    mov byte ptr al, [edx]    { Move byte 1 into AL. EAX is a DWORD,
                                a 4 byte register, but we only want
                                to copy 1 byte. That is why we copy
                                [EDX] to AL (the first byte of EAX)
                                instead of EAX. If we would copy
                                [EDX] to EAX, then 4 bytes would
                                be copied. }

    { |   Extra 16 bits   | High (AH) | Low  (AL) |
      +---------+---------+-----------+-----------+
      |         |         |           |           |
      |    4    |    3    |     2     |     1     |
      |         |         |           |           |
      +---------+---------+-----------+-----------+

       4 * 8 bits = 32 bits register EAX
    }


    add byte ptr al, [ebx]    { And add byte 2... }

    { Now because we have put another byte in AL, AL could overflow.
      Remember, a byte value can be 255 max! What happens if AL
      overflows 255? Then the so-called 'carry bit' is set. We check
      for that. If the carry bit is set, then we need to add 1 to
      the byte next to AL, called AH. (AL and AH stand for
      Accumulator Low and High.) In fact, we check if the carry bit
      is NOT set. If that is the case, then we skip the code
      for adding 1 to that byte, by jumping over it! }

    jnc @cont1                { Jump Not Carry, to label @cont1. }
    inc ah                    { Otherwise increase AH by 1.. }
    clc                       { ..and clear the carry bit again. }

  @cont1:                     { (cont as in continue) }

    add byte ptr al, [ebx+4]  { Now add byte 3. That's 4 bytes
                                offset from EBX. }
    jnc @cont2                { Same carry checks again... }
    inc ah
    clc

  @cont2:

    add byte ptr al, [ebx+8]  { Add byte 4... }
    jnc @cont3                { bla bla }
    inc ah
    clc

  @cont3:

    shr eax, 2                { Alright, we have all 4 bytes summed
                                up in EAX! Now we divide EAX by 4,
                                simply by shifting the whole
                                register 2 bits to the right. }


    mov byte ptr [edx], al    { And put the result back in byte 1! }
    shr eax, 5                { Divide by some value}
    sub byte ptr [edx], al    { sub it from result to atenuate}


    inc edx                   { Time for the next color of the 3.. }
    inc ebx                   { ..by increasing the pointers of
                                both rows by 1 byte. }

    loop @innerLoop           { Ok, next color! This loops back to the
                                label @innerLoop until ECX is 0.
                                This loop function automatically
                                decreases ECX by 1 everytime. }

  { Ok, at this point the loop seems to be done because 'loop' hasn't
    jumped back to @innerLoop. So all 3 colors are averaged in this
    pixel. Next would be the alpha channel, but we skip that because
    it doesn't do anything. Move both pointers another byte forward.. }

    inc edx                   { row 1, increase pointer by 1 byte }
    inc ebx                   { row 2, increase pointer by 1 byte }

  { Retrieve the pixel counter, that we had put on the stack,
    just before the inner loop started. }

    pop ecx

    loop @outerLoop           { Alright, next pixel! That completes
                                the outer loop. }

  { And remember that we put EBX on the stack, at the start of the
    procedure? Now we pop EBX back from the stack. }

    pop ebx                   { That's all! }
end;



end.


