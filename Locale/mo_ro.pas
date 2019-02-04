unit mo_ro;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Se deschide ...';
      Status_Closing:='Se inchide ...';
      Status_Playing:='Redare';
      Status_Paused:='Pauză';
      Status_Stopped:='La oprire';
      Status_Error:='Fișierul multimedia nu poate fi redat (Faceți clic pentru mai multe informații)';

    FullscreenControls:='Afișaje fullscreen';
    OSD:='Mod OSD';
      NoOSD:='Fără OSD';
      DefaultOSD:='OSD-ul implicit';
      TimeOSD:='Afișează durata';
      FullOSD:='Afișează durata totală';
    Escape:='Apăsați pe Escape pentru a ieși din modul ecran complet.';
    Filemenu:='&Fişier';
      OpenFile:='Redați fișierul ...';
      OpenURL:='Redați URL-ul ...';
        OpenURL_Caption:='Redați URL-ul';
        OpenURL_Prompt:='Redați de pe site-ul Internet';
      OpenDrive:='Redați (V)CD/DVD/BlueRay';
      InternetRadios:='Radiouri pe internet';
      OpenTV := 'Open TV/capture card';
      Close:='închide';
      Quit:='Ieșire';
    View:='&Vizualizare';
      SizeAny:='Marime personalizata';
      Size50:='Jumătate de măsură';
      Size100:='Dimensiunea originală';
      Size200:='Dimensiune dublă';
      VideoInside:='Nu recoltați videoclipul';
      Fullscreen:='Ecran complet';
      AudioEqu:='Egalizator';
      Compact:='Modul compact';
      TogOSD:='Comutați pe OSD';
      OnTop:='Întotdeauna vizibil';
      Vis:='Vizualizare';
      VisEnable:='Afișați vizualizarea';
      VisDirectRender:='Redare directă';
    Seek:='&Redare';
      Play:='Redare';
      Pause:='Pauză';
      Stop:='Stop';
      Prev:='Titlul anterior'^I'Ctrl Left';
      Next:='Titlul următor'^I'Ctrl Right';
      ShowPlaylist:='Listă de redare ...';
      Mute:='Mut';
      SeekF10:='Redirecționați 10 secunde'^I'Right';
      SeekR10:='Derulați înapoi 10 secunde'^I'Left';
      SeekF60:='Redirecționați 1 minut'^I'Up';
      SeekR60:='Derulați 1 minut'^I'Down';
      SeekF600:='Redirecționați 10 minute'^I'PgUp';
      SeekR600:='derulați 10 minute'^I'PgDn';
    Navigation:='&Navigare';
      Menu := 'Meniul';
      Titles := 'titlurile';
      Chapters:= 'capitolele';
    Extra:='&Opțiuni';
      Audio:='Canal audio';
      Subtitle:='Canal Subtitrări';
        NoSubtitle := 'dezactivați subtitrările';
      AddSubtitle := 'Încărcați subtitrările...';

      Aspect:='Raportul aspectului';
        AspectAuto:='Auto detectare';
        Aspect43:='Forța 4:3';
        Aspect169:='Forța 16:9';
        Aspect235:='Forța 2.35:1';
      DeinterlaceAlg:='Deinterlaționarea algoritmului';
        DeinterlaceBlend := 'Amestec';
        DeinterlaceSimple := 'Simplu';
        DeinterlaceAdaptative := 'Adaptive';
        DeinterlaceDoubleRate := 'Rata dublă';
      Deinterlace:='Deîntrețesere';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Ajustări video ...';
      Options:='Setări ...';
      Language:='Limba';
      StreamInfo:='Afișați informații despre fișiere ...';
      ShowOutput:='Afișați ieșirea MPlayer ...';
    Help:='&Ajutor';
      KeyHelp:='Ajutor pentru tastatură ...';
      About := 'Despre ...';


    HelpFormCaption:='Ajutor pentru tastatură';
    HelpFormHelpText:=
