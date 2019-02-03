unit mo_ar;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='جارى الفتح ...';
      Status_Closing:='جارى الاغلاق ...';
      Status_Playing:='جارى العرض';
      Status_Paused:='ايقاف مؤقت';
      Status_Stopped:='متوقف';
      Status_Error:='غير قادر على العرض (اضغط لمزيد من المعلومات)';

    FullscreenControls:='عرض عناصر التحكم في ملء الشاشة';
    OSD:='OSD وضعية';
      NoOSD:='OSDبدون';
      DefaultOSD:='الافتراضى OSD';
      TimeOSD:='اظهار الزمن';
      FullOSD:='اظهار الزمن الكلى';
    Escape:='اضغط على Escape للخروج من وضع ملء الشاشة.';
    Filemenu:='&ملف';
      OpenFile:='عرض ملف ...';
      OpenURL:='فتح عنوان ويب  ...';
        OpenURL_Caption:='فتح عنوان ويب ';
        OpenURL_Prompt:='ما عنوان الانترنت الذى تريد عرضه؟';
      OpenDrive:='عرض (V)CD/DVD/BlueRay';
      OpenTV := 'افتح تلفزيون / بطاقة التقاط';
      InternetRadios:='أجهزة راديو الإنترنت';
      Close:='اغلاق';
      Quit:='خروج';
    View:='&مظهر';
      SizeAny:='حجم معرف (';
      Size50:='نصف الحجم';
      Size100:='الحجم الاصلى';
      Size200:='الحجم مضاعف';
      VideoInside:='لا تقطع الفيديو';
      Fullscreen:='الشاشة كلها';
      AudioEqu:='التعادل';
      Compact:='الوضعية المضغوطة';
      TogOSD:='تبديل OSD';
      OnTop:='دائما على القمة';
      Vis:='تصور';
      VisEnable:='عرض التصور';
      VisDirectRender:='التقديم المباشر';
    Seek:='&عرض';
      Play:='عرض';
      Pause:='وقف مؤقت';
      Stop:='توقف';
      Prev:='سابق'^I'Ctrl Left';
      Next:='التالى'^I'Ctrl Right';
      ShowPlaylist:='لائحة العرض ...';
      Mute:='صامت';
      SeekF10:='تقدم عشر ثوان'^I'Right';
      SeekR10:='رجوع عشر ثوان'^I'Left';
      SeekF60:='تقدم دقيقة واحدة'^I'Up';
      SeekR60:='رجوع دقيقة واحدة'^I'Down';
      SeekF600:='تقدم عشر دقائق'^I'PgUp';
      SeekR600:='رجوع عشر دقائق'^I'PgDn';
    Navigation:='&DVD';
      Menu := 'قائمة DVD';
      Titles := 'عناوين DVD';
      Chapters:= 'فصول دي في دي';
    Extra:='&خيارات';
      Audio:='مقطع صوتي';
      Subtitle:='مسار الترجمة';
        NoSubtitle := 'لا ترجمات';
      AddSubtitle := 'تحميل ترجمات ...';

      Aspect:='نسبة المظهر';
        AspectAuto:='كشف تلقائى';
        Aspect43:='اجبار 4:3';
        Aspect169:='اجبار 16:9';
        Aspect235:='اجبار 2.35:1';
      DeinterlaceAlg:='تشابك';
        DeinterlaceBlend := 'مزيج';
        DeinterlaceSimple := 'بسيط';
        DeinterlaceAdaptative := 'متكيف';
        DeinterlaceDoubleRate := 'معدل مزدوج';
      Deinterlace:='تشابك';

      Off := 'Off';
      On:='On';
      Auto:='تلقائي';

      Settings := 'الإعدادات ...';
      Options:='خيارات ...';
      Language:='لغة';
      StreamInfo:='اظهار معلومات الكليب ...';
      ShowOutput:='اظهار خرج امبلاير ...';
    Help:='&مساعدة';
      KeyHelp:='مساعدة لوحة المفاتيح ...';
      About := 'عن ...';


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
'CTRL+LEFT'^I'Play previous track'^M^J+
'CTRL+RIGHT'^I'Play next track'^M^J+
'MEDIA_STOP'^I^I'Stop Playing'^M^J+
'MEDIA_PREV_TRACK'^I'Play previous track'^M^J+
'MEDIA_NEXT_TRACK'^I'Play next track'
  ;
    HelpFormClose:='غلق';

    //log form
    LogFormCaption:='خرج امبلاير';
    LogFormClose:='غلق';

    //about form
    AboutFormCaption := 'عن';
    AboutFormClose := 'غلق';
    AboutVersionMPUI := 'الإصدار:';
    AboutVersionMplayer := 'إصدار MPlayer:';

    //settings form
    SettingsformCaption := 'الإعدادات';
    Brightness := 'سطوع';
    Contrast := 'تناقض';
    Hue := 'مسحة';
    Saturation := 'التشبع';
    Gamma := 'غاما';
    SubScale := 'Sub. size';
    ResetSetting := 'إعادة تعيين';
    MResetSetting := 'إعادة تعيين';

    //options form
    FullScreenMonitor := 'مراقب ملء الشاشة';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='خيارات';
    OptionsFormOK:='OK';
    OptionsFormApply:='تطبيق';

    OptionsFormAssociate:='Associate';
    OptionsFormSelectAll:='Select All';
    OptionsFormSelectNone:='None';
    OptionsFormSave:='Save';
    OptionsFormClose:='غلق';
    OptionsFormHelp:='مساعدة';
    OptionsFormParams:='معلمات MPlayer إضافية:';

    OptionsFormIndex:='إعادة بناء فهرس الملف إذا لزم الأمر';
    OptionsFormPriorityBoost:='تشغيل بأولوية أعلى';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='برنامج إخراج الصوت';
    AudioOutNoDecode:='لا تفك تشفير الصوت';
    AudioOutNoOut:='لا تلعب الصوت';
    OptionsFormAudioDev:='جهاز الإخراج DirectSound';
    OptionsFormAudioFilterChannels := 'تصفية القنوات والتوجيه';
    OptionsFormSoftVol:='التحكم في مستوى الصوت / زيادة حجم الصوت';
    OptionsFormUseVolcmd := 'استخدم خيار سطر الأوامر لوحدة التخزين';
    OptionsFormAudioDecodeChannels := 'ماكس. الأسطوانات. من القنوات لفك';
    OptionsFormAc3Comp := 'مستوى ضغط AC3';
    OptionsFormUseliba52 := 'استخدم مكتبة liba52';

    OptionsFormVideoOut := 'سائق إخراج الفيديو';
    VideoOutUser := 'آخر:';
    OptionsFormOverlay:= 'تراكب اللون';
    ForceEvenWidth := 'قوة حتى العرض';
    DirectRender := 'التقديم المباشر';
    DoubleBuffer := 'التخزين المؤقت المزدوج';
    DrawSlices := 'ارسم باستخدام الشرائح';

    OptionsFormVideoeq  := 'معادل فيديو البرامج';
    VideoeqOff  := 'Off';
    VideoScaler := 'قشارة الفيديو البرمجيات';
    TryScaler := 'حاول قشارة على خطأ';

    OptionsFormPostproc:='المعالجة البعدية';
    PostprocOff:='Off';
    PostprocAuto:='تلقائي';
    PostprocMax:='أقصى جودة';

    OptionsFormGeneral := 'جنرال لواء';
    OptionsFormAudio := 'سمعي';
    OptionsFormVideo := 'فيديو';
    OptionsFormCaching := 'التخزين المؤقت';
    OptionsFormOSDSub := 'OSD and subs';

    MediaDefault := 'افتراضي';
    MediaFixed := 'القرص الثابت';
    MediaRamdisk := 'قرص ذاكرة الوصول العشوائي';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'جهاز قابل للإزالة';
    mediaNetwork := 'شبكه محليه';
    MediaInternet := 'الإنترنت';
    MediaDvd := 'تشغيل DVD';

    FontPath := 'الخط';
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

    FontConfig := 'مسح الخط';
    SubAss := 'Use SSA/ASS';
    SubAutoLoad := 'تحميل ملفات الترجمة الخارجية';

    SubAssBorderColor := 'لون حدود النص';
    SubAssColor := 'لون الخط';
    SubBgColor := 'لون خلفية النص';

    UseDvdNav := 'تمكين قوائم DVD';
    DeinterlaceDVD := 'دائما مشابك';

    //playlist form
    PlaylistFormCaption:='لائحة العرض';
    PlaylistFormPlay:='عرض';
    PlaylistFormAdd:='اضف ...';
    PlaylistFormMoveUp:='انقل للأعلى';
    PlaylistFormMoveDown:='انقل للأسفل';
    PlaylistFormDelete:='ازالة';
    PlaylistFormShuffle:='عشوائى';
    PlaylistFormLoop:='اعادة';
    PlaylistFormSave:='حفظ ...';
    PlaylistFormClose:='غلق';

    InfoFormCaption:='معلومات الكليب';
    InfoFormClose:='غلق';
    InfoFormCopy := 'لنسخ';
    NoInfo:='لا توجد معلومات عن الكليب حاليا.';
    InfoFileFormat:='النوعية';
    InfoPlaybackTime:='المدة';
    InfoTags:='معلومات الكليب الاولية';
    InfoVideo:='تراك الصورة';
    InfoAudio:='تراك الصوت';
    InfoDecoder:='مفكك الشفرة';
    InfoCodec:='التشفير';
    InfoBitrate:='معدل الكسرة';
    InfoVideoSize:='الابعاد';
    InfoVideoFPS:='معدل الاطار';
    InfoVideoAspect:='نسبة المظهر';
    InfoAudioRate:='معدل العينة';
    InfoAudioChannels:='القنوات';
    InfoInterlace:='الإطار';
    InfoVideoInt := 'المتداخلة';
    InfoVideoPro := 'تدريجي';
    InfoTrack := 'مسار';
    InfoFilesize := 'حجم الملف';
    InfoSub := 'عناوين فرعية';
    InfoFormCopyAll := 'نسخ جميع';
  end
end;

begin
  RegisterLocale('Arabic - عربى',Activate,LANG_ARABIC,ARABIC_CHARSET);
end.
