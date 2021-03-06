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
{   to compile:

    This code can be compiled using Embarcadero Delphi XE2 -> to Delphi 10.3 Rio( here using XE7 )
    You will need to install Alphaskin and OmniThreadLibrary components.
    For special questions or if you want to hire a delphi developer you can contact me:  nicolas.deoux@gmail.com
}

unit UfrmMain;
{$DEFINE APPLICATIONFORMSFIX}
//{$DEFINE ACTDEBUGLOG}

interface

uses
  Windows,sThirdParty, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, Menus, ShellAPI, StdCtrls,
  Math, UfrmPlaylist, ImgList, Clipbrd, mplayer, visEffects, VssScrollbar,
  VssDockForm, sSkinProvider, sPanel,sSkinProps, ComCtrls,
  sStatusBar, acSelectSkin, jpeg,FileUtils,
  httpsend,Synautil,
  OtlComm,
  OtlTask,
  OtlTaskControl,
  OtlEventMonitor,
  ZLibExGZ, sBitBtn, dxGDIPlusClasses ; // you can remove dxGDIPlusClasses ;

function SetThreadExecutionState(esFlags:Cardinal):Cardinal; stdcall; external 'kernel32.dll';
function TAGCoverMP3(value: widestring): Boolean; stdcall;external 'aart.dll';
function TAGCoverMP4(value: widestring): Boolean; stdcall;external 'aart.dll';
function TAGCoverOgg(value: widestring): Boolean; stdcall;external 'aart.dll';
function ThreadDownloadFile(URl:string;TargetFile:string): boolean;
procedure DoJobs(const task: IOmniTask);

const
  WM_USER_FIRSTSHOW = WM_USER + 100;
  MSG_RESULT_THREAD  = 1;

  //WM_MDOMETA = WM_USER + 2;
  UAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36';


