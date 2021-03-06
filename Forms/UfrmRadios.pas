{

	3nity Media Player, an MPlayer frontend for Windows

	Copyright (C) 2010-2019 Nicolas DEOUX  <>
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

unit UfrmRadios;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,httpsend,Synautil,StrUtils,{WSDLIntf,ZLibExGZ,} ComCtrls,ShellApi, Menus,xmldom, XMLIntf, msxmldom, XMLDoc,
  Buttons, sSpeedButton, ExtCtrls, sStatusBar, ImgList;

const
  WM_MUSICTITLE = WM_USER + 1;
  CSIDL_MYMUSIC = $000d;
  UAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36';
  ICON_NOTRECORDING = 0;
  ICON_RECORDING = 1;
type

  TFrmRadios = class(TForm)
    Memo1: TMemo;
    Lv: TListView;
    ComboGenre: TComboBox;
    ComboRadiosCount: TComboBox;
    PMenu: TPopupMenu;
    PMenuPlayStation: TMenuItem;
    sSpeedButtonRefresh: TsSpeedButton;
    sSpeedButtonRecord: TsSpeedButton;
    sSpeedOpenMusicFolder: TsSpeedButton;
    sStatusBar1: TsStatusBar;
    LStatus: TLabel;
    imgStatus: TImage;
    ImageList1: TImageList;

        procedure  CloseStreamRipper;
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
     function ClearLNText : integer;
     procedure FindGenres();
      function EExtractBetween(const Value, A, B: string): string;
       function ExtractBetween(const Value, A, B: string): string;
    procedure LvDblClick(Sender: TObject);
    procedure ComboRadiosCountChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateRecordInfo;

    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure PMenuPlayStationClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ComboGenreSelect(Sender: TObject);
    procedure LoadLv(str1: string;actionsearch:boolean);

    function CheckIFContain(const Value, A:string): boolean;
    function StartLoadXMLinMEMORY( ): boolean;
    procedure ComboGenreKeyPress(Sender: TObject; var Key: Char);
    procedure ComboRadiosCountSelect(Sender: TObject);
    function CleanThisString(tempus: string): string;
    procedure LvKeyPress(Sender: TObject; var Key: Char);
    procedure ReleaseRecords();
    procedure FormDestroy(Sender: TObject);
 
 
    procedure sSpeedButtonRefreshClick(Sender: TObject);
    procedure sSpeedButtonRecordClick(Sender: TObject);
    procedure sSpeedOpenMusicFolderClick(Sender: TObject);


  private


    { Private declarations }


    busy:boolean; //gestions erreurs , c'est � revoir
    ActionSearch: boolean;
      //quelques records pour stoquer toutes les infos sur une radio ( 600 radios maxi)
      {LNText: array[0..600] of record    //600 stations
        Xml: String;   //full line in XML File
        lc: string;    //listener count
        ct: string;    //currently playing track. not gauranteed to be up-to-date because of database caching
        genre: string; //station genre. This is a "freeform" text. These are used to populate the genre list. Calling the API with ?genre=xyz essential does a like genre like %xyz% database query.
        br: string;    //station bitrate
        id: string;    //station ID. use this when connecting to http://yp.shoutcast.com/tunein-station.pls?id=12345 to retrieve the playlist containing the station URL
        mt: string;    //MIME type, determines the codec used. audio/mpeg for MP3 and audio/aacp for aacPlus
        name: string;  //station name

      end;}
      LNText: array of record
      server_name: string;
      listen_url: string;
      server_type: string;
      bitrate: string;
      channels: string;
      samplerate: string;
      genre: string;
      current_song: string;
      end;
      FirstShow:boolean;
      LNTextCount: integer;
      RadioCount:integer;

  public
    { Public declarations }
        l: tstringlist;
        xfilename: string;
  end;

var
  FrmRadios: TFrmRadios;
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  RadiosPath: string;//path for saving records
  StreamRipperRunning:boolean;
implementation
uses locale, UfrmMain,mplayer,Config;
{$R *.dfm}
procedure TFrmRadios.ReleaseRecords();
var
    i:integer;
begin
     for i := 0 to length(LNText)-1 do
    begin
       Finalize(LNText[i]);
    end;
    SetLength(LNText, 0);
    LNText:=nil;


end;

procedure TFrmRadios.sSpeedButtonRefreshClick(Sender: TObject);
begin
  if busy then
    exit;
  if ActionSearch=false then
  begin
    LoadLv(ComboGenre.Text,false);
  end
  else
  begin
   LoadLv(ComboGenre.Text,true);
  end;
end;

procedure TFrmRadios.sSpeedOpenMusicFolderClick(Sender: TObject);
begin
   RadiosPath:=IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(musicdir)+'Radios_Records');
  if not DirectoryExists(RadiosPath) then
    CreateDir(RadiosPath);
  ShellExecute(Application.Handle,
    nil,
    'explorer.exe',
    PChar(RadiosPath), //wherever you want the window to open to
    nil,
    SW_NORMAL     //see other possibilities by ctrl+clicking on SW_NORMAL
    );
