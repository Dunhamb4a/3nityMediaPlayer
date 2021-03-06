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

    This code can be compiled using Embarcadero Delphi XE2 -> to Delphi 10.3 Rio( here using XE7  )
    You will need to install Alphaskin and OmniThreadLibrary components.
    For special questions or if you want to hire a delphi developer you can contact me:  nicolas.deoux@gmail.com
}

unit UfrmInfo;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, VssDockForm, NumUtils, mp3parser, Menus;

type
  TfrmInfo = class(TVssDockForm)
    InfoBox: TListBox;
    pmList: TPopupMenu;
    mpeCopy: TMenuItem;
    mpeCopyAll: TMenuItem;
    procedure BCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InfoBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormHide(Sender: TObject);
    procedure mpeCopyClick(Sender: TObject);
    procedure mpeCopyAllClick(Sender: TObject);
    procedure pmListPopup(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    TabOffset:integer;
    _Copy:string;_CopyAll:string;
    procedure CopyToClipboard(All : Boolean);

  public
    { Public declarations }
    procedure UpdateInfo;
    procedure DoLocalize ; override;
  end;

var
  frmInfo: TfrmInfo;


implementation
uses Locale, UfrmMain, mplayer, ClipBrd;

{$R *.dfm}

function FormatAspectRatio(const Aspect:real):string;
var Numerator,Denominator:integer;
begin
  str(Aspect:0:2,Result); Result:=Result+':1';
  for Denominator:=1 to 50 do begin
    Numerator:=CorrectRound(Aspect*Denominator);
    if abs(Numerator/Denominator-Aspect)<0.01 then begin

      Result:=IntToStr(Numerator)+':'+IntToStr(Denominator) +
              '  ('+Result+')';

      exit;
    end;
  end;
end;




procedure TfrmInfo.CopyToClipboard(All: Boolean);
var txt, line : string;
  i : integer;
begin
  if All then begin
    txt := '';
    for i := 0 to InfoBox.Items.Count - 1 do begin
      line := InfoBox.Items[i];
      if line[1]='!' then
      line := ^M+^J + copy(line,2,length(line)-1);
      txt := txt + line +^M+^J;
    end;
  end else begin
    if InfoBox.ItemIndex >= 0 then
      txt := InfoBox.Items[infobox.ItemIndex];
  end;

 Clipboard.AsText := txt;
end;

procedure TfrmInfo.DoLocalize;
begin
  inherited;
  Font.Charset:=CurrentLocaleCharset;
  Caption:=LOCstr.InfoFormCaption;
  _Copy:=LOCSTR.InfoFormCopy;
  _CopyAll:=LOCSTR.InfoFormCopyAll;
  mpeCopy.Caption:=_Copy;mpeCopyAll.Caption:=_CopyAll;
  //BClose.Caption:=LOCstr.InfoFormClose;
  //BCopy.Caption :=LOCstr.InfoFormCopy;
  self.UpdateInfo;
end;

procedure TfrmInfo.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInfo.UpdateInfo;
var HaveTagHeader,HaveVideoHeader,HaveAudioHeader, HaveSubHeader : boolean;
    W,i:integer; st, audioheader, subheader :string;
    Streaminfo : Tstreaminfo;
    Mp3Info : TMp3info;
  procedure AddHeader(var Flag:boolean; const Caption:WideString); begin
    if Flag then exit;
    InfoBox.Items.Add('!'+Caption);
    Flag:=true;
  end;
  procedure AddItem(const Key:WideString; const Value:string); begin
    W:=Canvas.TextWidth(Key);
    if W>TabOffset then TabOffset:=W;
    InfoBox.Items.Add(Key+^I+Value);
  end;
  procedure T(const Key:WideString; const Value:string);
    begin AddHeader(HaveTagHeader,LOCstr.InfoTags); AddItem(Key,Value); end;
  procedure V(const Key:WideString; const Value:string);
    begin AddHeader(HaveVideoHeader,LOCstr.InfoVideo); AddItem(Key,Value); end;
  procedure A(const Key:WideString; const Value:string);
    begin AddHeader(HaveAudioHeader,audioheader); AddItem(Key,Value); end;
  procedure S(const Key:WideString; const Value:string);
    begin AddHeader(HaveSubHeader,subheader); AddItem(Key,Value); end;
begin
  Streaminfo := frmMain.mpo.StreamInfo;
  Mp3Info := frmMain.mpo.Mp3Info;
  with Streaminfo do begin
    if not Visible then exit;
    InfoBox.Items.Clear;
    TabOffset:=0;
    if not frmMain.mpo.ValidFileInfo  then begin
      InfoBox.Items.Add(LOCstr.NoInfo);
      exit;
    end;
    HaveTagHeader:=false;
    HaveVideoHeader:=false;
    HaveAudioHeader:=false;
    HaveSubHeader := false;
    InfoBox.Items.Add(FileName);
    /////////////ExtractFileName
    try
    if Pos(':',FileName)=2 then
        begin
            if fileexists(FileName) then InfoBox.Items.Add(ExtractFileName(FileName));
        end;
    except

    end;
    
    
    if length(FileFormat)>0 then
      InfoBox.Items.Add(LOCstr.InfoFileFormat+^I+FileFormat);
    if length(DurationString)>0 then
      InfoBox.Items.Add(LOCstr.InfoPlaybackTime+^I+DurationString);
    InfoBox.Items.Add(LOCstr.InfoFilesize +^I+ GetSizeString(stream.length) + 'b ('
                        + formatCurr(',0', stream.length) +' bytes)');

    i := frmMain.mpo.AudioIDS.ActualIndex +1;

    audioheader := LOCstr.InfoAudio + '    ('+
                   LOCstr.InfoTrack + ': ' + inttostr(i) + '/' +
                                              inttostr(frmMain.mpo.AudioIDS.Count) +')';

    for i:=0 to 9 do
    
      with ClipInfo[i] do
        if (length(Key)>0) AND (length(Value)>0) then begin

          T(Key, Value);

        end;

    if length(Video.Decoder)>0 then
      V(LOCstr.InfoDecoder, Video.Decoder);
    if length(Video.Codec)>0 then
      V(LOCstr.InfoCodec, Video.Codec);
    if length(Video.Fourcc) > 0 then
      V('Fourcc',Video.Fourcc);
    if Video.Bitrate<>0 then
      V(LOCstr.InfoBitrate, IntToStr(Video.Bitrate DIV 1000)+' kbps');
    if (Video.Width<>0) AND (Video.Height<>0) then begin
      V(LOCstr.InfoVideoSize, IntToStr(Video.Width)+' x '+IntToStr(Video.Height));
      if Video.Interlaced  then
        st := LOCstr.InfoVideoInt
      else
        st := LOCstr.InfoVideoPro;
      V(LOCstr.InfoInterlace,st);
    end;
    if (Video.FPS>0.01) then begin
      str(Video.FPS:0:3,st); V(LOCstr.InfoVideoFPS, st+' fps'); end;


    if (Video.Autoaspect >0.01) then begin
      V(LOCstr.InfoVideoAspect, FormatAspectRatio(Video.Autoaspect)); end;
    if length(Audio.Decoder)>0 then
      A(LOCstr.InfoDecoder, Audio.Decoder);
    if length(Audio.Codec)>0 then
      A(LOCstr.InfoCodec, Audio.Codec);

    st := '';
    if Audio.Bitrate<>0 then
      st := IntToStr(Audio.Bitrate DIV 1000);
    if IsMp3 and (not Havevideo) and (Mp3Info.VbrBitRate > 0) then
      st := st + ' (' + inttostr(mp3info.VbrBitRate div 1000) + ' VBR)' ;
    if st <>'' then
      A(LOCstr.InfoBitrate, st +' kbps');


    if Audio.Rate<>0 then
      A(LOCstr.InfoAudioRate, IntToStr(Audio.Rate)+' Hz');
    if Audio.Channels<>0 then
      A(LOCstr.InfoAudioChannels, IntToStr(Audio.Channels));


    if frmMain.mpo.SubIDS.Count >0 then begin
      i := frmMain.mpo.SubIDS.ActualIndex;
      subheader := LOCstr.InfoSub + '    ('+
                   LOCstr.InfoTrack + ': ' + inttostr(i) + '/' +
                                              inttostr(frmMain.mpo.SubIDS.Count-1) +')';

      for i := 1 to frmMain.mpo.SubIDS.Count-1 do begin
        st := frmMain.mpo.SubIDS.Items[i].Text;
        if frmMain.mpo.SubIDS.Items[i].lang <> '' then
          st := st + ' - (' + frmMain.mpo.SubIDS.Items[i].lang  + ')';
      
        S(inttostr(i), st);
      end;
    end;

  end;
end;

procedure TfrmInfo.FormShow(Sender: TObject);
begin
  UpdateInfo;
  frmMain.MStreamInfo.Checked:=True;
  frmMain.BStreamInfo.Down:=True;
end;

procedure TfrmInfo.FormHide(Sender: TObject);
begin
  frmMain.MStreamInfo.Checked:=False;
  frmMain.BStreamInfo.Down:=False;
end;

procedure TfrmInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var todo:boolean;handled : boolean;
begin
  todo:=false;
  handled:=true;
 //PostMessage(Application.MainForm.Handle, WM_KEYDOWN, VK_RETURN, 0);
 //TForm(Owner)

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
    Ord('L'):   todo:=true;
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

procedure TfrmInfo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key) = VK_ESCAPE then
    Close;