type
  TfrmMain = class(TVssDockForm)
    MainMenu: TMainMenu;
    OMFile: TMenuItem;
    UpdateTimer: TTimer;
    MOpenFile: TMenuItem;
    MClose: TMenuItem;
    N1: TMenuItem;
    MQuit: TMenuItem;
    OMView: TMenuItem;
    MSize50: TMenuItem;
    MSize100: TMenuItem;
    MSize200: TMenuItem;
    MFullscreen: TMenuItem;
    OMSeek: TMenuItem;
    MSeekF10: TMenuItem;
    MSeekR10: TMenuItem;
    MSeekF60: TMenuItem;
    MSeekR60: TMenuItem;
    MSeekF600: TMenuItem;
    MSeekR600: TMenuItem;
    N2: TMenuItem;
    MPause: TMenuItem;
    MPlay: TMenuItem;
    N3: TMenuItem;
    MOptions: TMenuItem;
    MOSD: TMenuItem;
    MSizeAny: TMenuItem;
    MOpenURL: TMenuItem;
    MOnTop: TMenuItem;
    OMHelp: TMenuItem;
    MAbout: TMenuItem;
    MKeyHelp: TMenuItem;
    MShowOutput: TMenuItem;
    OMExtra: TMenuItem;
    N4: TMenuItem;
    MLanguage: TMenuItem;
    MAudio: TMenuItem;
    N5: TMenuItem;
    MSubtitle: TMenuItem;
    MDeinterlaceAlg: TMenuItem;
    MOpenDrive: TMenuItem;
    OpenDialog: TOpenDialog;
    MAspect: TMenuItem;
    MPrev: TMenuItem;
    MNext: TMenuItem;
    MShowPlaylist: TMenuItem;
    N6: TMenuItem;
    Imagery: TImageList;
    N7: TMenuItem;
    MMute: TMenuItem;
    MStreamInfo: TMenuItem;
    MCompact: TMenuItem;
    MPopup: TPopupMenu;
    MPPause: TMenuItem;
    MPPrev: TMenuItem;
    MPNext: TMenuItem;
    N8: TMenuItem;
    MPFullscreen: TMenuItem;
    MPCompact: TMenuItem;
    MPOnTop: TMenuItem;
    OSDMenu: TMenuItem;
    MNoOSD: TMenuItem;
    MDefaultOSD: TMenuItem;
    MTimeOSD: TMenuItem;
    MFullOSD: TMenuItem;
    N9: TMenuItem;
    MPQuit: TMenuItem;
    MPPlay: TMenuItem;
    MPStop: TMenuItem;
    N10: TMenuItem;
    MStop: TMenuItem;
    MPFullscreenControls: TMenuItem;
    MDeinterlace: TMenuItem;
    MSettings: TMenuItem;
    MOpenTv: TMenuItem;
    MDVD: TMenuItem;
    MDvdMenu: TMenuItem;
    MTitles: TMenuItem;
    MChapters: TMenuItem;
    N11: TMenuItem;
    MVideoInside: TMenuItem;
    N12: TMenuItem;
    MPVideoInside: TMenuItem;
    MSubAdd: TMenuItem;
    TimerVis: TTimer;
    N13: TMenuItem;
    MVis: TMenuItem;
    MvisEnable: TMenuItem;
    N14: TMenuItem;
    MvisBars: TMenuItem;
    MvisParticles: TMenuItem;
    MvisParticleBlur: TMenuItem;
    MVisDirectRender: TMenuItem;
    MVisBarsBlur: TMenuItem;
    MRepeat: TMenuItem;
    MPRepeat: TMenuItem;
    pnlAll: TPanel;
    OuterPanel: TPanel;
    LEscape: TLabel;
    imgVis: TImage;
    Logo: TImage;
    InnerPanel: TPanel;
    ControlPanel: TPanel;
    LSpeed: TLabel;
    PStatus: TPanel;
    pButtons: TPanel;
    BStreamInfo: TSpeedButton;
    BSettings: TSpeedButton;
    BCompact: TSpeedButton;
    BFullscreen: TSpeedButton;
    BMute: TSpeedButton;
    VolFrame: TPanel;
    VolImage: TImage;
    VolSlider: TPanel;
    VolBoost: TPanel;
    Mtest: TMenuItem;
    BPlaylist: TSpeedButton;
    BOpen: TSpeedButton;
    sSkinProvider1: TsSkinProvider;
    BPlay: TSpeedButton;
    BPause: TSpeedButton;
    BStop: TSpeedButton;
    BPrev: TSpeedButton;
    BNext: TSpeedButton;
    sStatusBar1: TsStatusBar;
    imgStatus: TImage;
    LStatus: TLabel;
    LTime: TLabel;
    lZoom: TLabel;
    imgAudio: TImage;
    Mskin: TMenuItem;
    MUpdate: TMenuItem;
    MRestoreWindows: TMenuItem;
    MRadios: TMenuItem;
    OTLMonitor: TOmniEventMonitor;
    Timer1: TTimer;
    BAudioEqu: TSpeedButton;
    Image1: TImage;
    N15: TMenuItem;


    procedure DoIdle(Sender: TObject; var Done: Boolean);

    procedure MvisEnableClick(Sender: TObject);
    Procedure MVisDirectRenderClick(Sender: TObject);
    procedure MVisEffBlurClick(Sender: TObject);
    procedure MVisEffClick(Sender: TObject);

    procedure TimerVisTimer(Sender: TObject);
    procedure MSubAddClick(Sender: TObject);
    procedure MVideoInsideClick(Sender: TObject);
    procedure MDvdMenuClick(Sender: TObject);
    procedure LEscapeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LogoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OuterPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InnerPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MOpenTvClick(Sender: TObject);

    procedure LEscapeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LogoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MSettingsClick(Sender: TObject);

    procedure InnerPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BPlayClick(Sender: TObject);
    procedure BPauseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DrawVis (step : boolean);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FindArt;
    procedure ReloadLogo;
    procedure SimulateKey(Sender: TObject);
    procedure MSizeClick(Sender: TObject);
    procedure MShowOutputClick(Sender: TObject);
    procedure MOSDClick(Sender: TObject);
    procedure MCloseClick(Sender: TObject);
    procedure MAudioClick(Sender: TObject);
    procedure MSubtitleClick(Sender: TObject);
    procedure MTitleClick(Sender: TObject);
    procedure MchapterClick(Sender: TObject);
    procedure UpdateMenus(Sender: TObject);
    procedure MDeinterlaceAlgClick(Sender: TObject);
    procedure MDeinterlaceClick(Sender: TObject);
    procedure MOpenFileClick(Sender: TObject);
    procedure MOpenRadio(Pls: string);
    procedure MOpenURLClick(Sender: TObject);
    procedure MOpenDriveClick(Sender: TObject);
    procedure MKeyHelpClick(Sender: TObject);
    procedure MAboutClick(Sender: TObject);
    procedure MLanguageClick(Sender: TObject);
    procedure MAspectClick(Sender: TObject);
    procedure MOptionsClick(Sender: TObject);
    procedure MPauseClick(Sender: TObject);
    procedure BPrevNextClick(Sender: TObject);
    procedure MShowPlaylistClick(Sender: TObject);
    procedure BStopClick(Sender: TObject);

    procedure GotoSeekbarPosition(Position : integer);
    procedure SpeedBarChange(Sender: TObject);
    procedure SeekBarChange(Sender: TObject);
    procedure SeekBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    function GetSpeedbarValue(Position : integer): real;
    function GetSpeedbarPosition(Value : real): integer;

    procedure VolSliderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VolSliderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure VolSliderMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BMuteClick(Sender: TObject);
    procedure MStreamInfoClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure DisplayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DisplayDblClick(Sender: TObject);
    procedure MPopupPopup(Sender: TObject);
    procedure OuterPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MPFullscreenControlsClick(Sender: TObject);
    procedure LStatusClick(Sender: TObject);
    procedure VolBoostClick(Sender: TObject);

    procedure mpolog(sender: TObject; str : string);
    procedure mpoLogClear(sender: TObject);
    procedure mpoStatusChange( Sender : TObject; oldstatus,newstatus : TStatus);
    procedure mpoOverlayChange( Sender : TObject;
                                required: boolean; color: Tcolor);
    procedure mpoVideoSizeChanged(sender: TObject);
    procedure mpoPercentPosition(sender : TObject);
    procedure mpoSecondPosition(sender : TObject);
    procedure mpoProgress(Sender : TObject;name: string; value : string);
    procedure mpoAudioChange(sender : Tobject;id : integer);
    procedure mpoSubAdded(sender : Tobject;id : integer);
    procedure mpoSubChange(sender : Tobject;id : integer);
    procedure mpoPropertysRead(sender : TObject);
    procedure mpoLoadNextFile(Sender : Tobject;var name : string);
    procedure mpoFileLoaded(Sender : Tobject;var name : string);
    procedure MRepeatClick(Sender: TObject);
    procedure MSizeAnyClick(Sender: TObject);
    procedure MtestClick(Sender: TObject);
    procedure BOpenClick(Sender: TObject);
    procedure sSkinManager1AfterChange(Sender: TObject);
    procedure sSkinManager1GetMenuExtraLineData(FirstItem: TMenuItem;
      var SkinSection, Caption: string; var Glyph: TBitmap;
      var LineVisible: Boolean);
    procedure MskinClick(Sender: TObject);
    procedure MUpdateClick(Sender: TObject);
    procedure MRestoreWindowsClick(Sender: TObject);
    procedure MRadiosClick(Sender: TObject);
    procedure OTLMonitorTaskTerminated(const task: IOmniTaskControl);
    procedure LoadRadios;
    procedure Timer1Timer(Sender: TObject);
    procedure BAudioEquClick(Sender: TObject);
    procedure OTLMonitorTaskMessage(const task: IOmniTaskControl;
      const msg: TOmniMessage);

  private
    { Private declarations }
    FTask      : IOMniTaskControl;

    ThreadResultok: boolean;
    FsmallIcon : Cardinal;
    DockList : TVssDockFormList;

    SeekBar : TVssScrollbar;
    SpeedBar : TVssScrollbar;
    ClosingApp : boolean;
    MenuAndCaption:integer;
    FirstShow:boolean;

    DeviceChanged : boolean;

    SeekMouseX,SeekBaseX:integer;
    ControlledResize:integer;
    LastSize : Integer;

    FS_WasMax:boolean;
    OldPlacement : TWindowPlacement;
    UpdatingWindow : Boolean;
    InSizeMoveLoop : Boolean;
    MinimizingWindow : Boolean;

    FirstParameter:integer;
    FullscreenControls:boolean;
    DisableFullscreenControlsCount:integer;
    EnableFullscreenControlsCount:integer;
    LastX, LastY : integer;
    Lastaspect : real;
    Lastzoom: integer;
    LastPanScan : real;

    ShowLogoCount:integer;

    Playing : boolean;
    WasPlaying : boolean;
    LastSeekbarpos : integer;
    VisSizeChange : boolean;


    PopupCanvasDrawn : Boolean;
    PopupHeight : Integer;
    PopupBitmap: TBitmap; { buffer for the bar }

    procedure ToggleFormVisibility(frm : TForm);

    procedure PassMsg(var msg: Tmessage); message $0401;

    procedure OpenDroppedFile(Sender: TObject; var Done: Boolean);
    procedure FormDropFiles(var msg:TMessage); message WM_DROPFILES;
    procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
    procedure WMPowerBroadcast(var Msg: TMessage); message WM_POWERBROADCAST;
    procedure Init_MOpenDrive;
    procedure Update_MOpenDrive;
    procedure Init_MLanguage;
    procedure Init_MOptions;
    procedure FormGetMinMaxInfo(var msg:TMessage); message WM_GETMINMAXINFO;
    procedure FormWantSpecialKey(var msg:TCMWantSpecialKey); message CM_WANTSPECIALKEY;

    procedure UpdateMPwindow( hide : boolean = false);
    procedure FormPosChanged(var Msg: TMessage); message WM_WINDOWPOSCHANGED;
    procedure FormWmWindowposChanging(var Msg: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure FormWmEnterSizeMove(var Msg : TMessage); message WM_ENTERSIZEMOVE;
    procedure FormWmExitSizeMove(var Msg : TMessage); message WM_EXITSIZEMOVE;
    procedure FormSyscommand(var Msg: TMessage); message WM_SYSCOMMAND;

    procedure FormWmSize(var Msg: TMessage); message WM_SIZE;
    procedure FormFirstShow(var Msg: TMessage); message WM_USER_FIRSTSHOW;
    procedure FormWmEraseBg(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure LoadForms();
    Procedure SetFormStyle(fs: TFormStyle);
    procedure UpdateVisElements();
    function InsideControls(pt: tpoint ) : boolean ; overload;
    function InsideControls() : boolean ; overload;

    procedure setMnuDrawEvents(Mnu : Tmenuitem);

    procedure SetPanelVisibility(p : TPanel; value: Boolean; delayed : Boolean = False);
    procedure BeginWindowUpdate();
    procedure EndWindowUpdate();
    procedure EnsureWindowUpdate();

    {$IFDEF ACTDEBUGLOG}
    procedure DebugLog(str : string);
    {$ENDIF}
  protected
    //procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    Fullscreen:boolean;
    Compact:boolean;
    Zoom : integer;
    CaptionString : string;
    mpo : Tmplayer;
    VisEffects : TVisEffects ;

    LastFileFilter : Integer;
    LastSubFilter : Integer;

    procedure FixSize;
    procedure UpdatePrevNext;
    procedure UpdatePlay;
    procedure SetupStart;
    procedure SetupPlayPause(wasStarting : boolean);
    procedure SetupPlayStarting();
    procedure SetupStop(Explicit:boolean);
    procedure UpdateSeekBar;

    procedure VideoSizeChanged;
    procedure DoOpen(const URL:string);
    procedure SetAlwaysOnTop(value: boolean);
    procedure SetFullscreen(Mode:boolean);
    procedure SetCompact(Mode:boolean);
    procedure NextAudio;

    procedure NextFile(Direction:integer; ExitState:TPlaybackState);
    procedure OpenSingleItem(const URL:string);
    procedure UpdateStatus;
    procedure UpdateAudioInfo;
    procedure UpdateLZoomPosition;
    procedure UpdateZoomLabel;
    procedure UpdateTime;
    procedure Caption8514;
    procedure UpdateCaption;
    procedure SetVolumeRel(Increment:integer);
    procedure UpdateVolumeSlider();
    procedure DoLocalize(); override;
    procedure SetFullscreenControls(Mode:boolean);
    procedure SetMouseVisible(Mode:boolean);
    procedure MAudioSelect;
    procedure UpdateMAudioItems;
    procedure UpdateMsubItems;
    procedure MSubSelect;
    procedure UpdateMTitleItems;
    procedure UpdateMChapterItems;
    procedure MTitleSelect;

    Procedure IncSpeed(value : integer);
    procedure ApplicationActivate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;

    end;

var
  frmMain: TfrmMain;
  counttitle : integer;
  OldWindowProc : Pointer;
  now1: Integer;
  elapsedTime1: Real;
  FLastTime1: Integer;
  Loading : boolean;

implementation
uses Locale, Config, URL,NumUtils, dwmApi, CustomFormsHelper,
     UfrmLog, UfrmHelp, UfrmAbout, UfrmOptions, UfrmInfo, UfrmSettings,
     VssAppVersion, VssThisAppVersion,UfrmRadios,ufrmAudioEqu;

const
  ES_SYSTEM_REQUIRED  = $01;
  ES_DISPLAY_REQUIRED = $02;

const
  PopupBarWidth = 24;
  PopupBarSpace = 2;
  PopupclStart: TColor = $00FFFF;
  PopupclEnd: TColor =   $FF0000;
  SPEEDBARSCALE = 20;

const
  TIME_HIDE_FS_CRONTROLS = 8;
  TIME_SHOW_FS_CRONTROLS = 1;
  MOVEPOS_SHOW_FS_CONTROLS = 2;
  TIME_SHOW_LOGO = 3;
  VIS_WIDTH = 412;
  VIS_HEIGHT = 168;
const
  ICON_CHECK_OFF = 55;
  ICON_CHECK_ON  = 56;

  ICON_CHECK     = 57;

  ICON_RADIO_OFF = 53;
  ICON_RADIO_ON  = 54;

  ICON_OPENING = 0;
  ICON_ERROR = 48;

  ICON_PLAY_NORMAL = 45;
  ICON_PLAY_YELLOW = 46;
  ICON_PLAY_SCALER = 47;

  ICON_AUDIO_NOAUDIO = 49;
  ICON_AUDIO_MONO = 50;
  ICON_AUDIO_STEREO = 51;


{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
  function CheckOption(OPTN:string):boolean; begin
    OPTN:=LowerCase(OPTN); Result:=False;
    if OPTN='-fs' then begin opt.WantFullscreen:=True; Result:=True; end;
    if OPTN='-compact' then begin opt.WantCompact:=True; Result:=True; end;
    if OPTN='-autoquit' then begin opt.AutoQuit:=True; Result:=True; end;

  end;
  procedure SetDoubleBuffer(p : Tpanel);
  begin
    p.ParentBackground := false;
    p.DoubleBuffered := true;
    p.ControlStyle:=p.ControlStyle+[csOpaque];
  end;
Var hIconL : Integer;
begin
  LastFileFilter := 1;
  LastSubFilter := 1;

  InSizeMoveLoop := False;
  UpdatingWindow := False;
  MinimizingWindow := False;

  {try
  // LOAD SMALL ICON FOR MAINFORM, VCL LOADS ONLY LARGE ICON
  FsmallIcon := LoadImage(HInstance,'MAINICON',IMAGE_ICON,16,16,LR_DEFAULTCOLOR);
  if FsmallIcon > 0 then begin

    hIconL := SendMessage(Handle, WM_SETICON, ICON_SMALL, FsmallIcon);
    if hIconL > 0 then
      DestroyIcon(hIconL);
  end;
  except

  end; }

  PopupCanvasDrawn := false;
  PopupHeight := 0;
  PopupBitmap := nil;


  ClosingApp := false;
  opt.windowPos := TStringList.Create;
  ResetOpt;

  imgaudio.Left := 440;
  imgstatus.Tag := -1;
  imgAudio.Tag := -1;

  SetDoubleBuffer(OuterPanel);
  SetDoubleBuffer(PButtons);
  with Logo do ControlStyle:=ControlStyle+[csOpaque];
  SetPanelVisibility(ControlPanel,True,True);

  randomize();
  FirstShow:=true;
  DeviceChanged := true;
  lastseekbarpos := -1;
  wasplaying := false;
  Zoom := 100;

  mpo := Tmplayer.create;
  VisEffects := TVisEffects.Create(VIS_WIDTH, VIS_HEIGHT);
  VisEffects.bmExt :=   imgvis.Picture.Bitmap;
  //Config.Load(mpo.mplayerPath+'autorun.inf'); //only for usb.. correct later

  //sSkinManager1.SkinDirectory:=ExtractFilePath(Application.ExeName) + 'skins';

  Config.Load('');
  //sskinmanager1.SkinName :=skinnameis;
  //sskinmanager1.Active:=true;
  Application.OnActivate := ApplicationActivate;

  mpo.Onlog := mpolog;
  mpo.OnlogClear := mpologClear;
  mpo.OnStatusChange := mpoStatusChange;
  mpo.OnOverlayChange := mpoOverlayChange;
  mpo.OnVideoSizeChanged := mpoVideosizeChanged;
  mpo.OnPercentPosition := mpoPercentPosition;
  mpo.OnSecondPosition := mpoSecondPosition;
  mpo.WindowHandle := innerpanel.Handle;
  mpo.OnAudioChange := mpoAudioChange;
  mpo.OnSubAdded := mpoSubAdded;
  mpo.OnSubChange := mpoSubChange;
  mpo.OnProgress := mpoProgress;
  mpo.OnPropertysRead := mpoPropertysRead;
  mpo.OnLoadNextFile := mpoLoadNextFile;
  mpo.OnFileLoaded := mpoFileLoaded;


  Init_MOpenDrive;
  Init_MOptions;
  Init_MLanguage;

  FirstParameter:=1;
  while CheckOption(ParamStr(FirstParameter)) do inc(FirstParameter);
  Fullscreen:=false; Compact:=False;
  FullscreenControls:=false;
  ControlledResize:=1;
  LastSize := SIZE_RESTORED;
  ShowLogoCount:=0;
  UpdateVolumeSlider;

  seekbar := TVssScrollbar.Create(Controlpanel);
  seekbar.Parent := Controlpanel;
  seekbar.SetBounds(4, 8 ,self.ClientWidth-8, 10);
  seekbar.SliderLineHeight := 10;

  seekbar.Min := 0;
  seekbar.Max := 100000;
  seekbar.Position := 0;
  seekbar.Enabled := false;
  seekbar.OnChange := seekbarChange;
  seekbar.onMouseUp := seekbarMouseUp;
  seekbar.BringToFront;

  seekbar.Anchors := [akLeft,akTop,akRight];

  speedbar := TVssScrollbar.Create(controlpanel);
  speedbar.Parent := Controlpanel;
  speedbar.SetBounds(bnext.Left+ bnext.Width ,23 + (24 div 2) - 4,200, 8);
  speedbar.Min := -18;
  speedbar.Max := 22;
  speedbar.Position := 0;
  speedbar.Enabled := false;
  speedbar.SliderLineHeight := 8;
  speedbar.Visible:=false;lspeed.Visible:=false;

  speedbar.Position := GetSpeedbarPosition(mpo.Speed);
  //speedbar.OnChange := speedbarChange;
  //SpeedBarChange(nil);

  height:=300;
  width:=427;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 1, nil, 0);
  SystemParametersInfo(SPI_SETBEEP, 1, nil, SPIF_SENDWININICHANGE);
  //FsmallIcon := SendMessage(Handle, WM_SETICON, ICON_SMALL, 0);
  //if FsmallIcon > 0 then
  //  DestroyIcon(FsmallIcon);

  Application.OnMessage :=  nil;
  FreeAndNil(DockList);
  FreeAndnil(VisEffects);
  FreeAndnil(Popupbitmap);
  FreeAndnil(mpo);
  FreeAndNil(opt.windowPos);
end;
procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  if assigned(FTask) then begin
    FTask.Terminate;
    FTask := nil;
  end;
  if not Playlist.ProcessingFiles then begin
  {Set form1's window proc back to it's original procedure}
    DockList.GetAllWindowsPos(opt.windowPos);

    Config.Save('',false);
    //Config.Save('',true);
    ClosingApp := true;
    Updatetimer.Enabled := false;
    mpo.StopAndWaitForDone;
    // hide all forms to look fast
    for I := 0 to application.ComponentCount-1 do begin
      if application.Components[i] is Tform then
        if Tform(application.Components[i]).Visible then
          Tform(application.Components[i]).Visible := false;
    end;
    sleep(100); // wait for Tmplayer threads to self destroy
  end else begin
    CanClose := False;
  end;
end;
procedure TfrmMain.DoOpen(const URL:string);
var
  newUrl : string;
begin
  newUrl := MakeURL(URL,Captionstring);
  UpdateCaption;
  mpo.Playmedia(newUrl);
  FindArt;
end;

procedure TfrmMain.BPlayClick(Sender: TObject);
begin
  if bplay.enabled  then begin
    if mpo.running then
      mpo.Pause:=false
    else begin
      NextFile(0,psPlaying);
    end;
    BPlay.Down:=mpo.Running;
  end;
end;

procedure TfrmMain.BPauseClick(Sender: TObject);
begin
  if bPause.enabled  then begin
    BPause.Down:=True;

    if mpo.Status=sPaused then begin
      //mpo.FrameStep;
      mpo.Pause:=false;
      BPause.Down:=false;
    end else begin
      mpo.Pause := true;
    end;
  end;
end;


procedure TfrmMain.SetVolumeRel(Increment:integer);
var newVolume : integer;
begin
  if (mpo.Volume>100) OR ((mpo.Volume=100) AND (Increment>0))
    then Increment:=Increment*10 DIV 3;  // bigger volume change steps if >100%
  newVolume := mpo.Volume;
  inc(newVolume, Increment);

  mpo.Volume := newVolume;

  if (increment > 0) and mpo.Mute then
    BMuteClick(nil);

  UpdateVolumeSlider;
end;
procedure TfrmMain.UpdateVisElements;
begin //
  timerVis.Enabled :=false;
  if not(mpo.streaminfo.HaveVideo) then begin
  outerpanel.color:=clblack;
  outerpanel.Repaint ;
  end;

  Logo.Visible:=not(mpo.streaminfo.HaveVideo);
  imgVis.visible := timerVis.Enabled;
  LEscape.Visible:=(Fullscreen and Logo.Visible);
end;

procedure TfrmMain.UpdateVolumeSlider();

begin
  if mpo.Volume>100 then begin
    VolBoost.Visible:=True;
    VolBoost.Caption:=IntToStr(mpo.Volume)+'%';
  end else begin
    VolBoost.Visible:=False;
    VolSlider.Left:=mpo.Volume*(VolFrame.ClientWidth-VolSlider.Width) DIV 100;
  end;
end;

procedure TfrmMain.IncSpeed(value: integer);
begin
    if speedbar.Visible then
    begin
    case value of
      1:   SpeedBar.Position := SpeedBar.Position + 1;
      -1:  SpeedBar.Position := SpeedBar.Position - 1;
      else SpeedBar.Position := 0;
    end;
    end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var handled : boolean;
  procedure HandleSeekCommand(const Command:string); begin
    mpo.SendCmd(Command);
    mpo.QueryPosition
  end;
  procedure ZoomUpdate(); begin
    FixSize;
    UpdateZoomLabel
  end;
  procedure IncZoom(value : integer); begin

    case value of
      1:begin
        inc(zoom);
        if zoom > 200 then
          zoom := 200;
      end;
       -1: begin
        dec(zoom);
        if zoom < 50 then
          zoom := 50;
      end;
      else
        zoom := 100;
    end;

    ZoomUpdate;
  end;

  procedure checksetAspectf(newval: single);
  begin
    if abs(newval-1)< 0.01 then
       newval := 1;
    mpo.aspectFactor := newval;
    if not mpo.Running  then
      updatezoomlabel
  end;

  procedure IncAspectf();
  var newval : single;
  begin
    newval := mpo.aspectFactor*1.025;
    if newval > 3 then
      newval := 3;
    checksetAspectf(newval);
  end;
  procedure DecAspectf();
  var newval : single;
  begin
    newval := mpo.aspectFactor/1.025;
    if newval < 0.25 then
      newval := 0.25;
    checksetAspectf(newval);
  end;
  procedure ResetAspectf(); begin
    if mpo.aspectFactor <> 1 then
      checksetAspectf(1);
  end;


begin
  handled := true;
  if Key=VK_ESCAPE then begin
    if Fullscreen then Key:=Ord('F')
    else if Compact then Key:=Ord('C');
  end;
  if ssCtrl in Shift then begin
   case Key of

    Ord('0'):  IncSpeed(0);
    VK_DIVIDE: IncSpeed(-1);
    VK_MULTIPLY: IncSpeed(1);

    Ord('O'):   MOpenFileClick(nil);  // handled also by menu, for compact mode
    Ord('L'):   MOpenURLClick(nil);
    Ord('W'):   MCloseClick(nil);
    VK_LEFT: if BPrev.Enabled then BPrevNextClick(BPrev);
    VK_RIGHT: if BNext.Enabled then BPrevNextClick(BNext);
    else handled := false;
   end;
  end else if ssAlt in Shift then begin
   case Key of
    Ord('0'):   MSizeAnyClick(nil);
    Ord('1'):   MSizeClick(MSize50);
    Ord('2'):   MSizeClick(MSize100);
    Ord('3'):   MSizeClick(MSize200);
//    Ord('4'):   OMFile.CheckMenuDropdown;
//    Ord('5'):   OMView.CheckMenuDropdown;
//    Ord('6'):   OMSeek.CheckMenuDropdown;
//    Ord('7'):   OMExtra.CheckMenuDropdown;
//    Ord('8'):   OMHelp.CheckMenuDropdown;
    VK_F4:      Close;
    VK_RETURN:  SetFullscreen(not(Fullscreen));
    //� revoir : VK_TAB: if Fullscreen then SetFullscreen(not(Fullscreen));
    else handled := false;
   end;
  end else begin  //touches seules
   case Key of
    VK_RIGHT:   mpo.seekby(10);
    VK_LEFT:    mpo.seekby(-10);
    VK_UP:      mpo.seekby(+60);
    VK_DOWN:    mpo.seekby(-60);
    VK_NEXT:   mpo.seekby(+600);
    VK_PRIOR:    mpo.seekby(-600);
    VK_SUBTRACT:mpo.SendCmd('audio_delay 0.100');
    VK_ADD:     mpo.SendCmd('audio_delay -0.100');
    Ord('M'):   BMuteClick(nil);
    Ord('9'):   SetVolumeRel(-3);
    Ord('0'):   SetVolumeRel(+3);
    VK_DIVIDE:  SetVolumeRel(-3);
    VK_MULTIPLY:SetVolumeRel(+3);
    Ord('O'):   mpo.osdlevel :=-1;
    Ord('1'):   frmSettings.PropertyInc(1,-1); //HandleCommand('contrast -1');
    Ord('2'):   frmSettings.PropertyInc(1,+1); //HandleCommand('contrast +1');
    Ord('3'):   frmSettings.PropertyInc(0,-1); //;HandleCommand('brightness -1');
    Ord('4'):   frmSettings.PropertyInc(0,+1); //HandleCommand('brightness +1');
    Ord('5'):   frmSettings.PropertyInc(3,-1); //HandleCommand('hue -1');
    Ord('6'):   frmSettings.PropertyInc(3,+1); //HandleCommand('hue +1');
    Ord('7'):   frmSettings.PropertyInc(2,-1); //HandleCommand('saturation -1');
    Ord('8'):   frmSettings.PropertyInc(2,+1); ////HandleCommand('saturation +1');
    ord('R'):   frmSettings.btnMResetClick(nil);
    Ord('D'):   mpo.SendCmd('frame_drop');
    Ord('F'):   SetFullscreen(not(Fullscreen));
    Ord('C'):   SetCompact(not(Compact));
    Ord('T'):   SetAlwaysOnTop(Not Opt.AlwaysOnTop);
    Ord('S'):   mpo.SendCmd('screenshot');
    Ord('L'):   MShowPlaylistClick(nil);
    191:        NextAudio;
    Ord('Q'):   Close;
    VK_RETURN:  BPlayClick(nil);
    Ord('P'):   BPauseClick(nil);
    VK_SPACE, VK_MEDIA_PLAY_PAUSE: begin
     if BPause.Enabled and (mpo.Status<> sPaused) then BPauseClick(nil) else BPlayClick(nil);
    end;
    VK_TAB:     MPFullscreenControlsClick(nil);
    VK_MEDIA_STOP:      if BStop.Enabled then BStopClick(nil);
    VK_MEDIA_PREV_TRACK:if BPrev.Enabled then BPrevNextClick(BPrev);
    VK_MEDIA_NEXT_TRACK:if BNext.Enabled then BPrevNextClick(BNext);
    VK_NUMPAD9 : inczoom(1);
    VK_NUMPAD5 : inczoom(0);
    VK_NUMPAD1 : inczoom(-1);

    VK_NUMPAD6 : incaspectf;
    VK_NUMPAD8 : resetaspectf;
    VK_NUMPAD4 : decaspectf;
    VK_NUMPAD7 : MVideoInsideClick(nil);

    ord('V'): if mpo.running then mpo.SendCmd('sub_visibility');
    else handled := false;
   end;
  end;
  if handled then
    Key:=0;
end;

function TfrmMain.InsideControls() : boolean;
var
  pt : tpoint;
begin
  getcursorpos(pt);
  result := InsideControls(pt);
end;

function TfrmMain.InsideControls(pt: tpoint) : boolean;
var H, W : integer;
    P : Tpoint;
begin
  H := outerpanel.ClientHeight;
  W := outerpanel.ClientWidth;
  P:=OuterPanel.ClientToScreen(Point(0,0));

  if (pt.Y < (P.Y + H)) and (pt.Y >=  (P.Y + H - controlpanel.Height - controlpanel.Height div 2)) and
     (pt.X < (P.X + W)) and (pt.X >= P.X) then
    result := true
  else
    result := false;
end;

procedure TfrmMain.DrawVis (step : boolean);
begin
  if (imgvis.Width  <> imgvis.Picture.Bitmap.Width) or
     (imgvis.Height <> imgvis.Picture.Bitmap.Height) then begin
      imgvis.Picture.Bitmap.Width := imgvis.Width;
      imgvis.Picture.Bitmap.Height := imgvis.Height;
  end;

  if step then begin
    VisEffects.RenderNewFrame;
  end else begin
    VisEffects.DrawToBitmap;
  end;
end;

procedure TfrmMain.EndWindowUpdate;
begin
  UpdatingWindow := False;
end;

procedure TfrmMain.EnsureWindowUpdate;
begin
  if not pnlAll.Visible then begin
    UpdatingWindow := false;
    Self.FormResize(nil);
  end;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin

try
  sskinprovider1.RepaintMenu ;
  timer1.Enabled:=false;
  frmmain.SetFocus;
except
   timer1.Enabled:=false;
end;
end;

procedure TfrmMain.TimerVisTimer(Sender: TObject);
begin
  if imgVis.Visible and (WindowState <> wsMinimized) then
    if mpo.Status = sPlaying then
      DrawVis(true)
    else
      if VisSizeChange then
        DrawVis(false);
    VisSizeChange := false;
end;

procedure TfrmMain.ToggleFormVisibility(frm: TForm);
begin
  if frm.Visible then
    frm.Hide
  else
    frm.Show;
end;

procedure TfrmMain.UpdateTimerTimer(Sender: TObject);
begin

  mpo.TimedTasks();
  if fullscreencontrols then
    if not InsideControls then begin //outside, hide
      if (DisableFullscreenControlsCount=0) then
        SetFullscreenControls(False)
        //sleep(1)
      else
        if (DisableFullscreenControlsCount>0) then
            dec(DisableFullscreenControlsCount)
    end else begin // inside, reset counter
      if (DisableFullscreenControlsCount>0) then
        DisableFullscreenControlsCount:=TIME_HIDE_FS_CRONTROLS;
    end;

  //dec show counter
  if EnableFullscreenControlsCount > 0 then
    dec(EnableFullscreenControlsCount)
  else
    if EnableFullscreenControlsCount < 0 then
      inc(EnableFullscreenControlsCount);

  if not FullscreenControls then begin
    LastX := -100;
    LastY := -100;
  end;



  if mpo.running then begin
    if mpo.streaminfo.havevideo then
      SetThreadExecutionState(ES_DISPLAY_REQUIRED)
    else
      SetThreadExecutionState(ES_SYSTEM_REQUIRED);
    ShowLogoCount := TIME_SHOW_LOGO;
  end else if not(Logo.Visible) then begin
    if (ShowLogoCount=0) then begin
      Playing := false;
      UpdateVisElements;
    end else begin
       dec(ShowLogoCount);
    end;
  end;
end;
procedure TfrmMain.UpdateLZoomPosition;
var pos : integer;
    newsize : integer;
  procedure setVis(comp : Tcontrol; value: boolean);
  begin
    if comp.Visible <> value then
      comp.Visible :=value;
  end;
begin
    pos := ((sStatusBar1.Width*3) div 5) - lzoom.Width;
    if pos < (lstatus.Left + lstatus.Width)  then begin
      setVis(Lstatus, false);
      lzoom.left := lStatus.Left;
    end else begin
      lzoom.left := pos ;
      LTime.Left := (sStatusBar1.Width - 137 );
      imgaudio.Left :=(sStatusBar1.Width - 32 );
      setVis(Lstatus, true);
    end;
    if speedbar.Visible then
    begin
    speedbar.Left  :=  BOpen.Left + BOpen.Width +5;
    newsize :=  pButtons.Left - speedbar.Left -5;

    setvis(speedbar, (newsize > 150));
    setvis(lSpeed , (newsize - lSpeed.Width) > 200);


    if newsize > 200 then
      newsize := 200;
    if speedbar.visible then
      speedbar.Width := newsize;
    if lSpeed.Visible then
      lspeed.Left := speedbar.Left + speedbar.Width +5;
    end;
    self.sStatusBar1.Repaint;self.sStatusBar1.Refresh;
end;

procedure TfrmMain.UpdateZoomLabel;
var sAuto : string;
var sPScan : string;
var sAspect : string;
var sZoom : string;
var calcAspect : real;
var AspectRender : Real;
begin
  calcAspect := (mpo.renderinfo.aspect*mpo.aspectFactor);

  if mpo.ValidFileInfo then
    AspectRender := mpo.renderinfo.aspect
  else
    AspectRender := -1;

  if (lastaspect <> AspectRender) or
     (lastzoom <> zoom) or
     (lastPanScan <>  calcAspect) then begin
    lastaspect :=  AspectRender;
    lastzoom := zoom;
    lastpanscan := calcaspect;
    if mpo.ValidFileInfo and  (mpo.Aspect = 0) then
     sAuto := '(Auto)'
    else
     sAuto := '';

    if mpo.ValidFileInfo and (mpo.aspectFactor <> 1) and (calcAspect> 0.01) then
      sPScan := 'PS ' + floattostrf( calcAspect, ffFixed,8,2)
    else
      sPScan := '';

    if mpo.ValidFileInfo and (mpo.Renderinfo.Aspect > 0) then
      sAspect := 'AR' + sauto + ':' +
        floattostrf( mpo.renderinfo.aspect, ffFixed,8,2)
    else
      sAspect := '';

    sZoom := 'Zoom:' + inttostr(zoom) + '%';

    if sPscan <> '' then begin
      if sAspect <> '' then
        sAspect := sAspect + ' - ';
      sAspect := sAspect + sPScan;
    end;

    if sAspect <> '' then
        sAspect := sAspect + ' - ';

    sAspect := sAspect + sZoom;

    lzoom.Caption := sAspect;//application.processMessages;
    UpdateLZoomPosition;
    //self.Refresh;application.processMessages;
  end;
end;
procedure TfrmMain.FixSize;
var SX,SY,NX,NY:integer;
begin
  if not InnerPanel.Visible then exit;
  if (mpo.renderinfo.height =0) OR (mpo.renderinfo.width=0) then begin
    InnerPanel.Align:=alClient;
    exit;
  end else
    InnerPanel.Align:=alNone;
  SX:=OuterPanel.ClientWidth;
  SY:=OuterPanel.ClientHeight;

  NX:=(mpo.renderinfo.width*SY + (mpo.renderinfo.Height div 2))
      div mpo.renderinfo.height;
  if ((NX>SX) and opt.VideoInside) or ((NX<SX) and (not opt.VideoInside))  then begin
    NX:=SX;
  end;

  NX:= (NX *Zoom) DIV 100;
  NY := (mpo.renderinfo.height*NX + (mpo.renderinfo.Width div 2))
         div mpo.renderinfo.width;

  if opt.ForceEvenWidth then
    if (NX mod 2) = 1 then
      NX := NX + 1;


  innerpanel.SetBounds((SX-NX) DIV 2,(SY-NY) DIV 2,NX, NY);
  if (mpo.Status = spaused)  then
    UpdateMPwindow();
end;

procedure TfrmMain.FormResize(Sender: TObject);
var CX,CY:integer;
begin
  {$IFDEF ACTDEBUGLOG}
  DebugLog('RESIZE');
  if Sender <> nil then
    DebugLog('--NOT NILL');
  if UpdatingWindow  then
    DebugLog('--UPDATING WINDOW');
  if pnlAll.Visible then
    DebugLog('--PNLALL VISIBLE')
  else
    DebugLog('--PNLALL NOT VISIBLE');
  {$ENDIF}


  if ClosingApp then exit;
  if UpdatingWindow then Exit;  

  pnlAll.SetBounds(0,0,ClientWidth,ClientHeight); //entire form client surface
  ControlPanel.SetBounds(0,
                         ClientHeight-controlpanel.Height,
                         ClientWidth,
                         ControlPanel.Height);

  CX:=ClientWidth;
  CY:=ClientHeight;
  if ControlPanel.Tag = 1 then
    CY := CY - ControlPanel.Height - OuterPanel.Top;

  OuterPanel.SetBounds(OuterPanel.Left,
                         OuterPanel.Top,
                        CX,
                        CY);
  FixSize;


  Logo.SetBounds( (CX-logo.Width) DIV 2,
                  (CY-logo.Height) DIV 2,
                  Logo.Width, Logo.Height);   //set logo position

  if (VIS_WIDTH  > cx) or (VIS_HEIGHT > cy) then begin
      imgvis.Width  := VIS_WIDTH;
      imgvis.Height := VIS_HEIGHT;
  end else begin
      imgvis.Width  :=Cx;
      imgvis.Height :=Cy;
  end;
  VisSizeChange := true;

  imgVis.Top := (CY-imgvis.Height) DIV 2;;
  imgvis.Left := (CX-imgvis.Width)  DIV 2;
  LEscape.Left:=(CX-LEscape.Width) DIV 2;
  LEscape.Top:=Max(Logo.Top+Logo.Height,CY*3 DIV 4);
  UpdateLZoomPosition;
  if controlledResize < 2 then
    if ControlledResize = 1 then
      ControlledResize:=0
    else if not MSizeAny.Checked then
      if mpo <> nil then
        if mpo.Streaminfo.Valid then begin
          MSizeAny.Checked:=true;
          MSizeAny.ImageIndex:=65;
          MSize50.ImageIndex:=6;
          MSize100.ImageIndex:=7 ;
          MSize200.ImageIndex:=8 ;
        end;


  SetPanelVisibility(ControlPanel,ControlPanel.Tag=1);

  pnlAll.Visible := True;  // allow window to update after changes

  {$IFDEF ACTDEBUGLOG}
  DebugLog('RESIZE END, set VISIBLE PNLALL');
  if pnlAll.Visible then
    DebugLog('--PNLALL VISIBLE')
  else
    DebugLog('--PNLALL NOT VISIBLE');
  {$ENDIF}
end;

procedure TfrmMain.UpdatePrevNext;
begin
  BPrev.Enabled:=playlist.CanDoPrev;
  BNext.Enabled:=playlist.CanDoNExt;
  UpdateMenus(nil);
  MPopupPopup(nil);
end;
procedure TfrmMain.UpdatePlay;
begin
  BPlay.Enabled:=(Playlist.Count>0) or mpo.Running;
  UpdateMenus(nil);
  MPopupPopup(nil);
end;
procedure TfrmMain.SetupStart;
begin
  BPlay.Enabled:=true;
  BPlay.Down:=true;
  BStop.Enabled:=true;
  BPause.Enabled:=true;
  BPause.Down:=false;
  UpdatePrevNext
end;
procedure TfrmMain.SetupPlayStarting();
begin
  InnerPanel.Visible:=mpo.streaminfo.HaveVideo;

  Playing := true;
  UpdateVisElements;

  if mpo.streaminfo.HaveVideo then
    FixSize
  else
    videosizechanged;

  BPause.Enabled:=true;
end;
procedure TfrmMain.SetupPlayPause(wasStarting : boolean);
begin
  if wasstarting then begin
    SeekBar.Enabled := true;
    seekbar.CancelScroll;
    LastSeekbarpos := -1;
    UpdateSeekBar;
    self.UpdateTime;
    BMute.Enabled:=mpo.streaminfo.HaveAudio;
    frmInfo.UpdateInfo;
    Caption8514;
    UpdateAudioInfo;
  end;
  Bpause.Down := mpo.Status = sPaused;
  UpdateTime;
end;
procedure TfrmMain.SetupStop(Explicit:boolean);
begin
  BPlay.Down:=false;
  UpdatePlay;

  BStop.Enabled:=false;
  seekbar.Enabled := false;
  InnerPanel.Visible:=false;
  BPause.Enabled:=false;
  BPause.Down:=false;
  UpdatePrevNext;

  if (Playlist.count=0)and(mpo.MediaFile<>'')and(MPO.Status <> sNone) then
    mpo.CloseMedia();
end;

procedure setFormChild(frm : TForm);
begin
  frm.WindowParent := frmMain;
end;
procedure TfrmMain.LoadForms();
begin
  AppVersion := TVssAppVersion.Create(ParamStr(0));


  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.CreateForm(TfrmPlayList, frmPlaylist);
  Application.CreateForm(TfrmInfo, frmInfo);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TFrmRadios, FrmRadios);
  Application.CreateForm(TfrmAudioEqu, frmAudioEqu);


  imagery.GetIcon(msettings.ImageIndex ,frmSettings.Icon);
  imagery.GetIcon(moptions.ImageIndex, frmOptions.icon);
  imagery.GetIcon(mshowplaylist.ImageIndex, frmPlaylist.icon);
  imagery.GetIcon(Mstreaminfo.ImageIndex, frmInfo.icon);
  imagery.GetIcon(Mshowoutput.ImageIndex, frmLog.icon);

  imagery.GetBitmap(mshowplaylist.ImageIndex,Bplaylist.Glyph);
  imagery.GetBitmap(Mstreaminfo.ImageIndex,Bstreaminfo.Glyph);
  imagery.GetBitmap(MFullscreen.ImageIndex,BFullscreen.Glyph);


  frmInfo.Width :=  frmSettings.Width ;

  setFormChild(frmHelp);
  setFormChild(frmAbout);
  setFormChild(frmOptions);
  setFormChild(frmPlaylist);
  setFormChild(frmInfo);
  setFormChild(frmSettings);

  setFormChild(frmAudioEqu);
  setFormChild(FrmRadios);
  frmLog.WindowParent := nil;


  DockList :=  TVssDockFormList.Create;
  MasterForm := True;

  DockList.Add(self);
  DockList.Add(frmPlaylist);
  DockList.Add(frmInfo);
  DockList.Add(frmSettings);

    DockList.Add(frmAudioEqu);

   with frmPlaylist.Dock do begin
    DockLR := 2;
    DockTB := -1;
    DockPos := 0;
    //DockForm := Self;
    LinkSize := True;
    SetSize := True;
    DockForm := frmMain;//
  end;

  with frmInfo.Dock do begin
    DockLR := -1;
    DockTB := 2;
    DockPos := 0;
    DockForm := frmPlayList;
    SetSize := True;
  end;

  with frmSettings.Dock do begin
    DockLR := -1;
    DockTB := 2;
    DockPos := 0;
    DockForm := frmMain;
  end;
  with frmAudioEqu.Dock do begin
    DockLR := -1;
    DockTB := 2;
    DockPos := 0;
    DockForm := frmMain;
    SetSize := True;
  end;

  DockList.SetAllWindowsPos(opt.windowPos);
  frmPlaylist.DockTo;
  frmInfo.DockTo;
  frmSettings.DockTo;
  frmAudioEqu.DockTo;
end;
Procedure TfrmMain.SetFormStyle(fs: TFormStyle);
var i: integer;
  f : Tform;
begin

  if fs=fsNormal then begin
    self.FormStyle := fs;
    SetWindowPos(Application.Handle, HWND_NOTOPMOST,0, 0, 0, 0,SWP_NOACTIVATE+SWP_NOMOVE+SWP_NOSIZE);
  end;

  for i := 0 to application.ComponentCount - 1 do
    if application.Components[i] is Tform then begin
      f := application.Components[i] as Tform;
      if f <> self  then begin
        f.FormStyle := fs;
      end;
    end;

  if fs<>fsNormal then begin
    self.FormStyle := fs;
    SetWindowPos(Application.Handle,HWND_TOPMOST,0, 0, 0, 0,SWP_NOACTIVATE+SWP_NOMOVE+SWP_NOSIZE);
  end;
  self.BringToFront;  //this makes child windows get the right z pos
end;

procedure TfrmMain.FormFirstShow(var Msg: TMessage);
var i:integer; FileName:string;
begin
  if FirstShow then begin

    //sSkinManager1.ThirdLists[Length(sSkinManager1.ThirdLists)].Add('TVssScrollbar');
    //UpdateThirdNames(sSkinManager1);

    SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 0, nil, 0);
    SystemParametersInfo(SPI_SETBEEP, 0, nil, SPIF_SENDWININICHANGE);
    FirstShow:=false;
    LoadForms;

    ActivateLocale(opt.DefaultLocale);

    ControlledResize := 1;
    Menu := MainMenu;

    //Application.ProcessMessages;
    Refresh;

    if opt.WantCompact then SetCompact(True);

    SetAlwaysOntop(opt.AlwaysOnTop);

    application.OnIdle := DoIdle;
    if ParamStr(FirstParameter)<>'' then begin
      Playlist.Clear();
      for i:=FirstParameter to ParamCount do begin

        FileName:=ParamStr(i);
        Playlist.Add(FileName);
        now1 := GetTickCount;
        elapsedTime1 := (now1 - FLastTime1) / 1000;
        FLastTime1 := now1;
      end;

      Application.OnIdle:=OpenDroppedFile;
    end else if opt.AutoPlay then begin
      Playlist.Add('.');
      if Playlist.Count>0 then
        Application.OnIdle:=OpenDroppedFile;
    end;
    DragAcceptFiles(Handle,true);

  end;

