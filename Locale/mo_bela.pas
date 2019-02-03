unit mo_bela;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Адчыненне ...';
      Status_Closing:='Зачыненне ...';
      Status_Playing:='Прайграванне';
      Status_Paused:='Прыпынены';
      Status_Stopped:='Стоп';
      Status_Error:='Немагчыма прайграць файл (Націскніце, каб атрымаць больш інфармацыі)';

    FullscreenControls:='Паказаць поўнаэкранныя кіравання';
    OSD:='Усталяваць рэжым OSD';
      NoOSD:='Без OSD';
      DefaultOSD:='Дэфолтавае OSD';
      TimeOSD:='Адлюстроўваць пазіцыю';
      FullOSD:='Адлюстроўваць пазіцыю\працягласць';
    Escape:='Націсніце клавішу Escape, каб выйсці з поўнаэкраннага рэжыму.';
    Filemenu:='&Файл';
      OpenFile:='PАдчыніць файл ...';
      OpenURL:='Адчыніць URL ...';
        OpenURL_Caption:='Адчыніць URL';
        OpenURL_Prompt:='Увядзіце жадаемы URL';
      OpenDrive:='Прайграць (V)CD/DVD/BlueRay';
      InternetRadios:='Інтэрнэт-радыё';
      OpenTV := 'Open TV/capture card';
      Close:='Зачыніць';
      Quit:='Выхад';
    View:='&Выгляд';
      SizeAny:='Адвольны памер';
      Size50:='1/2 памераe';
      Size100:='Арыгінальны памер';
      Size200:='Падвоены памер';
      VideoInside:='Не абрэзаць відэа';
      Fullscreen:='Поўнаэкранный рэжым';
      AudioEqu:='балансір';
      Compact:='Кампактны';
      TogOSD:='пераключыць OSD';
      OnTop:='Заўсёды зверху';
      Vis:='візуалізацыя';
      VisEnable:='паказаць візуалізацыю';
      VisDirectRender:='прамы рэндэрынг';
    Seek:='&Прайграваць';
      Play:='Прайграваць';
      Pause:='Прыпыніць';
      Stop:='спыніць';
      Prev:='Папярэдні трэк'^I'Ctrl Left';
      Next:='Наступны трэк'^I'Ctrl Right';
      ShowPlaylist:='Спіс файлаў ...';
      Mute:='Выключыць гук';
      SeekF10:='Наперад на 10 секунд'^I'Right';
      SeekR10:='Назад на 10 секунд'^I'Left';
      SeekF60:='Наперад на 1 хвіліну'^I'Up';
      SeekR60:='Назад на 1 хвіліну'^I'Down';
      SeekF600:='Наперад на 10 хвілін'^I'PgUp';
      SeekR600:='Назад на 10 хвілін'^I'PgDn';
    Navigation:='&рух';
      Menu := 'DVD-меню';
      Titles := 'DVD Тытулы';
      Chapters:= 'DVD Chapters';
    Extra:='&Налады';
      Audio:='Аудыётрэк';
      Subtitle:='Субтытры';
        NoSubtitle := 'Няма субтытраў';
      AddSubtitle := 'загрузка субтытраў...';

      Aspect:='Суадносіны старон';
        AspectAuto:='Аўтавызначэнне';
        Aspect43:=' 4:3';
        Aspect169:=' 16:9';
        Aspect235:=' 2.35:1';
      DeinterlaceAlg:='Дэінтэрлэйс';
        DeinterlaceBlend := 'сумесь';
        DeinterlaceSimple := 'Просты';
        DeinterlaceAdaptative := 'Адаптыўны';
        DeinterlaceDoubleRate := 'двайны тарыф';
      Deinterlace:='Дэінтэрлэйс';

      Off := 'Off';
      On:='On';
      Auto:='аўтаматычны';

      Settings := 'карэкціроўкі Відэа ...';
      Options:='Опцыі ...';
      Language:='Мова';
      StreamInfo:='Адлюстраваць інфармацыю пра файл ...';
      ShowOutput:='Адлюстроўваць вывад MPlayer ...';
    Help:='&Дапамога';
      KeyHelp:='Дапамога па клавіятуры ...';
      About := 'Пра праграму ...';


    HelpFormCaption:='Дапамога па клавіятуры';
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
    HelpFormClose:='Зачыніць';

    //log form
    LogFormCaption:='выхад MPlayer';
    LogFormClose:='Зачыніць';

    //about form
    AboutFormCaption := 'Пра праграму';
    AboutFormClose := 'Зачыніць';
    AboutVersionMPUI := '3nity Media Player версія:';
    AboutVersionMplayer := 'MPlayer версія:';

    //settings form
    SettingsformCaption := 'карэкціроўкі Відэа';
    Brightness := 'яркасць';
    Contrast := 'кантраставаць';
    Hue := 'адценне';
    Saturation := 'насычэнне';
    Gamma := 'гама';
    SubScale := 'памер субтытраў';
    ResetSetting := 'скід';
    MResetSetting := 'скід';

    //options form
    FullScreenMonitor := 'На ўвесь экран манітора';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='налады';
    OptionsFormOK:='OK';
    OptionsFormApply:='Прымяніць';

    OptionsFormAssociate:='Захаваць';
    OptionsFormSelectAll:='Абраць усё';
    OptionsFormSelectNone:='ні';
    OptionsFormSave:='Захаваць';
    OptionsFormClose:='Зачыніць';
    OptionsFormHelp:='Дапамога';
    OptionsFormParams:='Дадатковыя параметры MPlayer:';

    OptionsFormIndex:='Перабудаваць табліцу індэксаў AVI, калі неабходна';
    OptionsFormPriorityBoost:='Выконваць з большым прыарытэтам';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Драйвер вываду гуку';
    AudioOutNoDecode:='(ня дэкадуе гук)';
    AudioOutNoOut:='(ня прайграваць гук)';
    OptionsFormAudioDev:='прылада вываду DirectSound';
    OptionsFormAudioFilterChannels := 'Фільтраванне каналаў і маршрутызацыя';
    OptionsFormSoftVol:='Праграмная рэгуліроўка гуку';
    OptionsFormUseVolcmd := 'Опцыя каманднага радка Выкарыстоўвайце аб''ём';
    OptionsFormAudioDecodeChannels := 'максімум нумар. каналаў для дэкадавання';
    OptionsFormAc3Comp := 'Ступень сціску AC3';
    OptionsFormUseliba52 := 'Выкарыстанне бібліятэкі liba52';

    OptionsFormVideoOut := 'Драйвер вываду відэа';
    VideoOutUser := 'іншае:';
    OptionsFormOverlay:= 'накладанне колеру';
    ForceEvenWidth := 'нават шырыня';
    DirectRender := 'прамы рэндэрынг';
    DoubleBuffer := 'падвойная буферызацыя';
    DrawSlices := 'Маляванне з дапамогай лустачак';

    OptionsFormVideoeq  := 'Праграмнае забеспячэнне видеоэквалайзер';
    VideoeqOff  := 'Off';
    VideoScaler := 'Праграмнае забеспячэнне апскейлинг';
    TryScaler := 'Паспрабуйце скейлер па памылцы';

    OptionsFormPostproc:='постапрацоўку';
    PostprocOff:='Off';
    PostprocAuto:='аўтаматычная';
    PostprocMax:='максімальную якасць';

    OptionsFormGeneral := 'агульны';
    OptionsFormAudio := 'аўдыё';
    OptionsFormVideo := 'відэа';
    OptionsFormCaching := 'кэшаванне';
    OptionsFormOSDSub := 'OSD і субтытры';

    MediaDefault := 'дэфолт';
    MediaFixed := 'фіксаваны дыск';
    MediaRamdisk := 'RAM дыск';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'здымнае прылада';
    mediaNetwork := 'лакальная сетка';
    MediaInternet := 'інтэрнэт';
    MediaDvd := 'прайграванне DVD';

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

    FontConfig := 'сканаванне шрыфта';
    SubAss := 'SSA/ASS';
    SubAutoLoad := 'Загрузка знешніх файлаў субтытраў';

    SubAssBorderColor := 'Тэкст колер мяжы';
    SubAssColor := 'колер тэксту';
    SubBgColor := 'Колер фону тэксту';

    UseDvdNav := 'Ўключэнне меню DVD ';
    DeinterlaceDVD := 'заўсёды дэінтэрлейсінгу';

    //playlist form
    PlaylistFormCaption:='Спіс файлаў';
    PlaylistFormPlay:='Прайграць';
    PlaylistFormAdd:='Дадаць ...';
    PlaylistFormMoveUp:='Уверх';
    PlaylistFormMoveDown:='Уніз';
    PlaylistFormDelete:='Выдаліць';
    PlaylistFormShuffle:='Выбіраць адвольны трэк';
    PlaylistFormLoop:='Паўтараць';
    PlaylistFormSave:='Захаваць ...';
    PlaylistFormClose:='Зачыніць';

    InfoFormCaption:='Інфармацыя пра файл';
    InfoFormClose:='Зачыніць';
    InfoFormCopy := 'копія';
    NoInfo:='На гэты час няма ніякай інфармацыі пра файл.';
    InfoFileFormat:='Фармат';
    InfoPlaybackTime:='Працягласць';
    InfoTags:='Метададзеныя файла';
    InfoVideo:='Відыётрэк';
    InfoAudio:='Аудыётрэк';
    InfoDecoder:='Дэкодэр';
    InfoCodec:='Кодэк';
    InfoBitrate:='Бітрэйт';
    InfoVideoSize:='Памеры';
    InfoVideoFPS:='Колькасць кадраў у секунду';
    InfoVideoAspect:='Суадносіны старон';
    InfoAudioRate:='Якасць сэмпліравання';
    InfoAudioChannels:='Колькасць каналаў';
    InfoInterlace:='рамка';
    InfoVideoInt := 'празрадковай';
    InfoVideoPro := 'прагрэсавальны';
    InfoTrack := 'трэк';
    InfoFilesize := 'памер файла';
    InfoSub := 'субтытры';
    InfoFormCopyAll := 'скапіяваць усё';
  end
end;

begin
  RegisterLocale('Belarusian - беларускі', Activate, LANG_BELARUSIAN, RUSSIAN_CHARSET);
end.