end;

function TFrmRadios.ExtractBetween(const Value, A, B: string):String;
//var
  //aPos, bPos: Integer;
begin
{  result := '';
  aPos := Pos(A, Value);
  if aPos > 0 then begin
    aPos := aPos + Length(A);
    bPos := PosEx(B, Value, aPos);
    if bPos > 0 then begin
      result := Copy(Value, aPos, bPos - aPos);

    end;
  end;
  }
 end;

 function TFrmRadios.EExtractBetween(const Value, A, B: string): string;
 //var
  //aPos, bPos: Integer;
begin
{  result := '';
  aPos := Pos(A, Value);
  if aPos > 0 then begin
    aPos := aPos + Length(A);
    bPos := PosEx(B, Value, aPos);
    if bPos > 0 then begin
      result := Copy(Value, aPos, bPos - aPos);
      Memo1.text:=  Copy(Memo1.text,bPos,Length(Memo1.text)-bPos);  //ou d�coupe la partie trait�e ( on d�coupe jusqu'� la fin de la ligne qui nous interressait )
    end;
  end;
  }
end;


function TFrmRadios.ClearLNText : integer;
var i: integer;
begin

  for i := 0 to length(LNText)-1 do
  begin
    with LNText[i] do
    begin
      LNText[i].listen_url  := '';
      LNText[i].server_type  := '';
      LNText[i].bitrate  := '';
      LNText[i].genre  := '';
      LNText[i].current_song  := '';
      LNText[i].server_name  := '';
      LNText[i].channels  := '';
      LNText[i].samplerate  := '';
    end;
  end;
  LNTextCount := 0;
  Result := 1;
end;



procedure TFrmRadios.ComboGenreKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if busy then
      exit;
    if ComboGenre.Text <> '' then
    begin
    ActionSearch:=true;
       LoadLv(ComboGenre.Text,true);
    end;

  end;
end;

procedure TFrmRadios.ComboGenreSelect(Sender: TObject);
begin
   if busy  then
    exit;

  if ComboGenre.Text <> '' then
  begin
    ActionSearch:=false;
    LoadLv(ComboGenre.Text,false);
  end;
end;

procedure TFrmRadios.ComboRadiosCountChange(Sender: TObject);
begin
//RadioCount := StrToInt(ComboRadiosCount.Text);
end;

procedure TFrmRadios.ComboRadiosCountSelect(Sender: TObject);
begin
RadioCount := StrToInt(ComboRadiosCount.Text);
  if busy then
     exit;
  if ActionSearch=false then
  begin
  LoadLv(ComboGenre.Text,false);
  end
  else
  begin
  LoadLv(ComboGenre.Text,true);
  end;
end;

