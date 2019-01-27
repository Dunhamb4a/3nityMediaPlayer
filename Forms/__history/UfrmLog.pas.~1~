{   MPUI, an MPlayer frontend for Windows
    Copyright (C) 2008-2010 Visenri
    Original source code (2005) by Martin J. Fiedler <martin.fiedler@gmx.net>

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
  //if frmMain.Visible then
  //  frmMain.BringToFront;
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
