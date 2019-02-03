unit mo_bu;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Отваряне ...';
      Status_Closing:='Затваряне ...';
      Status_Playing:='Стартиране';
      Status_Paused:='На пауза';
      Status_Stopped:='Спрян';
      Status_Error:='Не може да стартира носителя (Натиснете тук за повече информация)';

    FullscreenControls:='Показване на контроли на цял екран';
    OSD:='OSD режим';
      NoOSD:='Без OSD';
      DefaultOSD:='OSD по подразбиране';
      TimeOSD:='Покажи времетраенето';
      FullOSD:='Покажи позиция/времетраене';
    Escape:='Натиснете Escape, за да излезете от режим на цял екран.';
    Filemenu:='&Файл';
      OpenFile:='Отвори файл ...';
      OpenURL:='Отвори URL ...';
        OpenURL_Caption:='Отвори URL';
        OpenURL_Prompt:='Въведете желаното от вас URL';
      OpenDrive:='Отвори (V)CD/DVD/BlueRay';
      InternetRadios:='Интернет радиостанции';
      OpenTV := 'Отворете TV / заснемащата карта';
      Close:='Затвори';
      Quit:='Изход';
    View:='&Изглед';
      SizeAny:='Потребителски размер';
      Size50:='Размер на половина';
      Size100:='Оригинален размер';
      Size200:='Двоен размер';
      VideoInside:='Не изрежете видеоклип';
      Fullscreen:='На цял екран';
      AudioEqu:='изравнител';
      Compact:='Компактен режим';
      TogOSD:='Превключване на OSD';
      OnTop:='винаги на преден план';
      Vis:='Визуализацията';
      VisEnable:='Показване на визуализацията';
      VisDirectRender:='Директно изобразяване';
    Seek:='&Старт';
      Play:='Старт';
      Pause:='Пауза';
      Stop:='Спри се';
      Prev:='Предишно заглавие'^I'Ctrl Left';
      Next:='Следващо заглавие'^I'Ctrl Right';
      ShowPlaylist:='Плейлист ...';
      Mute:='Без звук';
      SeekF10:='Напред с 10 секунди'^I'Right';
      SeekR10:='Назад с 10 секунди'^I'Left';
      SeekF60:='Напред с 1 минута'^I'Up';
      SeekR60:='Назад с 1 минута'^I'Down';
      SeekF600:='Напред с 10 минути'^I'PgUp';
      SeekR600:='Назад с 10 минути'^I'PgDn';
    Navigation:='&навигация';
      Menu := 'DVD меню';
      Titles := 'Заглавия на DVD';
      Chapters:= 'DVD глави';
    Extra:='&Настройки';
      Audio:='Аудио';
      Subtitle:='Субтитри';
        NoSubtitle := 'Няма субтитри';
      AddSubtitle := 'Заредете субтитри...';

      Aspect:='Съотношение на изображението';
        AspectAuto:='Автоматично';
        Aspect43:='Съотношение 4:3';
        Aspect169:='Съотношение 16:9';
        Aspect235:='Съотношение 2.35:1';
      DeinterlaceAlg:='Метод на деинтерлейсинг';
        DeinterlaceBlend := 'Blend';
        DeinterlaceSimple := 'Стандартно';
        DeinterlaceAdaptative := 'Адаптивно';
        DeinterlaceDoubleRate := 'Двойна цена';
      Deinterlace:='разплитане';

      Off := 'Off';
      On:='On';
      Auto:='Авто';

      Settings := 'Настройки за видео ...';
      Options:='Настройки ...';
      Language:='език';
      StreamInfo:='Покажи информация за клипа ...';
      ShowOutput:='Покажи изходните данни от MPlayer ...';
    Help:='&Помощ';
      KeyHelp:='Помощ за клавиатурата ...';
      About := 'Относно ...';


    HelpFormCaption:='Помощ за клавиатурата';
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
    HelpFormClose:='Затвори';

    //log form
    LogFormCaption:='Изход MPlayer';
    LogFormClose:='Затвори';

    //about form
    AboutFormCaption := 'Относно ';
    AboutFormClose := 'Затвори';
    AboutVersionMPUI := '3nity Media Player версия:';
    AboutVersionMplayer := 'MPlayer версия:';

    //settings form
    SettingsformCaption := 'Настройки за видео';
    Brightness := 'Яркост';
    Contrast := 'Контраст';
    Hue := 'Оттенък';
    Saturation := 'Наситеност';
    Gamma := 'Гама';
    SubScale := 'Размер на субтитрите';
    ResetSetting := 'Нулиране';
    MResetSetting := 'Нулиране';

    //options form
    FullScreenMonitor := 'Монитор на цял екран';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Настройки';
    OptionsFormOK:='OK';
    OptionsFormApply:='Приеми';

    OptionsFormAssociate:='Запамети';
    OptionsFormSelectAll:='Избери всички';
    OptionsFormSelectNone:='Нито един';
    OptionsFormSave:='Запамети';
    OptionsFormClose:='Затвори';
    OptionsFormHelp:='Помощ';
    OptionsFormParams:='Допълнителни параметри към MPlayer:';

    OptionsFormIndex:='Пресъздай файловия индекс, ако е необходимо';
    OptionsFormPriorityBoost:='Стартирайте с по-висок приоритет';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Драйвер за звук';
    AudioOutNoDecode:='(не декодира звук)';
    AudioOutNoOut:='(не пускайте звук)';
    OptionsFormAudioDev:='Изходно устройство DirectSound';
    OptionsFormAudioFilterChannels := 'Филтриране и маршрутизиране на канали';
    OptionsFormSoftVol:='Софтуер за контрол на силата на звука / увеличаване на силата на звука';
    OptionsFormUseVolcmd := 'Използвайте опцията за команден ред за обем';
    OptionsFormAudioDecodeChannels := 'Макс. брой канали за декодиране';
    OptionsFormAc3Comp := 'AC3 ниво на компресия';
    OptionsFormUseliba52 := 'Използвайте библиотеката liba52';

    OptionsFormVideoOut := 'Драйвер за видео изход';
    VideoOutUser := 'друг:';
    OptionsFormOverlay:= 'Цвят на наслагване';
    ForceEvenWidth := 'Принудителна ширина';
    DirectRender := 'Директно изобразяване';
    DoubleBuffer := 'Двойно буфериране';
    DrawSlices := 'Нарисувайте с помощта на филийки';

    OptionsFormVideoeq  := 'Софтуерен еквалайзер';
    VideoeqOff  := 'Off';
    VideoScaler := 'Софтуер за скалиране на видео';
    TryScaler := 'Опитайте с грешка при скалиране';

    OptionsFormPostproc:='Последваща обработка';
    PostprocOff:='Off';
    PostprocAuto:='автоматичен';
    PostprocMax:='Максимално качество';

    OptionsFormGeneral := 'Общ';
    OptionsFormAudio := 'звуков';
    OptionsFormVideo := 'Видео';
    OptionsFormCaching := 'кеширане';
    OptionsFormOSDSub := 'OSD и субтитри';

    MediaDefault := 'По подразбиране';
    MediaFixed := 'Фиксиран диск';
    MediaRamdisk := 'RAM диск';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Сменяемо устройство';
    mediaNetwork := 'Локална мрежа';
    MediaInternet := 'интернет';
    MediaDvd := 'Възпроизвеждане на DVD';

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

    FontConfig := 'Сканиране на шрифтове';
    SubAss := 'SSA/ASS';
    SubAutoLoad := 'Заредете файлове с външни субтитри';

    SubAssBorderColor := 'Цвят на границата на текста';
    SubAssColor := 'Цвят на текста';
    SubBgColor := 'Цвят на фона на текста';

    UseDvdNav := 'Активиране на DVD менюта';
    DeinterlaceDVD := 'Винаги деинтерлейс';

    //playlist form
    PlaylistFormCaption:='Плейлист';
    PlaylistFormPlay:='Стартирай';
    PlaylistFormAdd:='Добави файл ...';
    PlaylistFormMoveUp:='Нагоре';
    PlaylistFormMoveDown:='Надолу';
    PlaylistFormDelete:='Изтрий';
    PlaylistFormShuffle:='Случ. избор';
    PlaylistFormLoop:='Повтори всички';
    PlaylistFormSave:='Запамети ...';
    PlaylistFormClose:='Затвори';

    InfoFormCaption:='Информация за клипа';
    InfoFormClose:='Затвори';
    InfoFormCopy := 'да копирам';
    InfoFormCopyAll := 'Копиране на всички';
    NoInfo:='Няма информация за клипа.';
    InfoFileFormat:='Формат';
    InfoPlaybackTime:='Продължителност';
    InfoTags:='Метаданни за клипа';
    InfoVideo:='Видео';
    InfoAudio:='Аудио';
    InfoDecoder:='Декодер';
    InfoCodec:='Кодек';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Размери';
    InfoVideoFPS:='Кадри за секунда';
    InfoVideoAspect:='Съотношение на изображението';
    InfoAudioRate:='Sample rate';
    InfoAudioChannels:='Канали';
    InfoInterlace:='Кадър';
    InfoVideoInt := 'Презредово';
    InfoVideoPro := 'прогресивен';
    InfoTrack := 'път';
    InfoFilesize := 'Размер на файла';
    InfoSub := 'Субтитри';
  end
end;


begin
  RegisterLocale('Bulgarian - български', Activate, LANG_BULGARIAN, RUSSIAN_CHARSET); //عربى
end.
