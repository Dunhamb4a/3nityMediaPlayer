unit mo_hu;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Nyílás ...';
      Status_Closing:='Záró ...';
      Status_Playing:='Játék';
      Status_Paused:='Szünetel';
      Status_Stopped:='megállt';
      Status_Error:='Nem lehet lejátszani a médiát (további információért kattintson)';

    FullscreenControls:='Teljes képernyős vezérlők megjelenítése';
    OSD:='OSD mód';
      NoOSD:='Nincs OSD';
      DefaultOSD:='Alapértelmezett OSD';
      TimeOSD:='Idő megjelenítése';
      FullOSD:='Teljes idő megjelenítése';
    Escape:='A teljes képernyős módból való kilépéshez nyomja meg az Escape gombot.';
    Filemenu:='&Fájl';
      OpenFile:='Fájl lejátszása ...';
      OpenURL:='URL lejátszása ...';
        OpenURL_Caption:='URL lejátszása';
        OpenURL_Prompt:='Melyik URL-t szeretné megnyitni?';
      OpenDrive:='CD / DVD lejátszása';
      InternetRadios:='Internet rádiók';
      OpenTV := 'Open TV/capture card';
      Close:='Bezárás';
      Quit:='Quit';
    View:='&Kilátás';
      SizeAny:='Egyedi méret';
      Size50:='Feleakkora';
      Size100:='Eredeti méret';
      Size200:='Dupla méret';
      VideoInside:='Ne vágjon videót';
      Fullscreen:='Teljes képernyő';
      AudioEqu:='Kiegyenlítő';
      Compact:='Kompakt mód';
      TogOSD:='Az OSD váltása';
      OnTop:='Mindig a tetején';
      Vis:='Megjelenítés';
      VisEnable:='Megjelenítés megjelenítése';
      VisDirectRender:='Közvetlen megjelenítés';
    Seek:='&Játék';
      Play:='Játék';
      Pause:='Szünet';
      Stop:='Állj meg';
      Prev:='Korábbi cím'^I'Ctrl Left';
      Next:='Következő cím'^I'Ctrl Right';
      ShowPlaylist:='lejátszási lista ...';
      Mute:='Néma';
      SeekF10:='Tovább 10 másodperc'^I'Right';
      SeekR10:='Fordítsa vissza 10 másodpercet'^I'Left';
      SeekF60:='Előre 1 perc'^I'Up';
      SeekR60:='Fordítsa vissza 1 percet'^I'Down';
      SeekF600:='Tovább 10 perc'^I'PgUp';
      SeekR600:='Fordítsa vissza 10 percet'^I'PgDn';
    Navigation:='&Navigáció';
      Menu := 'Menü';
      Titles := 'Címek';
      Chapters:= 'fejezetek';
    Extra:='&Opciók';
      Audio:='Hangsáv';
      Subtitle:='Feliratok nyomon követése';
        NoSubtitle := 'Nincs felirat';
      AddSubtitle := 'Feliratok betöltése...';

      Aspect:='Képarány';
        AspectAuto:='Auto felismerés';
        Aspect43:='Erő 4: 3';
        Aspect169:='Erő 16: 9';
        Aspect235:='Erő 2.35: 1';
      DeinterlaceAlg:='Deinterlace algoritmus';
        DeinterlaceBlend := 'Keverék';
        DeinterlaceSimple := 'Egyszerű';
        DeinterlaceAdaptative := 'Adaptív';
        DeinterlaceDoubleRate := 'Dupla arány';
      Deinterlace:='Deinterlace';

      Off := 'Off';
      On:='On';
      Auto:='kocsi';

      Settings := 'A videó beállításai ...';
      Options:='Beállítások ...';
      Language:='Nyelv';
      StreamInfo:='Fájlinformációk megjelenítése ...';
      ShowOutput:='Az MPlayer kimenet megjelenítése ...';
    Help:='&Segítség';
      KeyHelp:='A billentyűzet segítségével ...';
      About := 'Ról ről ...';


    HelpFormCaption:='A billentyűzet segítségével';
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
    HelpFormClose:='Bezárás';

    //log form
    LogFormCaption:='MPlayer kimenet';
    LogFormClose:='Bezárás';

    //about form
    AboutFormCaption := 'Ról ről ';
    AboutFormClose := 'Bezárás';
    AboutVersionMPUI := '3nity Media Player változat:';
    AboutVersionMplayer := 'MPlayer változat:';

    //settings form
    SettingsformCaption := 'A videó beállításai';
    Brightness := 'Fényesség';
    Contrast := 'Kontraszt';
    Hue := 'Színárnyalat';
    Saturation := 'Telítettség';
    Gamma := 'Gamma';
    SubScale := 'Feliratok mérete';
    ResetSetting := 'Visszaállítás';
    MResetSetting := 'Visszaállítás';

    //options form
    FullScreenMonitor := 'Teljes képernyős monitor';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Beállítások';
    OptionsFormOK:='OK';
    OptionsFormApply:='Alkalmaz';

    OptionsFormAssociate:='Mentés';
    OptionsFormSelectAll:='Mindet kiválaszt';
    OptionsFormSelectNone:='Egyik sem';
    OptionsFormSave:='Mentés';
    OptionsFormClose:='Bezárás';
    OptionsFormHelp:='Segítség';
    OptionsFormParams:='További MPlayer paraméterek:';

    OptionsFormIndex:='Szükség esetén újraindítsa a fájlindexet';
    OptionsFormPriorityBoost:='Fuss nagyobb prioritással';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Hangkimeneti meghajtó';
    AudioOutNoDecode:='(ne dekódolja a hangot)';
    AudioOutNoOut:='(ne játsszon hangot)';
    OptionsFormAudioDev:='DirectSound kimeneti eszköz';
    OptionsFormAudioFilterChannels := 'Csatorna szűrés és útválasztás';
    OptionsFormSoftVol:='Szoftver hangerőszabályzó / hangerő növelése';
    OptionsFormUseVolcmd := 'Használja a kötet parancssorát';
    OptionsFormAudioDecodeChannels := 'Max. szám. csatornák dekódolásához';
    OptionsFormAc3Comp := 'AC3 tömörítési szint';
    OptionsFormUseliba52 := 'Használja a liba52 könyvtárat';

    OptionsFormVideoOut := 'Videó kimeneti illesztőprogram';
    VideoOutUser := 'Más:';
    OptionsFormOverlay:= 'Átfedés színe';
    ForceEvenWidth := 'Erős szélesség';
    DirectRender := 'Közvetlen megjelenítés';
    DoubleBuffer := 'Dupla pufferelés';
    DrawSlices := 'Rajzoljon szeleteket';

    OptionsFormVideoeq  := 'Szoftver videó kiegyenlítő';
    VideoeqOff  := 'Off';
    VideoScaler := 'Szoftveres videó-skálázó';
    TryScaler := 'Próbálkozzon hibaelhárítással';

    OptionsFormPostproc:='Post feldolgozás';
    PostprocOff:='Off';
    PostprocAuto:='Automatikus';
    PostprocMax:='Maximális minőség';

    OptionsFormGeneral := 'Tábornok';
    OptionsFormAudio := 'Hang';
    OptionsFormVideo := 'Videó';
    OptionsFormCaching := 'gyorsítótárral';
    OptionsFormOSDSub := 'OSD és feliratok';

    MediaDefault := 'Alapértelmezett';
    MediaFixed := 'Rögzített lemez';
    MediaRamdisk := 'RAM lemez';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Eltávolítható eszköz';
    mediaNetwork := 'Helyi hálózat';
    MediaInternet := 'Internet';
    MediaDvd := 'DVD-lejátszás';

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

    FontConfig := 'Betűtípus-vizsgálat';
    SubAss := 'Használja az SSA / ASS-t';
    SubAutoLoad := 'Töltsön fel külső feliratfájlokat';

    SubAssBorderColor := 'Szöveges szegély színe';
    SubAssColor := 'Szöveg szín';
    SubBgColor := 'Szöveg háttér színe';

    UseDvdNav := 'DVD menük engedélyezése ';
    DeinterlaceDVD := 'Mindig hajtsa le';

    //playlist form
    PlaylistFormCaption:='lejátszási lista';
    PlaylistFormPlay:='Játék';
    PlaylistFormAdd:='hozzáad ...';
    PlaylistFormMoveUp:='Mozgassa fel';
    PlaylistFormMoveDown:='Menj le';
    PlaylistFormDelete:='eltávolít';
    PlaylistFormShuffle:='Keverés';
    PlaylistFormLoop:='Ismétlés';
    PlaylistFormSave:='Mentés ...';
    PlaylistFormClose:='Bezárás';

    InfoFormCaption:='Fájl információk';
    InfoFormClose:='Bezárás';
    InfoFormCopy := 'Másolat';
    NoInfo:='Jelenleg nem áll rendelkezésre fájlinformáció.';
    InfoFileFormat:='Formátum';
    InfoPlaybackTime:='tartam';
    InfoTags:='A metaadatok rögzítése';
    InfoVideo:='Videó sáv';
    InfoAudio:='Hangsáv';
    InfoDecoder:='Decoder';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Méretek';
    InfoVideoFPS:='Filmkocka szám';
    InfoVideoAspect:='Képarány';
    InfoAudioRate:='Mintavételi ráta';
    InfoAudioChannels:='Csatornák';
    InfoInterlace:='Keret';
    InfoVideoInt := 'Az átlapolt';
    InfoVideoPro := 'Haladó';
    InfoTrack := 'Vágány';
    InfoFilesize := 'Fájl méret';
    InfoSub := 'feliratok';
    InfoFormCopyAll := 'Összes másolása';
  end
end;

begin
   RegisterLocale('Hungarian - Magyar',Activate,LANG_HUNGARIAN,EASTEUROPE_CHARSET);
end.