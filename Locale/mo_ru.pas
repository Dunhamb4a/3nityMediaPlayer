unit mo_ru;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Открытие ...';
      Status_Closing:='Закрытие ...';
      Status_Playing:='Проигрывание';
      Status_Paused:='Приостановлено';
      Status_Stopped:='Остановлено';
      Status_Error:='Невозможно проиграть носитель (Нажмите чтобы получить больше информации)';

    FullscreenControls:='показать полноэкранные элементы управления';
    OSD:='Установить режим OSD';
      NoOSD:='Без OSD';
      DefaultOSD:='OSD по умолчанию';
      TimeOSD:='Показывать позицию';
      FullOSD:='Показывать позицию\длительность';

    Escape:='Нажмите Escape для выхода из полноэкранного режима.';
    Filemenu:='&Файл';
      OpenFile:='Открыть файл ...';
      OpenURL:='Открыть URL ...';
        OpenURL_Caption:='Открыть URL';
        OpenURL_Prompt:='Введите желаемый URL';
      OpenDrive:='Проиграть (V)CD/DVD/BlueRay';
      OpenTV := 'Open TV/capture card';
      InternetRadios:='интернет-радио';
      Close:='Закрыть';
      Quit:='Выход';
    View:='&Вид';
      SizeAny:='Произвольный размер ';
      Size50:='1/2 размера';
      Size100:='Оригинальный размер';
      Size200:='Двойной размер';
      VideoInside:='Don''t crop video';
      Fullscreen:='Полноэкранный режим';
      AudioEqu:='Эквалайзер';
      Compact:='Компактный';
      TogOSD:='OSD   ';
      OnTop:='Всегда на вершине';
      Vis:='Визуализация';
      VisEnable:='Показать визуализацию';
      VisDirectRender:='Прямой рендеринг';
    Seek:='&Играть';
      Play:='Играть';
      Pause:='Приостановить';
      Stop:='прекращать';
      Prev:='Предыдущий трек'^I'Ctrl Left';
      Next:='Следующий трек'^I'Ctrl Right';
      ShowPlaylist:='Плейлист ...';
      Mute:='Выключить звук';
      SeekF10:='Вперёд на 10 секунд'^I'Right';
      SeekR10:='Назад на 10 секунд'^I'Left';
      SeekF60:='Вперёд на 1 минуту'^I'Up';
      SeekR60:='Назад на 1 минуту'^I'Down';
      SeekF600:='Вперёд на 10 минут'^I'PgUp';
      SeekR600:='Назад на 10 минут'^I'PgDn';
    Navigation:='&DVD';
      Menu := 'DVD-меню';
      Titles := 'DVD-заголовки';
      Chapters:= 'DVD главы';
    Extra:='&настройки';
      Audio:='Аудио трек';
      Subtitle:='Трек субтитров';
        NoSubtitle := 'Без субтитров';
      AddSubtitle := 'Загрузить субтитры...';

      Aspect:='Соотношение сторон';
        AspectAuto:='Автоопределение';
        Aspect43:='Принудительно 4:3';
        Aspect169:='Принудительно 16:9';
        Aspect235:='Принудительно 2.35:1';
      DeinterlaceAlg:='Деинтерлейс';
        DeinterlaceBlend := 'межфреймовой';
        DeinterlaceSimple := 'Простой';
        DeinterlaceAdaptative := 'Адаптивный';
        DeinterlaceDoubleRate := 'Double rate';
      Deinterlace:='деинтерлейсинг';

      Off := 'Off';
      On:='On';
      Auto:='авто';

      Settings := 'настройки ...';
      Options:='настройки ...';
      Language:='язык';
      StreamInfo:='Показать информацию о файле ...';
      ShowOutput:='Показывать вывод MPlayer ...';
    Help:='&Помощь';
      KeyHelp:='Помощь по клавиатуре ...';
      About := 'О программе ...';


    HelpFormCaption:='Помощь по клавиатуре';
    HelpFormHelpText:=
