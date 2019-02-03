unit mo_cz;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Otevírací ...';
      Status_Closing:='Uzavření ...';
      Status_Playing:='Přehrávání';
      Status_Paused:='Pozastaveno';
      Status_Stopped:='Zastavil';
      Status_Error:='Nelze přehrát média (klikněte pro více informací)';

    FullscreenControls:='Show fullscreen controls';
    OSD:='Nastavit OSD Mód';
      NoOSD:='Žádný OSD';
      DefaultOSD:='Standardní OSD';
      TimeOSD:='Zobraz odehraný čas';
      FullOSD:='Zobraz celkový čas';
    Escape:='Stisknutím klávesy Escape opustíte režim celé obrazovky.';
    Filemenu:='&Soubor';
      OpenFile:='Otevřít ...';
      OpenURL:='Otevřít URL ...';
        OpenURL_Caption:='Otevřít URL';
        OpenURL_Prompt:='Zadejte URL, která má být otevřena';
      OpenDrive:='Otevřít disk (V)CD/DVD/BlueRay';
      InternetRadios:='Internet rádia';
      OpenTV := 'Open TV/capture card';
      Close:='Zavřít';
      Quit:='Ukončit';
    View:='&Zobrazit';
      SizeAny:='Vlastní velikost';
      Size50:='Poloviční velikost';
      Size100:='Originální velikost';
      Size200:='Dvojnásobná velikost';
      VideoInside:='Nerušit video';
      Fullscreen:='Celá obrazovka';
      AudioEqu:='Ekvalizér';
      Compact:='Kompaktní režim';
      TogOSD:='Přepínání OSD';
      OnTop:='Vždy v popředí';
      Vis:='Vizualizace';
      VisEnable:='Zobrazit vizualizaci';
      VisDirectRender:='Přímé vykreslování';
    Seek:='&Přehrávat';
      Play:='Přehrávat';
      Pause:='Pozastavit';
      Stop:='Stop';
      Prev:='Předchozí'^I'Ctrl Left';
      Next:='další'^I'Ctrl Right';
      ShowPlaylist:='Seznam ...';
      Mute:='Ztlumit';
      SeekF10:='O 10 sekund vpřed'^I'Right';
      SeekR10:='O 10 sekund zpět'^I'Left';
      SeekF60:='O 1 minutu vpřed'^I'Up';
      SeekR60:='O 1 minutu zpět'^I'Down';
      SeekF600:='O 10 minut vpřed'^I'PgUp';
      SeekR600:='O 10 minut zpět'^I'PgDn';
    Navigation:='&Navigace';
      Menu := 'Jídelní lístek';
      Titles := 'Ttituly';
      Chapters:= 'Kapitoly';
    Extra:='&Nastavení';
      Audio:='Zvuková stopa';
      Subtitle:='Stopa titulků';
        NoSubtitle := 'Žádné titulky';
      AddSubtitle := 'Vložte titulky...';

      Aspect:='Formát obrazu';
        AspectAuto:='Automatický';
        Aspect43:='Vždy 4:3';
        Aspect169:='Vždy 16:9';
        Aspect235:='Vždy 2.35:1';
      DeinterlaceAlg:='Deinterlace algoritmus';
        DeinterlaceBlend := 'Směs';
        DeinterlaceSimple := 'Jednoduché';
        DeinterlaceAdaptative := 'Adaptivní';
        DeinterlaceDoubleRate := 'Dvojitá sazba';
      Deinterlace:='Deinterlace';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Nastavení videa ...';
      Options:='Nastavení ...';
      Language:='Jazyk';
      StreamInfo:='Zobrazit informace o souboru ...';
      ShowOutput:='Zobraz konzoli MPlayeru ...';
    Help:='&Nápověda';
      KeyHelp:='Klávesové zkratky ...';
      About := 'O programu ...';


    HelpFormCaption:='Klávesové zkratky';
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
    HelpFormClose:='Zavřít';

    //log form
    LogFormCaption:='Výstup MPlayer';
    LogFormClose:='Zavřít';

    //about form
    AboutFormCaption := 'O programu';
    AboutFormClose := 'Zavřít';
    AboutVersionMPUI := '3nity Media Player verze:';
    AboutVersionMplayer := 'MPlayer verze:';

    //settings form
    SettingsformCaption := 'Nastavení videa';
    Brightness := 'Jas';
    Contrast := 'Kontrast';
    Hue := 'Odstín';
    Saturation := 'Nasycení';
    Gamma := 'Gamma';
    SubScale := 'Velikost titulků';
    ResetSetting := 'Resetovat';
    MResetSetting := 'Resetovat';

    //options form
    FullScreenMonitor := 'Monitor na celou obrazovku';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Nastavení';
    OptionsFormOK:='OK';
    OptionsFormApply:='Použít';

    OptionsFormAssociate:='Uložit';
    OptionsFormSelectAll:='Vybrat vše';
    OptionsFormSelectNone:='Žádný';
    OptionsFormSave:='Uložit';
    OptionsFormClose:='Zavřít';
    OptionsFormHelp:='Nápověda';
    OptionsFormParams:='Dodatkové parametry MPlayeru:';

    OptionsFormIndex:='Zrekonstruování indexu souboru, pokud je to nezbytné';
    OptionsFormPriorityBoost:='Běh s vyšší prioritou';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Ovladač výstupu zvuku';
    AudioOutNoDecode:='(dekódujte zvuk)';
    AudioOutNoOut:='(nehrajte zvuk)';
    OptionsFormAudioDev:='Výstupní zařízení DirectSound';
    OptionsFormAudioFilterChannels := 'Filtrování a směrování kanálů';
    OptionsFormSoftVol:='Ovládání hlasitosti softwaru / zvýšení hlasitosti';
    OptionsFormUseVolcmd := 'Použijte volbu příkazového řádku hlasitosti';
    OptionsFormAudioDecodeChannels := 'Max. číslo. kanálů k dekódování';
    OptionsFormAc3Comp := 'Úroveň komprese AC3';
    OptionsFormUseliba52 := 'Použijte knihovnu liba52';

    OptionsFormVideoOut := 'Ovladač výstupu videa';
    VideoOutUser := 'jiný:';
    OptionsFormOverlay:= 'Barva překrytí';
    ForceEvenWidth := 'Vynutit rovnoměrnou šířku';
    DirectRender := 'Přímé vykreslování';
    DoubleBuffer := 'Dvojitá vyrovnávací paměť';
    DrawSlices := 'Nakreslete pomocí plátků';

    OptionsFormVideoeq  := 'Software pro ekvalizér videa';
    VideoeqOff  := 'Off';
    VideoScaler := 'Software měřítko';
    TryScaler := 'Zkuste měřítko chyby';

    OptionsFormPostproc:='Následné zpracování';
    PostprocOff:='Off';
    PostprocAuto:='Automatický';
    PostprocMax:='Maximální kvalita';

    OptionsFormGeneral := 'Všeobecné';
    OptionsFormAudio := 'Zvuk';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Ukládání do mezipaměti';
    OptionsFormOSDSub := 'OSD a titulky';

    MediaDefault := 'Výchozí nastavení';
    MediaFixed := 'Pevný disk';
    MediaRamdisk := 'RAM disk';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Vyměnitelné zařízení';
    mediaNetwork := 'Lokální síť';
    MediaInternet := 'Internet';
    MediaDvd := 'Přehrávání disků DVD';

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

    FontConfig := 'Skenování písma';
    SubAss := 'SSA/ASS';
    SubAutoLoad := 'Vložte externí soubory titulků';

    SubAssBorderColor := 'Barva okraje textu';
    SubAssColor := 'Barva textu';
    SubBgColor := 'Barva pozadí textu';

    UseDvdNav := 'Povolte nabídky DVD ';
    DeinterlaceDVD := 'Vždy deinterlace';

    //playlist form
    PlaylistFormCaption:='Playlist';
    PlaylistFormPlay:='Přehrávat';
    PlaylistFormAdd:='Přidat ...';
    PlaylistFormMoveUp:='Přesuňte se nahoru';
    PlaylistFormMoveDown:='Posunout dolů';
    PlaylistFormDelete:='Odstranit';
    PlaylistFormShuffle:='Zamíchat';
    PlaylistFormLoop:='Opakovat';
    PlaylistFormSave:='Uložit ...';
    PlaylistFormClose:='Zavřít';

    InfoFormCaption:='Informace o souboru';
    InfoFormClose:='Zavřít';
    InfoFormCopy := 'kopírovat';
    NoInfo:='Momentálně nejsou k dispozici žádné informace o souboru.';
    InfoFileFormat:='Formát';
    InfoPlaybackTime:='Doba trvání';
    InfoTags:='Metadata ';
    InfoVideo:='Video stopa';
    InfoAudio:='Audio stopa';
    InfoDecoder:='Dekodér';
    InfoCodec:='Kodek';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Rozměry';
    InfoVideoFPS:='Snímková frekvence';
    InfoVideoAspect:='Poměr stran';
    InfoAudioRate:='Vzorkovací frekvence';
    InfoAudioChannels:='Kanály';
    InfoInterlace:='Rám';
    InfoVideoInt := 'Prokládané';
    InfoVideoPro := 'Progresivní';
    InfoTrack := 'Dráha';
    InfoFilesize := 'Velikost souboru';
    InfoSub := 'Titulky';
    InfoFormCopyAll := 'kopírovat všechny';
  end
end;

begin
   RegisterLocale('Czech - čeština',Activate,LANG_CZECH,EASTEUROPE_CHARSET);
end.