end;

procedure TfrmMain.FormShow(Sender: TObject);

begin
  if FirstShow then
    postmessage(self.Handle,WM_USER_FIRSTSHOW,0,0);
end;

procedure TfrmMain.FormHide(Sender: TObject);
begin
  DragAcceptFiles(Handle,false);
end;

procedure TfrmMain.FormDropFiles(var msg:TMessage);
var hDrop:THandle;
    i,DropCount:integer;
    fnbuf:array[0..1024]of char;
begin
  hDrop:=msg.wParam;

  if not Playlist.ProcessingFiles then begin
    DropCount:=DragQueryFile(hDrop,cardinal(-1),nil,0);
    Playlist.Clear;
    for i:=0 to DropCount-1 do begin
      DragQueryFile(hDrop,i,@fnbuf[0],1024);
      Playlist.Add(fnbuf);
    end;
    Application.OnIdle:=OpenDroppedFile;
  end;

  DragFinish(hDrop);
  msg.Result:=0;

end;

procedure TfrmMain.OpenDroppedFile(Sender: TObject; var Done: Boolean);
begin
  Done:=true;
  Application.OnIdle:=nil;
  NextFile(0,psPlaying);
  sskinprovider1.RepaintMenu ;
end;

procedure TfrmMain.UpdateSeekBar;
var
  val : integer;