'Клавиши навигации:'^M^J+
'Space'^I'Играть/Приостановить'^M^J+
'Right'^I'Вперёд на 10 секунд'^M^J+
'Left'^I'Назад на 10 секунд'^M^J+
'Up'^I'Вперёд на 1 минуту'^M^J+
'Down'^I'Назад на 1 минуту'^M^J+
'PgUp'^I'Вперёд на 10 минут'^M^J+
'PgDn'^I'Назад на 10 минут'^M^J+
^M+^J+
'Другие ключи:'^M^J+
'O'^I'Переключить OSD'^M^J+
'F'^I'Включить полноэкранный режим'^M^J+
'C'^I'Переключить компактный режим'^M^J+
'T'^I'Всегда на вершине'^M^J+
'Q'^I'Quit immediately'^M^J+
'9/0'^I'Adjust volume'^M^J+
'-/+'^I'Adjust audio/video sync'^M^J+
'1/2'^I'Adjust brightness'^M^J+
'3/4'^I'Adjust contrast'^M^J+
'5/6'^I'Adjust hue'^M^J+
'7/8'^I'Adjust saturation'^M^J+
'M'^I'Выключить звук'^M^J+
'//*'^I'громкость звука'^M^J+
'D'^I'падение кадра'^M^J+
'C'^I'Режим Компактный'^M^J+
'T'^I'Всегда на вершине'^M^J+
//'s'^I'screenshot'^M^J+
'L'^I'Плейлист'^M^J+
'RETURN'^I'Играть'^M^J+
'P'^I'Приостановить'^M^J+
'TAB'^I'Полноэкранные элементы управления'^M^J+
'NUMPAD9'^I'зум +'^M^J+
'NUMPAD5'^I'зум Reset'^M^J+
'NUMPAD1'^I'зум сброс -'^M^J+
'NUMPAD6'^I'вкл аспект'^M^J+
'NUMPAD8'^I'Сбросить аспект'^M^J+
'NUMPAD4'^I'Дек Аспект'^M^J+
'NUMPAD7'^I'Обрезать видео'^M^J+
'V'^I^I'видимость субтитров'^M^J+
'CTRL+0'^I^I'Сбросить скорость'^M^J+
'CTRL+/'^I^I'скорость -'^M^J+
'CTRL+*'^I^I'скорость +'^M^J+
'CTRL+O'^I^I'Открыть файл'^M^J+
'CTRL+L'^I^I'Открыть URL'^M^J+
'CTRL+W'^I^I'закрывать'^M^J+
'CTRL+LEFT'^I'предыдущий трек'^M^J+
'CTRL+RIGHT'^I'следующий трек'^M^J+
'Alt+0'^I^I'Произвольный размер'^M^J+
'Alt+1'^I^I'1/2 размера'^M^J+
'Alt+2'^I^I'Оригинальный размер'^M^J+
'Alt+3'^I^I'Двойной размер'^M^J+
'Alt+F4'^I^I'закрыть программу'^M^J+
'Alt+Return'^I'Полноэкранный'^M^J+
'CTRL+LEFT'^I'предыдущий трек'^M^J+
'CTRL+RIGHT'^I'следующий трек'^M^J+
'MEDIA_STOP'^I^I'стоп'^M^J+
'MEDIA_PREV_TRACK'^I'предыдущий трек'^M^J+
'MEDIA_NEXT_TRACK'^I'следующий трек'
  ;
    HelpFormClose:='Закрыть';

    //log form
    LogFormCaption:='Выход Mplayer';
    LogFormClose:='Закрыть';

    //about form
    AboutFormCaption := 'О программ ';
    AboutFormClose := 'Закрыть';
    AboutVersionMPUI := 'Версия 3nity Media Player:';
    AboutVersionMplayer := 'Версия MPlayer:';

    //settings form
    SettingsformCaption := '--';
    Brightness := 'яркость';
    Contrast := 'контрастировать';
    Hue := 'оттенок';
    Saturation := 'насыщение';
    Gamma := 'Гамма';
    SubScale := 'Размер субтитров';
    ResetSetting := 'Сброс';
    MResetSetting := 'Сброс';

    //options form
    FullScreenMonitor := 'Полноэкранный монитор';
    AutoLocale:='(Авто)';

    OptionsFormCaption:='настройки';
    OptionsFormOK:='OK';
    OptionsFormApply:='Применить';

    OptionsFormAssociate:='ассоциированный';
    OptionsFormSelectAll:='Выбрать все';
    OptionsFormSelectNone:='Никто';
    OptionsFormSave:='Сохранить';
    OptionsFormClose:='Закрыть';
    OptionsFormHelp:='Закрыть';
    OptionsFormParams:='Дополнительные параметры MPlayer:';

    OptionsFormIndex:='При необходимости перестройте индекс файла.';
    OptionsFormPriorityBoost:='Выполнять с более высоким приоритетом';

    Autosync := 'коэффициент автосинхронизации';
    AVsyncperframe := 'Аудио видео синхронизация за кадр (миллисекунды.)';

    OptionsFormAudioOut:='Драйвер вывода звука';
    AudioOutNoDecode:='(не декодировать звук)';
    AudioOutNoOut:='(не воспроизводить звук)';
    OptionsFormAudioDev:='Устройство вывода DirectSound';
    OptionsFormAudioFilterChannels := 'Фильтрация каналов и маршрутизация';
    OptionsFormSoftVol:='Увеличение громкости';
    OptionsFormUseVolcmd := 'Использовать параметр командной строки громкости';
    OptionsFormAudioDecodeChannels := 'Максимальное количество каналов для декодирования';
    OptionsFormAc3Comp := 'Уровень сжатия AC3';
    OptionsFormUseliba52 := 'Используйте библиотеку liba52';

    OptionsFormVideoOut := 'Драйвер вывода видео';
    VideoOutUser := 'Другой:';
    OptionsFormOverlay:= 'Наложение цвета';
    ForceEvenWidth := 'Принудительная четная ширина';
    DirectRender := 'Прямой рендеринг';
    DoubleBuffer := 'Двойная буферизация';
    DrawSlices := 'Рисовать используя ломтики';

    OptionsFormVideoeq  := 'Программный эквалайзер';
    VideoeqOff  := 'Off';
    VideoScaler := 'Программный видео скалер';
    TryScaler := 'Попробуй скалер при ошибке';

    OptionsFormPostproc:='Постобработка';
    PostprocOff:='Off';
    PostprocAuto:='автоматическая';
    PostprocMax:='Максимальное качество';

    OptionsFormGeneral := 'генеральный';
    OptionsFormAudio := 'аудио';
    OptionsFormVideo := 'видео';
    OptionsFormCaching := 'Кэширование';
    OptionsFormOSDSub := 'OSD и сабвуферы';

    MediaDefault := 'По умолчанию';
    MediaFixed := 'Фиксированный диск';
    MediaRamdisk := 'RAM диск';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Съемное устройство';
    mediaNetwork := 'Локальная сеть';
    MediaInternet := 'интернет';
    MediaDvd := 'Воспроизведение DVD';

    FontPath := 'Шрифт';
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

    FontConfig := 'сканирование шрифтов';
    SubAss := 'SSA/ASS';
    SubAutoLoad := 'Загрузка внешних файлов субтитров';

    SubAssBorderColor := 'Цвет границы текста';
    SubAssColor := 'Цвет текста';
    SubBgColor := 'Цвет фона текста';

    UseDvdNav := 'Включить DVD меню';
    DeinterlaceDVD := 'Всегда деинтерлейсинг';

    //playlist form
    PlaylistFormCaption:='Плейлист';
    PlaylistFormPlay:='Играть';
    PlaylistFormAdd:='Добавить ...';
    PlaylistFormMoveUp:='Вверх';
    PlaylistFormMoveDown:='Вниз';
    PlaylistFormDelete:='Удалить';
    PlaylistFormShuffle:='наугад';
    PlaylistFormLoop:='Повторять';
    PlaylistFormSave:='Сохранить ...';
    PlaylistFormClose:='Закрыть';

    InfoFormCaption:='Информация о файле';
    InfoFormClose:='Закрыть';
    InfoFormCopy := 'копировать';
    NoInfo:='Информация о файле на данный момент недоступна.';
    InfoFileFormat:='Формат';
    InfoPlaybackTime:='продолжительность';
    InfoTags:='Метаданные клипа';
    InfoVideo:='Видеодорожка';
    InfoAudio:='Звуковая дорожка';
    InfoDecoder:='дешифратор';
    InfoCodec:='кодер';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Размеры';
    InfoVideoFPS:='Частота кадров';
    InfoVideoAspect:='Соотношение сторон';
    InfoAudioRate:='Качество сэмплирования';
    InfoAudioChannels:='Количество каналов';
    InfoInterlace:='кадр';
    InfoVideoInt := 'чересстрочной';
    InfoVideoPro := 'прогрессирующий';
    InfoTrack := 'трек';
    InfoFilesize := 'Размер файла';
    InfoSub := 'Субтитры';
    InfoFormCopyAll := 'Копировать все';
  end
end;

begin
  RegisterLocale('Russian - русский', Activate, LANG_RUSSIAN, RUSSIAN_CHARSET);
end.
