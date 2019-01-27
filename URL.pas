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

unit URL;
interface

const
      PlayableExtensionsA : array[1..39] of string = (
        'wav','mp1','mp2','mp3','mpa','ogg','wma','ac3','m4a','pcm','oga','spx','mka','f4a','aac',
        'aif','aifc','aiff','amr','ape','au','awb','cdg','f4b','flac','m4b','mpc','mpga','mpp','nsa',
        'qcp','ra','snd','tak','voc','vqf','w64','wv','wvp'
      );


     PlayableExtensionsV :array[1..72] of string = (
        'avi','divx','mpg','mpeg','vob','dat','bin','mpe','pva','mpv','m1v','m2v',
        'ogm','mkv','wmv','asf','mov','qt','dv','m4v','26l','264','jsv','flv','mp4',
        '3g2','3ga','3gp','3gp2','3gpp','3gpp2','bdm','bdmv','clpi','cpi','cpk','f4v',
        'flc','fli','m2t','m2ts','mjpg','moov','mp2','mpl','mpls','mts','mxf','nsv',
        'nuv','ogg','ogv','ogx','qtvr','rec','rm','rmvb','roq','rv','spl','str','swf',
        'trp','ts','ty','vdr','viv','vivo','webm','y4m','bik','smk'

      );

      PlayableExtensionsS : array[1..10] of string = (
        'srt','sub','smi','ssa','ass','aqt','jss','mpsub','js','txt'
      );
      PlayableExtensionsP : array[1..3] of string = ('pls','m3u','ram');

function MakeURL(Query:string; var DisplayName:string):string;

function GetExtension(FileName:string):integer;

function GetPlayableExtensionFilter(
  AllFiles, Playablefiles,AudioFiles, VideoFiles, PlaylistFiles, SubFiles : Boolean) : string;

implementation
uses SysUtils, FileUtils, Dialogs;

function CombineExtensionStrings(
            const strs : array of string; const originalstring : string = '') : string;
var
  J : Integer;
begin
  Result := originalstring;
  for j := Low(strs) to high(strs) do begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + '*.' + strs[J];
  end;
end;

function GetPlayableExtensionFilter(
  AllFiles, Playablefiles,AudioFiles, VideoFiles, PlaylistFiles, SubFiles : Boolean) : string;

  procedure AddString(displayName, Extensions: string; ShowExt : Boolean = True);
  begin
    if Result <> '' then
      Result := Result + '|';

    Result := Result + displayName;
    if ShowExt then
      Result := Result + ' (' + Extensions + ')';
    Result := Result + '|' + Extensions;

  end;
begin
  Result := '';
  if Playablefiles then
    AddString('Playable files',
      CombineExtensionStrings(PlayableExtensionsP,
        CombineExtensionStrings(PlayableExtensionsA,
          CombineExtensionStrings(PlayableExtensionsV)
        )
      ),false);
  if Videofiles then
    AddString('Video files', CombineExtensionStrings(PlayableExtensionsV));
  if AudioFiles then
    AddString('Audio files', CombineExtensionStrings(PlayableExtensionsA));
  if PlaylistFiles then
    AddString('Playlist files', CombineExtensionStrings(PlayableExtensionsP));
  if SubFiles then
    AddString('SubTitle files',CombineExtensionStrings(PlayableExtensionsS));
  if AllFiles then
    AddString('All files','*.*');
end;


function GetExtension(FileName:string):integer;
var i:integer;
    extCount : Integer;
begin
  FileName:=LowerCase(ExtractFileExtNoDot(FileName));

  extCount := High(PlayableExtensionsA);
  for i:=1 to extCount do
    if FileName=PlayableExtensionsA[i] then begin
      Result:=i;
      exit;
    end;

  extCount := High(PlayableExtensionsV);
  for i:=1 to extCount do
    if FileName=PlayableExtensionsV[i] then begin
      Result:=i;
      exit;
    end;
    
  Result:=0
end;


function FindPlayableFile(Path:string; MustBeSingleFile:boolean):string;
var SR:TSearchRec; Cont:integer;
begin
  Result:='';
  Path:=IncludeTrailingPathDelimiter(Path);
  Cont:=FindFirst(Path+'*.*',$27,SR);
  while Cont=0 do begin
    Cont:=GetExtension(SR.Name);
    if Cont>0 then
      if MustBeSingleFile then begin
        if length(Result)=0
          then Result:=Path+SR.Name
          else begin Result:=''; break; end;
      end else begin
        Result:=Path+SR.Name;
        break;
      end;
    Cont:=FindNext(SR);
  end;
  FindClose(SR);
end;


function MakeURL(Query:string; var DisplayName:string):string;
var s:string; i:integer;
begin
  // by default, pass the URL directly to MPlayer
  Result:=Query;
  // generate a display name
  i:=Pos('p:',LowerCase(Query));
  if (i>=1) AND (i<6)
    then DisplayName:=Query  // why this? well, the above two lines read like
                             // the regexp /.{1,5}p:/, which matches http:,
                             // ftp:, rtp: and so on ...
    else DisplayName:=ExtractFileName(Query);
  // someone's trying to pass an .IFO file? stupid ...
  if UpperCase(ExtractFileExtNoDot(Query))='IFO' then
    Query:=ExtractFileDir(Query);
  // if is it a regular file, we're set

  if FileExists(Query) then exit;

  // else, it may be a directory
  Query:=ExcludeTrailingPathDelimiter(Query);
  if (length(Query)=2) AND (Query[2]=':') then Query:=Query+'\';
  if DirectoryExists(Query) then begin
    // is there a single playable file?
    s:=FindPlayableFile(Query,true);
    if length(s)>0 then begin
      Result:=s;
      DisplayName:=ExtractFileName(s);
      exit;
    end;

    // is it a DVD directory?
    if UpperCase(ExtractFileName(Query))='VIDEO_TS' then
      Query:=ExtractFileDir(Query);
    if DirectoryExists(Query+'\VIDEO_TS') then begin
      Result:=copy(Query,1,1)+' dvd://';
      //Result:=copy(Query,1,1)+' dvdnav://1';
      DisplayName:='DVD';
      exit;
    end;

    // is it a (S)VCD directory?
    if DirectoryExists(Query+'\MPEGAV') then Query:=Query+'\MPEGAV';
    if DirectoryExists(Query+'\MPEG2') then Query:=Query+'\MPEG2';
    s:=FindPlayableFile(Query,true);
    if length(s)>0 then begin
      Result:=s;
      if pos('MPEG2',s)>0 then DisplayName:='SVCD' else DisplayName:='VCD';
      exit;
    end;
  end;
  if ansipos('tv://', Query) = 1 then
    DisplayName := 'TV';

end;

end.
