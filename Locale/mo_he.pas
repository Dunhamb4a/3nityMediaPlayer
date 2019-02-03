unit mo_he;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='פתיחה ...';
      Status_Closing:='סוגר ...';
      Status_Playing:='משחק';
      Status_Paused:='מושהה';
      Status_Stopped:='עצר';
      Status_Error:='לא ניתן להפעיל מדיה (לחץ לקבלת מידע נוסף)';

    FullscreenControls:='הצג פקדים במסך מלא';
    OSD:='מצב OSD';
      NoOSD:='אין OSD';
      DefaultOSD:='ברירת המחדל של המסך';
      TimeOSD:='הצג את השעה';
      FullOSD:='הצג את השעה הכוללת';
    Escape:='לחץ על Escape כדי לצאת ממצב מסך מלא.';
    Filemenu:='&קובץ';
      OpenFile:='הפעל קובץ ...';
      OpenURL:='הפעל כתובת אתר ...';
        OpenURL_Caption:='הפעל כתובת אתר';
        OpenURL_Prompt:='איזו כתובת אתר ברצונך להפעיל?';
      OpenDrive:='נגן תקליטור / DVD';
      InternetRadios:='רדיו אינטרנט';
      OpenTV := 'Open TV/capture card';
      Close:='סגור';
      Quit:='צא';
    View:='&נוף';
      SizeAny:='גודל מותאם אישית';
      Size50:='חצי מידה';
      Size100:='גודל מקורי';
      Size200:='חדר זוגי';
      VideoInside:='אין לחתוך וידאו';
      Fullscreen:='מסך מלא';
      AudioEqu:='אקולייזר';
      Compact:='מצב קומפקטי';
      TogOSD:='החלפת OSD';
      OnTop:='תמיד על העליונה';
      Vis:='ויזואליזציה';
      VisEnable:='הצג פריטים חזותיים';
      VisDirectRender:='עיבוד ישיר';
    Seek:='&שחק';
      Play:='שחק';
      Pause:='השהה';
      Stop:='תפסיק';
      Prev:='כותרת קודמת'^I'Ctrl Left';
      Next:='הכותרת הבאה'^I'Ctrl Right';
      ShowPlaylist:='פלייליסט ...';
      Mute:='השתקה';
      SeekF10:='העבר 10 שניות'^I'Right';
      SeekR10:='חזור על 10 שניות'^I'Left';
      SeekF60:='קדימה 1 דקה'^I'Up';
      SeekR60:='חזור לאחור 1 דקות'^I'Down';
      SeekF600:='העבר 10 דקות'^I'PgUp';
      SeekR600:='חזור לאחור 10 דקות'^I'PgDn';
    Navigation:='&ניווט';
      Menu := 'תפריט';
      Titles := 'כותרות';
      Chapters:= 'פרקים';
    Extra:='&אפשרויות';
      Audio:='אודיו במסלול';
      Subtitle:='רצועת כתוביות';
        NoSubtitle := 'אין כתוביות';
      AddSubtitle := 'טען כתוביות...';

      Aspect:='יחס הממדים';
        AspectAuto:='זיהוי אוטומטי';
        Aspect43:='כוח 4: 3';
        Aspect169:='כוח 16: 9';
        Aspect235:='כוח 2.35: 1';
      DeinterlaceAlg:='אלגוריתם Deinterlace';
        DeinterlaceBlend := 'תערובת';
        DeinterlaceSimple := 'פשוט';
        DeinterlaceAdaptative := 'מסתגלת';
        DeinterlaceDoubleRate := 'תעריף כפול';
      Deinterlace:='Deinterlace';

      Off := 'Off';
      On:='On';
      Auto:='אוטומטי';

      Settings := 'התאמות וידאו ...';
      Options:='הגדרות ...';
      Language:='שפה';
      StreamInfo:='הצג פרטי קובץ ...';
      ShowOutput:='הצג פלט MPlayer ...';
    Help:='&עזרה';
      KeyHelp:='עזרה בלוח המקשים ...';
      About := 'על אודות ...';


    HelpFormCaption:='עזרה בלוח המקשים';
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
    HelpFormClose:='סגור';

    //log form
    LogFormCaption:='MPlayer output';
    LogFormClose:='סגור';

    //about form
    AboutFormCaption := 'על אודות';
    AboutFormClose := 'סגור';
    AboutVersionMPUI := '3nity Media Player גרסה:';
    AboutVersionMplayer := 'MPlayer גרסה:';

    //settings form
    SettingsformCaption := 'התאמות וידאו';
    Brightness := 'בהירות';
    Contrast := 'בניגוד';
    Hue := 'גוון';
    Saturation := 'רוויה';
    Gamma := 'גמא';
    SubScale := 'גודל הגודל';
    ResetSetting := 'אפס';
    MResetSetting := 'אפס';

    //options form
    FullScreenMonitor := 'מסך מלא';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='הגדרות';
    OptionsFormOK:='OK';
    OptionsFormApply:='להגיש מועמדות';

    OptionsFormAssociate:='להציל';
    OptionsFormSelectAll:='Select All';
    OptionsFormSelectNone:='None';
    OptionsFormSave:='להציל';
    OptionsFormClose:='סגור';
    OptionsFormHelp:='עזרה';
    OptionsFormParams:='פרמטרים נוספים של MPlayer:';

    OptionsFormIndex:='לבנות מחדש את קובץ הקובץ במידת הצורך';
    OptionsFormPriorityBoost:='הפעל עם עדיפות גבוהה יותר';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='הנהג פלט סאונד';
    AudioOutNoDecode:='(לא לפענח קול)';
    AudioOutNoOut:='(אל תשמע צליל)';
    OptionsFormAudioDev:='התקן פלט DirectSound';
    OptionsFormAudioFilterChannels := 'ערוץ סינון וניתוב';
    OptionsFormSoftVol:='בקרת נפח תוכנה / להגביר את עוצמת הקול';
    OptionsFormUseVolcmd := 'השתמש באפשרות ''אפשרויות שורת פקודה''';
    OptionsFormAudioDecodeChannels := 'מקסימלי מס ''. של ערוצים לפענח';
    OptionsFormAc3Comp := 'AC3 רמת דחיסה';
    OptionsFormUseliba52 := 'השתמש בספריית liba52';

    OptionsFormVideoOut := 'מנהל התקן פלט וידאו';
    VideoOutUser := 'אחר:';
    OptionsFormOverlay:= 'צבע שכבת על';
    ForceEvenWidth := 'כוח אפילו רוחב';
    DirectRender := 'עיבוד ישיר';
    DoubleBuffer := 'חציצה כפולה';
    DrawSlices := 'צייר באמצעות פרוסות';

    OptionsFormVideoeq  := 'וידאו אקולייזר תוכנה';
    VideoeqOff  := 'Off';
    VideoScaler := 'תוכנות וידאו Scaler';
    TryScaler := 'נסה scaler על שגיאה';

    OptionsFormPostproc:='לאחר עיבוד';
    PostprocOff:='Off';
    PostprocAuto:='אוטומטי';
    PostprocMax:='איכות מקסימלית';

    OptionsFormGeneral := 'כללי';
    OptionsFormAudio := 'אודיו';
    OptionsFormVideo := 'וידאו';
    OptionsFormCaching := 'מטמון';
    OptionsFormOSDSub := 'OSD וכתוביות';

    MediaDefault := 'ברירת מחדל';
    MediaFixed := 'דיסק קבוע';
    MediaRamdisk := 'דיסק RAM';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'התקן נשלף';
    mediaNetwork := 'רשת מקומית';
    MediaInternet := 'אינטרנט';
    MediaDvd := 'השמעת DVD';

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

    FontConfig := 'סריקה גופן';
    SubAss := 'השתמש ב- SSA / ASS';
    SubAutoLoad := 'טען קבצי כתוביות חיצוניים';

    SubAssBorderColor := 'צבע גבול טקסט';
    SubAssColor := 'צבע טקסט';
    SubBgColor := 'צבע רקע לטקסט';

    UseDvdNav := 'הפעל תפריטי DVD ';
    DeinterlaceDVD := 'תמיד מחלץ';

    //playlist form
    PlaylistFormCaption:='פלייליסט';
    PlaylistFormPlay:='שחק';
    PlaylistFormAdd:='הוסף ...';
    PlaylistFormMoveUp:='זוז למעלה';
    PlaylistFormMoveDown:='לרדת';
    PlaylistFormDelete:='הסר';
    PlaylistFormShuffle:='דשדוש';
    PlaylistFormLoop:='חזור';
    PlaylistFormSave:='להציל ...';
    PlaylistFormClose:='סגור';

    InfoFormCaption:='פרטי קובץ';
    InfoFormClose:='סגור';
    InfoFormCopy := 'עותק';
    NoInfo:='אין מידע על הקובץ זמין כרגע.';
    InfoFileFormat:='פורמט';
    InfoPlaybackTime:='משך';
    InfoTags:='מטא נתונים של קליפ';
    InfoVideo:='רצועת וידאו';
    InfoAudio:='אודיו במסלול';
    InfoDecoder:='מפענח';
    InfoCodec:='Codec';
    InfoBitrate:='קצב סיביות';
    InfoVideoSize:='ממדים';
    InfoVideoFPS:='קצב פריימים';
    InfoVideoAspect:='יחס הממדים';
    InfoAudioRate:='קצב דגימה';
    InfoAudioChannels:='ערוצים';
    InfoInterlace:='מסגרת';
    InfoVideoInt := 'משולבת';
    InfoVideoPro := 'פרוגרסיבי';
    InfoTrack := 'עקוב אחר';
    InfoFilesize := 'גודל הקובץ';
    InfoSub := 'כתוביות';
    InfoFormCopyAll := 'העתק הכל';
  end
end;

begin
    RegisterLocale('Hebrew - עברית',Activate,LANG_HEBREW,HEBREW_CHARSET);
end.