begin
  if seekbar.Scrolling then exit;
  val := mpo.PercentPos;
  seekbar.Position := val;
end;

procedure TfrmMain.SeekBarChange(Sender: TObject);
begin
  //not used, seekbar moving
end;

function TfrmMain.GetSpeedbarValue(Position: integer): real;
begin
  if position > 0 then
    if Position < 20 then
      result := (Position /SPEEDBARSCALE)+1
    else
      result := (Position - SPEEDBARSCALE)+2
  else begin
    Result := Position/SPEEDBARSCALE + 1;
    if Result < 0.01 then
      Result := 0.01;
  end;
end;
function TfrmMain.GetSpeedbarPosition(Value: real): integer;
begin
  if Value > 2 then
    Result := correctround(Value -2) + SPEEDBARSCALE
  else
    result := correctround((Value-1)*SPEEDBARSCALE)
end;

procedure TfrmMain.SpeedBarChange(Sender: TObject);
begin
  exit;
  if sender <>nil then
    mpo.Speed := GetSpeedbarValue(SpeedBar.Position);
  lspeed.Caption := floattostrf( mpo.speed, ffFixed,8,2) + 'x';
end;

procedure TfrmMain.sSkinManager1AfterChange(Sender: TObject);


begin
      Loading := False;
end;

procedure TfrmMain.sSkinManager1GetMenuExtraLineData(FirstItem: TMenuItem;
  var SkinSection, Caption: string; var Glyph: TBitmap;
  var LineVisible: Boolean);
begin

    if (FirstItem = MPopup.Items[0]) then begin
        LineVisible := True;
    Caption := '3nity Media Player';
    end
    else LineVisible := False;
end;

procedure TfrmMain.ReloadLogo;
begin
  logo.Stretch:=false;
  logo.Picture:=Image1.Picture;
end;

procedure TfrmMain.FindArt;
var
nono:widestring;
FFExt: string;
begin

nono:= mpo.Streaminfo.FileName;
FFExt:=LowerCase(ExtractFileExtNoDot(mpo.Streaminfo.FileName));
case StringToCaseSelect(FFExt,
      ['mp3','m4a','ogg']) of

    0: begin

          if TAGCoverMP3(nono)  then
          begin
            try
            logo.Picture.LoadFromFile(TempDir + 'tempart.bmp');
            logo.Stretch:=true;
            except
            ReloadLogo;
            end;
          end
          else
          begin
            ReloadLogo;
          end;
    end;
    1: begin

          if TAGCoverMP4(nono)  then
          begin
            try
            logo.Picture.LoadFromFile(TempDir + 'tempart.bmp');
            logo.Stretch:=true;
            except
            ReloadLogo;
            end;
          end
          else
          begin
            ReloadLogo;
          end;
    end;
    2: begin
          if TAGCoverOgg(nono)  then
          begin
            try
            logo.Picture.LoadFromFile(TempDir + 'tempart.bmp');
            logo.Stretch:=true;
            except
            ReloadLogo;
            end;
          end
          else
          begin
            ReloadLogo;
          end;
    end;
    else begin
       ReloadLogo;
    end;
end;

end;

procedure TfrmMain.GotoSeekbarPosition(Position : integer);
var MaxPos:integer; newtime : integer;
    newpos : int64;
begin
  if (not seekbar.Scrolling) and (LastSeekbarpos < 0)  then exit;
  MaxPos:= seekbar.Max;
  if (mpo.SecondPosInvalid and (not mpo.streaminfo.IsMp3)) or (mpo.StreamInfo.DurationExt  = 0)  then
   begin
    if mpo.StreamInfo.stream.length <= 0 then begin
      newtime := (Position*100+(MaxPos SHR 1)) DIV MaxPos;
      if newtime < 0 then
        newtime := 0;
      mpo.seekto(newtime, 1);
    end else begin
      if mpo.UseSeekbystream then begin
        newpos := (Position*mpo.StreamInfo.stream.length+(MaxPos SHR 1)) DIV MaxPos;
        newpos := newpos + mpo.StreamInfo.stream.start;
        if newpos < 0 then
          newpos := 0;
        mpo.seekto(newpos, 3);
      end else begin
        newtime := (Position*mpo.StreamInfo.DurationExt +(MaxPos SHR 1)) DIV MaxPos;
        if newtime < 0 then
          newtime := 0;
        mpo.seekto(newtime, 4);
      end;
    end;
   end
  else
   begin
      newtime := (Position*mpo.StreamInfo.DurationExt +(MaxPos SHR 1)) DIV MaxPos;
      if newtime < 0 then
        newtime := 0;
      mpo.seekto(newtime, 2);
   end;
  lastseekbarpos := -1;
end;
procedure TfrmMain.SeekBarMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GotoSeekbarPosition(seekbar.Position);
end;

// simulates key from sender tag
procedure TfrmMain.SimulateKey(Sender: TObject);
var Key:word;
begin
  Key:=(Sender as TComponent).Tag;
  FormKeyDown(Sender,Key,[]);
end;



procedure TfrmMain.VideoSizeChanged;
var
    SX,SY,PX,PY, Resizes:integer;
    actVideo : boolean;
begin

  updatezoomlabel;
  if MSizeAny.Checked OR Fullscreen or (self.WindowState = wsMaximized) then begin
    FixSize;
    exit;
  end;

  // try two times, just because sometimes as size changes, menu height changes
  for Resizes := 0 to 1 do begin

    PX:=Left; PY:=Top;
    if (mpo.renderinfo.Width=0) OR (mpo.renderinfo.Height=0) then begin
      SX := Width-Outerpanel.ClientWidth+ VIS_WIDTH;
      SY := Height-OuterPanel.ClientHeight+VIS_HEIGHT;
      actVideo := false;
    end else begin
      SX:=mpo.renderinfo.Width; SY:=mpo.renderinfo.Height;
      if MSize50.Checked then begin SX:=SX DIV 2; SY:=SY DIV 2; end;
      if MSize200.Checked then begin SX:=SX*2; SY:=SY*2; end;
      SX:=Width-OuterPanel.ClientWidth+SX;
      SY:=Height-OuterPanel.ClientHeight+SY;
      actVideo := true;
    end;

    ControlledResize:=1;
    if mpo.running and actVideo then
      InnerPanel.Visible:=true;
    SetBounds(PX,PY,SX,SY);
  end;

  if opt.WantFullscreen then begin
    SetFullscreen(True);
    opt.WantFullscreen:=False;
  end else begin
  //forced fixsize in case form does not resize because of max or min size
    fixsize;
  end;
end;

procedure TfrmMain.MSizeAnyClick(Sender: TObject);
begin
  MSizeAny.Checked:=True;
  MSizeAny.ImageIndex:=65;
  MSize50.ImageIndex:=6;
  MSize100.ImageIndex:=7 ;
  MSize200.ImageIndex:=8 ;
end;

procedure TfrmMain.MSizeClick(Sender: TObject);
begin
  if Fullscreen then exit;
  (Sender as TMenuItem).Checked:=True;
  MSizeAny.ImageIndex:=5;
  MSize50.ImageIndex:=6;
  MSize100.ImageIndex:=7 ;
  MSize200.ImageIndex:=8 ;
  Case (Sender as TMenuItem).Tag of
      502 : MSize50.ImageIndex:=62;
      503 : MSize100.ImageIndex:=63 ;
      504 : MSize200.ImageIndex:=64 ;
  end;
  VideoSizeChanged;
end;

procedure TfrmMain.MskinClick(Sender: TObject);
begin
  frmOptions.Show;
end;

procedure TfrmMain.MShowOutputClick(Sender: TObject);
begin
  frmLog.Show;
end;

procedure TfrmMain.MOSDClick(Sender: TObject);
begin
  with Sender as TMenuItem do
    mpo.OsdLevel := Tag;
end;


procedure TfrmMain.SetAlwaysOnTop(value : boolean);
begin
  opt.AlwaysOnTop := value;
  if Fullscreen then exit;
  if formstyle = fsStayOnTop then begin
    if not value then
      SetFormStyle(fsNormal);
  end else begin
    if value then
      SetFormStyle(fsStayOnTop);
  end;
end;

procedure TfrmMain.MCloseClick(Sender: TObject);
begin
  mpo.CloseMedia;
end;

procedure UpdateMenuItems(Menu : TmenuItem; Handler:TNotifyEvent ; ItemIDS: TItemids);
var i,j : integer; Item:TMenuItem ; capt : string;
    added : boolean;
  procedure addcapt(s : string);
  begin
    if not added then
      capt := capt + ' -';
    capt := capt + ' ' + s;
    added := true;
  end;
begin
    //if ItemIds.Kind <> IDS_TYPE_SUB then j:=0 else j:=1;
    j:=0;

    if (Menu.count > (ItemIDS.Count+j)) or (ItemIDS.Count = 0) then begin
      if menu.Count > 0 then
         Menu.Clear;
      Menu.Enabled := false;
    end;

    if j > 0 then begin
      for i := 0 to j-1 do begin
        if i >= menu.Count then begin
          Item := TmenuItem.Create(Menu);
          Item.GroupIndex:=$0A;
          Item.RadioItem:=true;
          Menu.add(Item);
          Item.OnDrawItem := menu.OnDrawItem;
          item.OnAdvancedDrawItem := menu.OnAdvancedDrawItem;
        end else begin
          Item := Menu.Items[i];
        end;
        Item.Caption :='--';
        Item.Tag := -1;
      end;
    end;

    for i:= 0 to ItemIDS.Count - 1 do begin
      if (i+j) >= Menu.Count then begin
        Item := TmenuItem.Create(Menu);
        Item.GroupIndex:=$0A;
        Item.RadioItem:=true;
      end else begin
        Item := Menu.Items[i+j];
      end;

      if ItemIds.Kind <> IDS_TYPE_SUB then begin
        capt := inttostr(ItemIDS.Items[i].id);
        added := false;
        if (ItemIDS.Items[i].text <> '') then
          addcapt(ItemIDS.Items[i].text);
      end;

      case ItemIds.Kind of
          IDS_TYPE_AUDIO:
            if ItemIDS.Items[i].value[0]> 0 then
              addcapt(inttostr(ItemIDS.Items[i].value[0])+'CH');
          IDS_TYPE_SUB: begin
            if ItemIDS.Items[i].id <= 0 then
              capt := LOCstr.NoSubtitle
            else begin
              //capt := inttostr(ItemIDS.Items[i].id);
              capt := inttostr(i);
              added := false;
              if (ItemIDS.Items[i].value[0] = 1) or (ItemIDS.Items[i].value[0] = 2) then
                addcapt(ExtractFileName(ItemIDS.Items[i].text))
              else
                addcapt(ItemIDS.Items[i].text);
            end;
          end;
          IDS_TYPE_DVDTITLE: begin
            if ItemIDS.Items[i].value[0]> 0 then
              addcapt(inttostr(ItemIDS.Items[i].value[0])+'Chap.');
            if ItemIDS.Items[i].value[1]> 0 then
              addcapt(inttostr(ItemIDS.Items[i].value[1])+'Ang.');
            if ItemIDS.Items[i].value[2]> -1 then
              addcapt(SecondsToTimeHMS(ItemIDS.Items[i].value[2]));
          end;
          IDS_TYPE_DVDCHAPTER:
            if ItemIDS.Items[i].value[2]> -1 then
              addcapt(SecondsToTimeHMS(ItemIDS.Items[i].value[2]));
      end;

      if ItemIDS.Items[i].lang <> '' then
        addcapt('(' + ItemIDS.Items[i].lang + ')');

      Item.Caption := capt;

      Item.Tag := ItemIDS.Items[i].id;
      Item.OnClick := Handler;
      if (i+j) >= Menu.Count then begin
        Menu.add(Item);
        Item.OnDrawItem := menu.OnDrawItem;
        item.OnAdvancedDrawItem := menu.OnAdvancedDrawItem;
      end;
    end;
    if Menu.Count > 0 then
      Menu.enabled := true;
    if Menu.Count = 1 then
      Menu.Items[0].Checked := true;
end;

procedure MenuSelect(men : TmenuItem ;index : integer);
begin
  if men.count > 0 then begin
     if (index < men.count) and (index >= 0) then
        men.Items[index].Checked := true
     else
        men.Items[men.count-1].Checked := true;
  end;
end;
procedure MenuSelectId(Menu : TmenuItem; id : integer; default : integer = -1);
var
  i: integer;