'Navigation keys:'^M^J+
'Space'^I'Play/Pause'^M^J+
'Right'^I'Forward 10 seconds'^M^J+
'Left'^I'Rewind 10 seconds'^M^J+
'Up'^I'Forward 1 minute'^M^J+
'Down'^I'Rewind 1 minute'^M^J+
'PgUp'^I'Forward 10 minutes'^M^J+
'PgDn'^I'Rewind 10 minutes'^M^J+
^M+^J+
'Other keys:'^M^J+
'O'^I'Toggle OSD'^M^J+
'F'^I'Toggle fullscreen'^M^J+
'C'^I'Toggle compact mode'^M^J+
'T'^I'Toggle always on top'^M^J+
'Q'^I'Quit immediately'^M^J+
'9/0'^I'Adjust volume'^M^J+
'-/+'^I'Adjust audio/video sync'^M^J+
'1/2'^I'Adjust brightness'^M^J+
'3/4'^I'Adjust contrast'^M^J+
'5/6'^I'Adjust hue'^M^J+
'7/8'^I'Adjust saturation'^M^J+
'M'^I'Mute'^M^J+
'//*'^I'volume'^M^J+
'D'^I'frame_drop'^M^J+
'C'^I'Mode Compact'^M^J+
'T'^I'Always On Top'^M^J+
//'s'^I'screenshot'^M^J+
'L'^I'ShowPlaylist'^M^J+
'RETURN'^I'Play'^M^J+
'P'^I'Pause'^M^J+
'TAB'^I'Fullscreen Controls'^M^J+
'NUMPAD9'^I'Zoom +'^M^J+
'NUMPAD5'^I'Zoom Reset'^M^J+
'NUMPAD1'^I'Zoom -'^M^J+
'NUMPAD6'^I'inc Aspect'^M^J+
'NUMPAD8'^I'Reset Aspect'^M^J+
'NUMPAD4'^I'Dec Aspect'^M^J+
'NUMPAD7'^I'Crop Video'^M^J+
'V'^I^I'subtitles visibility'^M^J+
'CTRL+0'^I^I'Reset Speed'^M^J+
'CTRL+/'^I^I'Speed -'^M^J+
'CTRL+*'^I^I'Speed +'^M^J+
'CTRL+O'^I^I'OpenFile'^M^J+
'CTRL+L'^I^I'Open URL'^M^J+
'CTRL+W'^I^I'Close'^M^J+
'CTRL+LEFT'^I'Play previous track'^M^J+
'CTRL+RIGHT'^I'Play next track'^M^J+
'Alt+0'^I^I'Custom size'^M^J+
'Alt+1'^I^I'Half Size'^M^J+
'Alt+2'^I^I'Original size'^M^J+
'Alt+3'^I^I'Double size'^M^J+
'Alt+F4'^I^I'Close Program'^M^J+
'Alt+Return'^I'Fullscreen'^M^J+
'MEDIA_STOP'^I^I'Stop Playing'^M^J+
'MEDIA_PREV_TRACK'^I'Play previous track'^M^J+
'MEDIA_NEXT_TRACK'^I'Play next track'
  ;
    HelpFormClose:='închide';

    //log form
    LogFormCaption:='Ieșire MPlayer';
    LogFormClose:='închide';

    //about form
    AboutFormCaption := 'Despre ';
    AboutFormClose := 'închide';
    AboutVersionMPUI := 'Versiunea 3nity Media Player:';
    AboutVersionMplayer := 'Versiunea MPlayer:';

    //settings form
    SettingsformCaption := 'Ajustări video';
    Brightness := 'strălucire';
    Contrast := 'Contrast';
    Hue := 'Nuanţă';
    Saturation := 'Saturare';
    Gamma := 'Gamma';
    SubScale := 'Dimensiunea subtitraților';
    ResetSetting := 'Restabili';
    MResetSetting := 'Restabili';

    //options form
    FullScreenMonitor := 'Monitor pe tot ecranul';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Setări';
    OptionsFormOK:='OK';
    OptionsFormApply:='Aplica';

    OptionsFormAssociate:='Salva';
    OptionsFormSelectAll:='Selectează tot';
    OptionsFormSelectNone:='Nici unul';
    OptionsFormSave:='Salva';
    OptionsFormClose:='închide';
    OptionsFormHelp:='Ajutor';
    OptionsFormParams:='Parametri suplimentari MPlayer:';

    OptionsFormIndex:='Refaceți indexul de fișiere, dacă este necesar';
    OptionsFormPriorityBoost:='Rulați cu prioritate mai mare';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Sursă de sunet';
    AudioOutNoDecode:='(nu decodificați sunetul)';
    AudioOutNoOut:='(nu redați sunetul)';
    OptionsFormAudioDev:='Dispozitiv de ieșire DirectSound';
    OptionsFormAudioFilterChannels := 'Filtrarea și rutarea canalelor';
    OptionsFormSoftVol:='Controlul volumului software / creșterea volumului';
    OptionsFormUseVolcmd := 'Utilizați opțiunea pentru linia de comandă volum';
    OptionsFormAudioDecodeChannels := 'Max. număr. de canale pentru a decoda';
    OptionsFormAc3Comp := 'Nivelul de comprimare AC3';
    OptionsFormUseliba52 := 'Folosiți biblioteca liba52';

    OptionsFormVideoOut := 'Video driver de ieșire';
    VideoOutUser := 'Alte:';
    OptionsFormOverlay:= 'Culoarea suprapusă';
    ForceEvenWidth := 'Forțați chiar și lățimea';
    DirectRender := 'Redare directă';
    DoubleBuffer := 'Tamponare dublă';
    DrawSlices := 'Desenați folosind felii';

    OptionsFormVideoeq  := 'Ecuator de video de software';
    VideoeqOff  := 'Off';
    VideoScaler := 'Software de scalare video';
    TryScaler := 'Încearcă scalar la eroare';

    OptionsFormPostproc:='Post procesare';
    PostprocOff:='Off';
    PostprocAuto:='Automat';
    PostprocMax:='Calitate maximă';

    OptionsFormGeneral := 'General';
    OptionsFormAudio := 'Audio';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Caching';
    OptionsFormOSDSub := 'OSD și subtitrări';

    MediaDefault := 'Mod implicit';
    MediaFixed := 'Disc fixat';
    MediaRamdisk := 'Disc RAM';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Dispozitiv detașabil';
    mediaNetwork := 'Retea locala';
    MediaInternet := 'Internet';
    MediaDvd := 'Redare DVD';

    FontPath := 'Font';
    FontEncoding := 'Character encoding';
    FontEncodings[0] := 'Default encoding';
    FontEncodings[1] := 'Unicode';
    FontEncodings[2] := 'Western European Languages (ISO-8859-1)';
    FontEncodings[3] := 'Western European Languages with Euro (ISO-8859-15)';
    FontEncodings[4] := 'Slavic/Central European Languages (ISO-8859-2)';
    FontEncodings[5] := 'Esperanto, Galician, Maltese, Turkish (ISO-8859-3)';
    FontEncodings[6] := 'Old Baltic charset (ISO-8859-4)';
    FontEncodings[7] := 'Cyrillic (ISO-8859-5)';
    FontEncodings[8] := 'Arabic (ISO-8859-6)';
    FontEncodings[9] := 'Modern Greek (ISO-8859-7)';
    FontEncodings[10] := 'Turkish (ISO-8859-9)';
    FontEncodings[11] := 'Baltic (ISO-8859-13)';
    FontEncodings[12] := 'Celtic (ISO-8859-14)';
    FontEncodings[13] := 'Hebrew charsets (ISO-8859-8)';
    FontEncodings[14] := 'Russian (KOI8-R)';
    FontEncodings[15] := 'Ukrainian, Belarusian (KOI8-U/RU)';
    FontEncodings[16] := 'Simplified Chinese charset (CP936)';
    FontEncodings[17] := 'Traditional Chinese charset (BIG5)';
    FontEncodings[18] := 'Japanese charsets (SHIFT-JIS)';
    FontEncodings[19] := 'Korean charset (CP949)';
    FontEncodings[20] := 'Thai charset (CP874)';
    FontEncodings[21] := 'Cyrillic Windows (CP1251)';
    FontEncodings[22] := 'Slavic/Central European Windows (CP1250)';

    FontConfig := 'Scanarea fonturilor';
    SubAss := 'Utilizați SSA / ASS';
    SubAutoLoad := 'Încărcați fișiere de subtitrare externe';

    SubAssBorderColor := 'Culoarea frontierei textului';
    SubAssColor := 'Culoarea textului';
    SubBgColor := 'Culoarea fundalului textului';

    UseDvdNav := 'Activați meniurile DVD ';
    DeinterlaceDVD := 'Întotdeauna dezinterlația';

    //playlist form
    PlaylistFormCaption:='Listă de redare';
    PlaylistFormPlay:='Redare';
    PlaylistFormAdd:='Adăuga ...';
    PlaylistFormMoveUp:='Ridică-te';
    PlaylistFormMoveDown:='Du-te în jos';
    PlaylistFormDelete:='Elimina';
    PlaylistFormShuffle:='Amesteca';
    PlaylistFormLoop:='Repeta';
    PlaylistFormSave:='Salva ...';
    PlaylistFormClose:='închide';

    InfoFormCaption:='Informații despre fișier';
    InfoFormClose:='închide';
    InfoFormCopy := 'Copiați';
    NoInfo:='Momentan nu există informații despre fișier.';
    InfoFileFormat:='Format';
    InfoPlaybackTime:='Durată';
    InfoTags:='Clip metadate';
    InfoVideo:='Canalul video';
    InfoAudio:='Canalul audio';
    InfoDecoder:='Decodor';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Dimensiuni';
    InfoVideoFPS:='Frame rate';
    InfoVideoAspect:='Aspect';
    InfoAudioRate:='Rata sample-urilor';
    InfoAudioChannels:='canale';
    InfoInterlace:='Frame';
    InfoVideoInt := 'întrețesut';
    InfoVideoPro := 'Progresiv';
    InfoTrack := 'Track';
    InfoFilesize := 'Mărime fișier';
    InfoSub := 'Subtitrare';
    InfoFormCopyAll := 'Copiați toate';
  end
end;

begin
    RegisterLocale('Romanian - Română', Activate, LANG_ENGLISH, EASTEUROPE_CHARSET);

end.