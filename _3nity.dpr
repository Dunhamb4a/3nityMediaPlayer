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
program _3nity;



uses
  SysUtils,
  Windows,
  ShellAPI,
  Controls,
  Forms,
  Dialogs,
  VssAppVersion in 'VclAddOns\VssAppVersion.pas',
  VssThisAppVersion in 'VclAddOns\VssThisAppVersion.pas',
  UfrmMain in 'Forms\UfrmMain.pas' {frmMain},
  UfrmLog in 'Forms\UfrmLog.pas' {frmLog},
  URL in 'URL.pas',
  UfrmHelp in 'Forms\UfrmHelp.pas' {frmHelp},
  UFrmAbout in 'Forms\UFrmAbout.pas' {frmAbout},
  Locale in 'Locale\Locale.pas',
  UfrmOptions in 'Forms\UfrmOptions.pas' {frmOptions},
  Config in 'Config.pas',
  UfrmPlaylist in 'Forms\UfrmPlaylist.pas' {frmPlayList},
  UfrmInfo in 'Forms\UfrmInfo.pas' {frmInfo},
  UfrmSettings in 'Forms\UfrmSettings.pas' {frmSettings},
  UfrmRadios in 'Forms\UfrmRadios.pas',
  FormLocal in 'FormClasses\FormLocal.pas',
  mplayer in 'mplayer.pas',
  NumUtils in 'NumUtils.pas',
  AutoselectEdits in 'Controls\AutoselectEdits.pas',
  mp3parser in 'mp3parser.pas',
  FileClasses in 'FileClasses.pas',
  FileUtils in 'FileUtils.pas',
  VisEffects in 'VisEffects.pas',
  VssList in 'VssList.pas',
  VssDockForm in 'FormClasses\VssDockForm.pas',
  CustomFormsHelper in 'VclAddOns\CustomFormsHelper.pas',
  UVssProgressForm in 'Controls\UVssProgressForm.pas' {VssProgressForm},
  UVssColorPicker in 'Controls\UVssColorPicker.pas' {VssColorPicker: TFrame},
  FormsFixed in 'VclAddOns\FormsFixed.pas',
  UVssColorpickerForm in 'Controls\UVssColorpickerForm.pas' {VssColorPickerForm},
  VssIniFiles in 'VssIniFiles.pas',
  VssScrollbar in 'Controls\VssScrollbar.pas',
  VssPlaylist in 'VssPlaylist.pas',
  ufrmAudioEqu in 'Forms\ufrmAudioEqu.pas' {frmAudioEqu},
  asn1util in 'synapse\asn1util.pas',
  blcksock in 'synapse\blcksock.pas',
  clamsend in 'synapse\clamsend.pas',
  dnssend in 'synapse\dnssend.pas',
  ftpsend in 'synapse\ftpsend.pas',
  ftptsend in 'synapse\ftptsend.pas',
  httpsend in 'synapse\httpsend.pas',
  imapsend in 'synapse\imapsend.pas',
  ldapsend in 'synapse\ldapsend.pas',
  mimeinln in 'synapse\mimeinln.pas',
  mimemess in 'synapse\mimemess.pas',
  mimepart in 'synapse\mimepart.pas',
  nntpsend in 'synapse\nntpsend.pas',
  pingsend in 'synapse\pingsend.pas',
  pop3send in 'synapse\pop3send.pas',
  slogsend in 'synapse\slogsend.pas',
  smtpsend in 'synapse\smtpsend.pas',
  snmpsend in 'synapse\snmpsend.pas',
  sntpsend in 'synapse\sntpsend.pas',
  synachar in 'synapse\synachar.pas',
  synacode in 'synapse\synacode.pas',
  synacrypt in 'synapse\synacrypt.pas',
  synadbg in 'synapse\synadbg.pas',
  synafpc in 'synapse\synafpc.pas',
  synaicnv in 'synapse\synaicnv.pas',
  synaip in 'synapse\synaip.pas',
  synamisc in 'synapse\synamisc.pas',
  synaser in 'synapse\synaser.pas',
  synautil in 'synapse\synautil.pas',
  synsock in 'synapse\synsock.pas',
  tlntsend in 'synapse\tlntsend.pas',
  ZLibExGZ in 'zlibex\ZLibExGZ.pas',
  ZLibEx in 'zlibex\ZLibEx.pas',
  ZLibExApi in 'zlibex\ZLibExApi.pas',
  mo_ar in 'Locale\mo_ar.pas',
  mo_bela in 'Locale\mo_bela.pas',
  mo_bu in 'Locale\mo_bu.pas',
  mo_cn in 'Locale\mo_cn.pas',
  mo_cz in 'Locale\mo_cz.pas',
  mo_de in 'Locale\mo_de.pas',
  mo_dk in 'Locale\mo_dk.pas',
  mo_en in 'Locale\mo_en.pas',
  mo_es in 'Locale\mo_es.pas',
  mo_fr in 'Locale\mo_fr.pas',
  mo_gr in 'Locale\mo_gr.pas',
  mo_he in 'Locale\mo_he.pas',
  mo_hu in 'Locale\mo_hu.pas',
  mo_it in 'Locale\mo_it.pas',
  mo_jp in 'Locale\mo_jp.pas',
  mo_kr in 'Locale\mo_kr.pas',
  mo_nl in 'Locale\mo_nl.pas',
  mo_pl in 'Locale\mo_pl.pas',
  mo_pt in 'Locale\mo_pt.pas',
  mo_ro in 'Locale\mo_ro.pas',
  mo_ru in 'Locale\mo_ru.pas',
  mo_tu in 'Locale\mo_tu.pas',
  mo_ukrainian in 'Locale\mo_ukrainian.pas',
  mo_vi in 'Locale\mo_vi.pas';