begin
    for i:=0 to Menu.Count-1 do begin
      if Menu.Items[i].Tag = id  then begin
        Menu.Items[i].Checked := true;
        exit;
      end;
    end;
    if (Menu.Count > 0) and (default > -2) then
      if (default >= 0) and (default < menu.count) then
        Menu.iTems[default].Checked := true
      else
        Menu.Items[0].Checked := true;
end;

procedure TfrmMain.UpdateMAudioItems();
begin
  if mpo.Status <> sNone then
    UpdateMenuItems(Maudio,MaudioClick,mpo.AudioIDS)
  else begin
    Maudio.Clear;Maudio.Enabled := false;
  end;
end;
procedure TfrmMain.MAudioSelect();
begin
    MenuSelectId(Maudio,mpo.AudioIds.ActualId);
end;
procedure TfrmMain.UpdateMsubItems();
begin
  if mpo.Status <> sNone then
    UpdateMenuItems(MSubtitle,MSubtitleClick, mpo.SubIds)
  else begin
    MSubtitle.Clear; MSubtitle.Clear;
  end;
end;
procedure TfrmMain.MSubAddClick(Sender: TObject);
begin
  with OpenDialog do begin
    Filter := GetPlayableExtensionFilter(True,False,False,False,False,True);
    FilterIndex := LastSubFilter;
    Options:=Options-[ofAllowMultiSelect];
    if Execute then begin
      LastSubFilter := FilterIndex;
      mpo.LoadSubtitle(FileName);
    end;
  end;
end;

procedure TfrmMain.MSubSelect();
begin
  MenuSelectId(MSubtitle,mpo.SubIds.ActualId);
end;

procedure TfrmMain.UpdateMTitleItems();
begin
  if mpo.Status <> sNone then
    UpdateMenuItems(MTitles,MTitleClick,mpo.TitleIDS)
  else begin
    MTitles.Clear;MTitles.Enabled := false;
  end;
end;
procedure TfrmMain.UpdateMChapterItems();
begin
  if mpo.Status <> sNone then
    UpdateMenuItems(MChapters,MchapterClick,mpo.ChapterIDS)
  else begin
    MChapters.Clear;MChapters.Enabled := false;
  end;
end;
procedure TfrmMain.MTitleSelect();
begin
  MenuSelectId(MTitles,mpo.TitleIds.SelectedId);
end;

procedure TfrmMain.MUpdateClick(Sender: TObject);
begin
 //SetCurrentDir(ExtractFilePath(Application.ExeName)); //pour l'updater
 //BStopClick(nil);
 //webupdatewizard.Execute;
end;

procedure TfrmMain.MVideoInsideClick(Sender: TObject);
begin
  opt.VideoInside := not opt.VideoInside;
  fixsize;
end;

procedure TfrmMain.MVisEffBlurClick(Sender: TObject);
begin
  if sender is TmenuItem then
    if (sender as TmenuItem).Tag < visEffects.VisCount  then
      visEffects.Vis[(sender as TmenuItem).Tag].Blur  :=
                         not((sender as TmenuItem).Checked);
end;

procedure TfrmMain.MvisEffClick(Sender: TObject);
begin
  if sender is TmenuItem then
    if (sender as TmenuItem).Tag < visEffects.VisCount  then
      visEffects.Vis[(sender as TmenuItem).Tag].Enabled  :=
                         not((sender as TmenuItem).Checked);
end;

procedure TfrmMain.MVisDirectRenderClick(Sender: TObject);
begin
  visEffects.DirectRender :=not(MVisDirectRender.Checked);
end;

procedure TfrmMain.MvisEnableClick(Sender: TObject);
begin
  visEffects.Enabled := not(Mvisenable.Checked);
  UpdateVisElements;
end;

procedure TfrmMain.MAudioClick(Sender: TObject);
begin
  if (Sender as TMenuItem).Checked<>True then begin
    mpo.AudioID:=(Sender as TMenuItem).Tag;
    if mpo.AudioID=(Sender as TMenuItem).Tag then
      (Sender as TMenuItem).Checked:=True;
  end;
end;
procedure TfrmMain.MSubtitleClick(Sender: TObject);
begin
  mpo.SubID:=(Sender as TMenuItem).Tag;
  if mpo.SubID=(Sender as TMenuItem).Tag then
    (Sender as TMenuItem).Checked:=True;
end;
procedure TfrmMain.MtestClick(Sender: TObject);
begin
  Self.FormResize(nil);
end;

procedure TfrmMain.MTitleClick(Sender: TObject);
begin
  mpo.TitleId := (sender as TMenuItem).Tag;
  if mpo.TitleId = (sender as TMenuItem).Tag  then
    (Sender as TMenuItem).Checked:=True;
end;

procedure TfrmMain.MchapterClick(Sender: TObject);
begin
  mpo.ChapterID := (sender as TMenuItem).Tag;
  if mpo.ChapterID = (sender as TMenuItem).Tag  then
    (Sender as TMenuItem).Checked:=True;
end;

procedure TfrmMain.UpdateMenus(Sender: TObject);
var
  i: integer;
  EnableClickProc, BlurClickProc : TNotifyEvent;
begin
  MenuSelect(Mdeinterlace, mpo.Deinterlace);
  MenuSelect(MdeinterlaceAlg, mpo.DeinterlaceAlg);
  MenuSelect(MAspect, mpo.Aspect);

  MKeyHelp.Checked:=frmHelp.Visible;
  MPlay.Enabled:=BPlay.Enabled;
  MSubAdd.Enabled := Bplay.Enabled;
  MPause.Enabled:=BPause.Enabled;
  MStop.Enabled:=BStop.Enabled;
  MPrev.Enabled:=BPrev.Enabled;
  MNext.Enabled:=BNext.Enabled;
  MPlay.Checked:=BPlay.Down;
  MPause.Checked:=BPause.Down;
  MFullscreen.Checked:=Fullscreen;
  MOnTop.Checked:=opt.AlwaysOnTop;

  mVideoInside.Checked := opt.VideoInside;

  mRepeat.Checked := playlist.Loop;
  mPRepeat.Checked := playlist.Loop;

  MMute.Checked:=BMute.Down;

  mvisEnable.checked := VisEffects.Enabled;
  mvisDirectRender.checked := VisEffects.DirectRender;

  EnableClickProc := MVisEffClick;
  BlurClickProc := MVisEffBlurClick;

  for i := 0 to mvis.Count-1 do begin
    if @mvis[i].OnClick = @EnableClickProc  then
      mvis[i].Checked := VisEffects.Vis[mvis[i].Tag].Enabled;
    if @mvis[i].OnClick = @BlurClickProc  then
      mvis[i].Checked := VisEffects.Vis[mvis[i].Tag].Blur;
  end;

  if DeviceChanged then
    if sender is TMenuItem then
      if (sender as TmenuItem) = OMFile then begin
        Update_MOpenDrive;
      end;
end;

procedure TfrmMain.MPopupPopup(Sender: TObject);
begin
  PopupCanvasDrawn := False;

  MPPlay.Enabled:=BPlay.Enabled;
  MPPause.Enabled:=BPause.Enabled;
  MPStop.Enabled:=BStop.Enabled;
  MPPrev.Enabled:=BPrev.Enabled;
  MPNext.Enabled:=BNext.Enabled;
  MPPlay.Checked:=BPlay.Down;
  MPPause.Checked:=BPause.Down;
  MPFullscreen.Checked:=Fullscreen;

  mPVideoInside.Checked := opt.VideoInside;

  MPFullscreenControls.Checked:=DisableFullscreenControlsCount = -1;
  MPCompact.Checked:=Compact;
  MPOnTop.Checked:=opt.AlwaysOnTop;

  OSDMenu.Enabled := true;
  MenuSelect(OSDMenu, mpo.OsdLevel);
end;

procedure TfrmMain.MDeinterlaceAlgClick(Sender: TObject);
begin
  mpo.DeinterlaceAlg := (Sender as TMenuItem).Tag;
end;

procedure TfrmMain.MDeinterlaceClick(Sender: TObject);
begin
  mpo.Deinterlace := (Sender as TMenuItem).Tag;
end;

procedure TfrmMain.MDvdMenuClick(Sender: TObject);
begin
  mpo.DVDgoMenu
end;

procedure TfrmMain.MAspectClick(Sender: TObject);
begin
  mpo.Aspect := (Sender as TMenuItem).Tag
end;

procedure TfrmMain.MOpenFileClick(Sender: TObject);
var i:integer;
begin

  with OpenDialog do begin
    Filter := GetPlayableExtensionFilter(True,True,True,True,True,False);
    FilterIndex := LastFileFilter;

    if Execute then begin
      LastFileFilter := FilterIndex;
      Playlist.Clear;
      if not Playlist.ProcessingFiles then begin

        for i:=0 to Files.Count-1 do

          Playlist.Add(Files[i]);
          NextFile(0,psPlaying)
        end;

      end;
    end;
end;

procedure TfrmMain.MOpenRadio(Pls: string);
begin
  Playlist.Clear;
  if not Playlist.ProcessingFiles then begin
    Playlist.Add(Pls);
    NextFile(0,psPlaying)
  end;
end;

procedure TfrmMain.MOpenTvClick(Sender: TObject);
begin
  OpenSingleItem('tv://');
end;

procedure TfrmMain.MOpenURLClick(Sender: TObject);
var s:string;
begin

  s:=Trim(Clipboard.AsText);
  if (Pos(^M,s)>0) OR (Pos(^J,s)>0) OR (Pos(^I,s)>0) OR
     ((Pos('//',s)=0) AND (Pos('\\',s)=0) AND (Pos(':',s)=0))
     then s:='';
  if InputQuery(LOCstr.OpenURL_Caption,LOCstr.OpenURL_Prompt,s)
    then OpenSingleItem(s);
end;

procedure TfrmMain.Init_MOpenDrive;
var Mask:cardinal; Name:array[0..3]of char; Drive:char;
    Item:TMenuItem;
begin
  Name:='@:\';
  Mask:=GetLogicalDrives();
  for Drive:='A' to 'Z' do
    if (Mask AND (1 SHL (Ord(Drive)-65)))<>0 then begin
      Name[0]:=Drive;
      if GetDriveType(Name)=DRIVE_CDROM then begin
        Item:=TMenuItem.Create(MOpenDrive);
        with Item do begin
          Caption:=Drive+':';
          Tag:=Ord(Drive);
          OnClick:=MOpenDriveClick;
        end;
        MOpenDrive.Add(Item);
        MOpenDrive.Enabled:=true;
      end;
    end;
  setMnuDrawEvents(MOpenDrive);
end;