function TFrmRadios.CleanThisString(tempus: string): string;
begin
  try
    tempus := StringReplace(StringReplace(tempus, '#10', ' ', [rfReplaceAll]),
      '#13', ' ', [rfReplaceAll]);
    tempus := StringReplace(StringReplace(tempus, '/', ' ', [rfReplaceAll]),
      '\', ' ', [rfReplaceAll]);
    Result := tempus;
  except

  end;

end;

procedure TFrmRadios.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if busy=true then    CanClose:=false;
end;

procedure TFrmRadios.FormCreate(Sender: TObject);
begin

  busy:=false;
  RadioCount:=50;
  FirstShow:=true;
  ActionSearch:=false;

end;

procedure TFrmRadios.FormDestroy(Sender: TObject);
begin
CloseStreamRipper;
  ReleaseRecords;
end;

procedure TFrmRadios.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
//____ if Screen.ActiveControl = ComboBox1 then Handled := True;
//if Screen.ActiveControl is TCombobox then Handled := True;
end;

procedure TFrmRadios.FormResize(Sender: TObject);
begin

  //Lv.Columns.Items[1].Width := Round((Lv.Width - 65 - 250 - 99) / 100 * 55.55);
  //Lv.Columns.Items[2].Width := Lv.Width - 65 - 250 - 99 - Lv.Columns.Items[1].Width;
end;
procedure TFrmRadios.FormShow(Sender: TObject);

begin

  if FirstShow then begin
    if busy=true then    exit;
        if StartLoadXMLinMEMORY()=true then
        begin
          FrmMain.Caption:=FrmMain.Caption + ' _The best of Music_ ' + inttostr(LNTextCount) + ' Radio Stations loaded  ' ;
          ComboGenreSelect(nil);
        end
        else
        begin
          close;
        end;

    FirstShow:=false;
  end;
    RadiosPath:=IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(musicdir)+'Radios_Records');
  if not DirectoryExists(RadiosPath) then
    CreateDir(RadiosPath);
  UpdateRecordInfo;
end;

procedure TFrmRadios.LvDblClick(Sender: TObject);
var
    id:string;
begin
    if Lv.ItemIndex <>-1  then  begin
    if lv.Selected<>nil then
    begin
    //on r�cup�re l'id de la radio cliqu� par l'utilisateur
    id:=Lv.Items.Item[Lv.ItemIndex].SubItems[5];   
    frmmain.MOpenRadio(id);
    end;
    end;

end;

procedure TFrmRadios.LvKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
  begin

    LvDblClick(nil);

  end; 
end;

procedure TFrmRadios.PMenuPlayStationClick(Sender: TObject);
begin
    LvDblClick(nil);
end;

function TFrmRadios.StartLoadXMLinMEMORY( ): boolean;
var
  Nodes:IXMLNodeList;
  Node: IXMLNode;
  PassNodes: IXMLNodeList;
  Doc:      IXMLDocument;
  i: integer;
  //Returnn: boolean;
  //xfilename: string;
  count: integer;
  //myYear, myMonth, myDay : Word;
 begin

    busy := true;
    Memo1.Clear;
    ClearLNText;
    {
    DecodeDate(Date, myYear, myMonth, myDay);
     // try to get the directory in one shot !
     //only one file by day
     xfilename := Tempdir + 'yp_' + IntToStr(myDay) + '_' + IntToStr(myMonth) + '_' + IntToStr(myYear)  + '.xml';
      if FileExists(xfilename) then
        begin
          Returnn := true;
        end
      else
      begin
        Returnn := DownloadFile('http://dir.xiph.org/yp.xml' , xfilename);

      end;
     }
     {
    if Returnn = False then
    begin
      busy := False;
      Lv.Clear;
      exit;
    end;
    }
  // readxml from file
  Doc := LoadXMLDocument(xfilename);
  Node := doc.DocumentElement;
  Nodes := Node.ChildNodes ;
  PassNodes:=Nodes[1].ChildNodes ;
  if Node.NodeName = 'directory' then
      begin
        count := 0;
        Lv.Clear;
  SetLength(LNText, Nodes.Count  );
           for i := 0 to  Nodes.Count  -1 do
           begin
               PassNodes:=Nodes[i].ChildNodes ;  
               if PassNodes.Count>=8 then
               begin

                if PassNodes[1].HasChildNodes then begin

                        if PassNodes[0].HasChildNodes then
                        begin
                          try
                             LNText[count].server_name  :=PassNodes[0].ChildNodes[0].NodeValue
                          except
                             LNText[count].server_name  :='';
                          end;
                        end
                        else
                        LNText[count].server_name  :='';
                        if PassNodes[7].HasChildNodes  then
                        begin
                          try
                             LNText[count].current_song  := PassNodes[7].ChildNodes[0].NodeValue
                          except
                             LNText[count].current_song  := '';
                          end;
                        end
                        else
                        LNText[count].current_song  := '';
                        if PassNodes[6].HasChildNodes then
                        begin
                          try
                             LNText[count].genre := PassNodes[6].ChildNodes[0].NodeValue
                          except
                             LNText[count].genre := '';
                          end;
                        end
                        else
                        LNText[count].genre := '';
                        if PassNodes[3].HasChildNodes then
                        begin
                          try
                             LNText[count].bitrate:=PassNodes[3].ChildNodes[0].NodeValue
                          except
                             LNText[count].bitrate:='';
                          end;
                        end
                        else
                        LNText[count].bitrate:='';
                        if PassNodes[2].HasChildNodes then
                        begin
                          try
                             LNText[count].server_type :=PassNodes[2].ChildNodes[0].NodeValue
                          except
                             LNText[count].server_type :='';
                          end;
                        end
                        else
                        LNText[count].server_type :='';

                          try
                             LNText[count].listen_url :=PassNodes[1].ChildNodes[0].NodeValue;
                          except
                             LNText[count].listen_url :='';
                          end;

                        count:=count+1;
                end;
                //Application.ProcessMessages;

                end;//if PassNodes.Count=8 then
           end;
           if count > 0 then
           begin
           LNTextCount:=count;
           FindGenres;
           end;
      end
    else
      begin
          MessageDlg('This is not suitable or valid XML file!',mtWarning,[mbOK], 0) ;
      end;


    busy := False;


    if LNTextCount>0 then begin
        Result := True;
    end
    else
    begin
        Result := False;
    end;


 end;
  procedure TFrmRadios.FindGenres();
 var
 i,j,found:integer;
 list : tstringlist;
