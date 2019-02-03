unit mo_pl;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Otwieranie ...';
      Status_Closing:='Zamykanie ...';
      Status_Playing:='Odtwarzanie';
      Status_Paused:='Pauza';
      Status_Stopped:='Zatrzymane';
      Status_Error:='Nie można odtwarzać multimediów (kliknij, aby uzyskać więcej informacji)';

    FullscreenControls:='Pokaż elementy sterujące na pełnym ekranie';
    OSD:='OSD ';
      NoOSD:='No OSD';
      DefaultOSD:='Default OSD';
      TimeOSD:='Czas wyświetlania';
      FullOSD:='Pokaż całkowity czas';
    Escape:='Naciśnij Escape, aby wyjść z trybu pełnoekranowego.';
    Filemenu:='&Plik';
      OpenFile:='Odtwórz plik ...';
      OpenURL:='Odtwórz URL ...';
        OpenURL_Caption:='Odtwórz URL';
        OpenURL_Prompt:='Który adres URL chcesz zagrać?';
      OpenDrive:='Odtwórz CD / DVD';
      OpenTV := 'Otwórz TV / kartę przechwytującą';
      InternetRadios:='radia internetowe';
      Close:='Zatrzymać';
      Quit:='Wyjechać';
    View:='&Widok';
      SizeAny:='Niestandardowy rozmiar';
      Size50:='Pół rozmiaru';
      Size100:='Oryginalny rozmiar';
      Size200:='Podwójny rozmiar';
      VideoInside:='Nie przycinaj wideo';
      Fullscreen:='Pełny ekran';
      AudioEqu:='Wyrównywacz';
      Compact:='Tryb kompaktowy';
      TogOSD:='Przełącz OSD';
      OnTop:='Zawsze na górze';
      Vis:='Wyobrażanie sobie';
      VisEnable:='Pokaż wizualizację';
      VisDirectRender:='Bezpośrednie renderowanie';
    Seek:='&Odtwórz';
      Play:='Odtwórz';
      Pause:='Pauza';
      Stop:='zatrzymać';
      Prev:='Poprzedni '^I'Ctrl Left';
      Next:='następny'^I'Ctrl Right';
      ShowPlaylist:='Playlista ...';
      Mute:='Wycisz';
      SeekF10:='Przekaż 10 sekund'^I'Right';
      SeekR10:='Przewiń o 10 sekund'^I'Left';
      SeekF60:='Przekaż 1 minutę'^I'Up';
      SeekR60:='Przewiń o 1 minutę'^I'Down';
      SeekF600:='Przekaż 10 minut'^I'PgUp';
      SeekR600:='Przewiń o 10 minut'^I'PgDn';
    Navigation:='&Nawigacja';
      Menu := 'Menu DVD';
      Titles := 'Tytuły DVD';
      Chapters:= 'Rozdziały DVD';
    Extra:='&Opcje';
      Audio:='Ścieżka dźwiękowa';
      Subtitle:='Ścieżka napisów';
        NoSubtitle := 'Bez napisów';
      AddSubtitle := 'Załaduj napisy...';

      Aspect:='Współczynnik proporcji';
        AspectAuto:='Automatyczne wykrywanie';
        Aspect43:='Siła 4: 3';
        Aspect169:='Siła 16:9';
        Aspect235:='Siła 2.35:1';
      DeinterlaceAlg:='Algorytm usuwania przeplotu';
        DeinterlaceBlend := 'melanż';
        DeinterlaceSimple := 'Prosty';
        DeinterlaceAdaptative := 'Adaptacyjny';
        DeinterlaceDoubleRate := 'Podwójna stawka';
      Deinterlace:='Usuń przeplot';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Korekty wideo ...';
      Options:='Ustawienia ...';
      Language:='Język';
      StreamInfo:='Pokaż informacje o pliku ...';
      ShowOutput:='Pokaż wyjście MPlayera ...';
    Help:='&Wsparcie';
      KeyHelp:='Pomoc klawiatury ...';
      About := 'O tym programie ...';


    HelpFormCaption:='Pomoc klawiatury';
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
'M'^I'Wycisz'^M^J+
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
'CTRL+W'^I^I'Blisko'^M^J+
'CTRL+LEFT'^I'Play previous track'^M^J+
'CTRL+RIGHT'^I'Play next track'^M^J+
'Alt+0'^I^I'Custom size'^M^J+
'Alt+1'^I^I'Half Size'^M^J+
'Alt+2'^I^I'Original size'^M^J+
'Alt+3'^I^I'Double size'^M^J+
'Alt+F4'^I^I'Close Program'^M^J+
'Alt+Return'^I'Fullscreen'^M^J+
'CTRL+LEFT'^I'Play previous track'^M^J+
'CTRL+RIGHT'^I'Play next track'^M^J+
'MEDIA_STOP'^I^I'Stop Playing'^M^J+
'MEDIA_PREV_TRACK'^I'Play previous track'^M^J+
'MEDIA_NEXT_TRACK'^I'Play next track'
  ;
    HelpFormClose:='Blisko';

    //log form
    LogFormCaption:='MPlayer output';
    LogFormClose:='Blisko';

    //about form
    AboutFormCaption := 'O tym programie';
    AboutFormClose := 'Blisko';
    AboutVersionMPUI := '3nity Media Player wersja:';
    AboutVersionMplayer := 'MPlayer wersja:';

    //settings form
    SettingsformCaption := 'Korekty wideo';
    Brightness := 'Jasność';
    Contrast := 'Kontrast';
    Hue := 'Odcień';
    Saturation := 'Nasycenie';
    Gamma := 'Gamma';
    SubScale := 'Pod. rozmiar';
    ResetSetting := 'Nastawić';
    MResetSetting := 'Nastawić';

    //options form
    FullScreenMonitor := 'Monitor pełnoekranowy';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Ustawienia';
    OptionsFormOK:='OK';
    OptionsFormApply:='Zastosuj';

    OptionsFormAssociate:='kojarzyć';
    OptionsFormSelectAll:='Zaznacz wszystko';
    OptionsFormSelectNone:='Żaden';
    OptionsFormSave:='Zapisz';
    OptionsFormClose:='Blisko';
    OptionsFormHelp:='Wsparcie';
    OptionsFormParams:='Dodatkowe parametry MPlayera:';

    OptionsFormIndex:='W razie potrzeby przebuduj indeks pliku';
    OptionsFormPriorityBoost:='Uruchom z wyższym priorytetem';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Sterownik wyjścia dźwięku';
    AudioOutNoDecode:='nie dekoduj dźwięku';
    AudioOutNoOut:='nie odtwarzaj dźwięku';
    OptionsFormAudioDev:='Urządzenie wyjściowe DirectSound';
    OptionsFormAudioFilterChannels := 'Filtrowanie i routing kanałów';
    OptionsFormSoftVol:='Kontrola głośności oprogramowania / zwiększenie głośności';
    OptionsFormUseVolcmd := 'Użyj opcji wiersza poleceń';
    OptionsFormAudioDecodeChannels := 'Maksymalna liczba kanałów do odkodowania';
    OptionsFormAc3Comp := 'Poziom kompresji AC3';
    OptionsFormUseliba52 := 'Użyj biblioteki liba52';

    OptionsFormVideoOut := 'Sterownik wyjścia wideo';
    VideoOutUser := 'Inny:';
    OptionsFormOverlay:= 'Kolor nakładki';
    ForceEvenWidth := 'Wymuś równą szerokość';
    DirectRender := 'Bezpośrednie renderowanie';
    DoubleBuffer := 'Podwójne buforowanie';
    DrawSlices := 'Rysuj za pomocą plasterków';

    OptionsFormVideoeq  := 'Programowy korektor wideo';
    VideoeqOff  := 'Off';
    VideoScaler := 'Oprogramowanie skalujące wideo';
    TryScaler := 'Spróbuj skalowania przy błędzie';

    OptionsFormPostproc:='Przetwarzanie końcowe';
    PostprocOff:='Off';
    PostprocAuto:='Automatyczny';
    PostprocMax:='Maksymalna jakość';

    OptionsFormGeneral := 'Generał';
    OptionsFormAudio := 'Audio';
    OptionsFormVideo := 'Wideo';
    OptionsFormCaching := 'Buforowanie';
    OptionsFormOSDSub := 'OSD and subs';

    MediaDefault := 'Domyślna';
    MediaFixed := 'Naprawiono dysk';
    MediaRamdisk := 'RAM dysk';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Urządzenie przenośne';
    mediaNetwork := 'Lokalna sieć';
    MediaInternet := 'Internet';
    MediaDvd := 'Odtwarzanie DVD';

    FontPath := 'Czcionka';
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

    FontConfig := 'Skanowanie czcionek';
    SubAss := 'SSA/ASS';
    SubAutoLoad := 'Załaduj zewnętrzne pliki napisów';

    SubAssBorderColor := 'Kolor obramowania tekstu';
    SubAssColor := 'Kolor tekstu';
    SubBgColor := 'Kolor tła tekstu';

    UseDvdNav := 'Włącz menu DVD';
    DeinterlaceDVD := 'Zawsze usuwaj przeplot';

    //playlist form
    PlaylistFormCaption:='Lista odtwarzania';
    PlaylistFormPlay:='Odtwórz';
    PlaylistFormAdd:='Dodaj ...';
    PlaylistFormMoveUp:='podnieść';
    PlaylistFormMoveDown:='Padnij';
    PlaylistFormDelete:='Usunąć';
    PlaylistFormShuffle:='Człapać';
    PlaylistFormLoop:='Powtarzać';
    PlaylistFormSave:='Zapisać ...';
    PlaylistFormClose:='Blisko';

    InfoFormCaption:='Informacje o pliku';
    InfoFormClose:='Blisko';
    InfoFormCopy := 'kopiować';
    NoInfo:='W tej chwili nie są dostępne żadne informacje o plikach.';
    InfoFileFormat:='Format';
    InfoPlaybackTime:='Trwanie';
    InfoTags:='Metadane';
    InfoVideo:='Ścieżka wideo';
    InfoAudio:='Ścieżka Audio';
    InfoDecoder:='Dekoder';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='wymiary';
    InfoVideoFPS:='Częstotliwość wyświetlania klatek';
    InfoVideoAspect:='Współczynnik proporcji';
    InfoAudioRate:='Próbna stawka';
    InfoAudioChannels:='Kanały';
    InfoInterlace:='Frame';
    InfoVideoInt := 'Z przeplotem';
    InfoVideoPro := 'Progresywny';
    InfoTrack := 'Track';
    InfoFilesize := 'Rozmiar pliku';
    InfoSub := 'Napisy na filmie obcojęzycznym';
    InfoFormCopyAll := 'Skopiuj wszystko';
  end
end;

begin
    RegisterLocale('Polish - Polski',Activate,LANG_POLISH,EASTEUROPE_CHARSET);
end.