procedure TfrmMain.Update_MOpenDrive;
  function GetVolumeLabel(DriveChar: Char; var discLabel : string): boolean;
  var
    NotUsed:     DWORD;
    VolumeFlags: DWORD;
    VolumeSerialNumber: DWORD;
    Buf: array [0..MAX_PATH] of Char;
  begin
    if GetVolumeInformation(PChar(DriveChar + ':\'),
      Buf, SizeOf(Buf), @VolumeSerialNumber, NotUsed,
      VolumeFlags, nil, 0) then begin
      SetString(discLabel, Buf,StrLen(Buf) )   { Set return result };
      result := true;
    end else begin
      discLabel := '';
      result := false;
    end;
  end;
var i: integer;
  DiscLabel: String;
  Drive : char;
begin
  for I :=0 to  MOpendrive.Count - 1  do begin
    Drive := MOpendrive.Items[i].Caption[1];
    if Drive = '&' then
      Drive := MOpendrive.Items[i].Caption[2];

    if GetVolumeLabel(Drive, DiscLabel) then
      MOpendrive.Items[i].ImageIndex := MOpendrive.ImageIndex
    else
      MOpendrive.Items[i].ImageIndex := -1;

    if DiscLabel <> '' then
      DiscLabel := Drive +  ': - ' +  DiscLabel
    else
      DiscLabel := Drive + ':';
    MOpendrive.Items[i].Caption :=  DiscLabel;
  end;
  DeviceChanged:= false;
end;

procedure TfrmMain.WMDeviceChange(var Msg: TMessage);
const
  DBT_DEVICEARRIVAL = $8000; // system detected a new device
  DBT_DEVICEREMOVECOMPLETE = $8004;  // device is gone
begin
  inherited;
  if (msg.WParam = DBT_DEVICEARRIVAL) or
     (msg.WParam = DBT_DEVICEREMOVECOMPLETE) then
    DeviceChanged := true;
end;


procedure TfrmMain.WMPowerBroadcast(var Msg: TMessage);
const
  PBT_APMSUSPEND = $4;
  PBT_APMRESUMESUSPEND = $7;
  PBT_APMRESUMEAUTOMATIC = $12;
begin
  if msg.WParam = PBT_APMSUSPEND then begin
    if mpo.Running  then begin
      WasPlaying := true;
      lastseekbarpos := Seekbar.Position;
      //mpo.StopAndWaitForDone;
      if mpo.Status=sPlaying then begin
          mpo.Pause:=True;
          BPause.Down:=True;
      end else begin

      end;
      sleep(100); // allow some extra time
    end else begin
      WasPlaying := false
    end;
  end else if msg.WParam = PBT_APMRESUMESUSPEND then begin
    if WasPlaying then begin
      //BPlayClick(nil);
      WasPlaying := false
    end;
    ; // todo, better resume code
  end;
end;

procedure TfrmMain.MOpenDriveClick(Sender: TObject);
begin
  OpenSingleItem(char((Sender as TMenuItem).Tag)+':');
end;

procedure TfrmMain.MKeyHelpClick(Sender: TObject);
begin
   frmmain.ToggleFormVisibility(frmhelp);
end;

procedure TfrmMain.MAboutClick(Sender: TObject);
begin
  frmAbout.Show;
end;


procedure TfrmMain.Init_MLanguage;
var i:integer; Item:TMenuItem;
begin
  MLanguage.Clear;
  for i:=0 to High(Locales) do begin
    Item:=TMenuItem.Create(MLanguage);
    with Item do begin
      Caption:=Locales[i].Name;
      //GroupIndex:=1;
      RadioItem:=true;
      //AutoCheck:=true;
      Tag:=i;
      OnClick:=MLanguageClick;
    end;
    MLanguage.Add(Item);
  end;
end;

procedure TfrmMain.Init_MOptions;
begin
  BuildOptMenu(DeinterlaceAlgMap,MdeinterlaceAlg, MDeinterlaceAlgClick);
  BuildOptMenu(DeinterlaceMap,Mdeinterlace, MDeinterlaceClick);
  BuildOptMenu(AspectMap,MAspect, MAspectClick);
end;

procedure TfrmMain.MLanguageClick(Sender: TObject);
var op:integer;
begin
  if not (Sender as TMenuItem).Checked  then  begin
    (Sender as TMenuItem).Checked := true;
    op:=(Sender as TMenuItem).Tag;
    ActivateLocale((Sender as TMenuItem).Tag);
    opt.DefaultLocale:=op;
    application.OnIdle := DoIdle;
  end;
end;

procedure TfrmMain.MOptionsClick(Sender: TObject);
begin
  frmOptions.Show;
end;

procedure TfrmMain.MPauseClick(Sender: TObject);
begin
  BPauseClick(nil);
end;

procedure TfrmMain.SetFullscreen(Mode:boolean);
var Pivot:TPoint;
    PX,PY,SX,SY :integer;
    MonitorFound : integer;
    MonitorIsPrimary : Boolean;
    NewPlacement : TWindowPlacement;
begin
  {$IFDEF ACTDEBUGLOG}
  if Mode then
    DebugLog('FULLSCREEN')
  else
    DebugLog('NOT FULLSCREEN');
  {$ENDIF}

  if Compact and mode  then begin // quit compact mode if going fullscreen
    SetCompact(False);
  end;

  Fullscreen:=Mode;
  FullscreenControls:=False;

  BFullscreen.Down:=Fullscreen;
  if fullscreen then
    if windowstate = wsmaximized then
      FS_WasMax := true
    else
      FS_WasMax := false;


  ControlledResize:=2;
  if Fullscreen then begin
    BeginWindowUpdate;
    OldPlacement.length := SizeOf(TWindowPlacement);
    GetWindowPlacement(Handle, @OldPlacement);
    NewPlacement := OldPlacement;

    borderstyle := bsNone;

    Pivot:=OuterPanel.ClientToScreen(Point(0,0));

    //initialize px, py, sx, xy
    PX:=Left-Pivot.X;
    PY:=Top -Pivot.Y;

    SX:=Screen.Width;
    SY:=Screen.Height;

    MonitorFound := -1;
    MonitorIsPrimary := True;
    //search for monitor number
    if opt.FullScreenMonitor > 0 then
      MonitorFound := GetMonitorIndex(opt.FullScreenMonitor -1);

    //search for current monitor number if not found or not forced
    if MonitorFound = -1 then
      MonitorFound := GetMonitorIndex(Monitor.MonitorNum);

    //if any matching monitor position window in monitor
    if MonitorFound > -1 then
      with screen do begin
        PX:= PX + Monitors[MonitorFound].Left;
        PY:= PY + Monitors[MonitorFound].top;

        SX:=Monitors[MonitorFound].Width;
        SY:=Monitors[MonitorFound].Height;
        MonitorIsPrimary := Monitors[MonitorFound].Primary;
      end;

    SX:= SX + Width-ClientWidth;
    SY:= SY + Height-ClientHeight;

    if MonitorIsPrimary then begin
      PX:=PX -Screen.WorkAreaRect.Left;
      PY:=PY -screen.WorkAreaRect.Top;
    end;

    SetPanelVisibility(ControlPanel,DisableFullscreenControlsCount=-1,true);
    EndWindowUpdate;
    //SetWindowPos(Handle,0,PX,PY,SX,SY , SWP_NOZORDER);
    NewPlacement.showCmd := SW_SHOWNORMAL;
    NewPlacement.rcNormalPosition:= Rect(PX,PY,PX+SX,PY+SY);
    SetWindowPlacement(Handle, @NewPlacement);
    //WindowState:=wsNormal; // only for the VCL, window is already RESTORED

    SetFormStyle(fsNormal);
    formstyle := fsStayOnTop;


    SetMouseVisible(false);
    UpdateVisElements;
    FullscreenControls:=not(DisableFullscreenControlsCount=-1); //force update
    SetFullscreenControls(DisableFullscreenControlsCount=-1);
    if not FullscreenControls  then BEGIN
      EnableFullscreenControlsCount := - TIME_SHOW_FS_CRONTROLS*2;
      LastX := -100;
      LastY := -100;
    end;
  end else begin
    NewPlacement.length := SizeOf(TWindowPlacement);
    GetWindowPlacement(Handle, @NewPlacement);

    BeginWindowUpdate;
    borderstyle := bsSizeable;;

    UpdateVisElements;
    SetMouseVisible(true);

    //restore original size and pos
    SetPanelVisibility(ControlPanel,True,True);
    EndWindowUpdate;

    if FS_WasMax then begin
      // SET BACK TO MAXIMIZED
      NewPlacement.showCmd := SW_SHOWMAXIMIZED;
      SetWindowPlacement(Handle,@NewPlacement);
      // SET DATA FOR RESTORE, KEEPS MAXIMIZED STATE
      NewPlacement.rcNormalPosition := OldPlacement.rcNormalPosition;
      SetWindowPlacement(Handle,@NewPlacement);
      WindowState:=wsMaximized; // only for the VCL, window is already MAXIMIZED
    end else begin
      NewPlacement.rcNormalPosition := OldPlacement.rcNormalPosition;
      NewPlacement.showCmd := SW_SHOWNORMAL;
      SetWindowPlacement(Handle,@NewPlacement);
      WindowState:=wsNormal; // only for the VCL, window is already RESTORED
    end;

    //SetWindowPos(Handle,0,FS_PX,FS_PY,FS_SX,FS_SY,SWP_NOZORDER);

    if opt.AlwaysOnTop  then
      setformstyle(fsStayOnTop)
    else
      setformstyle(fsNormal);

    VideoSizeChanged;
    UpdateMPwindow; // avoid wrong zorder with always on top, this enables taskbar
  end;

  EnsureWindowUpdate;
  ControlledResize:=0;
  DragAcceptFiles(Handle,true);
  {$IFDEF ACTDEBUGLOG}
  DebugLog('-END FULLSCREEN');
  {$ENDIF}
end;

procedure TfrmMain.SetCompact(Mode:boolean);
var
  oldstyle: integer;
begin
  if Fullscreen then begin
    SetFullscreen(False);
  end;

  WindowState:=wsNormal;
  Compact:=Mode;
  BCompact.Down:=Compact;
  if menu <> nil then
    menuAndcaption := outerpanel.Top + getSystemMetrics(SM_CYMENU) + GetSystemMetrics(SM_CYCAPTION);

  oldstyle := GetWindowLong(Handle,GWL_STYLE);

  if Compact then begin
    SetPanelVisibility(ControlPanel,False,True);
    ControlledResize:=1;
    SetWindowLong(Handle,GWL_STYLE,
      (oldstyle OR word(WS_POPUP)) AND (NOT WS_DLGFRAME));
    menu := nil;
    ControlledResize:=1;
    SetBounds(Left,Top+MenuAndCaption,Width,Height-MenuAndCaption-ControlPanel.Height);
  end else begin
    ControlledResize:=1;
    SetWindowLong(Handle,GWL_STYLE,
      (oldstyle OR WS_DLGFRAME) AND (NOT word(WS_POPUP)));
    menu := mainmenu;
    SetPanelVisibility(ControlPanel,True,True);
    ControlledResize:=1;
    SetBounds(Left,Top-MenuAndCaption,Width,Height+MenuAndCaption+ControlPanel.Height);
  end;
end;

procedure TfrmMain.FormGetMinMaxInfo(var msg:TMessage);
begin
  if Fullscreen then
    with PMinMaxInfo(msg.lParam)^.ptMaxTrackSize do begin
      X:=4095;
      Y:=4095;
    end;
  msg.Result:=0;

end;

procedure TfrmMain.NextAudio;
var i,AudioIndex:integer;
begin
  if MAudio.Count<2 then exit;
  AudioIndex:=-1;
  for i:=0 to MAudio.Count-1 do
    if MAudio.Items[i].Checked then begin
      AudioIndex:=(i+1) MOD MAudio.Count;
    end;
  if AudioIndex<0 then exit;

  MAudioClick(Maudio.Items[AudioIndex]); // do the same as menu
end;


procedure TfrmMain.NextFile(Direction:integer; ExitState:TPlaybackState);
var Index:integer;
begin
  Index:=Playlist.GetNext(ExitState,Direction);
  if Index<0 then begin
    if opt.AutoQuit then Close;
    exit;
  end;
  Playlist.NowPlaying(Index);
  DoOpen(Playlist[Index].FullURL);
  frmplaylist.PlaylistBox.TopIndex:= Index;
end;


procedure TfrmMain.BPrevNextClick(Sender: TObject);
begin
  NextFile((Sender as TComponent).Tag,psSkipped);
end;

procedure TfrmMain.MShowPlaylistClick(Sender: TObject);
begin
  ToggleFormVisibility(frmPlaylist);
end;

procedure TfrmMain.MStreamInfoClick(Sender: TObject);
begin
  ToggleFormVisibility(frmInfo);
end;

procedure TfrmMain.OpenSingleItem(const URL:string);
begin
  if not Playlist.ProcessingFiles then begin
    Playlist.Clear;

    if Playlist.Add(URL) >= 0 then

      NextFile(0,psPlaying)
  end;
end;

procedure TfrmMain.BStopClick(Sender: TObject);
begin
  mpo.Stop;
  Playlist.GetNext(psSkipped,0);
end;


procedure TfrmMain.UpdateStatus;
var imgindex : integer;
begin

  imgindex := -1;
  case mpo.Status of
    sNone:    LStatus.Caption:='';
    sOpening, sPlayStarting: begin
              LStatus.Caption:=LOCstr.Status_Opening;
              imgindex := ICON_OPENING;
    end;
    sClosing: LStatus.Caption:=LOCstr.Status_Closing;

    sPlaying: LStatus.Caption:=LOCstr.Status_Playing;
    sPaused:  LStatus.Caption:=LOCstr.Status_Paused;

    sStopped: LStatus.Caption:=LOCstr.Status_Stopped;
    sError, SErrorRetry:   begin
              LStatus.Caption:=LOCstr.Status_Error;
              imgindex := ICON_ERROR;
    end;
  end;


  if (mpo.status = sPlaying) or (mpo.Status = sPaused) then begin
      if not mpo.ScalerTried then
        imgindex := ICON_PLAY_NORMAL
      else
        imgindex := ICON_PLAY_SCALER;
  end;
  UpdateImageFromImagery(imgstatus,imagery,imgindex);

  if (mpo.Status=sError) or (mpo.Status=sErrorRetry)
    then LStatus.Cursor:=crHandPoint
    else LStatus.Cursor:=crDefault;
  if (mpo.Status<>sPlaying) AND (mpo.Status<>sPaused) then
    LTime.Caption:='';
end;

procedure TfrmMain.UpdateAudioInfo;
var imgindex: integer;
begin
  imgindex := -1;
  if mpo.ValidFileInfo then begin
    if mpo.Streaminfo.HaveAudio then begin
      if mpo.StreamInfo.Audio.Channels > 1 then
        imgindex := ICON_AUDIO_STEREO
      else
        imgindex := ICON_AUDIO_MONO;
    end else begin
      imgindex := ICON_AUDIO_NOAUDIO;
    end;
  end;

  UpdateImageFromImagery(imgAudio,imagery,imgindex);
end;

procedure TfrmMain.UpdateTime;
begin
  if (mpo.Status<>sPlaying) AND (mpo.Status<>sPaused)
    then LTime.Caption:=''
    else
    begin
      LTime.Caption:='';application.processMessages;
      LTime.Caption:=SecondsToTimeHMS(mpo.SecondPos)+
                        ' / '+ mpo.streaminfo.durationString;
    end;
    self.Refresh;
    application.processMessages;
end;

procedure TfrmMain.UpdateCaption;
begin

  if length(Captionstring)<>0
    then Caption:=Captionstring+' - '+LOCstr.Title
    else Caption:=LOCstr.Title;
end;

procedure TfrmMain.VolSliderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button<>mbLeft then exit;
  VolSlider.BevelInner:=bvLowered;
  SeekMouseX:=X; SeekBaseX:=VolSlider.Left;
end;

procedure TfrmMain.VolSliderMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var NewX,MaxX,NewVolume:integer;
begin
  if not(ssLeft in Shift) then exit;
  NewX:=X-SeekMouseX+VolSlider.Left;
  MaxX:=VolFrame.ClientWidth-VolSlider.Width;
  if NewX<0 then NewX:=0;
  if NewX>MaxX then NewX:=MaxX;
  VolSlider.Left:=NewX;
  NewVolume:=(NewX*100+(MaxX SHR 1)) DIV MaxX;
  if NewVolume=mpo.Volume then exit;

  if NewVolume > mpo.Volume then
    if mpo.Mute then
     BMuteClick(nil);
  mpo.Volume:=NewVolume;
end;

procedure TfrmMain.VolSliderMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  VolSlider.BevelInner:=bvRaised;
end;

procedure TfrmMain.BAudioEquClick(Sender: TObject);
begin
ToggleFormVisibility(frmaudioequ);
end;

procedure TfrmMain.BeginWindowUpdate;
begin
  UpdatingWindow := True;
end;

procedure TfrmMain.BMuteClick(Sender: TObject);
begin
  if Sender=BMute then
    mpo.Mute:=BMute.Down
  else begin
    mpo.Mute:=not(mpo.Mute);
    BMute.Down:=mpo.Mute;
  end;
end;

procedure TfrmMain.BOpenClick(Sender: TObject);
begin

MOpenFileClick(nil);

end;

procedure TfrmMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if shift =[] then
    SetVolumeRel(WheelDelta DIV 40)
  else if shift = [ssCtrl] then
    if wheeldelta > 0 then
      incspeed(1)
    else
      incspeed(-1);
end;


procedure TfrmMain.UpdateMPwindow( hide : boolean = false);
  var wpos : twindowpos;
  var mphandle :  cardinal;
  var istop : bool;
begin
  // hide parameter is not used actually

  if not mpo.renderinfo.HasVideoOverlay then Exit;

  mphandle := mpo.GetMplayerWindowHandle;

  if mphandle > 0 then
  begin

    istop := (GetWindowLong(Handle ,  GWL_EXSTYLE) and WS_EX_TOPMOST) <> 0;
    if istop then
      wpos.hwndInsertAfter := 0
    else
      wpos.hwndInsertAfter := GetNextWindow(mphandle,GW_HWNDprev);

    if (wpos.hwndInsertAfter > 0) or istop then
    begin
     wpos.hwnd := mphandle;
     wpos.x := 0;
     wpos.y := 0;
     if hide then begin
       wpos.cx := 1 ;
       wpos.cy := 1 ;
       wpos.flags := 0;
     end else begin
       wpos.cx := screen.Width ;
       wpos.cy := screen.Height ;
       wpos.flags := swp_nosize;
     end;
     wpos.flags := wpos.flags +  swp_nomove or swp_noredraw or swp_noactivate or 1800 ;

     sendmessage(mphandle, WM_WINDOWPOSCHANGED, 0, integer( @wpos ));
    end;
  end;

end;

procedure TfrmMain.DoIdle(Sender: TObject; var Done: Boolean);
begin
  sskinprovider1.RepaintMenu ;
  // SendMessage(Application.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  SendMessage(Application.MainForm.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  SetForegroundWindow(Application.MainForm.Handle);
  Done:=true;
  Application.OnIdle:=nil;
end;

procedure TfrmMain.FormWmEnterSizeMove(var Msg: TMessage);
begin
  inherited;
  InSizeMoveLoop := True;
end;

procedure TfrmMain.FormWmEraseBg(var Msg: TWMEraseBkgnd);
begin
  if DwmCompositionEnabled then begin
    Canvas.Brush.Color := clBlack;
    Canvas.FillRect(Rect(0,0,ClientWidth,ClientHeight));
  end;
  Msg.Result := 1;
end;

procedure TfrmMain.FormWmExitSizeMove(var Msg: TMessage);
begin
  inherited;
  InSizeMoveLoop := False;
end;

{$IFDEF APPLICATIONFORMSFIX}
procedure showAppOwnedWindows(show: Boolean);
var
  i: Integer;
  f: Tform;
  wParentHandle : HWND;
  activeHandle : HWND;
begin

  activeHandle := Application.ActiveFormHandle;
  for i := Screen.FormCount - 1 downto 0 do begin
    f := Screen.Forms[I];
    wParentHandle := HWND(GetWindowLong(f.Handle,GWL_HWNDPARENT));
    if (wParentHandle = Application.Handle) or (wParentHandle = 0) then begin
      if show then begin
        if f.Visible then begin
          ShowWindow(f.Handle, SW_SHOWNA);
          ShowOwnedPopups(f.Handle, true);
        end;
      end else begin
        if f <> Application.MainForm then begin
          ShowWindow(f.Handle, SW_HIDE);
          ShowOwnedPopups(f.Handle, false);
        end;
      end;
    end;
  end;

  if activeHandle <> 0 then
    SetActiveWindow(activeHandle);
end;
{$ENDIF}

procedure TfrmMain.FormWmSize(var Msg: TMessage);
var
  Restoring :boolean;
  RestoringFromMinimized : Boolean;
  Minimizing : Boolean;
begin
  restoring := False;
  RestoringFromMinimized := False;
  Minimizing := False;

  if Msg.WParam = SIZE_MINIMIZED then begin
    ControlledResize := 1;
    {$IFDEF APPLICATIONFORMSFIX}
    if LastSize <> SIZE_MINIMIZED  then
      Minimizing := True;
    {$ENDIF}

    LastSize := SIZE_MINIMIZED;

    {$IFDEF ACTDEBUGLOG}
    DebugLog('MINIMIZED');
    {$ENDIF}
  end;
   sStatusBar1.SizeGrip:=true;
  if Msg.WParam = SIZE_MAXIMIZED then begin
    ControlledResize := 1;
    sStatusBar1.SizeGrip:=false;
    if LastSize = SIZE_MINIMIZED then
      RestoringFromMinimized := True;

    LastSize := SIZE_MAXIMIZED;
    {$IFDEF ACTDEBUGLOG}
    DebugLog('MAXIMIZED');
    {$ENDIF}
  end;
  if Msg.WParam = SIZE_RESTORED then begin
    if LastSize <> SIZE_RESTORED  then begin
      ControlledResize := 1;
      restoring := True;
    end;

    if LastSize = SIZE_MINIMIZED then
      RestoringFromMinimized := True;

    LastSize := SIZE_RESTORED;


    {$IFDEF ACTDEBUGLOG}
    DebugLog('RESTORED');
    {$ENDIF}
  end;
    {$IFDEF ACTDEBUGLOG}
    DebugLog('----------------########-----------------------');
    {$ENDIF}
  inherited;

    {$IFDEF ACTDEBUGLOG}
    DebugLog('-----------------------------------------------');
    {$ENDIF}

  if restoring and (not Fullscreen) then
    if not MSizeAny.Checked then
      if mpo <> nil then begin
        VideoSizeChanged;
      end;

  {$IFDEF APPLICATIONFORMSFIX}
  if Minimizing then //or RestoringFromMinimized then
    SetWindowPos(Application.Handle,0,0,0,0,0, SWP_HIDEWINDOW +
            SWP_NOACTIVATE+SWP_NOMOVE+SWP_NOOWNERZORDER+SWP_NOSIZE +SWP_NOZORDER);

  if RestoringFromMinimized  then
    begin
    showAppOwnedWindows(True);

    end;

  if Minimizing then begin
    //showAppOwnedWindows(false);
  end;
  {$ENDIF}

  if RestoringFromMinimized then
  begin
    MinimizingWindow := False;
    timer1.Enabled:=true;
  end;
end;

procedure TfrmMain.FormWmWindowposChanging(var Msg: TWMWindowPosChanging);
begin
  inherited;
  if not InSizeMoveLoop then begin
    if (Msg.WindowPos.flags and SWP_NOSIZE) = 0 then
      if (Msg.WindowPos.cx <> Width) or (Msg.WindowPos.cy <> Height) then begin

        if not MinimizingWindow then
          pnlAll.Visible := False;
        {$IFDEF ACTDEBUGLOG}
        DebugLog('POSCHANGING');

        if pnlAll.Visible then
          DebugLog('--PNLALL VISIBLE')
        else
          DebugLog('--PNLALL NOT VISIBLE');
        {$ENDIF}
      end;
      {$IFDEF ACTDEBUGLOG}
      debugLog(Format('%4.4x  %d %d',
                     [Msg.WindowPos.flags, Msg.WindowPos.cx, Msg.WindowPos.cy]));
      {$ENDIF}

  end;
end;

procedure TfrmMain.FormSyscommand(var Msg: TMessage);
begin

  if msg.WParam = SC_MINIMIZE then begin
    MinimizingWindow := True;

  end;
  {$IFDEF ACTDEBUGLOG}
  if msg.WParam = SC_MINIMIZE then
    debugLog('SC_MINIMIZE');
  {$ENDIF}
  inherited;
end;
procedure TfrmMain.ApplicationActivate(Sender: TObject);
begin
{$IFDEF APPLICATIONFORMSFIX}
  //if WindowState <> wsMinimized then
      //sskinprovider1.RepaintMenu ;

{$ENDIF}
end;

procedure TfrmMain.FormPosChanged(var Msg: TMessage);

begin
  {$IFDEF ACTDEBUGLOG}
  DebugLog('POSCHANGED');
  {$ENDIF}
  inherited;
  if assigned (mpo) then
    if (mpo.Status = spaused)  then
      UpdateMPwindow();
end;

procedure TfrmMain.DisplayMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if Sender = innerpanel then begin
    if (Button = mbLeft) and mpo.Running then
      mpo.DVDMenuClick
      // send dvd command before releasecapture.
      // mouseup event never fires because of releasecapture
  end;

  // do not start moving if fullscreen, maximized or right button
  if Fullscreen OR (Button<>mbLeft) or (windowstate = wsMaximized) then exit;
  // I love these undocumented Windows messages ... [http://keyj.s2000.ws/?p=18]
  ReleaseCapture;
  SendMessage(Handle, WM_SYSCOMMAND, SC_MOVE+2, 0);
end;

{$IFDEF ACTDEBUGLOG}
procedure TMainForm.DebugLog(str : string);
begin
  if (frmLog <> nil) and (not closingApp) then
    frmLog.AddLine(str);
end;
{$ENDIF}


procedure TfrmMain.DisplayDblClick(Sender: TObject);
begin
  SetFullscreen(not(Fullscreen));
end;

procedure TfrmMain.LEscapeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  outerpanelmousemove(sender,shift,x + lEscape.left, y + lEscape.Top); // visenri mod
end;

procedure TfrmMain.LEscapeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  outerpanelmouseup(sender,button,shift,x,y);
end;

function CreateRotatedFont(F: TFont; Angle: Integer): hFont; 
var 
  LF : TLogFont; 
begin 
  FillChar(LF, SizeOf(LF), #0);
  with LF do 
  begin 
    lfHeight := F.Height; 
    lfWidth := 0; 
    lfEscapement := Angle*10; 
    lfOrientation := 0; 
    if fsBold in F.Style then 
      lfWeight := FW_BOLD 
    else 
      lfWeight := FW_NORMAL; 
    lfItalic := Byte(fsItalic in F.Style); 
    lfUnderline := Byte(fsUnderline in F.Style); 
    lfStrikeOut := Byte(fsStrikeOut in F.Style); 
    lfCharSet := DEFAULT_CHARSET; 
    StrPCopy(lfFaceName, F.Name); 
    lfQuality := DEFAULT_QUALITY; 

    lfOutPrecision := OUT_DEFAULT_PRECIS; 
    lfClipPrecision := CLIP_DEFAULT_PRECIS; 
    case F.Pitch of 
      fpVariable: lfPitchAndFamily := VARIABLE_PITCH; 
      fpFixed: lfPitchAndFamily := FIXED_PITCH; 
    else 
      lfPitchAndFamily := DEFAULT_PITCH; 
    end; 
  end;
  Result := CreateFontIndirect(LF); 
end;

procedure DrawVerticalGradient(bm: Tbitmap; clStart : Tcolor; clEnd : Tcolor);
var
i : integer;
ColorStart, ColorEnd: Longint;
rc1, gc1, bc1, rc2, gc2, bc2 : byte;
begin
  bm.Canvas.Brush.Style := bssolid;
  ColorStart := ColorToRGB(clStart);
  ColorEnd := ColorToRGB(clEnd);
  if ColorStart = ColorEnd then begin
    bm.Canvas.Brush.Color := ColorStart;
    bm.Canvas.FillRect(Rect(0, 0, bm.Width ,bm.Height));
  end else begin
    { get the color components here so they are faster to access
          inside the loop }
    rc1 := GetRValue(ColorStart);
    gc1 := GetGValue(ColorStart);
    bc1 := GetBValue(ColorStart);
    rc2 := GetRValue(ColorEnd);
    gc2 := GetGValue(ColorEnd);
    bc2 := GetBValue(ColorEnd);

    { make sure that division by zero doesn't happen }
    if bm.Height <> 0 then
      for i := 0 to bm.height-1 do
      begin
        bm.Canvas.Brush.Color := RGB(
          (rc1 + (((rc2 - rc1) * (i)) div
            bm.Height)),
          (gc1 + (((gc2 - gc1) * (i)) div
            bm.Height)),
          (bc1 + (((bc2 - bc1) * (i)) div
            bm.Height)));
        bm.Canvas.FillRect(Rect(0, i, bm.Width, i + 1));
      end;
  end;
end;

procedure DrawVerticalText(bm: Tbitmap; Text: string; Text2 : string);
var
  iTmp : Cardinal;
  r : Trect;
  loffset : integer;
begin
  with bm.Canvas.Font do
  begin
    Name := 'Tahoma';
    Size := 14;
    Color := clWhite;
    Style := [fsBold];

    iTmp := Handle; { store old }
    Handle := CreateRotatedFont(bm.Canvas.Font, 90);
  end;

  bm.Canvas.Brush.Style := bsClear;
  r := Rect(0, 0, bm.Width , bm.Height);
  loffset := (bm.Width - bm.Canvas.TextHeight(Text)) div 2;

  ExtTextOut(bm.canvas.Handle, loffset, bm.Height - 8 ,
    ETO_CLIPPED, @r, PChar(Text), Length(Text),
    nil);

  { delete created font and restore old handle }
  DeleteObject(bm.Canvas.Font.Handle);
  bm.Canvas.Font.Handle := iTmp;

  with bm.Canvas.Font do
  begin
    Name := 'Tahoma';
    Size := 12;
    Color := clBlue;
    Style := [];

    iTmp := Handle; { store old }
    Handle := CreateRotatedFont(bm.Canvas.Font, 90);
  end;

  loffset := (bm.Width - bm.Canvas.TextHeight(Text2)) div 2;

  ExtTextOut(bm.canvas.Handle, loffset , bm.Canvas.TextWidth(Text2) + 8 ,
    ETO_CLIPPED, @r, PChar(Text2), Length(Text2),
    nil);

  { delete created font and restore old handle }
  DeleteObject(bm.Canvas.Font.Handle);
  bm.Canvas.Font.Handle := iTmp;
end;

function isMenuRoot (mnuItem : TmenuItem) : boolean;
var
  c: Tcomponent;
begin
  Result :=false;
  c := mnuItem.GetParentComponent;
  if c is Tmenu then
    if mnuItem.Parent = (c as Tmenu).Items then
      Result := true;
end;
function isMenuParentClass(mnuItem:TmenuItem; pclass : Tclass) : boolean;
var
  c: Tcomponent;
begin
  c := mnuItem.GetParentComponent;
  Result := c is pclass;
end;

procedure TfrmMain.setMnuDrawEvents(Mnu : Tmenuitem);
var i : integer;
begin
exit;
  for i := 0 to Mnu.Count - 1 do
    setMnuDrawEvents(Mnu.Items[i]);
end;


procedure TfrmMain.DoLocalize;

  procedure Local_Menu(Men: TmenuItem; const Locstr : array of widestring);
  var i : integer;
  begin
    for i := 0 to Men.Count  -1 do begin
      if high(Locstr) >= i then
        Men.Items[i].Caption := Locstr[i];
    end;
  end;
var i: integer;
begin
  inherited;
  with MLanguage do
    for i:=0 to Count-1 do
      if Items[i].Tag=CurrentLocale then
        Items[i].Checked:=true;

  Font.Charset:=CurrentLocaleCharset;
  LEscape.Font.Charset:=CurrentLocaleCharset;

  MPFullscreenControls.Caption:=LOCstr.FullscreenControls;
  OSDMenu.Caption:=LOCstr.OSD;
    MNoOSD.Caption:=LOCstr.NoOSD;
    MDefaultOSD.Caption:=LOCstr.DefaultOSD;
    MTimeOSD.Caption:=LOCstr.TimeOSD;
    MFullOSD.Caption:=LOCstr.FullOSD;
  LEscape.Caption:=LOCstr.Escape;
  OMFile.Caption:=LOCstr.Filemenu;
    MOpenFile.Caption:=LOCstr.OpenFile;
    MOpenURL.Caption:=LOCstr.OpenURL;
    MOpenDrive.Caption:=LOCstr.OpenDrive;
    MOpenTv.Caption := LOCstr.OpenTV;
    MRadios.Caption:=LOCstr.InternetRadios;;
    MClose.Caption:=LOCstr.Close;
    MQuit.Caption:=LOCstr.Quit + #9'Q';
  OMView.Caption:=LOCstr.View;
    MSizeAny.Caption:=LOCstr.SizeAny;
    MSize50.Caption:=LOCstr.Size50;
    MSize100.Caption:=LOCstr.Size100;
    MSize200.Caption:=LOCstr.Size200;
    MVideoInside.Caption := LOCstr.VideoInside;
    MFullscreen.Caption:=LOCstr.Fullscreen + #9'F';
    MCompact.Caption:=LOCstr.Compact + #9'C';
    MOSD.Caption:=LOCstr.TogOSD + #9'O';
    MOnTop.Caption:=LOCstr.OnTop + #9'T';
    MVis.Caption := LOCstr.Vis;
    MVisEnable.Caption := LOCstr.VisEnable;
    MvisDirectRender.Caption := LOCstr.VisDirectRender;
  OMSeek.Caption:=LOCstr.Seek;
    MPlay.Caption:=LOCstr.Play;
    MPause.Caption:=LOCstr.Pause;
    MStop.Caption:=LOCstr.Stop;
    MPrev.Caption:=LOCstr.Prev;
    MNext.Caption:=LOCstr.Next;
    MShowPlaylist.Caption:=LOCstr.ShowPlaylist;
    MRepeat.Caption:= LOCstr.PlaylistFormLoop;
    MMute.Caption:=LOCstr.Mute;
    MSeekF10.Caption:=LOCstr.SeekF10;
    MSeekR10.Caption:=LOCstr.SeekR10;
    MSeekF60.Caption:=LOCstr.SeekF60;
    MSeekR60.Caption:=LOCstr.SeekR60;
    MSeekF600.Caption:=LOCstr.SeekF600;
    MSeekR600.Caption:=LOCstr.SeekR600;
  MDVD.Caption:=LOCstr.Navigation;
    MDVDmenu.Caption:=LOCstr.Menu;
    MTitles.Caption:=LOCstr.Titles;
    MChapters.Caption:=LOCstr.Chapters;
  OMExtra.Caption:=LOCstr.Extra;
    MAudio.Caption:=LOCstr.Audio;
    MSubtitle.Caption:=LOCstr.Subtitle;
    if (MSubtitle.Count> 0) then
      Msubtitle.Items[0].Caption := LOCstr.NoSubtitle;
    MSubAdd.Caption := LOCstr.AddSubtitle;

  MSettings.caption := LOCstr.Settings;
    MAspect.Caption:=LOCstr.Aspect;
    MDeinterlaceAlg.Caption:=LOCstr.DeinterlaceAlg;
    MDeinterlace.Caption:=LOCstr.Deinterlace;
    MOptions.Caption:=LOCstr.Options;
    Mlanguage.Caption :=LOCstr.Language;
    MStreamInfo.Caption:=LOCstr.StreamInfo;
    MShowOutput.Caption:=LOCstr.ShowOutput;
  OMhelp.Caption:=LOCstr.Help;
    MKeyHelp.Caption:=LOCstr.KeyHelp;
    MAbout.Caption := LOCstr.About;

  MPPlay.Caption:=MPlay.Caption;
  MPPause.Caption:=MPause.Caption;
  MPStop.Caption:=MStop.Caption;
  MPPrev.Caption:=MPrev.Caption;
  MPNext.Caption:=MNext.Caption;
  MPRepeat.Caption:= MRepeat.Caption;

  MPVideoinside.Caption := LOCstr.VideoInside;
  MPFullscreen.Caption:=LOCstr.Fullscreen;
  MPCompact.Caption:=LOCstr.Compact;
  MPOnTop.Caption:=LOCstr.OnTop;
  MPQuit.Caption:=LOCstr.Quit;


  Local_Menu(MAspect, LOCstr.AspectMap);
  Local_Menu(MDeinterlaceAlg, LOCstr.DeinterlaceAlgMap);
  Local_Menu(MDeinterlace, LOCstr.OffOnAuto);

  BStreamInfo.Hint := LOCstr.StreamInfo;
  BPlaylist.Hint:=LOCstr.ShowPlaylist;
  Bsettings.Hint := Msettings.Caption;
  BFullscreen.Hint:=LOCstr.Fullscreen;
  BAudioEqu.Hint:=LOCstr.AudioEqu ; /////////////////////
  BMute.Hint:=LOCstr.Mute;
  BCompact.Hint:=LOCstr.Compact;

  UpdateStatus;
  UpdateCaption;
end;

procedure TfrmMain.LogoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if sender is TImage then
    outerpanelmousemove(sender,shift,x +(sender as Timage).Left , y +(sender as Timage).Top); // visenri mod
end;

procedure TfrmMain.LogoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  outerpanelmouseup(sender,button,shift,x,y);
end;

procedure TfrmMain.InnerPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  outerpanelmousemove(sender,shift,x + innerpanel.Left, y +innerpanel.Top); // visenri mod
  if mpo.Running then
  begin
    mpo.DVDMenuPostition((x* mpo.Renderinfo.Width)div innerpanel.Width,
                         (y*mpo.Renderinfo.Height) div innerpanel.Height);
  end;
end;
procedure TfrmMain.InnerPanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  outerpanelmouseup(sender,button,shift,x,y);
end;

procedure TfrmMain.OuterPanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  //SetFullscreenControls(true);exit; //asupp
  if Fullscreen  then
    if not(FullscreenControls) then
     if (LastX > 0) and (LastY > 0) then begin
      if (abs(X-LastX) + abs(Y-LastY)) > MOVEPOS_SHOW_FS_CONTROLS then begin
        if EnableFullscreenControlsCount < TIME_SHOW_FS_CRONTROLS then
            inc(EnableFullscreenControlsCount)

        else
            SetFullscreenControls(True)
      end
     end else begin
       LastX := X;
       LastY := Y;
     end
    else
      if (X <> LastX) or (Y <> LastY) then begin
        if DisableFullscreenControlsCount >= 0 then begin
            DisableFullscreenControlsCount:=TIME_HIDE_FS_CRONTROLS;
        end;
        LastX := X;
        LastY := Y;
      end;
end;

procedure TfrmMain.OuterPanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Fullscreen  then begin
    if not(FullscreenControls) then begin
      if EnableFullscreenControlsCount >= 0 then begin
        EnableFullscreenControlsCount := TIME_SHOW_FS_CRONTROLS;
        SetFullscreenControls(True)
      end;
    end;
  end;
end;

procedure TfrmMain.SetFullscreenControls(Mode:boolean);
begin
  if (not Fullscreen) or (fullscreencontrols = mode) then exit;
  //if (not Fullscreen)  then exit;

  if Mode then begin
    SetMouseVisible(True);
    controlpanel.SendToBack; //avoid controlpanel flash in old position with vo gl
    controlpanel.Visible := true;
    controlpanel.BringToFront;
    UpdateLZoomPosition;
    FullscreenControls:=True;
    if DisableFullscreenControlsCount >= 0 then
      DisableFullscreenControlsCount:=TIME_HIDE_FS_CRONTROLS;
  end else begin
    EnableFullscreenControlsCount := 0;
    controlpanel.Visible := false;
    FullscreenControls:=False;
    SetMouseVisible(False);
  end;
end;

procedure TfrmMain.SetMouseVisible(Mode:boolean);
begin
  if Mode then begin
    Logo.Cursor:=crDefault;
    InnerPanel.Cursor:=crDefault;
    OuterPanel.Cursor:=crDefault;
    LEscape.Cursor := crDefault;
  end else begin
    OuterPanel.Cursor:=-1;
    InnerPanel.Cursor:=-1;
    Logo.Cursor:=-1;
    LEscape.Cursor := -1;
  end;
end;


procedure TfrmMain.SetPanelVisibility(p : TPanel; value: Boolean; delayed : Boolean = False);
begin
  if not delayed then
    p.Visible := value;
  if value then
    p.Tag := 1
  else
    p.Tag := 0;
end;

procedure TfrmMain.LoadRadios;
begin
  frmradios.show;
end;
procedure TfrmMain.MRadiosClick(Sender: TObject);

var
  xfilename: string;
  myYear, myMonth, myDay : Word;
begin

     DecodeDate(Date, myYear, myMonth, myDay);
     xfilename := Tempdir + 'yp_' + IntToStr(myDay) + '_' + IntToStr(myMonth) + '_' + IntToStr(myYear)  + '.xml';
     frmradios.xfilename:=xfilename;
      if FileExists(xfilename) then
        begin

          frmradios.Show;
        end
      else
      begin
          FTask := CreateTask(DoJobs, 'DoJobs')
          .MonitorWith(OTLMonitor)
          .SetParameter('URL', 'http://dir.xiph.org/yp.xml')
          .SetParameter('TargetFile', xfilename)
          .Run;
      end;

end;

procedure TfrmMain.MRepeatClick(Sender: TObject);
begin
    frmPlaylist.CLoop.Checked := not mrepeat.Checked;
end;



procedure TfrmMain.MRestoreWindowsClick(Sender: TObject);
begin
   with frmPlaylist.Dock do begin
    DockLR := 2;
    DockTB := -1;
    DockPos := 0;
    //DockForm := Self;
    LinkSize := True;
    SetSize := True;
    DockForm := frmMain;//
  end;

  with frmInfo.Dock do begin
    DockLR := -1;
    DockTB := 2;
    DockPos := 0;
    DockForm := frmPlayList;
    SetSize := True;
  end;

  with frmSettings.Dock do begin
    DockLR := -1;
    DockTB := 2;
    DockPos := 0;
    DockForm := frmMain;
  end;

  //DockList.SetAllWindowsPos(opt.windowPos);
  frmPlaylist.DockTo;
  frmInfo.DockTo;
  frmSettings.DockTo;

end;

procedure TfrmMain.MSettingsClick(Sender: TObject);
begin
  ToggleFormVisibility(frmSettings);
end;

// Indicate that we want all keys, even special ones
procedure TfrmMain.FormWantSpecialKey(var msg:TCMWantSpecialKey);
begin
  msg.Result:=1;
end;



procedure TfrmMain.MPFullscreenControlsClick(Sender: TObject);
begin
  if DisableFullscreenControlsCount = -1 then
    DisableFullscreenControlsCount:=0
  else
    DisableFullscreenControlsCount:=-1;

  if Fullscreen  then
    SetFullscreenControls(DisableFullscreenControlsCount=-1);

end;

procedure TfrmMain.LStatusClick(Sender: TObject);
begin
  if (mpo.Status=sError) or (mpo.Status=sErrorRetry) then begin
    frmLog.Show;
    frmLog.TheLog.ScrollBy(0,32767);
    frmLog.SetFocus;
  end;
end;

procedure TfrmMain.VolBoostClick(Sender: TObject);
begin
  if mpo.Volume>100 then begin
    mpo.Volume:=100;
    VolBoost.Caption:='100%';
  end;
end;
procedure TfrmMain.mpoLogClear(sender: TObject);
begin
  frmLog.ClearLog;
end;
procedure TfrmMain.mpoAudioChange(sender: tobject; id: integer);
begin
  if not mpo.IsOpening then begin
    UpdateMAudioItems;
    MenuSelectId(Maudio,id);
    if frmInfo.Visible then
      frmInfo.UpdateInfo;
      Caption8514;
  end;
end;
procedure TfrmMain.mpoSubAdded(sender : tobject;id : integer);
begin
  if not mpo.IsOpening then
    UpdateMSubItems;
end;
procedure TfrmMain.mpoSubChange(sender: tobject; id: integer);
begin
  if not mpo.IsOpening then begin
    MenuSelectId(Msubtitle,id);
    if frmInfo.Visible then
      frmInfo.UpdateInfo;
      Caption8514;
  end;
end;

procedure TfrmMain.mpolog(sender: TObject; str: string);
begin
  frmLog.AddLine(str);
end;
procedure TfrmMain.mpoOverlayChange(Sender: TObject; required: boolean;
  color: Tcolor);
begin
    if required then
      innerpanel.Color := color
    else
      innerpanel.Color := outerpanel.Color;
end;
procedure TfrmMain.mpoVideoSizeChanged(sender: TObject);
begin
  videosizechanged();
end;
procedure TfrmMain.mpoPercentPosition(sender: TObject);
begin
  UpdateSeekBar;
end;
procedure TfrmMain.mpoSecondPosition(sender: TObject);
begin
  UpdateTime
end;


procedure TfrmMain.mpoStatusChange(Sender: TObject; oldstatus,newstatus: TStatus);
begin



  case newstatus of
    sNone: begin
      setupstop(true);
      UpdateMAudioItems;
      UpdateMSubItems;
      UpdateMTitleItems;
      UpdateMChapterItems;
      frmInfo.UpdateInfo;
      Caption8514;
      Captionstring := '';
      updatecaption;
      UpdateZoomLabel;
      UpdateAudioInfo;
      frmPlaylist.checkEmptyPlaylist;
    end;
    sOpening: begin
     setupstart;
     mAudio.Enabled := false;
     mSubtitle.Enabled := false;
     mTitles.Enabled := false;
     mChapters.Enabled := false;
     mDvdMenu.Enabled := false;
     InnerPanel.Visible:=false;
    end;
    sPlayStarting: begin
      setupplayStarting();
    end;
    sPlaying, sPaused: begin
      if oldstatus = sPlayStarting then begin
        UpdateMAudioItems;
        MAudioSelect;
        UpdateMSubItems;
        MSubSelect;
        UpdateMTitleItems;
        UpdateMChapterItems;
        MTitleSelect;
        updatezoomlabel;
        mDvdMenu.Enabled := mpo.Streaminfo.IsDvdNav;
        frmPlaylist.SetCurrentDuration(mpo.Streaminfo.DurationString);
        if lastseekbarpos > 0 then
          GotoSeekbarPosition(lastseekbarpos);
      end;
      SetupPlayPause(oldstatus = sPlayStarting);
    end;
    sClosing: begin
        outerpanel.color:=clblack;
        outerpanel.Repaint ;
        Logo.Visible:=true;
    end;
    sStopped: begin
       setupstop(true);
       UpdateZoomLabel;
    end;
    sError,sErrorRetry:  setupstop(true);
  end;
  updatestatus;

  if (newstatus = sError) or (newstatus = sStopped) and
     not(mpo.ExplicitStop) then begin
      if newstatus = sStopped then begin
        outerpanel.color:=clblack;
        outerpanel.Repaint ;
        Logo.Visible:=true;

        NextFile(1,psPlayed);

      end else
        outerpanel.color:=clblack;
        outerpanel.Repaint ;
        Logo.Visible:=true;
        NextFile(1,psSkipped)
  end;
end;

procedure TfrmMain.mpoProgress(Sender : TObject;name: string; value : string);
  function getStrPosRev(schr : char;echr : char; const str: string): string;
  var spos, epos : integer;
  begin
    spos := lastdelimiter(schr,str);
    epos := lastdelimiter(echr,str);
    if (spos > 0) and (spos < length(str)) then
      if epos > 0 then
        result := copy(str,spos+1,epos - spos-1)
      else
        result := copy(str,spos+1,length(str) - spos)
    else
      result :='';
  end;
begin
  if mpo.Status = sOpening then
    if length(value)>0 then
    begin
      lzoom.Caption := name + ': ' + value;UpdateLZoomPosition;
      //UpdateZoomLabel(name + ': ' + value);
      //application.processMessages;
    end
    else
     UpdateLZoomPosition;
  //self.Refresh;application.processMessages;
  lastaspect := -1;

end;
procedure TfrmMain.mpoPropertysRead(sender: TObject);
var i : integer;
begin
  for i := 0 to MAX_PROP_ENTRYS do
    frmSettings.EnableSetting(i,mpo.propertyValues[i].valid);

end;
procedure TfrmMain.mpoLoadNextFile(Sender: Tobject; var name: string);
var index: integer;
  dummy : string;
begin
  if not playlist.Shuffle then begin
    Index:=Playlist.GetNext(psPlayed,1,true);
    if index >=0 then
        name := MakeURL(Playlist[Index].FullURL,dummy);
  end;
end;
procedure TfrmMain.mpoFileLoaded(Sender: Tobject; var name: string);
var index: integer;
  newUrl : string;
  newCaption : string;
begin

  Index:=Playlist.GetNext(psPlayed,1);
  if index >=0 then begin
    newUrl := MakeURL(Playlist[Index].FullURL,newCaption);
    if newUrl = name then begin
      Captionstring := newcaption;
      updateCaption;
      Playlist.NowPlaying(Index);
    end else begin
      name :='';
    end;
  end else begin
    MakeURL(name,Captionstring);
    updateCaption;
  end;



end;
procedure TfrmMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WinClassName := '3nityMutex';
end;
procedure TfrmMain.PassMsg(var msg: Tmessage);
var
buf : array[0..MAX_PATH]of char;
F : string;
n : integer;
begin

      n := 0;
      if msg.LParam  = 1 then begin
      //Get 2nd instance's ParamStr(1)
      FillChar(buf, SizeOf(buf), 0);
      n := GlobalGetAtomName(msg.WParam , @buf, MAX_PATH);
      // Lib�ration des ressources
      GlobalDeleteAtom(msg.WParam );
      end;
      //Open 2nd instance's ParamStr(1)...
      if n > 0 then begin
      F := buf;

      now1 := GetTickCount;
      elapsedTime1 := (now1 - FLastTime1) / 1000;
      FLastTime1 := now1;
          if elapsedTime1 > 2 then
          begin

          Playlist.Clear();

          Playlist.Add(F);
          Application.OnIdle:=frmMain.OpenDroppedFile;
          end
          else
          begin
          Playlist.Add(F);
          end;



      end;
      end;

procedure TfrmMain.Caption8514;
begin
      for counttitle:=0 to 9 do
     with mpo.Streaminfo.ClipInfo[counttitle] do
        if (length(Key)>0) AND (length(Value)>0) then begin
          //Captionstring
          //T(Key, Value);
          if (lowercase(Key)='title') then begin
             CaptionString:=Value;
             UpdateCaption ;
          end;

     end;
end;

function ThreadDownloadFile(URl:string;TargetFile:string): boolean;
const
  MaxRetries=3;
var
  HTTPGetResult: boolean;
  HTTPSender: THTTPSend;
  RetryAttempt: integer;
  DecompStream:tstream;
begin
  result:=true;
  RetryAttempt:=1;
  HTTPSender:=THTTPSend.Create;
  HTTPSender.Headers.Add('Accept-Encoding: gzip,deflate');
  HTTPSender.Protocol:='1.1';
  try
    try
          // Try to get the file
          HTTPSender.UserAgent:=UAgent;
          HTTPGetResult:=HTTPSender.HTTPMethod('GET', URL);
          while (HTTPGetResult=false) and (RetryAttempt<MaxRetries) do
          begin
              sleep(500*RetryAttempt);
              HTTPGetResult:=HTTPSender.HTTPMethod('GET', URL);
              RetryAttempt:=RetryAttempt+1;
          end;
          // If we have an answer from the server, check if the file
          // was sent to us.
          case HTTPSender.Resultcode of
            100..299:
              begin
                HeadersToList(HTTPSender.Headers);

                if Trim(HTTPSender.Headers.Values['Content-Encoding']) = 'gzip' then
                  begin
                    DecompStream := TMemoryStream.Create;
                    try
                    //DecompStream.Seek(0, soFromBeginning) ;
                    HTTPSender.Document.Seek(0, soFromBeginning);
                      GZDecompressStream(HTTPSender.Document, DecompStream);

                     with TFileStream.Create(TargetFile,fmCreate or fmOpenWrite) do
                    try
                        Seek(0, soFromBeginning);
                        CopyFrom(DecompStream, 0);
                    finally
                        Free;
                    end;

                    finally
                      DecompStream.Free;
                    end;

                  end;
              end;

        300..399: result:=false; //redirection. Not implemented, but could be.
        400..499: result:=false; //client error; 404 not found etc
        500..599: result:=false; //internal server error
        else result:=false; //unknown code
      end;
    except
      // We don't care for the reason for this error; the download failed.
      result:=false;

    end;
  finally
    HTTPSender.Free;
  end;
end;
procedure DoJobs(const task: IOmniTask); //thread
var
  URL  : string;
  TargetFile:string;
begin
  URL := task.Param.ByName('URL');//.ParamByName['URL'];
  TargetFile := task.Param.ByName('TargetFile');//.ParamByName['TargetFile'];
  if ThreadDownloadFile(URL,TargetFile) then
  begin

     task.Comm.Send(MSG_RESULT_THREAD, 'ok');
  end
  else
  begin
     task.Comm.Send(MSG_RESULT_THREAD, 'ko');
  end;
end;
procedure TfrmMain.OTLMonitorTaskMessage(const task: IOmniTaskControl;
  const msg: TOmniMessage);
begin
  //task.Comm.Receive(msg);
  //task.Comm.Receive(msg);
  if msg.MsgID = MSG_RESULT_THREAD then
  begin
     if msg.MsgData.AsString='ok' then
     begin
        ThreadResultok:=true;
     end
     else
     begin
        ThreadResultok:=false;
     end;
  end;
end;

procedure TfrmMain.OTLMonitorTaskTerminated(const task:
  IOmniTaskControl);

begin
  if ThreadResultok then
  begin
    frmradios.show;
  end;
  
end;

end.


