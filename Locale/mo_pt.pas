unit mo_pt;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='A abrir ...';
      Status_Closing:='A fechar ...';
      Status_Playing:='a reproduzir';
      Status_Paused:='Pausa';
      Status_Stopped:='Parado';
      Status_Error:='Não é possível reproduzir mídia (Clique para mais informações)';

    FullscreenControls:='Mostrar controles em tela cheia';
    OSD:='modo OSD';
      NoOSD:='Sem OSD';
      DefaultOSD:='OSD padrão';
      TimeOSD:='Mostrar tempo';
      FullOSD:='Mostrar tempo total';
    Escape:='Pressione Escape para sair do modo de tela cheia.';
    Filemenu:='&Ficheiro';
      OpenFile:='Reproduzir ficheiro ...';
      OpenURL:='Reproduzir URL ...';
        OpenURL_Caption:='Reproduzir URL';
        OpenURL_Prompt:='Qual o URL a reproduzir?';
      OpenDrive:='Reproduzir (V)CD/DVD/BlueRay';
      InternetRadios:='Rádios da Internet';
      OpenTV := 'Open TV/capture card';
      Close:='Fechar';
      Quit:='Sair';
    View:='&Ver';
      SizeAny:='Tamanho personalizado';
      Size50:='Metade do tamanho';
      Size100:='Tamanho original';
      Size200:='Dobro do tamanho';
      VideoInside:='Não cortar vídeo';
      Fullscreen:='Tela cheia';
      AudioEqu:='Equalizador';
      Compact:='Modo compacto';
      TogOSD:='Alternar OSD';
      OnTop:='Sempre visível';
      Vis:='visualização';
      VisEnable:='Mostrar visualização';
      VisDirectRender:='Renderização direta';
    Seek:='&Reproduzir';
      Play:='Reproduzir';
      Pause:='Pausa';
      Stop:='Pare';
      Prev:='Título anterior'^I'Ctrl Left';
      Next:='Próximo título'^I'Ctrl Right';
      ShowPlaylist:='Lista de reprodução ...';
      Mute:='Mudo';
      SeekF10:='Encaminhar 10 segundos'^I'Right';
      SeekR10:='Recuar 10 segundos'^I'Left';
      SeekF60:='Avançar 1 minuto'^I'Up';
      SeekR60:='Retroceder 1 minuto'^I'Down';
      SeekF600:='Avançar 10 minutos'^I'PgUp';
      SeekR600:='Recuar 10 minutos'^I'PgDn';
    Navigation:='&Navegação';
      Menu := 'Cardápio';
      Titles := 'Títulos';
      Chapters:= 'Capítulos';
    Extra:='&Preferências';
      Audio:='Pista de áudio';
      Subtitle:='Pista de legendas';
        NoSubtitle := 'Sem legendas';
      AddSubtitle := 'Carregar legendas...';

      Aspect:='Formato de imagem';
        AspectAuto:='Autodetectar';
        Aspect43:='Força 4:3';
        Aspect169:='Força 16:9';
        Aspect235:='Força 2.35:1';
      DeinterlaceAlg:='Algoritmo de desentrelaçamento';
        DeinterlaceBlend := 'Mistura';
        DeinterlaceSimple := 'Simples';
        DeinterlaceAdaptative := 'Adaptativo';
        DeinterlaceDoubleRate := 'Taxa dupla';
      Deinterlace:='Desentrelaçar';

      Off := 'Off';
      On:='On';
      Auto:='Auto';

      Settings := 'Ajustes de vídeo ...';
      Options:='Definições ...';
      Language:='Língua';
      StreamInfo:='Mostrar detalhes do filme ...';
      ShowOutput:='Mostrar mensagens do MPlayer ...';
    Help:='&Ajuda';
      KeyHelp:='Ajuda do teclado ...';
      About := 'Sobre o ...';


    HelpFormCaption:='Keyboard help';
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
    HelpFormClose:='Fechar';

    //log form
    LogFormCaption:='MPlayer output';
    LogFormClose:='Fechar';

    //about form
    AboutFormCaption := 'Sobre o ';
    AboutFormClose := 'Fechar';
    AboutVersionMPUI := 'versão do 3nity Media Player:';
    AboutVersionMplayer := 'versão do MPlayer:';

    //settings form
    SettingsformCaption := 'Ajustes de vídeo';
    Brightness := 'Brilho';
    Contrast := 'Contraste';
    Hue := 'Matiz';
    Saturation := 'Saturação';
    Gamma := 'Gama';
    SubScale := 'Tamanho das legendas';
    ResetSetting := 'Restabelecer';
    MResetSetting := 'Restabelecer';

    //options form
    FullScreenMonitor := 'Monitor de tela cheia';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Definições';
    OptionsFormOK:='OK';
    OptionsFormApply:='Aplicar';

    OptionsFormAssociate:='Guardar';
    OptionsFormSelectAll:='Selecionar tudo';
    OptionsFormSelectNone:='Nenhum';
    OptionsFormSave:='Guardar';
    OptionsFormClose:='Fechar';
    OptionsFormHelp:='Ajuda';
    OptionsFormParams:='Parâmetros adicionais do MPlayer: ';

    OptionsFormIndex:='Reconstruir o índice do arquivo, se necessário';
    OptionsFormPriorityBoost:='Executar com prioridade total';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Driver de saída de som';
    AudioOutNoDecode:='(não decodifique o som)';
    AudioOutNoOut:='(não toca som)';
    OptionsFormAudioDev:='Dispositivo de saída DirectSound';
    OptionsFormAudioFilterChannels := 'Filtragem e roteamento de canais';
    OptionsFormSoftVol:='Controle de volume de software / aumento de volume';
    OptionsFormUseVolcmd := 'Use a opção de linha de comando de volume';
    OptionsFormAudioDecodeChannels := 'Max. número. de canais para decodificar';
    OptionsFormAc3Comp := 'Nível de compressão AC3';
    OptionsFormUseliba52 := 'Use a biblioteca liba52';

    OptionsFormVideoOut := 'Driver de saída de vídeo';
    VideoOutUser := 'De outros:';
    OptionsFormOverlay:= 'Cor de sobreposição';
    ForceEvenWidth := 'Forçar largura uniforme';
    DirectRender := 'Renderização direta';
    DoubleBuffer := 'Buffer duplo';
    DrawSlices := 'Desenhe usando fatias';

    OptionsFormVideoeq  := 'Equalizador de vídeo de software';
    VideoeqOff  := 'Off';
    VideoScaler := 'Scaler de vídeo de software';
    TryScaler := 'Tente o scaler no erro';

    OptionsFormPostproc:='Pós-processamento';
    PostprocOff:='Off';
    PostprocAuto:='Automático';
    PostprocMax:='Qualidade máxima';

    OptionsFormGeneral := 'Geral';
    OptionsFormAudio := 'Audio';
    OptionsFormVideo := 'Vídeo';
    OptionsFormCaching := 'Cache';
    OptionsFormOSDSub := 'OSD e legendas';

    MediaDefault := 'Padrão';
    MediaFixed := 'Disco fixo';
    MediaRamdisk := 'Disco RAM';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Dispositivo removivél';
    mediaNetwork := 'Rede local';
    MediaInternet := 'Internet';
    MediaDvd := 'Reprodução de DVD';

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

    FontConfig := 'Varredura de fontes';
    SubAss := 'Use SSA/ASS';
    SubAutoLoad := 'Carregar arquivos de legenda externos';

    SubAssBorderColor := 'Cor da borda do texto';
    SubAssColor := 'Cor do texto';
    SubBgColor := 'Cor de fundo do texto';

    UseDvdNav := 'Ativar menus de DVD ';
    DeinterlaceDVD := 'Sempre desentrelaçar';

    //playlist form
    PlaylistFormCaption:='Lista de reprodução';
    PlaylistFormPlay:='Reproduzir';
    PlaylistFormAdd:='Adicionar ...';
    PlaylistFormMoveUp:='Subir';
    PlaylistFormMoveDown:='Descer';
    PlaylistFormDelete:='Apagar';
    PlaylistFormShuffle:='Embaralhar';
    PlaylistFormLoop:='Repetir';
    PlaylistFormSave:='Guardar ...';
    PlaylistFormClose:='Fechar';

    InfoFormCaption:='Detalhes do filme';
    InfoFormClose:='Fechar';
    InfoFormCopy := 'cópia de';
    NoInfo:='Nenhuma informação de arquivo está disponível no momento.';
    InfoFileFormat:='Formato';
    InfoPlaybackTime:='Duração';
    InfoTags:='Metadata do filme';
    InfoVideo:='Pista de video';
    InfoAudio:='Pista de áudio';
    InfoDecoder:='Descodificador';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Dimensões';
    InfoVideoFPS:='Taxa de imagens';
    InfoVideoAspect:='Formato de imagem';
    InfoAudioRate:='Taxa de amostragem';
    InfoAudioChannels:='Canais';
    InfoInterlace:='Quadro, Armação';
    InfoVideoInt := 'Entrelaçado';
    InfoVideoPro := 'Progressivo';
    InfoTrack := 'Pista';
    InfoFilesize := 'Tamanho do arquivo';
    InfoSub := 'Legendas';
    InfoFormCopyAll := 'Copiar tudo';
  end
end;

begin
    RegisterLocale('Portuguese - Português', Activate, LANG_PORTUGUESE, DEFAULT_CHARSET);
end.