begin
            list := TStringList.Create;
           list.Add ('');
           for i := 0 to LNTextCount - 1 do
           begin
                if (LNText[i].genre <>'')  then begin
                   found:=0;
                   for j := 0 to list.count  - 1 do
                   begin
                     if list[j] =LNText[i].genre then found:=found+1;
                   end;
                   if found=0 then list.Add(LNText[i].genre);
                   //ComboGenre.Items.Add(LNText[i].genre);
                end;
           end;
           list.Sorted:=true;
           for i := 1 to list.Count  - 1 do
           begin
                ComboGenre.Items.Add(list[i]);
           end;

           list.Free;

end;

procedure TFrmRadios.LoadLv(str1: string;actionsearch:boolean);
var
  i,j: integer;
  Itm: TListItem;
begin
    busy := true;
    //lConnectionInfo.Caption :=       'Ready       >>>To tune in: Double Click a radio station<<<';

    Lv.Clear;
           j:=0;
           for i := 0 to LNTextCount - 1  do
           begin
                if (LNText[i].server_name <>'') and (( CheckIFContain(LowerCase(LNText[i].server_name ),LowerCase(str1)) or CheckIFContain(LowerCase(LNText[i].genre  ),LowerCase(str1))) or CheckIFContain(LowerCase(LNText[i].current_song   ),LowerCase(str1))    )     then
                // or (CheckIFContain(LowerCase(LNText[i].server_name ),LowerCase(str1)=true)))
                begin
                j:=j+1;
                Itm := Lv.Items.Add;
                Itm.Caption := IntToStr(j);
                Itm.SubItems.Add(LNText[i].server_name );
                Itm.SubItems.Add(LNText[i].current_song );
                Itm.SubItems.Add(LNText[i].bitrate );
                Itm.SubItems.Add(LNText[i].server_type );
                Itm.SubItems.Add(LNText[i].genre );
                Itm.SubItems.Add(LNText[i].listen_url);
                end;
                if j=RadioCount then break;
           end;


    busy := False;
end;
//CmdLine:=CmdLine+#32 + escapeparam(sFile);
function EscapeParam(const Param:string):string;
begin
  //if Pos(#32,Param)>0 then Result:=#34+Param+#34 else Result:=Param;
    Result:=#34+Param+#34 ;
end;

function ExecAndNotWait(const FileName, Params: string;
  WindowState: Word): Boolean;
var
  //SUInfo: TStartupInfo;
  //ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  { Enclose filename in quotes to take care of
    long filenames with spaces. }
  CmdLine := '"' + FileName + '"' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  with SUInfo do
  begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  {Result := CreateProcess(nil, PChar(CmdLine), nil, nil, False,
    CREATE_NEW_CONSOLE or
    NORMAL_PRIORITY_CLASS, nil,
    PChar(ExtractFilePath(FileName)),
    SUInfo, ProcInfo); }

   //CmdLine:=CmdLine+#32 + EscapeParam(sFile);
   CmdLine:='"' + FileName + '"' + params;
   Result := CreateProcess(nil, PChar(CmdLine), nil, nil, False,
   0, nil,
    PChar(ExtractFilePath(FileName)),
    SUInfo, ProcInfo);
  { Wait for it to finish. }
  //if Result then
  //  WaitForSingleObject(ProcInfo.hProcess, INFINITE);

