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

unit UfrmLog;

interface

uses
  Windows, Messages, Classes, Controls, Forms, FormLocal,
  StdCtrls, ExtCtrls;

type
  TfrmLog = class(TFormLocal)
    TheLog: TMemo;
    ControlPanel: TPanel;
    BClose: TButton;
    Command: TEdit;
    procedure FormHide(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure CommandKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CommandKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    History:TStringList;
    HistoryPos:integer;
    WasVisible : Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    procedure AddLine(const Line:string);
    procedure ClearLog();
    procedure DoLocalize ; override;
  end;

var
  frmLog: TfrmLog;

implementation
uses Ufrmmain, Locale;

{$R *.dfm}

procedure TfrmLog.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLog.CommandKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=^M then begin
    if frmMain.mpo.Running  then begin
      if length(command.text) >0  then begin
        TheLog.Lines.Add('> '+Command.Text);
        frmMain.mpo.ResetLogLastMsg();
        frmMain.mpo.SendCmd(Command.Text);
        History.Add(Command.Text);
        HistoryPos:=History.Count;
        Command.Text:='';
        key := #0;
      end;
    end;
  end;
end;

procedure TfrmLog.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.WndParent := application.Handle;
  Params.WndParent := 0;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;
  //Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TfrmLog.DoLocalize;
begin
  inherited;
  Caption:=LOCstr.LogFormCaption;
  BClose.Caption:=LOCstr.LogFormClose;
end;



procedure TfrmLog.FormCreate(Sender: TObject);
begin
  History:=TStringList.Create;
  WasVisible := False;
end;

procedure TfrmLog.FormDestroy(Sender: TObject);
begin
  History.Free;
end;


procedure TfrmLog.CommandKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_UP) AND (HistoryPos>0) then begin
    dec(HistoryPos);
    Command.Text:=History[HistoryPos];
  end;
  if (Key=VK_DOWN) AND (HistoryPos<History.Count) then begin
    inc(HistoryPos);
    if HistoryPos>=History.Count
      then Command.Text:=''
      else Command.Text:=History[HistoryPos];
  end;
end;

procedure TfrmLog.FormShow(Sender: TObject);
begin
  if not WasVisible then begin
    TheLog.Perform(EM_LINESCROLL,0,32767);
    WasVisible := True;
  end;

  frmMain.MShowOutput.Checked := true;
end;
procedure TfrmLog.FormHide(Sender: TObject);
begin
  frmMain.MShowOutput.Checked := false;
  WasVisible := false;
end;

procedure TfrmLog.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmLog.AddLine(const Line:string);
begin
  TheLog.Lines.Add(Line);
  if Visible then TheLog.Perform(EM_LINESCROLL,0,32767);
end;
procedure TfrmLog.ClearLog;
begin
  Thelog.Clear;
end;
end.
