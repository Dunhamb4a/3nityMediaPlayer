unit mo_gr;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Ανοιγμα ...';
      Status_Closing:='Κλείσιμο ...';
      Status_Playing:='Παιχνίδι';
      Status_Paused:='Παύση';
      Status_Stopped:='Σταμάτησε';
      Status_Error:='Δεν είναι δυνατή η αναπαραγωγή μέσων (κάντε κλικ για περισσότερες πληροφορίες)';

    FullscreenControls:='Εμφάνιση ελέγχων πλήρους οθόνης';
    OSD:='Λειτουργία OSD';
      NoOSD:='Δεν υπάρχει OSD';
      DefaultOSD:='Προεπιλεγμένη OSD';
      TimeOSD:='Εμφάνιση ώρας';
      FullOSD:='Εμφάνιση συνολικού χρόνου';
    Escape:='Πατήστε Escape για έξοδο από τη λειτουργία πλήρους οθόνης.';
    Filemenu:='&Αρχείο';
      OpenFile:='Αναπαραγωγή αρχείου ...';
      OpenURL:='Αναπαραγωγή διευθύνσεων URL ...';
        OpenURL_Caption:='Αναπαραγωγή διευθύνσεων URL';
        OpenURL_Prompt:='Ποια διεύθυνση URL θέλετε να παίξετε;?';
      OpenDrive:='Αναπαραγωγή CD / DVD';
      InternetRadios:='Ραδιόφωνα στο Διαδίκτυο';
      OpenTV := 'Open TV/capture card';
      Close:='κοντά';
      Quit:='Εγκαταλείπω';
    View:='&Θέα';
      SizeAny:='Προσαρμοσμένο μέγεθος';
      Size50:='Μισό μέγεθος';
      Size100:='Αυθεντικό μέγεθος';
      Size200:='Αυθεντικό μέγεθος';
      VideoInside:='Μην περικόψετε βίντεο';
      Fullscreen:='ΠΛΗΡΗΣ ΟΘΟΝΗ';
      AudioEqu:='Εξισωτής';
      Compact:='Συμπαγής λειτουργία';
      TogOSD:='Εναλλαγή OSD';
      OnTop:='Πάντα σε πρώτο πλάνο';
      Vis:='Οραματισμός';
      VisEnable:='Εμφάνιση οπτικοποίησης';
      VisDirectRender:='Άμεση απόδοση';
    Seek:='&Παίζω';
      Play:='Παίζω';
      Pause:='Παύση';
      Stop:='Να σταματήσει';
      Prev:='Προηγούμενος τίτλος'^I'Ctrl Left';
      Next:='Επόμενος τίτλος'^I'Ctrl Right';
      ShowPlaylist:='Λίστα αναπαραγωγής ...';
      Mute:='Βουβός';
      SeekF10:='Προωθήστε 10 δευτερόλεπτα'^I'Right';
      SeekR10:='Αναδίπλωση 10 δευτερόλεπτα'^I'Left';
      SeekF60:='Προωθήστε 1 λεπτό'^I'Up';
      SeekR60:='Αναδίπλωση 1 λεπτό'^I'Down';
      SeekF600:='Προωθήστε 10 λεπτά'^I'PgUp';
      SeekR600:='Αναδίπλωση 10 λεπτά'^I'PgDn';
    Navigation:='&Πλοήγηση';
      Menu := 'Μενού';
      Titles := 'Τίτλοι';
      Chapters:= 'Κεφάλαια';
    Extra:='&Επιλογές';
      Audio:='Ηχογράφηση';
      Subtitle:='Οι υπότιτλοι παρακολουθούν';
        NoSubtitle := 'Δεν υπάρχουν υπότιτλοι';
      AddSubtitle := 'Τοποθετήστε τους υπότιτλους...';

      Aspect:='Αναλογία απεικόνισης';
        AspectAuto:='Αυτόματη αναγνώριση';
        Aspect43:='Δύναμη 4: 3';
        Aspect169:='Δύναμη 16:9';
        Aspect235:='Δύναμη 2.35:1';
      DeinterlaceAlg:='Αλγόριθμος απαλλαγής';
        DeinterlaceBlend := 'Μείγμα';
        DeinterlaceSimple := 'Απλός';
        DeinterlaceAdaptative := 'Προσαρμοστικός';
        DeinterlaceDoubleRate := 'Διπλό συντελεστή';
      Deinterlace:='Αποστράγγιση';

      Off := 'Off';
      On:='On';
      Auto:='Αυτο';

      Settings := 'Ρυθμίσεις βίντεο ...';
      Options:='Ρυθμίσεις ...';
      Language:='Γλώσσα';
      StreamInfo:='Εμφάνιση πληροφοριών αρχείου ...';
      ShowOutput:='Εμφάνιση της εξόδου MPlayer ...';
    Help:='&Βοήθεια';
      KeyHelp:='Βοήθεια πληκτρολογίου ...';
      About := 'Σχετικά με ...';


    HelpFormCaption:='Βοήθεια πληκτρολογίου';
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
    HelpFormClose:='κοντά';

    //log form
    LogFormCaption:='Έξοδο MPlayer';
    LogFormClose:='κοντά';

    //about form
    AboutFormCaption := 'Σχετικά με ';
    AboutFormClose := 'κοντά';
    AboutVersionMPUI := '3nity Media Player εκδοχή:';
    AboutVersionMplayer := 'MPlayer εκδοχή:';

    //settings form
    SettingsformCaption := 'Ρυθμίσεις βίντεο';
    Brightness := 'Λάμψη';
    Contrast := 'Αντίθεση';
    Hue := 'Απόχρωση';
    Saturation := 'Κορεσμός';
    Gamma := 'Gamma';
    SubScale := 'Μεγέθους υποτίτλων';
    ResetSetting := 'Επαναφορά';
    MResetSetting := 'Επαναφορά';

    //options form
    FullScreenMonitor := 'Οθόνη πλήρους οθόνης';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Ρυθμίσεις';
    OptionsFormOK:='OK';
    OptionsFormApply:='Ισχύουν';

    OptionsFormAssociate:='αποθηκεύσετε';
    OptionsFormSelectAll:='Select All';
    OptionsFormSelectNone:='None';
    OptionsFormSave:='αποθηκεύσετε';
    OptionsFormClose:='κοντά';
    OptionsFormHelp:='Βοήθεια';
    OptionsFormParams:='Επιπλέον παραμέτρους MPlayer:';

    OptionsFormIndex:='Αναδημιουργήστε το ευρετήριο αρχείων, αν είναι απαραίτητο';
    OptionsFormPriorityBoost:='Εκτελέστε με μεγαλύτερη προτεραιότητα';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Έλεγχος εξόδου ήχου';
    AudioOutNoDecode:='(μην αποκωδικοποιείτε τον ήχο)';
    AudioOutNoOut:='(μην αναπαράγετε ήχο)';
    OptionsFormAudioDev:='Συσκευή εξόδου DirectSound';
    OptionsFormAudioFilterChannels := 'Φιλτράρισμα και δρομολόγηση καναλιών';
    OptionsFormSoftVol:='Έλεγχος έντασης λογισμικού / αύξηση έντασης ήχου';
    OptionsFormUseVolcmd := 'Χρησιμοποιήστε την επιλογή γραμμής εντολών έντασης';
    OptionsFormAudioDecodeChannels := 'Μέγιστη. αριθμός. των καναλιών για αποκωδικοποίηση';
    OptionsFormAc3Comp := 'Επίπεδο συμπίεσης AC3';
    OptionsFormUseliba52 := 'Χρησιμοποιήστε τη βιβλιοθήκη liba52';

    OptionsFormVideoOut := 'Έξοδος προγράμματος οδήγησης βίντεο';
    VideoOutUser := 'Αλλα:';
    OptionsFormOverlay:= 'Χρώμα επικάλυψης';
    ForceEvenWidth := 'Ισχύει ακόμη και το πλάτος';
    DirectRender := 'Άμεση απόδοση';
    DoubleBuffer := 'Διπλό buffer';
    DrawSlices := 'Σχεδίαση χρησιμοποιώντας φέτες';

    OptionsFormVideoeq  := 'Λογισμικό ισοσταθμιστή βίντεο';
    VideoeqOff  := 'Off';
    VideoScaler := 'Βελτιστοποιητής βίντεο λογισμικού';
    TryScaler := 'Δοκιμάστε το scaler για σφάλμα';

    OptionsFormPostproc:='Επεξεργασία μετά';
    PostprocOff:='Off';
    PostprocAuto:='Αυτόματο';
    PostprocMax:='Μέγιστη ποιότητα';

    OptionsFormGeneral := 'Γενικός';
    OptionsFormAudio := 'Ήχος';
    OptionsFormVideo := 'βίντεο';
    OptionsFormCaching := 'Caching';
    OptionsFormOSDSub := 'OSD και υπότιτλους';

    MediaDefault := 'Προκαθορισμένο';
    MediaFixed := 'Σταθερός δίσκος';
    MediaRamdisk := 'RAM δίσκο';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Αφαιρούμενη συσκευή';
    mediaNetwork := 'Τοπικό δίκτυο';
    MediaInternet := 'Διαδίκτυο';
    MediaDvd := 'Αναπαραγωγή DVD';

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

    FontConfig := 'Σάρωση γραμματοσειρών';
    SubAss := 'Χρησιμοποιήστε SSA / ASS';
    SubAutoLoad := 'Τοποθετήστε εξωτερικά αρχεία υποτίτλων';

    SubAssBorderColor := 'Χρώμα περιγράμματος κειμένου';
    SubAssColor := 'Χρώμα κειμένου';
    SubBgColor := 'Χρώμα φόντου κειμένου';

    UseDvdNav := 'Ενεργοποιήστε τα μενού του DVD ';
    DeinterlaceDVD := 'Πάντοτε αποσυναρμολόγηση';

    //playlist form
    PlaylistFormCaption:='Λίστα αναπαραγωγής';
    PlaylistFormPlay:='Παίζω';
    PlaylistFormAdd:='Προσθέτω ...';
    PlaylistFormMoveUp:='Μετακινήστε επάνω';
    PlaylistFormMoveDown:='Μετακινηθείτε προς τα κάτω';
    PlaylistFormDelete:='Αφαιρώ';
    PlaylistFormShuffle:='Ανάμιξη';
    PlaylistFormLoop:='Επαναλαμβάνω';
    PlaylistFormSave:='αποθηκεύσετε ...';
    PlaylistFormClose:='κοντά';

    InfoFormCaption:='Πληροφορίες αρχείου';
    InfoFormClose:='κοντά';
    InfoFormCopy := 'αντιγράφω';
    NoInfo:='Δεν υπάρχουν πληροφορίες αρχείου αυτήν τη στιγμή.';
    InfoFileFormat:='Μορφή';
    InfoPlaybackTime:='Διάρκεια';
    InfoTags:='Μεταδεδομένα';
    InfoVideo:='Βίντεο κομματιού';
    InfoAudio:='Ηχογράφηση';
    InfoDecoder:='Αποκρυπτογράφος';
    InfoCodec:='Κωδικοποιητής';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Διαστάσεις';
    InfoVideoFPS:='Ρυθμός καρέ';
    InfoVideoAspect:='Αναλογία απεικόνισης';
    InfoAudioRate:='Ρυθμός δειγματοληψίας';
    InfoAudioChannels:='Κανάλια';
    InfoInterlace:='Πλαίσιο';
    InfoVideoInt := 'Ενδιάμεσα';
    InfoVideoPro := 'Προοδευτικός';
    InfoTrack := 'Πίστα';
    InfoFilesize := 'Μέγεθος αρχείου';
    InfoSub := 'Υπότιτλοι';
    InfoFormCopyAll := 'Αντιγράψτε όλα';
  end
end;

begin
   RegisterLocale('Greek - Ελληνικά',Activate,LANG_GREEK,GREEK_CHARSET);
end.