end;



procedure TFrmRadios.UpdateRecordInfo;
var imgindex: integer;
begin
  imgindex := -1;
  if StreamRipperRunning then
      imgindex:=ICON_RECORDING
      else
      imgindex:= ICON_NOTRECORDING;

  UpdateImageFromImagery(imgStatus,ImageList1,imgindex);
end;

function GetShortName(sLongName: string): string;
var 
  sShortName:    string;
  nShortNameLen: Integer; 
begin 
  SetLength(sShortName, MAX_PATH); 
  nShortNameLen := GetShortPathName(PChar(sLongName), PChar(sShortName), MAX_PATH - 1);
  if (0 = nShortNameLen) then
  begin
    // handle errors... 
  end;
  SetLength(sShortName, nShortNameLen);
  Result := sShortName;
end;



procedure TFrmRadios.sSpeedButtonRecordClick(Sender: TObject);
var macom:string;ExePath:string;Selected:string;
begin
if sSpeedButtonRecord.Down then
begin
    //button is now down : start record

    //if ProcInfo.hProcess <> 0 then CloseStreamRipper;

    if lv.Items.Count > 0 then
    begin
        if Lv.ItemIndex <>-1  then  begin
            if lv.Selected<>nil then
            begin

              Selected:=Lv.Items.Item[Lv.ItemIndex].SubItems[5];
              ExePath:= appdir + 'streamripper.exe';
              //macom:= ' "' + Selected + '" ' + ' -d '+  '"' + RadiosPath  + '"' + ' -q -u ' + ' "winamp 2/x"';
              if (Win32MajorVersion >= 6) then
              begin
                   macom:= ' ' + Selected + ' ' + '-d '+  '' + RadiosPath  + '' + ' -q  -u ' + ' "winamp 2/x"';
              end
              else
              begin
                   macom:= ' ' + Selected + ' ' + '-d '+  '' + GetShortName(RadiosPath)  + '' + ' -q  -u ' + ' "winamp 2/x"';
              end;



              if ExecAndNotWait(ExePath,macom,SW_HIDE) then
              begin
                  StreamRipperRunning:=true;
                  UpdateRecordInfo;
                  if Lv.Items.Item[Lv.ItemIndex].SubItems[0]<>'' then
                      Lstatus.Caption:='Recording ' + Lv.Items.Item[Lv.ItemIndex].SubItems[0]
                  else
                      Lstatus.Caption:='Recording ';

              end
              else
              begin
              StreamRipperRunning:=false;
              Lstatus.Caption:='Not Recording ' ;
              UpdateRecordInfo;
              end;
            end;
        end
        else
        begin
            sSpeedButtonRecord.Down:=false;
        end;
    end
    else
    begin
        sSpeedButtonRecord.Down:=false;
    end;
end
else
begin
    //button is up : stop record

    CloseStreamRipper;
end;
end;
procedure  TFrmRadios.CloseStreamRipper;
begin
if StreamRipperRunning then
begin
      StreamripperRunning:=false;
      UpdateRecordInfo;
      try
        if ProcInfo.hProcess <> 0 then
        begin
          Lstatus.Caption:='Not Recording ' ;
          if not TerminateProcess(ProcInfo.hProcess,0) then
          begin
             TerminateProcess(ProcInfo.hProcess,0);
          end;
          CloseHandle(ProcInfo.hProcess);
        end;

      except

      end;
      try
      if ProcInfo.hThread <> 0 then
          CloseHandle(ProcInfo.hThread);
      //PostThreadMessage(ProcInfo.hThread , WM_CLOSE, 0, 0)
      except

      end;

end;
end;


function TFrmRadios.CheckIFContain(const Value, A:string): boolean;
var
  aPos: integer;
begin
  Result := false;
  aPos := Pos(A, Value);
  if aPos > 0 then
  begin
       result:=true;

  end;
end;




 end.
