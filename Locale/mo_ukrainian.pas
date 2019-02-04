unit mo_ukrainian;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='відкриття ...';
      Status_Closing:='закриття ...';
      Status_Playing:='відтворення';
      Status_Paused:='припинена';
      Status_Stopped:='зупинився';
      Status_Error:='Неможливо відтворити медіа (натисніть, щоб отримати додаткову інформацію)';

    FullscreenControls:='Показати повноекранні елементи керування';
    OSD:='OSD mode';
      NoOSD:='No OSD';
      DefaultOSD:='Default OSD';
      TimeOSD:='Показувати час';
      FullOSD:='Показати загальний час';
    Escape:='Натисніть Escape, щоб вийти з повноекранного режиму.';
    Filemenu:='&Файл';
      OpenFile:='Відтворити файл ...';
      OpenURL:='URL-адреса відтворення ...';
        OpenURL_Caption:='URL-адреса відтворення';
        OpenURL_Prompt:='Яку URL-адресу потрібно відтворити?';
      OpenDrive:='Відтворення CD / DVD';
      InternetRadios:='Інтернет-радіо';
      OpenTV := 'Open TV/capture card';
      Close:='близько';
      Quit:='вихід';
    View:='&Переглянути';
      SizeAny:='Спеціальний розмір';
      Size50:='Половина розміру';
      Size100:='Оригінальний розмір';
      Size200:='Подвійний розмір';
      VideoInside:='Не обрізайте відео';
      Fullscreen:='Повноекранний';
      AudioEqu:='Еквалайзер';
      Compact:='Компактний режим';
      TogOSD:='Перемкнути екранне меню';
      OnTop:='Завжди на висоті';
      Vis:='Візуалізація';
      VisEnable:='Показати візуалізацію';
      VisDirectRender:='Прямий рендеринг';
    Seek:='&Грати';
      Play:='Грати';
      Pause:='Пауза';
      Stop:='Стій';
      Prev:='Попередній заголовок'^I'Ctrl Left';
      Next:='Наступний заголовок'^I'Ctrl Right';
      ShowPlaylist:='Список відтворення ...';
      Mute:='німий';
      SeekF10:='Вперед 10 секунд'^I'Right';
      SeekR10:='Перемотування назад 10 секунд'^I'Left';
      SeekF60:='Вперед 1 хвилина'^I'Up';
      SeekR60:='Перемотати 1 хвилину'^I'Down';
      SeekF600:='Вперед 10 хвилин'^I'PgUp';
      SeekR600:='Перемотати 10 хвилин'^I'PgDn';
    Navigation:='&Навігація';
      Menu := 'Меню';
      Titles := 'Назви';
      Chapters:= 'Розділи';
    Extra:='&Опції';
      Audio:='Аудіодоріжка';
      Subtitle:='Пісня субтитрів';
        NoSubtitle := 'Немає субтитрів';
      AddSubtitle := 'Завантаження субтитрів...';

      Aspect:='Співвідношення сторін';
        AspectAuto:='Автовизначення';
        Aspect43:='Сила 4:3';
        Aspect169:='Сила 16:9';
        Aspect235:='Сила 2.35:1';
      DeinterlaceAlg:='Алгоритм деінтерляції';
        DeinterlaceBlend := 'Суміш';
        DeinterlaceSimple := 'Простий';
        DeinterlaceAdaptative := 'Адаптивна';
        DeinterlaceDoubleRate := 'Подвійний тариф';
      Deinterlace:='Деінтерлейс';

      Off := 'Off';
      On:='On';
      Auto:='Авто';

      Settings := 'Налаштування відео ...';
      Options:='Налаштування ...';
      Language:='Мова';
      StreamInfo:='Показати інформацію про файл ...';
      ShowOutput:='Показати вихід MPlayer ...';
    Help:='&Довідка';
      KeyHelp:='Довідка з клавіатури ...';
      About := 'Про ...';


    HelpFormCaption:='Довідка з клавіатури';
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
    HelpFormClose:='близько';

    //log form
    LogFormCaption:='Вихід MPlayer';
    LogFormClose:='близько';

    //about form
    AboutFormCaption := 'Версія 3nity Media Player';
    AboutFormClose := 'близько';
    AboutVersionMPUI := '3nity Media Player version:';
    AboutVersionMplayer := 'Версія MPlayer:';

    //settings form
    SettingsformCaption := 'Налаштування відео';
    Brightness := 'Яскравість';
    Contrast := 'Контраст';
    Hue := 'Hue';
    Saturation := 'Насиченість';
    Gamma := 'Гамма';
    SubScale := 'Розмір субтитрів';
    ResetSetting := 'Скинути';
    MResetSetting := 'Скинути';

    //options form
    FullScreenMonitor := 'Повноекранний монітор';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Налаштування';
    OptionsFormOK:='OK';
    OptionsFormApply:='Застосувати';

    OptionsFormAssociate:='економити';
    OptionsFormSelectAll:='Вибрати все';
    OptionsFormSelectNone:='Немає';
    OptionsFormSave:='економити';
    OptionsFormClose:='близько';
    OptionsFormHelp:='Довідка';
    OptionsFormParams:='Додаткові параметри MPlayer:';

    OptionsFormIndex:='Переробити індекс файлу, якщо необхідно';
    OptionsFormPriorityBoost:='Запуск із вищим пріоритетом';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Драйвер виведення звуку';
    AudioOutNoDecode:='(не декодувати звук)';
    AudioOutNoOut:='(не відтворюйте звук)';
    OptionsFormAudioDev:='Вихідний пристрій DirectSound';
    OptionsFormAudioFilterChannels := 'Фільтрація каналів і маршрутизація';
    OptionsFormSoftVol:='Керування гучністю програмного забезпечення / підвищення гучності';
    OptionsFormUseVolcmd := 'Використовуйте параметр командного рядка volume';
    OptionsFormAudioDecodeChannels := 'Макс. номер. каналів для декодування';
    OptionsFormAc3Comp := 'Рівень стиснення AC3';
    OptionsFormUseliba52 := 'Рівень стиснення AC3';

    OptionsFormVideoOut := 'Драйвер виводу відео';
    VideoOutUser := 'Інший:';
    OptionsFormOverlay:= 'Накладання кольору';
    ForceEvenWidth := 'Примусово рівна ширина';
    DirectRender := 'Прямий рендеринг';
    DoubleBuffer := 'Подвійна буферизація';
    DrawSlices := 'Намалюйте фрагменти';

    OptionsFormVideoeq  := 'Програмне забезпечення відео еквалайзера';
    VideoeqOff  := 'Off';
    VideoScaler := 'Програмне забезпечення відео скалера';
    TryScaler := 'Спробуйте виконати скалер за помилкою';

    OptionsFormPostproc:='Подальша обробка';
    PostprocOff:='Off';
    PostprocAuto:='Автоматично';
    PostprocMax:='Максимальна якість';

    OptionsFormGeneral := 'Загальні';
    OptionsFormAudio := 'Аудіо';
    OptionsFormVideo := 'Відео';
    OptionsFormCaching := 'Кешування';
    OptionsFormOSDSub := 'OSD/субтитри';

    MediaDefault := 'За замовчуванням';
    MediaFixed := 'Фіксований диск';
    MediaRamdisk := 'RAM диск';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Знімний пристрій';
    mediaNetwork := 'Локальна мережа';
    MediaInternet := 'Інтернет';
    MediaDvd := 'Відтворення DVD';

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

    FontConfig := 'Сканування шрифтів';
    SubAss := 'Використовуйте SSA / ASS';
    SubAutoLoad := 'Завантажте файли зовнішніх субтитрів';

    SubAssBorderColor := 'Колір рамки тексту';
    SubAssColor := 'Колір тексту';
    SubBgColor := 'Колір фону тексту';

    UseDvdNav := 'Увімкнення меню DVD ';
    DeinterlaceDVD := 'Завжди деінтерлейс';

    //playlist form
    PlaylistFormCaption:='Список відтворення';
    PlaylistFormPlay:='Грати';
    PlaylistFormAdd:='Додати ...';
    PlaylistFormMoveUp:='Рухатися вгору';
    PlaylistFormMoveDown:='Рухатися вниз';
    PlaylistFormDelete:='Видалити';
    PlaylistFormShuffle:='Перемішати';
    PlaylistFormLoop:='Повторіть';
    PlaylistFormSave:='економити ...';
    PlaylistFormClose:='близько';

    InfoFormCaption:='Інформація про файл';
    InfoFormClose:='близько';
    InfoFormCopy := 'Копіювати';
    NoInfo:='На даний момент інформація про файл не доступна.';
    InfoFileFormat:='Формат';
    InfoPlaybackTime:='Тривалість';
    InfoTags:='Метадані кліпу';
    InfoVideo:='Відеотрек';
    InfoAudio:='Аудіодоріжка';
    InfoDecoder:='Decoder';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Розміри';
    InfoVideoFPS:='Частота кадрів';
    InfoVideoAspect:='Співвідношення сторін';
    InfoAudioRate:='Частота вибірки';
    InfoAudioChannels:='Канали';
    InfoInterlace:='Кадр';
    InfoVideoInt := 'Чересстрочная';
    InfoVideoPro := 'Прогресивна';
    InfoTrack := 'Трек';
    InfoFilesize := 'Розмір файлу';
    InfoSub := 'Субтитри';
    InfoFormCopyAll := 'Копіювати все';
  end
end;

begin
    RegisterLocale('Ukrainian - Українська', Activate, LANG_UKRAINIAN, RUSSIAN_CHARSET);
end.