unit mo_it;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Aprendo ...';
      Status_Closing:='Chiudendo ...';
      Status_Playing:='Apertura';
      Status_Paused:='Fermato';
      Status_Stopped:='Interrotto';
      Status_Error:='Non in grado di mandare in play (Clicca per maggiori info)';

    FullscreenControls:='Mostra i comandi a schermo intero';
    OSD:='OSD ';
      NoOSD:='No OSD';
      DefaultOSD:='Default OSD';
      TimeOSD:='Mostra tempo';
      FullOSD:='Mostra tempo totale';
    Escape:='Premi Esc per uscire dalla modalità a schermo intero.';
    Filemenu:='&File';
      OpenFile:='Apri file ...';
      OpenURL:='Apri URL ...';
        OpenURL_Caption:='Apri URL';
        OpenURL_Prompt:='Quale URL vuoi vedere?';
      OpenDrive:='Apri (V)CD/DVD/BlueRay';
      InternetRadios:='Internet radios';
      OpenTV := 'Open TV/capture card';
      Close:='Chiudi';
      Quit:='Esci';
    View:='&Guarda';
      SizeAny:='Personalizza Dim';
      Size50:='1/2 dimensione';
      Size100:='1/1 diensione';
      Size200:='2X dimensione';
      VideoInside:='Non ritagliare video';
      Fullscreen:='Tutto Schermo';
      AudioEqu:='Equalizzatore';
      Compact:='Modo compatto';
      TogOSD:='Attiva OSD';
      OnTop:='In primo piano';
      Vis:='visualizzazione';
      VisEnable:='Mostra visualizzazione';
      VisDirectRender:='Rendering diretto';
    Seek:='&Avvia';
      Play:='Avvia';
      Pause:='Pausa';
      Stop:='Finire';
      Prev:='Titolo precedente'^I'Ctrl Left';
      Next:='Prossimo titolo'^I'Ctrl Right';
      ShowPlaylist:='Playlist ...';
      Mute:='Muto';
      SeekF10:='Avanza 10 secondi'^I'Right';
      SeekR10:='Avanza 10 secondi'^I'Left';
      SeekF60:='Avanza 1 minuto'^I'Up';
      SeekR60:='Indietro 1 minuto'^I'Down';
      SeekF600:='Avanza 10 minuti'^I'PgUp';
      SeekR600:='Indietro 10 minuti'^I'PgDn';
    Navigation:='&Navigazione';
      Menu := 'Menu';
      Titles := 'Titoli';
      Chapters:= 'capitoli';
    Extra:='&Strumenti';
      Audio:='Traccia Audio';
      Subtitle:='Traccia Sottotitoli';
        NoSubtitle := 'Senza sottotitoli';
      AddSubtitle := 'Carica i sottotitoli...';

      Aspect:='Aspetto (AR)';
        AspectAuto:='Automatico';
        Aspect43:='Forza 4:3';
        Aspect169:='Forza 16:9';
        Aspect235:='Forza 2.35:1';
      DeinterlaceAlg:='Algoritmo di deinterlacciamento';
        DeinterlaceBlend := 'Miscela';
        DeinterlaceSimple := 'Semplice';
        DeinterlaceAdaptative := 'Adattivo';
        DeinterlaceDoubleRate := 'Doppia tariffa';
      Deinterlace:='Deinterlacciatura';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Regolazioni video ...';
      Options:='impostazioni ...';
      Language:='Linguaggio';
      StreamInfo:='Mostra info su clip ...';
      ShowOutput:='Mostra MPlayer info ...';
    Help:='&Aiuto';
      KeyHelp:='Aiuto Tastiera ...';
      About := 'Circa ...';


    HelpFormCaption:='Aiuto Tastiera';
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
    HelpFormClose:='Chiudi';

    //log form
    LogFormCaption:='Uscita MPlayer';
    LogFormClose:='Chiudi';

    //about form
    AboutFormCaption := 'Circa ';
    AboutFormClose := 'Chiudi';
    AboutVersionMPUI := 'Versione 3nity Media Player:';
    AboutVersionMplayer := 'Versione MPlayer:';

    //settings form
    SettingsformCaption := 'Regolazioni video';
    Brightness := 'Luminosità';
    Contrast := 'Contrasto';
    Hue := 'Colore';
    Saturation := 'Saturazione';
    Gamma := 'Gamma';
    SubScale := 'Dim. dei sottotitoli';//'Dimensione dei sottotitoli';
    ResetSetting := 'Reset';
    MResetSetting := 'Reset';

    //options form
    FullScreenMonitor := 'Monitor a schermo intero';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='impostazioni';
    OptionsFormOK:='OK';
    OptionsFormApply:='Applica';

    OptionsFormAssociate:='Salva';
    OptionsFormSelectAll:='Seleziona tutto';
    OptionsFormSelectNone:='Nessuna';
    OptionsFormSave:='Salva';
    OptionsFormClose:='Chiudi';
    OptionsFormHelp:='Aiuto';
    OptionsFormParams:='Parametri aggiuntivi di MPlayer:';

    OptionsFormIndex:='Ricostruisci l''indice dei file se necessario';
    OptionsFormPriorityBoost:='Avvia in alta priorita';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Driver di uscita audio';
    AudioOutNoDecode:='(non decodificare il suono)';
    AudioOutNoOut:='(non riprodurre suoni)';
    OptionsFormAudioDev:='Dispositivo di output DirectSound';
    OptionsFormAudioFilterChannels := 'Filtro e instradamento dei canali';
    OptionsFormSoftVol:='SControllo del volume del software / aumento del volume';
    OptionsFormUseVolcmd := 'Utilizzare l''opzione della riga di comando del volume';
    OptionsFormAudioDecodeChannels := 'Max. numero. dei canali da decodificare';
    OptionsFormAc3Comp := 'Livello di compressione AC3';
    OptionsFormUseliba52 := 'Usa la libreria liba52';

    OptionsFormVideoOut := 'Driver di uscita video';
    VideoOutUser := 'Altro:';
    OptionsFormOverlay:= 'Colore sovrapposto';
    ForceEvenWidth := 'Forza anche la larghezza';
    DirectRender := 'Rendering diretto';
    DoubleBuffer := 'Doppio buffering';
    DrawSlices := 'Disegna usando le fette';

    OptionsFormVideoeq  := 'Equalizzatore video software';
    VideoeqOff  := 'Off';
    VideoScaler := 'Scaler video software';
    TryScaler := 'Prova scaler per errore';

    OptionsFormPostproc:='Post produzione';
    PostprocOff:='Off';
    PostprocAuto:='Automatico';
    PostprocMax:='Qualità massima';

    OptionsFormGeneral := 'Generale';
    OptionsFormAudio := 'Audio';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Caching';
    OptionsFormOSDSub := 'OSD e sottotitoli';

    MediaDefault := 'Predefinito';
    MediaFixed := 'Disco fisso';
    MediaRamdisk := 'Disco RAM';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Dispositivo rimovibile';
    mediaNetwork := 'Rete locale';
    MediaInternet := 'Internet';
    MediaDvd := 'Riproduzione DVD';

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

    FontConfig := 'Scansione dei caratteri';
    SubAss := 'Usa SSA / ASS';
    SubAutoLoad := 'Carica file di sottotitoli esterni';

    SubAssBorderColor := 'Colore del bordo del testo';
    SubAssColor := 'Colore del testo';
    SubBgColor := 'Colore di sfondo del testo';

    UseDvdNav := 'Abilita i menu DVD ';
    DeinterlaceDVD := 'Sempre deinterlacciare';

    //playlist form
    PlaylistFormCaption:='Playlist';
    PlaylistFormPlay:='Avvia';
    PlaylistFormAdd:='Aggiungi ...';
    PlaylistFormMoveUp:='Alza';
    PlaylistFormMoveDown:='Abbassa';
    PlaylistFormDelete:='Togli';
    PlaylistFormShuffle:='Shuffle';
    PlaylistFormLoop:='Ripetere';
    PlaylistFormSave:='Salva ...';
    PlaylistFormClose:='Chiudi';

    InfoFormCaption:='Informzioni sulla Clip';
    InfoFormClose:='Chiudi';
    InfoFormCopy := 'Copia';
    NoInfo:='Nessuna informazione disponibile.';
    InfoFileFormat:='Formato';
    InfoPlaybackTime:='Durata';
    InfoTags:='Clip metadata';
    InfoVideo:='Traccia video';
    InfoAudio:='Traccia audio';
    InfoDecoder:='Decoder';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Dimensione';
    InfoVideoFPS:='Frame rate';
    InfoVideoAspect:='Aspect ratio';
    InfoAudioRate:='Frequenza';
    InfoAudioChannels:='Canali';
    InfoInterlace:='Frame';
    InfoVideoInt := 'interlacciata';
    InfoVideoPro := 'Progressivo';
    InfoTrack := 'Traccia';
    InfoFilesize := 'Dim. del file';
    InfoSub := 'Sottotitoli';
    InfoFormCopyAll := 'Copia tutto';
  end
end;

begin
    RegisterLocale('Italian - italiano', Activate, LANG_ITALIAN, ANSI_CHARSET);
end.