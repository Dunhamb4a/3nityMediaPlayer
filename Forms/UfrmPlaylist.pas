{

	3nity Media Player, an MPlayer frontend for Windows

	Copyright (C) 2010-2019 Nicolas DEOUX  < nicolas.deoux@gmail.com >
									<http://3nitysoftwares.com>

    Original source code 2008-2010 Visenri  <http://sourceforge.net/projects/mpui-ve/>
    Original source code (2005) by Martin J. Fiedler <martin.fiedler@gmx.net>>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}
{Special Note for Developers:

    This code can be compiled using Embarcadero Delphi XE2 -> to Delphi 10.3 Rio( i'm using XE7 )
    You will need to install Alphaskin and OmniThreadLibrary components.
    For special questions or if you want to hire a delphi developer you can contact me:  nicolas.deoux@gmail.com
}

unit UfrmPlaylist;

interface
{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShellAPI, VssDockForm, UVssProgressForm, sListBox,
  ExtCtrls;

  type
  TPlaybackState=(psNotPlayed,psPlaying,psPlayed,psSkipped);
  TPlaylistEntry=record
    State:TPlaybackState;
    LastPlayed: boolean;
    Selected:boolean;
    FullURL:string;
    DisplayURL:string;
    DisplayTime : string;
  end;

  TPlaylist=class
  private
    frmProg : TVssProgressForm;
    Data:array of TPlaylistEntry;
    function GetCount:integer;
    function GetItem(Index:integer):TPlaylistEntry;
    function GetSelected(Index:integer):boolean;
    procedure SetSelected(Index:integer; Value:boolean);
    function GetProcessingFiles: Boolean;
  public
    Shuffle,Loop:boolean;

    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function Add(const Entry:TPlaylistEntry):integer; overload;
    function Add(const URL:string):integer; overload;
    function AddFromPlaylist(const FileName:string):boolean;
    procedure AddDirectory(Directory:string);
    property Count:integer read GetCount;
    property Items[Index:integer]:TPlaylistEntry read GetItem; default;
    property Selected[Index:integer]:boolean read GetSelected write SetSelected;
    function GetNext(ExitState:TPlaybackState; Direction:integer; Test : boolean = false):integer;
    function CanDoPrev : boolean;
    function CanDoNext : boolean;
    function GetCurrent(Getlastplay : boolean = false):integer;
    procedure NowPlaying(Index:integer);
    procedure Changed;
    procedure MoveSelectedUp(nPos: integer = 1);
    procedure MoveSelectedDown(nPos: integer = 1);
    procedure SaveToFile(const FileName:string);
    property ProcessingFiles : Boolean read GetProcessingFiles;
  end;


  TfrmPlayList = class(TVssDockForm)
    PlaylistBox: TsListBox;
    BPlay: TBitBtn;
    BAdd: TBitBtn;
    BMoveUp: TBitBtn;
    BMoveDown: TBitBtn;
    BDelete: TBitBtn;
    CShuffle: TCheckBox;
    CLoop: TCheckBox;
    BSave: TBitBtn;
    SavePlaylistDialog: TSaveDialog;
    btnClose: TBitBtn;
    procedure PlaylistBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnCloseClick(Sender: TObject);
    procedure PlaylistBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PlaylistBoxStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure PlaylistBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
      procedure ChangeColor(bmp: TBitmap; Color1, Color2: TColor);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure PlaylistBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure BPlayClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure BMoveClick(Sender: TObject);


    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CShuffleClick(Sender: TObject);
    procedure CLoopClick(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    FirstShow:boolean;
    BMPpsPlaying,BMPpsPlayed,BMPpsSkipped:TBitmap;
    SrcPos : integer;
    StartingPoint : TPoint;
    Dragstarted : boolean;

    procedure FormDropFiles(var msg:TMessage); message WM_DROPFILES;
    procedure MoveItems(nPos : integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }    
    
    widthchanged : boolean;
    procedure checkEmptyPlaylist;
    procedure DoLocalize(); override;
    procedure SetCurrentDuration(const Duration:string);
  end;

var
  frmPlaylist: TfrmPlayList;
  Playlist: TPlaylist;


implementation

uses UfrmMain, URL, Locale, mplayer, FileUtils, VssPlaylist;

{$R *.dfm}
{$R Playlist_img.res}

function LoadBitmapResource(const ResName:string):TBitmap;
begin
  Result:=TBitmap.Create;
  Result.LoadFromResourceName(HInstance,ResName);
end;

procedure TPlaylist.Clear;
begin
  SetLength(Data,0);
end;

constructor TPlaylist.Create;
begin
  inherited;
  frmProg := nil;
end;

destructor TPlaylist.Destroy;
begin
  if frmProg <> nil then
    frmProg.Free;
  inherited;
end;

function TPlaylist.Add(const Entry:TPlaylistEntry):integer;
begin
  Result:=length(Data);
  SetLength(Data,Result+1);
  Data[Result]:=Entry;
  Changed;
end;

function TPlaylist.Add(const URL:string):integer;
type
  TOpenError=(OeNone,OeNodisc,OeNoDrive,OeNofiles);
var Entry:TPlaylistEntry; drivestring :array[0..3]of char;
  URLError : TOpenError;
  driveType : Cardinal;
begin

  URLError := OeNone;
  Result := -1;

  //check for error
  if Length(URL) = 2 then begin
    if copy(URL,2,1) = ':' then  begin
        drivestring :=  '@:\';
        drivestring[0] := URL[1];
        driveType := GetDriveType(drivestring);
        if driveType = DRIVE_NO_ROOT_DIR then begin
          Result := -1;
          URLError := OeNoDrive;
        end else begin
          if not DirectoryExists(drivestring) then begin
            Result := -1;
            URLError := OeNodisc;
          end;
        end;
    end;
  end;

  if URLError = OeNone then begin
    // check for directory
    if DirectoryExists(URL) then begin
      AddDirectory(URL);
      Result:=High(Data);
    end else begin
      // check for .m3u playlist file
      if TVssPlayListFile.IsValidPlaylistFile(URL) then begin
        AddFromPlayList(URL);

        Result:=High(Data);
      end else begin
        // no playlist -> enter directly
        with Entry do begin
          State:=psNotPlayed;
          lastplayed := false;
          FullURL:=URL;
          Displaytime := '';
          MakeURL(URL, DisplayURL);
        end;
        Result:=Add(Entry);
      end;
    end;
    if Result < 0 then
      URLError := OeNofiles;
  end;

  case URLError of
    OeNoDrive:
      application.MessageBox('No Drive','Error', mb_Ok + MB_ICONEXCLAMATION);
    OeNodisc:
      application.MessageBox('No disc','Error', mb_Ok + MB_ICONINFORMATION);
    OeNofiles:
      application.MessageBox('No Playable files ','Error', mb_Ok + MB_ICONINFORMATION);
  end;

end;

function TPlaylist.GetCount:integer;
begin
  Result:=length(Data);
end;

function TPlaylist.GetItem(Index:integer):TPlaylistEntry;
begin
  if (Index<Low(Data)) OR (Index>High(Data))
    then raise ERangeError.Create('invalid playlist item')
    else Result:=Data[Index];
end;

function TPlaylist.GetSelected(Index:integer):boolean;
begin
  if (Index<Low(Data)) OR (Index>High(Data))
    then raise ERangeError.Create('invalid playlist item')
    else Result:=Data[Index].Selected;
end;

procedure TPlaylist.SetSelected(Index:integer; Value:boolean);
begin
  if (Index<Low(Data)) OR (Index>High(Data))
    then raise ERangeError.Create('invalid playlist item')
    else Data[Index].Selected:=Value;
end;

function TPlaylist.GetCurrent(Getlastplay : boolean = false):integer;
var i:integer;
    lastplay : integer;
begin
  Result:=-1;
  lastplay := -1;
  for i:=Low(Data) to High(Data) do begin
    if not getlastplay then
      if Data[i].State=psPlaying then begin
        Result:=i;
        exit;
      end;
    if Data[i].LastPlayed then begin
      lastplay:=i;
      if getlastplay then
        break;
    end;
  end;
  if lastplay <> -1 then
    result := lastplay;
end;

function TPlaylist.GetNext(ExitState:TPlaybackState; Direction:integer; Test : boolean = false):integer;
var i,Count:integer;
begin
  Result:=GetCurrent;
  // mark current track as played
  if (result >= 0) and (not Test) then begin
    if Data[Result].State = psPlaying then
      Data[Result].State:=ExitState;
  end;
  if Shuffle then begin
    // ***** SHUFFLE MODE *****
    if Loop then
      Result:=Random(length(Data))
    else begin
      // unplayed tracks left?
      Count:=0;
      for i:=Low(Data) to High(Data) do
        if Data[i].State=psNotPlayed then
          inc(Count);
      // find a track
      if Count=0 then
        Result:=-1
      else repeat
        Result:=Random(length(Data));
      until Data[Result].State=psNotPlayed;
    end;
  end else begin
    // ***** NORMAL MODE *****
    inc(Result,Direction);
    if Result<0 then Result:=0;
    if Result>High(Data) then begin
      if Loop then Result:=Low(Data)
              else Result:=-1;
    end;
    if Result<Low(Data) then begin
      if Loop then Result:=High(Data)
              else Result:=-1;
    end;
  end;
  Changed;
end;

function TPlaylist.GetProcessingFiles: Boolean;
begin
  Result := frmProg <> nil;
end;

function TPlaylist.CanDoPrev : boolean;
var  PLI : integer;
begin
  PLI:=GetCurrent;
  Result:=((PLI>0) OR Shuffle or loop) and ( count> 1);
end;
function TPlaylist.CanDoNext : boolean;
var  PLI : integer;
begin
  PLI:=GetCurrent;
  Result:=((PLI+1<Count) OR Shuffle or loop) and (Count > 1);
end;


procedure TPlaylist.NowPlaying(Index:integer);
var ind: integer;
begin
  ind := GetCurrent(true);
  if ind >= 0 then begin
    Data[ind].LastPlayed :=false;
  end;

  if (Index<Low(Data)) OR (Index>High(Data)) then exit;
  Data[Index].State:=psPlaying;
  Data[Index].LastPlayed := true;
  Changed;
end;


procedure TPlaylist.Changed;
var oldIndex : integer ;
    oldSelected : boolean;
begin
  frmPlaylist.checkemptyPlaylist;
  frmMain.UpdatePrevNext;
  frmMain.UpdatePlay;
  if not frmPlaylist.Visible then exit;
  oldIndex := frmPlaylist.PlaylistBox.ItemIndex;
  if frmPlaylist.PlaylistBox.Count<>Count then begin
    oldSelected := false;
    if oldIndex > -1 then
      oldSelected := frmPlaylist.PlaylistBox.Selected[oldIndex];
    frmPlaylist.PlaylistBox.Count:=Count;
    if (oldIndex > -1) and (frmPlaylist.PlaylistBox.Count> 0)  then begin
      if oldIndex > frmPlaylist.PlaylistBox.Count-1 then
        oldIndex := frmPlaylist.PlaylistBox.Count-1;
      frmPlaylist.PlaylistBox.ItemIndex := oldIndex;
      if oldselected then
        frmPlaylist.PlaylistBox.Selected[oldIndex]:= true;
    end;
  end;
  frmPlaylist.PlaylistBox.Invalidate;

end;

procedure TPlaylist.MoveSelectedUp (nPos: integer = 1);
var i:integer; temp:TPlaylistEntry;
begin
  for i:=nPos to High(Data) do
    if Data[i].Selected AND not(Data[i-nPos].Selected) then begin
      temp:=Data[i];
      Data[i]:=Data[i-nPos];
      Data[i-nPos]:=temp;
    end;
  Changed;
end;

procedure TPlaylist.MoveSelectedDown(nPos: integer = 1);
var i:integer; temp:TPlaylistEntry;
begin
  for i:=(High(Data)-nPos) downto 0 do
    if Data[i].Selected AND not(Data[i+nPos].Selected) then begin
      temp:=Data[i];
      Data[i]:=Data[i+nPos];
      Data[i+nPos]:=temp;
    end;
  Changed;
end;

procedure TPlaylist.SaveToFile(const FileName:string);
var
  pl : TVssPlayListFile;
  i : Integer;
begin
  pl := TVssPlayListFile.Create;
  for i:=Low(Data) to High(Data) do
    pl.Files.Add(data[i].FullURL);
  if not pl.SaveToFile(FileName, True) then
    ShowMessage('Error saving file');

  pl.Free
end;

function TPlaylist.AddFromPlaylist(const FileName: string): boolean;
var
  pl : TVssPlayListFile;
  i : Integer;
begin
  pl := TVssPlayListFile.Create;
  Result := pl.LoadFromFile(FileName);

  if Result then begin
    for i := 0 to pl.Files.Count - 1 do      
      add(pl.FullPathFiles[i]);
  end;

  pl.Free
end;

procedure TPlaylist.AddDirectory(Directory:string);
var SR:TSearchRec; Cont:integer;
    Files,Directories:TStringList;
    i:integer;
    Entry:TPlaylistEntry;
    CancelFormCreated : Boolean;
begin
  CancelFormCreated := False;

  Directory:=ExcludeTrailingPathDelimiter(ExpandUNCFileName(Directory));
  // check for DVD directory
  if (UpperCase(ExtractFileName(Directory))='VIDEO_TS')
  OR (DirectoryExists(Directory+'\VIDEO_TS'))
  then begin
    // if it's a DVD, pass is directly to the URL builder
    with Entry do begin
      State:=psNotPlayed;
      FullURL:=Directory;
      Displaytime := '';
      MakeURL(Directory, DisplayURL);
    end;
    Add(Entry);
    exit;
  end;
  // no DVD -> search the directory recursively

  if frmProg = nil then begin
    frmProg := TVssProgressForm.Create(nil,'Searching files',Directory,True,True);
    frmProg.PopupMode := pmExplicit;
    frmProg.PopupParent := nil;
    frmProg.Show;
    CancelFormCreated := True;
  end else begin
    frmProg.InfoText := Directory;
    frmProg.CicleProgress;
  end;
  //Sleep(1);
  Application.ProcessMessages;
  if frmProg.Canceled then
    Exit;

  Files:=TStringList.Create;
  Files.CaseSensitive:=True;
  Directories:=TStringList.Create;
  Directories.CaseSensitive:=True;
  // build lists
  Cont:=FindFirst(Directory+'\*.*',faAnyFile,SR);
  while Cont=0 do begin
    // exclude POSIXly or Win32ly hidden files
    if (SR.Name[1]<>'.') AND ((SR.Attr AND faHidden)=0) then begin
      if ((SR.Attr AND faDirectory)<>0) then
        Directories.Add(SR.Name)
      else if GetExtension(SR.Name)>0 then
        Files.Add(SR.Name);
    end;
    Cont:=FindNext(SR);
  end;
  FindClose(SR);
  // add directories
  Directories.Sort;
  for i:=0 to Directories.Count-1 do begin
    AddDirectory(Directory+'\'+Directories[i]);
    if frmProg.Canceled then
      Break;
  end;
  Directories.Free;
  // add files
  Files.Sort;
  for i:=0 to Files.Count-1 do begin
    Add(Directory+'\'+Files[i]);
    if frmProg.Canceled then
      Break;
  end;
  Files.Free;

  if CancelFormCreated then begin
    frmProg.Close;
    FreeAndNil(frmProg);
  end;
end;

procedure TfrmPlayList.checkEmptyPlaylist;
begin
  if (Playlist.Count=0) AND not(frmMain.mpo.Running) then begin
    if frmMain.mpo.MediaFile <> '' then
      frmMain.mpo.Closemedia;
  end;
end;

procedure TfrmPlayList.FormCreate(Sender: TObject);
begin
 FirstShow:=true;
  BMPpsPlaying:=LoadBitmapResource('PS_PLAYING');
  BMPpsPlayed :=LoadBitmapResource('PS_PLAYED' );
  BMPpsSkipped:=LoadBitmapResource('PS_SKIPPED');
  //LinkSize := True;
  //width := frmMain.Width;
end;

procedure TfrmPlayList.FormShow(Sender: TObject);
begin
 if FirstShow then begin
    frmplaylist.CShuffle.Checked:= Playlist.shuffle;
    frmplaylist.CLoop.Checked:= Playlist.Loop ;
    FirstShow:=false;
 end;

  if PlaylistBox.Count <> Playlist.Count then
    PlaylistBox.Count:=Playlist.Count;
  DragAcceptFiles(Handle,true);
  frmMain.MShowPlaylist.Checked:=true;
  frmMain.BPlaylist.Down:=true;
end;

procedure TfrmPlayList.FormHide(Sender: TObject);
begin
  DragAcceptFiles(Handle,false);
  frmMain.MShowPlaylist.Checked:=false;
  frmMain.BPlaylist.Down:=false;
end;

procedure TfrmPlayList.PlaylistBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var tp : TPoint;
    dstPos : integer;
begin
  Accept := (Source = PlaylistBox) and Dragstarted;

  if dragstarted then begin
    if srcPos = -2 then begin
      StartingPoint.X :=X;
      StartingPoint.Y :=Y;
      srcPos := PlaylistBox.ItemAtPos(StartingPoint, true);
    end else if (srcPos >= 0) then begin
      tp.X := X;
      tp.Y := Y;
      StartingPoint.X :=X;
      StartingPoint.Y :=Y;
      dstPos := PlaylistBox.ItemAtPos(StartingPoint, true);
      if (dstPos >= 0) and (dstPos <> srcPos) then begin
        MoveItems(dstPos-srcPos);
          srcPos := dstPos;
      end;

    end;
  end;
end;
procedure TfrmPlayList.ChangeColor(bmp: TBitmap; Color1, Color2: TColor);

type

  PRGBArray = ^TRGBArray;

  TRGBArray = array[Word] of TRGBTriple;

var

  Line: PRGBArray;

  x,y: integer;

begin

  // Make sure this is a 24bit bitmap, create exception if it's not

  if not (bmp.PixelFormat = pf24bit) then

  begin

    raise Exception.Create('Not a 24bit bitmap');

    Exit;

  end;



  for y := 0 to bmp.Height - 1 do

  begin

    Line := bmp.Scanline[y];

    for x := 0 to bmp.Width - 1 do

    begin

      if RGB(Line[x].rgbtRed,

             Line[x].rgbtGreen,

             Line[x].rgbtBlue) = Color1 then

      begin

        Line[x].rgbtBlue := GetBValue(Color2);

        Line[x].rgbtGreen := GetGValue(Color2);

        Line[x].rgbtRed := GetRValue(Color2);

      end;

    end;

  end;

end;
procedure TfrmPlayList.PlaylistBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  sz : TSize;
  txtTime : string;
  txtName : string;
  rectT : Trect;

begin
 with PlaylistBox.Canvas do begin
  if(odSelected in state )  then
    Brush.Color := clnavy
  else
    Brush.Color := clBtnFace;

  FillRect(Rect);

  if (Index<0) OR (Index>=Playlist.Count) then exit;
  if (playlist[Index].State = psPlaying) or playlist[Index].LastPlayed then begin
      Font.Style := [fsBold];
  end else begin
    Font.Style := [];
  end;
  if  not Loading then begin

   BMPpsPlaying.Free;
  BMPpsPlayed.Free;
  BMPpsSkipped.Free;
  BMPpsPlaying:=LoadBitmapResource('PS_PLAYING');
  BMPpsPlayed :=LoadBitmapResource('PS_PLAYED' );
  BMPpsSkipped:=LoadBitmapResource('PS_SKIPPED');
  ChangeColor(BMPpsPlaying,clWhite,Font.Color  );
  ChangeColor(BMPpsPlayed,clWhite,Font.Color  );
  ChangeColor(BMPpsSkipped,clWhite,Font.Color  );
    BMPpsSkipped.Mask(16711935);
  BMPpsPlayed.Mask(16711935);
  BMPpsPlaying.Mask(16711935);
  end;
  //FillRect(Rect);
  //copymode := cmSrcPaint;
  copymode := cmSrcCopy	 ;

  with Playlist[Index] do begin
    case State of

      psPlaying:Draw(Rect.Left+3,Rect.Top+1,BMPpsPlaying);
      psPlayed :Draw(Rect.Left+3,Rect.Top+1,BMPpsPlayed);
      psSkipped:Draw(Rect.Left+3,Rect.Top+1,BMPpsSkipped );

    end;

    txtName := inttostr(index+1) + '. ' + DisplayURL;
    txttime := playlist.Data[Index].DisplayTime;

    rectT := rect;
    SZ := TextExtent(' 00:00:00 ');

    rectT.Top := rectt.Top + ((rectt.Bottom - rectt.Top) -SZ.cy) div 2;
    rectT.Right := rectt.Right - SZ.cx;
    rectT.Left :=  rectt.Left + 16;
    TextRect(rectt,txtName);

    if txttime <>'' then begin
      SZ := TextExtent(txttime);
      TextOut(Rect.Right - sz.cx -5,rectT.Top, txttime);
    end;
  end;
 end;
end;

procedure TfrmPlayList.PlaylistBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
    BDeleteClick(nil)
  else if (key = VK_SPACE) OR (key = ord('P')) then
    BPlayClick(nil);

end;

procedure TfrmPlayList.PlaylistBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Dragstarted := false;
end;

procedure TfrmPlayList.PlaylistBoxStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if playlistbox.SelCount <> 0 then begin
    Dragstarted := true;
    srcPos := -2;
  end;
end;
procedure TfrmPlayList.SetCurrentDuration(const Duration: string);
var i : integer;
begin
  i := playlist.GetCurrent();
  if i >= 0 then begin
    playlist.data[i].DisplayTime := Duration;
    PlaylistBox.Invalidate
  end;
end;

procedure TfrmPlayList.BPlayClick(Sender: TObject);
var Index:integer;
begin
  Index:=PlaylistBox.ItemIndex;
  if (Index<0) OR (Index>=Playlist.Count) then exit;
  Playlist.GetNext(psSkipped,0);
  Playlist.NowPlaying(Index);
  frmMain.DoOpen(Playlist[Index].FullURL);
end;

procedure TfrmPlayList.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlayList.BDeleteClick(Sender: TObject);
var iOld,iNew:integer;
begin
  with Playlist do begin
    iNew:=0;
    for iOld:=0 to High(Data) do
      if not PlaylistBox.Selected[iOld] then begin
        if iNew<iOld then Data[iNew]:=Data[iOld];
        inc(iNew);
      end;
    SetLength(Data,iNew);
    Changed;
  end;
end;

procedure TfrmPlayList.BAddClick(Sender: TObject);
var i:integer;
begin
  if not Playlist.ProcessingFiles then begin
    with frmMain.OpenDialog do begin
      Filter := GetPlayableExtensionFilter(True,True,True,True,True,False);
      FilterIndex := frmMain.LastFileFilter;
      Options:=Options+[ofAllowMultiSelect];
      if Execute then begin
        frmMain.LastFileFilter := FilterIndex;
        for i:=0 to Files.Count-1 do
          Playlist.Add(Files[i]);
      end;
    end;
  end;
end;

procedure TfrmPlayList.FormDestroy(Sender: TObject);
begin
  BMPpsPlaying.Free;
  BMPpsPlayed.Free;
  BMPpsSkipped.Free;
end;

procedure TfrmPlayList.FormDropFiles(var msg:TMessage);
var hDrop:THandle;
    i,DropCount:integer;
    fnbuf:array[0..1024]of char;
begin
  hDrop:=msg.wParam;

  if not Playlist.ProcessingFiles then begin
    DropCount:=DragQueryFile(hDrop,cardinal(-1),nil,0);
    for i:=0 to DropCount-1 do begin
      DragQueryFile(hDrop,i,@fnbuf[0],1024);
      Playlist.Add(fnbuf);
    end;
  end;
  
  DragFinish(hDrop);
  msg.Result:=0;
end;

procedure TfrmPlayList.MoveItems(nPos: integer);
var i: integer;
begin
  for i:=0 to (Playlist.Count-1) do
    Playlist.Selected[i]:=PlaylistBox.Selected[i];
  if nPos < 0 then
    Playlist.MoveSelectedUp
  else
    Playlist.MoveSelectedDown;
  for i:=0 to (Playlist.Count-1) do
    if PlaylistBox.Selected[i] <> Playlist.Selected[i] then
      PlaylistBox.Selected[i]:=Playlist.Selected[i];
  PlaylistBox.Invalidate;
end;

procedure TfrmPlayList.BMoveClick(Sender: TObject);
begin
  if (Sender as TComponent).Tag=1 then
    MoveItems(-1)
  else
    Moveitems(+1);
end;

procedure TfrmPlayList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var todo:boolean;handled : boolean;
begin
  todo:=false;
  handled:=true;
 //PostMessage(Application.MainForm.Handle, WM_KEYDOWN, VK_RETURN, 0);
 //TForm(Owner)

  ////////////////////////
  ///
  if ssCtrl in Shift then begin
   case Key of

    Ord('0'):  todo:=true;
    VK_DIVIDE: todo:=true;
    VK_MULTIPLY: todo:=true;

    Ord('O'):   todo:=true;
    Ord('L'):   todo:=true;
    Ord('W'):   todo:=true;
    VK_LEFT: todo:=true;
    VK_RIGHT: todo:=true;
    else handled := false;
   end;
  end else if ssAlt in Shift then begin
   case Key of
    Ord('0'):   todo:=true;
    Ord('1'):   todo:=true;
    Ord('2'):   todo:=true;
    Ord('3'):   todo:=true;
//    Ord('4'):   OMFile.CheckMenuDropdown;
//    Ord('5'):   OMView.CheckMenuDropdown;
//    Ord('6'):   OMSeek.CheckMenuDropdown;
//    Ord('7'):   OMExtra.CheckMenuDropdown;
//    Ord('8'):   OMHelp.CheckMenuDropdown;
    VK_F4:      todo:=true;
    VK_RETURN:  todo:=true;
    else handled := false;
   end;
  end else begin  //touches seules
   case Key of
    VK_RIGHT:  todo:=true;
    VK_LEFT:    todo:=true;
    VK_UP:      todo:=true;
    VK_DOWN:    todo:=true;
    VK_NEXT:   todo:=true;
    VK_PRIOR:    todo:=true;
    VK_SUBTRACT:todo:=true;
    VK_ADD:     todo:=true;
    Ord('M'):   todo:=true;
    Ord('9'):   todo:=true;
    Ord('0'):   todo:=true;
    VK_DIVIDE:  todo:=true;
    VK_MULTIPLY:todo:=true;
    Ord('O'):   todo:=true;
    Ord('1'):   todo:=true;
    Ord('2'):   todo:=true;
    Ord('3'):   todo:=true;
    Ord('4'):   todo:=true;
    Ord('5'):   todo:=true;
    Ord('6'):   todo:=true;
    Ord('7'):   todo:=true;
    Ord('8'):   todo:=true;
    ord('R'):   todo:=true;
    Ord('D'):   todo:=true;
    Ord('F'):   todo:=true;
    Ord('C'):   todo:=true;
    Ord('T'):   todo:=true;
    Ord('S'):   todo:=true;
    //Ord('L'):   todo:=true;
    191:        todo:=true;
    Ord('Q'):   todo:=true;
    VK_RETURN:  todo:=true;
    Ord('P'):   todo:=true;
    VK_SPACE, VK_MEDIA_PLAY_PAUSE: todo:=true;
    VK_TAB:     todo:=true;
    VK_MEDIA_STOP:      todo:=true;
    VK_MEDIA_PREV_TRACK: todo:=true;
    VK_MEDIA_NEXT_TRACK: todo:=true;
    VK_NUMPAD9 : todo:=true;
    VK_NUMPAD5 : todo:=true;
    VK_NUMPAD1 : todo:=true;

    VK_NUMPAD6 : todo:=true;
    VK_NUMPAD8 : todo:=true;
    VK_NUMPAD4 : todo:=true;
    VK_NUMPAD7 : todo:=true;

    ord('V'): todo:=true;
    else handled := false;
   end;
  end;



   if handled then
   begin
    if todo  then
    frmMain.FormKeyDown(nil,Key,Shift);
    Key:=0;
   end;
end;

procedure TfrmPlayList.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if upcase(Key)='L' then Hide;
end;

procedure TfrmPlayList.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  ReleaseCapture;
  SendMessage(Handle, WM_SYSCOMMAND, SC_MOVE+2, 0);
end;

procedure TfrmPlayList.FormResize(Sender: TObject);
begin
  playlistbox.Invalidate;

end;

procedure TfrmPlayList.CShuffleClick(Sender: TObject);
begin
  Playlist.Shuffle:=CShuffle.Checked;
  frmMain.UpdatePrevNext;
end;

procedure TfrmPlayList.DoLocalize;
begin
  inherited;

  Font.Charset:=CurrentLocaleCharset;

  Caption:=LOCstr.PlaylistFormCaption;
  BPlay.Caption:=LOCstr.PlaylistFormPlay;
  BAdd.Caption:=LOCstr.PlaylistFormAdd;
  BMoveUp.Caption:=LOCstr.PlaylistFormMoveUp;
  BMoveDown.Caption:=LOCstr.PlaylistFormMoveDown;
  BDelete.Caption:=LOCstr.PlaylistFormDelete;
  CShuffle.Caption:=LOCstr.PlaylistFormShuffle;
  CLoop.Caption:=LOCstr.PlaylistFormLoop;
  BSave.Caption:=LOCstr.PlaylistFormSave;
end;


procedure TfrmPlayList.CLoopClick(Sender: TObject);
begin
  Playlist.Loop:=CLoop.Checked;
  frmMain.UpdatePrevNext;
end;

procedure TfrmPlayList.CreateParams(var Params: TCreateParams);
begin
  inherited;
  WITH Params DO
    Style := (Style OR WS_POPUP) AND (NOT WS_DLGFRAME);
end;

procedure TfrmPlayList.BSaveClick(Sender: TObject);
begin
  if SavePlaylistDialog.Execute then
    Playlist.SaveToFile(SavePlaylistDialog.FileName);
end;

procedure TfrmPlayList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

initialization
  Playlist:=TPlaylist.Create;
finalization
  Playlist.Free;
end.