{$R *.res}


var
    Mutex: THandle;
    atom: integer;
    atomFound: boolean;
    i: integer;
    Mf: hWnd;

begin
    Init;


    if (ParamStr(1) = '/register') then
    begin

         if (Win32MajorVersion >= 6) {and (not IsAdmin())} then
         begin
              if (Win32MinorVersion >=2) then
              begin
              //regAssWindows8;
              end
              else
              begin
              ShellExecute(Application.Handle, 'runas', PChar(ParamStr(0)), '/adminoption 0', nil, SW_SHOWDEFAULT);
              end;
         end
         else
         begin
          regAss();
         end;
          exit;
    end;

    if (Win32MajorVersion >= 6) and (ParamStr(1) = '/adminoption') then
    begin
        //if fass<>'' then
        if (Win32MinorVersion >=2) then
        begin
          regAssWindows8;
          exit;
        end;
        regAss;
        exit;
    end;

    Mutex := CreateMutex(nil, True, '3nityMutex');
    if (Mutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then
    begin
    if (Win32Platform = VER_PLATFORM_WIN32_NT) then Mf := FindWindow('3nityMutex', nil)
    else Mf := FindWindow('3nityMutex', nil);
    if Mf <> 0 then begin


        if ParamStr(1) <> '' then
        begin
            for i := 1 to ParamCount do
            begin

                if (fileexists(ExtractFilePath(PChar(ParamStr(i))))) xor
                    (DirectoryExists(ExtractFilePath(PChar(ParamStr(i))))) then
                begin

                    Sleep(500);
                    //Create an atom
                    atom := GlobalFindAtom(PChar(ParamStr(i)));
                    atomFound := atom <> 0;


                    if not atomFound then
                        atom := GlobalAddAtom(PChar(ParamStr(i)));
                    try
                        //Pass atom identifier in WParam, set LParam to 1
                        SendMessageW(Mf,
                            $0401, atom, 1);

                    finally
                        //Delete the atom
                        if not atomFound then
                            while GlobalDeleteAtom(atom) > 0 do
                                GlobalDeleteAtom(atom);
                    end;
                end;
            end;//end for
        end;
        end

        else
            Sleep(600);

    end
    else
    begin

        /////////////////////////////
        Application.Initialize;
        Application.Title := '3nity Media Player';
        Application.MainFormOnTaskBar := True;

        Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLog, frmLog);
  Application.Run;

        if Mutex <> 0 then
            CloseHandle(Mutex);

    end;

end.

