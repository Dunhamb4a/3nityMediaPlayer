unit mo_de;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Öffnung ...';
      Status_Closing:='Schließen ...';
      Status_Playing:='Wiedergabe';
      Status_Paused:='Pause';
      Status_Stopped:='Abgebrochen';
      Status_Error:='Abspielen fehlgeschlagen (Klicken für weitere Informationen)';

    FullscreenControls:='Vollbild-Steuerelemente anzeigen';
    OSD:='OSD-Modus';
      NoOSD:='Kein OSD';
      DefaultOSD:='Standard-OSD';
      TimeOSD:='Zeitanzeige';
      FullOSD:='Gesamtzeitanzeige';
    Escape:='Drücken Sie die Escape-Taste, um den Vollbildmodus zu verlassen.';
    Filemenu:='&Datei';
      OpenFile:='Datei abspielen ...';
      OpenURL:='URL abspielen ...';
        OpenURL_Caption:='URL abspielen';
        OpenURL_Prompt:='Welche URL soll abgespielt werden?';
      OpenDrive:='CD/DVD/BlueRay abspielen';
      OpenTV := 'TV / Capture-Karte öffnen';
      InternetRadios:='Internet radios';
      Close:='Schließen';
      Quit:='Beenden';
    View:='&Ansicht';
      SizeAny:='Beliebige Größe';
      Size50:='Halbe Größe';
      Size100:='Originalgröße';
      Size200:='Doppelte Größe';
      VideoInside:='Video nicht zuschneiden';
      Fullscreen:='Vollbildmodus';
      AudioEqu:='Equalizer';
      Compact:='Kompakte Darstellung';
      TogOSD:='OSD umschalten';
      OnTop:='Immer im Vordergrund';
      Vis:='Visualisierung';
      VisEnable:='Visualisierung anzeigen';
      VisDirectRender:='Direktes Rendern';
    Seek:='&Abspielen';
      Play:='Abspielen';
      Pause:='Pause';
      Stop:='halt';
      Prev:='Voriger Titel'^I'Ctrl Left';
      Next:='Nächster Titel'^I'Ctrl Right';
      ShowPlaylist:='Wiedergabeliste ...';
      Mute:='Stumm';
      SeekF10:='10 Sekunden vorwärts'^I'Right';
      SeekR10:='10 Sekunden zurück'^I'Left';
      SeekF60:='1 Minute vorwärts'^I'Up';
      SeekR60:='1 Minute zurück'^I'Down';
      SeekF600:='10 Minuten vorwärts'^I'PgUp';
      SeekR600:='10 Minuten zurück'^I'PgDn';
    Navigation:='&Navigation';
      Menu := 'DVD-Menü';
      Titles := 'DVD-Titel';
      Chapters:= 'DVD-Kapitel';
    Extra:='&Extras';
      Audio:='Tonspur';
      Subtitle:='Untertitelspur';
        NoSubtitle := 'Keine Untertitel';
      AddSubtitle := 'Untertitel laden...';

      Aspect:='Seitenverhältnis';
        AspectAuto:='Automatisch';
        Aspect43:='Immer 4:3';
        Aspect169:='Immer 16:9';
        Aspect235:='Immer 2.35:1';
      DeinterlaceAlg:='Deinterlace algorithm';
        DeinterlaceBlend := 'Mischung';
        DeinterlaceSimple := 'Einfach';
        DeinterlaceAdaptative := 'Anpassungsfähig';
        DeinterlaceDoubleRate := 'Doppelte Rate';
      Deinterlace:='Deinterlacing';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Videoeinstellungen ...';
      Options:='Einstellungen ...';
      Language:='Sprache';
      StreamInfo:='Clip-Informationen anzeigen ...';
      ShowOutput:='MPlayer-Ausgabe anzeigen ...';
    Help:='&Hilfe';
      KeyHelp:='Tastaturhilfe ...';
      About := 'Über ...';


    HelpFormCaption:='Tastaturhilfe';
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
'CTRL+LEFT'^I'Play previous track'^M^J+
'CTRL+RIGHT'^I'Play next track'^M^J+
'MEDIA_STOP'^I^I'Stop Playing'^M^J+
'MEDIA_PREV_TRACK'^I'Play previous track'^M^J+
'MEDIA_NEXT_TRACK'^I'Play next track'
  ;
    HelpFormClose:='Schließen';

    //log form
    LogFormCaption:='MPlayer-Ausgabe';
    LogFormClose:='Schließen';

    //about form
    AboutFormCaption := 'Über 3nity Media Player';
    AboutFormClose := 'Schließen';
    AboutVersionMPUI := '3nity Media Player version:';
    AboutVersionMplayer := 'MPlayer version:';

    //settings form
    SettingsformCaption := 'Einstellungen';
    Brightness := 'Helligkeit';
    Contrast := 'Kontrast';
    Hue := 'Farbton';
    Saturation := 'Sättigung';
    Gamma := 'Gamma';
    SubScale := 'Größe der Untertitel';
    ResetSetting := 'Zurücksetzen';
    MResetSetting := 'Zurücksetzen';

    //options form
    FullScreenMonitor := 'Vollbild-Monitor';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Einstellungen';
    OptionsFormOK:='OK';
    OptionsFormApply:='Sich bewerben';

    OptionsFormAssociate:='Dateien zuordnen';
    OptionsFormSelectAll:='Wählen Sie Alle';
    OptionsFormSelectNone:='Keiner';
    OptionsFormSave:='sparen';
    OptionsFormClose:='Schließen';
    OptionsFormHelp:='Hilfe';
    OptionsFormParams:='Zusätzliche MPlayer-Parameter:';

    OptionsFormIndex:='Erstellen Sie ggf. den Dateiindex neu';
    OptionsFormPriorityBoost:='Führen Sie eine höhere Priorität aus';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Soundausgabetreiber';
    AudioOutNoDecode:='dekodieren Sie keinen Ton';
    AudioOutNoOut:='keinen Ton abspielen';
    OptionsFormAudioDev:='DirectSound-Ausgabegerät';
    OptionsFormAudioFilterChannels := 'Kanalfilterung und Routing';
    OptionsFormSoftVol:='Software-Lautstärkeregler / Lautstärke erhöhen';
    OptionsFormUseVolcmd := 'Verwenden Sie die Volume-Befehlszeilenoption';
    OptionsFormAudioDecodeChannels := 'Max. Anzahl der zu decodierenden Kanäle';
    OptionsFormAc3Comp := 'AC3-Komprimierungsstufe';
    OptionsFormUseliba52 := 'Verwenden Sie die liba52-Bibliothek';

    OptionsFormVideoOut := 'Videoausgabetreiber';
    VideoOutUser := 'Andere:';
    OptionsFormOverlay:= 'Überlagerungsfarbe';
    ForceEvenWidth := 'Gleichmäßige Breite erzwingen';
    DirectRender := 'Direktes Rendern';
    DoubleBuffer := 'Doppelte Pufferung';
    DrawSlices := 'Zeichne mit Scheiben';

    OptionsFormVideoeq  := 'Software-Video-Equalizer';
    VideoeqOff  := 'Off';
    VideoScaler := 'Software-Videoscaler';
    TryScaler := 'Versuchen Sie es mit einem Scaler';

    OptionsFormPostproc:='Nachbearbeitung';
    PostprocOff:='Off';
    PostprocAuto:='Automatik';
    PostprocMax:='Höchste Qualität';

    OptionsFormGeneral := 'Allgemeines';
    OptionsFormAudio := 'Audio';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Caching';
    OptionsFormOSDSub := 'OSD und Untertitel';

    MediaDefault := 'Standard';
    MediaFixed := 'Festplatte';
    MediaRamdisk := 'RAM-Disk';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Wechselbares Gerät';
    mediaNetwork := 'Lokales Netzwerk';
    MediaInternet := 'Internet';
    MediaDvd := 'DVD-Wiedergabe';

    FontPath := 'Schriftart';
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

    FontConfig := 'Scannen von Schriftarten';
    SubAss := 'SSA/ASS';
    SubAutoLoad := 'Laden Sie externe Untertiteldateien';

    SubAssBorderColor := 'Textumrandungsfarbe';
    SubAssColor := 'Textfarbe';
    SubBgColor := 'Texthintergrundfarbe';

    UseDvdNav := 'DVD-Menüs aktivieren';
    DeinterlaceDVD := 'Deinterlace immer';

    //playlist form
    PlaylistFormCaption:='Wiedergabeliste';
    PlaylistFormPlay:='Abspielen';
    PlaylistFormAdd:='Hinzufügen ...';
    PlaylistFormMoveUp:='Nach oben';
    PlaylistFormMoveDown:='Nach unten';
    PlaylistFormDelete:='Entfernen';
    PlaylistFormShuffle:='Zufall';
    PlaylistFormLoop:='Wiederholen';
    PlaylistFormSave:='Speichern ...';
    PlaylistFormClose:='Schließen';

    InfoFormCaption:='Clip-Informationen';
    InfoFormClose:='Schließen';
    InfoFormCopy := 'Kopieren';
    NoInfo:='Zur Zeit sind keine Informationen verfügbar.';
    InfoFileFormat:='Format';
    InfoPlaybackTime:='Abspieldauer';
    InfoTags:='Metadaten';
    InfoVideo:='Videospur';
    InfoAudio:='Tonspur';
    InfoDecoder:='Decoder';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Bildgröße';
    InfoVideoFPS:='Frame rate';
    InfoVideoAspect:='Seitenverhältnis';
    InfoAudioRate:='Samplerate';
    InfoAudioChannels:='Kanäle';
    InfoInterlace:='Rahmen';
    InfoVideoInt := 'Interlaced';
    InfoVideoPro := 'Progressiv';
    InfoTrack := 'Spur';
    InfoFilesize := 'Dateigröße';
    InfoSub := 'Untertitel';
    InfoFormCopyAll := 'Kopiere alles';
  end
end;

begin
   RegisterLocale('German - Deutsch', Activate, LANG_GERMAN, DEFAULT_CHARSET);
end.
