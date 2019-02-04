unit mo_nl;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Openen ...';
      Status_Closing:='Sluiten ...';
      Status_Playing:='Speelt';
      Status_Paused:='Gepauseerd';
      Status_Stopped:='Gestopt';
      Status_Error:='Media niet afspeelbaar (Klik voor meer info)';

    FullscreenControls:='Volledig scherm';
    OSD:='OSD (on-screen display) modus';
      NoOSD:='Geen OSD';
      DefaultOSD:='Standaard OSD';
      TimeOSD:='Verstreken speeltijd';
      FullOSD:='Totale speeltijd';
    Escape:='Druk op Escape om de modus voor volledig scherm te sluiten.';
    Filemenu:='&Bestand';
      OpenFile:='Bestand laden ...';
      OpenURL:='URL laden ...';
        OpenURL_Caption:='URL laden';
        OpenURL_Prompt:='Welke URL wenst u af te spelen?';
      OpenDrive:='Laad (V)CD/DVD/BlueRay';
      InternetRadios:='Internetradio''s';
      OpenTV := 'Open TV/capture card';
      Close:='Media sluiten';
      Quit:='Afsluiten';
    View:='&Beeld';
      SizeAny:='Willekeurig formaat';
      Size50:='Half formaat';
      Size100:='Origineel formaat';
      Size200:='Dubbel formaat';
      VideoInside:='Geen video bijsnijden';
      Fullscreen:='Beeldvullend';
      AudioEqu:='Equalizer';
      Compact:='Compacte modus';
      TogOSD:='OSD-modus wijzigen';
      OnTop:='Venster altijd zichtbaar';
      Vis:='visualisatie';
      VisEnable:='Visualisatie weergeven';
      VisDirectRender:='Directe weergave';
    Seek:='&Afspelen';
      Play:='Afspelen';
      Pause:='Pause';
      Stop:='Media sluiten';
      Prev:='Vorig item in speellijst'^I'Ctrl Left';
      Next:='Volgend item in speellijst'^I'Ctrl Right';
      ShowPlaylist:='Speellijst ...';
      Mute:='Geluid aan/uit';
      SeekF10:='10 seconden doorspoelen'^I'Right';
      SeekR10:='10 seconden terugspoelen'^I'Left';
      SeekF60:='1 minuut doorspoelen'^I'Up';
      SeekR60:='1 minuut terugspoelen'^I'Down';
      SeekF600:='10 minuten doorspoelen'^I'PgUp';
      SeekR600:='10 minuten terugspoelen'^I'PgDn';
    Navigation:='&Navigatie';
      Menu := 'Menu';
      Titles := 'Titels';
      Chapters:= 'hoofdstukken';
    Extra:='&Extra';
      Audio:='Audiospoor';
      Subtitle:='Ondertitelspoor';
        NoSubtitle := 'Geen ondertiteling';
      AddSubtitle := 'Ondertitels laden...';

      Aspect:='Verhouding';
        AspectAuto:='Detecteren';
        Aspect43:='4:3 forceren';
        Aspect169:='16:9 forceren';
        Aspect235:='2.35:1 forceren';
      DeinterlaceAlg:='Deinterlacing-algoritme';
        DeinterlaceBlend := 'Mengsel';
        DeinterlaceSimple := 'Eenvoudig';
        DeinterlaceAdaptative := 'Adaptief';
        DeinterlaceDoubleRate := 'Dubbele prijs';
      Deinterlace:='Deinterlacing';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Video-aanpassingen ...';
      Options:='instellingen ...';
      Language:='Taal';
      StreamInfo:='Toon media-informatie ...';
      ShowOutput:='Toon MPlayer output ...';
    Help:='&Help';
      KeyHelp:='Toetsenbord help ...';
      About := 'Info ...';


    HelpFormCaption:='Toetsenbord help';
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
    HelpFormClose:='Sluiten';

    //log form
    LogFormCaption:='MPlayer-uitvoer';
    LogFormClose:='Sluiten';

    //about form
    AboutFormCaption := 'Info ';
    AboutFormClose := 'Sluiten';
    AboutVersionMPUI := '3nity Media Player versie:';
    AboutVersionMplayer := 'MPlayer versie:';

    //settings form
    SettingsformCaption := 'Video adjustments';
    Brightness := 'Helderheid';
    Contrast := 'Contrast';
    Hue := 'Tint';
    Saturation := 'Verzadiging';
    Gamma := 'Gamma';
    SubScale := 'Ondertitels grootte';
    ResetSetting := 'Reset';
    MResetSetting := 'Reset';

    //options form
    FullScreenMonitor := 'Volledig scherm';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='instellingen';
    OptionsFormOK:='OK';
    OptionsFormApply:='Toepassen';

    OptionsFormAssociate:='Opslaan';
    OptionsFormSelectAll:='Selecteer alles';
    OptionsFormSelectNone:='Geen';
    OptionsFormSave:='Opslaan';
    OptionsFormClose:='Sluiten';
    OptionsFormHelp:='Help';
    OptionsFormParams:='Additionele MPlayer parameters:';

    OptionsFormIndex:='Video-index hergenereren indien nodig';
    OptionsFormPriorityBoost:='Afspelen met hogere prioriteit';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Geluidsuitgangsdriver';
    AudioOutNoDecode:='(decodeer het geluid niet)';
    AudioOutNoOut:='(speel geen geluid)';
    OptionsFormAudioDev:='DirectSound-uitvoerapparaat';
    OptionsFormAudioFilterChannels := 'Kanaalfiltering en routing';
    OptionsFormSoftVol:='Softwarematige volumeregeling / Volume boost';
    OptionsFormUseVolcmd := 'Gebruik de opdrachtregeloptie volume';
    OptionsFormAudioDecodeChannels := 'Max. aantal. van kanalen om te decoderen';
    OptionsFormAc3Comp := 'AC3 compressieniveau';
    OptionsFormUseliba52 := 'Gebruik de liba52-bibliotheek';

    OptionsFormVideoOut := 'Video-uitvoerstuurprogramma';
    VideoOutUser := 'anders:';
    OptionsFormOverlay:= 'Overlay kleur';
    ForceEvenWidth := 'Forceer gelijkmatige breedte';
    DirectRender := 'Directe weergave';
    DoubleBuffer := 'Dubbele buffering';
    DrawSlices := 'Teken met plakjes';

    OptionsFormVideoeq  := 'Software video-equalizer';
    VideoeqOff  := 'Off';
    VideoScaler := 'Software video scaler';
    TryScaler := 'Probeer scaler op fout';

    OptionsFormPostproc:='Nabewerking';
    PostprocOff:='Off';
    PostprocAuto:='automatisch';
    PostprocMax:='MMaximale kwaliteit';

    OptionsFormGeneral := 'Algemeen';
    OptionsFormAudio := 'Audio';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Caching';
    OptionsFormOSDSub := 'OSD en ondertitels';

    MediaDefault := 'Standaard';
    MediaFixed := 'Vaste schijf';
    MediaRamdisk := 'RAM-schijf';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Verwijderbaar apparaat';
    mediaNetwork := 'Lokaal netwerk';
    MediaInternet := 'Internet';
    MediaDvd := 'DVD afspelen';

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

    FontConfig := 'Lettertype scannen';
    SubAss := 'Gebruik SSA / ASS';
    SubAutoLoad := 'Laad externe ondertitelingsbestanden';

    SubAssBorderColor := 'Tekst randkleur';
    SubAssColor := 'Tekst kleur';
    SubBgColor := 'Tekst achtergrondkleur';

    UseDvdNav := 'DVD-menu''s inschakelen ';
    DeinterlaceDVD := 'Altijd deïnterliniëren';

    //playlist form
    PlaylistFormCaption:='Speellijst';
    PlaylistFormPlay:='Afspelen';
    PlaylistFormAdd:='Toevoegen ...';
    PlaylistFormMoveUp:='Naar boven';
    PlaylistFormMoveDown:='Naar beneden';
    PlaylistFormDelete:='Verwijderen';
    PlaylistFormShuffle:='Shuffle';
    PlaylistFormLoop:='Herhalen';
    PlaylistFormSave:='Opslaan ...';
    PlaylistFormClose:='Sluiten';

    InfoFormCaption:='Media-informatie';
    InfoFormClose:='Sluiten';
    InfoFormCopy := 'Copy';
    NoInfo:='Momenteel geen media-informatie beschikbaar.';
    InfoFileFormat:='Bestandsformaat';
    InfoPlaybackTime:='Speelduur';
    InfoTags:='Metadata';
    InfoVideo:='Videospoor';
    InfoAudio:='Audiospoor';
    InfoDecoder:='Decoder';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Afmetingen';
    InfoVideoFPS:='Beelden per seconde';
    InfoVideoAspect:='Verhoudingen';
    InfoAudioRate:='Sample rate';
    InfoAudioChannels:='Kanalen';
    InfoInterlace:='Frame';
    InfoVideoInt := 'Interlaced';
    InfoVideoPro := 'Progressief';
    InfoTrack := 'Spoor';
    InfoFilesize := 'Bestandsgrootte';
    InfoSub := 'Ondertitels';
    InfoFormCopyAll := 'Copy All';
  end
end;

begin
    RegisterLocale('Netherlands - Nederlands ' ,Activate, LANG_DUTCH, ANSI_CHARSET);
end.