end;

procedure TfrmInfo.InfoBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var s:string; p:integer;
begin with InfoBox.Canvas do begin
  s:=InfoBox.Items[Index];
  if s[1]='!' then begin
    Brush.Color:=clBtnFace;
    Font.Color:=clBtnText;
    Font.Style:=Font.Style+[fsBold];
    FillRect(Rect);
    TextOut(Rect.Left+2, Rect.Top+1, Copy(s,2,length(s)));
    exit;
  end;
  Brush.Color:=InfoBox.Brush.Color;
  Font.Color:=InfoBox.Font.Color;
  Pen.Style:= psClear;
  p:=Pos(^I,s);
  FillRect(Rect);
  if p>0 then begin
    TextOut(Rect.Left+2, Rect.Top+1, Copy(s,1,p-1));
    TextOut(Rect.Left+TabOffset+10, Rect.Top+1, Copy(s,p+1,length(s)));
  end else
    TextOut(Rect.Left+2, Rect.Top+1, s);
end; end;




procedure TfrmInfo.mpeCopyAllClick(Sender: TObject);
begin
  CopyToClipboard(True);
end;

procedure TfrmInfo.mpeCopyClick(Sender: TObject);
begin
  CopyToClipboard(False);
end;

procedure TfrmInfo.pmListPopup(Sender: TObject);
begin
  mpeCopy.Enabled := InfoBox.ItemIndex >= 0;
  //mpeCopyAll.Enabled := InfoBox.Items.Count> 0;
  mpeCopyAll.Enabled:= InfoBox.ItemIndex >= 0;
end;

end.
