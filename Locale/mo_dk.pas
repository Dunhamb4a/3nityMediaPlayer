unit mo_dk;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Åbner ...';
      Status_Closing:='Lukker ...';
      Status_Playing:='Spiller';
      Status_Paused:='Pauset';
      Status_Stopped:='Stoppet';
      Status_Error:='Kan ikke afspille media  (klik for mere info)';

    FullscreenControls:='Vis fuldskærmskontrol';
    OSD:='OSD mode';
      NoOSD:='Ingen OSD';
      DefaultOSD:='Normal OSD';
      TimeOSD:='Vis tid';
      FullOSD:='Vis sammenlagt tid';
    Escape:='Tryk på Escape for at forlade fuldskærmstilstand.';
    Filemenu:='&Filer';
      OpenFile:='Afspil fil ...';
      OpenURL:='Afspil Internetadresse ...';
        OpenURL_Caption:='Afspil Internetadresse';
        OpenURL_Prompt:='Hvilken Internetadresse vil du gerne afspille?';
      OpenDrive:='Afspil (V)CD/DVD/BlueRay';
      InternetRadios:='Internetradioer';
      OpenTV := 'Open TV/capture card';
      Close:='Luk';
      Quit:='Afslut';
    View:='&Vis';
      SizeAny:='Normal størrelse';
      Size50:='Halv størrelse';
      Size100:='Original størrelse';
      Size200:='Dobbelt størrelse';
      VideoInside:='Skær ikke video';
      Fullscreen:='Skift fuldskærms mode';
      AudioEqu:='Equalizer';
      Compact:='Kompakt mode til/fra';
      TogOSD:='Skift OSD';
      OnTop:='Altid på toppen';
      Vis:='Visualisering';
      VisEnable:='Vis visualisering';
      VisDirectRender:='Direkte gengivelse';
    Seek:='&Afspil';
      Play:='Afspil';
      Pause:='Pause';
      Stop:='Hold op';
      Prev:='Forrige titel'^I'Ctrl Left';
      Next:='Næste titel'^I'Ctrl Right';
      ShowPlaylist:='Afspilningsliste ...';
      Mute:='Lydløs';
      SeekF10:='Spol 10 sekunder fremad'^I'Right';
      SeekR10:='Spol 10 Sekunder tilbage'^I'Left';
      SeekF60:='Spol 1 minut fremad'^I'Up';
      SeekR60:='Spol 1 minut tilbage'^I'Down';
      SeekF600:='Spol 10 minutter fremad'^I'PgUp';
      SeekR600:='Spol 10 minutter tilbage'^I'PgDn';
    Navigation:='&Navigation';
      Menu := 'Menu';
      Titles := 'Titler';
      Chapters:= 'kapitler';
    Extra:='&Værktøjer';
      Audio:='Lydspor';
      Subtitle:='Undertextspor';
        NoSubtitle := 'Ingen undertekster';
      AddSubtitle := 'Indlæs undertekster...';

      Aspect:='Aspekt Forhold';
        AspectAuto:='Opfang Automatisk';
        Aspect43:='Tving 4:3';
        Aspect169:='Tving 16:9';
        Aspect235:='Tving 2.35:1';
      DeinterlaceAlg:='Deinterlace algoritme';
        DeinterlaceBlend := 'blande';
        DeinterlaceSimple := 'Simpel';
        DeinterlaceAdaptative := 'Tilpasselig';
        DeinterlaceDoubleRate := 'Dobbelt sats';
      Deinterlace:='Deinterlace';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Videojusteringer ...';
      Options:='Funktioner ...';
      Language:='Sprog';
      StreamInfo:='Vis Klip information ...';
      ShowOutput:='Vis MPlayer udlæsning ...';
    Help:='&Hjælp';
      KeyHelp:='Tastaturhjælp ...';
      About := 'Om ...';


    HelpFormCaption:='Tastaturhjælp';
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
    HelpFormClose:='Luk';

    //log form
    LogFormCaption:='MPlayer output';
    LogFormClose:='Luk';

    //about form
    AboutFormCaption := 'Om ';
    AboutFormClose := 'Luk';
    AboutVersionMPUI := '3nity Media Player version:';
    AboutVersionMplayer := 'MPlayer version:';

    //settings form
    SettingsformCaption := 'Videojusteringer';
    Brightness := 'lysstyrke';
    Contrast := 'Kontrast';
    Hue := 'Hue';
    Saturation := 'Mætning';
    Gamma := 'Gamma';
    SubScale := 'Undertekststørrelse';
    ResetSetting := 'Nulstil';
    MResetSetting := 'Nulstil';

    //options form
    FullScreenMonitor := 'Fuldskærmskærm';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Funktioner';
    OptionsFormOK:='OK';
    OptionsFormApply:='Tilføj';

    OptionsFormAssociate:='Gem';
    OptionsFormSelectAll:='Vælg alle';
    OptionsFormSelectNone:='Vælg Ingen';
    OptionsFormSave:='Gem';
    OptionsFormClose:='Luk';
    OptionsFormHelp:='Hjælp';
    OptionsFormParams:='Flere MPlayer parametre:';

    OptionsFormIndex:='Genopbyg filindekset hvis det er nødvendigt';
    OptionsFormPriorityBoost:='Kør med højere prioritet';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Sound output driver';
    AudioOutNoDecode:='(Afkod ikke lyden)';
    AudioOutNoOut:='(spil ikke lyd)';
    OptionsFormAudioDev:='DirectSound output enhed';
    OptionsFormAudioFilterChannels := 'Kanalfiltrering og routing';
    OptionsFormSoftVol:='Software volumenkontrol / Volumen boost';
    OptionsFormUseVolcmd := 'Brug volumen kommandolinje indstilling';
    OptionsFormAudioDecodeChannels := 'Maks. nummer. af kanaler til afkodning';
    OptionsFormAc3Comp := 'AC3 kompressionsniveau';
    OptionsFormUseliba52 := 'Brug liba52 bibliotek';

    OptionsFormVideoOut := 'Video output driver';
    VideoOutUser := 'Andet:';
    OptionsFormOverlay:= 'Overlay farve';
    ForceEvenWidth := 'Force ens bredde';
    DirectRender := 'Direkte gengivelse';
    DoubleBuffer := 'Dobbelt buffering';
    DrawSlices := 'Tegn med skiver';

    OptionsFormVideoeq  := 'Software video equalizer';
    VideoeqOff  := 'Off';
    VideoScaler := 'Software video scaler';
    TryScaler := 'Prøv at scalere ved fejl';

    OptionsFormPostproc:='Efterbehandling';
    PostprocOff:='Off';
    PostprocAuto:='Automatisk';
    PostprocMax:='Maksimal kvalitet';

    OptionsFormGeneral := 'Generel';
    OptionsFormAudio := 'Lyd';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Caching';
    OptionsFormOSDSub := 'OSD og undertekster';

    MediaDefault := 'Standard';
    MediaFixed := 'Fast disk';
    MediaRamdisk := 'RAM disk';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Aftagelig enhed';
    mediaNetwork := 'Lokalt netværk';
    MediaInternet := 'Internet';
    MediaDvd := 'DVD afspilning';

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

    FontConfig := 'Font scanning';
    SubAss := 'SSA/ASS';
    SubAutoLoad := 'Indlæs eksterne undertekstfiler';

    SubAssBorderColor := 'Tekst grænsen farve';
    SubAssColor := 'Tekstfarve';
    SubBgColor := 'Tekst baggrundsfarve';

    UseDvdNav := 'Aktivér DVD-menuer ';
    DeinterlaceDVD := 'Altid deinterlace';

    //playlist form
    PlaylistFormCaption:='Spilleliste';
    PlaylistFormPlay:='Afspil';
    PlaylistFormAdd:='Tilføj ...';
    PlaylistFormMoveUp:='Flyt op';
    PlaylistFormMoveDown:='Flyt ned';
    PlaylistFormDelete:='Fjern';
    PlaylistFormShuffle:='Bland';
    PlaylistFormLoop:='Gentag';
    PlaylistFormSave:='Gem ...';
    PlaylistFormClose:='Luk';

    InfoFormCaption:='Klip information';
    InfoFormClose:='Luk';
    InfoFormCopy := 'at kopiere';
    NoInfo:='No file information is available at the moment.';
    InfoFileFormat:='Format';
    InfoPlaybackTime:='Duration';
    InfoTags:='Clip metadata';
    InfoVideo:='Videospor';
    InfoAudio:='Lydspor';
    InfoDecoder:='Afkoder';
    InfoCodec:='Codec';
    InfoBitrate:='Bithastighed';
    InfoVideoSize:='Dimensioner';
    InfoVideoFPS:='Formhastighed';
    InfoVideoAspect:='Aspekt Forhold';
    InfoAudioRate:='Prøvehastighed';
    InfoAudioChannels:='Kanaler';
    InfoInterlace:='Ramme';
    InfoVideoInt := 'Interlaced';
    InfoVideoPro := 'Progressiv';
    InfoTrack := 'Spore';
    InfoFilesize := 'Filstørrelse';
    InfoSub := 'Undertekster';
    InfoFormCopyAll := 'kopi alle';
  end
end;

begin
   RegisterLocale('Danish - Dansk', Activate, LANG_ENGLISH, ANSI_CHARSET);
end.
