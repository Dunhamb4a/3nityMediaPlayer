unit mo_tu;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='açılış ...';					
      Status_Closing:='Kapanış ...';
      Status_Playing:='oynama';
      Status_Paused:='Duraklat';
      Status_Stopped:='Durduruldu';
      Status_Error:='Medya yürütülemiyor (Daha fazla bilgi için tıklayın)';

    FullscreenControls:='Tam ekran kontrolleri';
    OSD:='OSD modu';
      NoOSD:='OSD yok';
      DefaultOSD:='Varsayılan OSD';
      TimeOSD:='Gösteri zamanı';
      FullOSD:='Toplam süreyi göster';
    Escape:='Tam ekran modundan çıkmak için Escape düğmesine basın.';
    Filemenu:='&Dosya';
      OpenFile:='Dosyayı oynat ...';
      OpenURL:='URL''yi oynat ...';
        OpenURL_Caption:='URL''yi oynat';
        OpenURL_Prompt:='Hangi URL''yi oynamak istersiniz?';
      OpenDrive:='CD / DVD Oynat';
      InternetRadios:='internet radyosu';
      OpenTV := 'Open TV/capture card';
      Close:='Kapat';
      Quit:='çıkmak';
    View:='&Görünüm';
      SizeAny:='Özel boyut';
      Size50:='Yarım boy';
      Size100:='Orijinal boyut';
      Size200:='İki katı';
      VideoInside:='Videoyu kırpma';
      Fullscreen:='Tam ekran';
      AudioEqu:='Ekolayzer';
      Compact:='Kompakt mod';
      TogOSD:='OSD''yi değiştir';
      OnTop:='Her zaman yukarıda';
      Vis:='görüntüleme';
      VisEnable:='Görselleştirmeyi göster';
      VisDirectRender:='Doğrudan işleme';
    Seek:='&Oyun';
      Play:='Oyun';
      Pause:='Duraklat';
      Stop:='durdurmak';
      Prev:='Önceki başlık'^I'Ctrl Left';
      Next:='Sonraki başlık'^I'Ctrl Right';
      ShowPlaylist:='Oynatma Listesi ...';
      Mute:='Sessiz';
      SeekF10:='10 saniye ileri'^I'Right';
      SeekR10:='10 saniye geri sar'^I'Left';
      SeekF60:='1 dakika ileri'^I'Up';
      SeekR60:='1 dakika geri sar'^I'Down';
      SeekF600:='10 dakika ileri'^I'PgUp';
      SeekR600:='10 dakika geri sar'^I'PgDn';
    Navigation:='&navigasyon';
      Menu := 'Menü';
      Titles := 'Başlıklar';
      Chapters:= 'Bölümler';
    Extra:='&Seçenekler';
      Audio:='Müzik parçası';
      Subtitle:='Altyazı parça';
        NoSubtitle := 'Altyazı yok';
      AddSubtitle := 'Altyazıları yükle...';

      Aspect:='Boy oranı';
        AspectAuto:='Otomatik tespit';
        Aspect43:='Kuvvet 4:3';
        Aspect169:='Kuvvet 16:9';
        Aspect235:='Kuvvet 2.35:1';
      DeinterlaceAlg:='Deinterlace algoritması';
        DeinterlaceBlend := 'Harman';
        DeinterlaceSimple := 'Basit';
        DeinterlaceAdaptative := 'Adaptif';
        DeinterlaceDoubleRate := 'Çift oranı';
      Deinterlace:='Çözücü';

      Off := 'Off';
      On:='On';
      Auto:='Otomatik';

      Settings := 'Video ayarları ...';
      Options:='Ayarlar ...';
      Language:='Dil';
      StreamInfo:='Dosya bilgilerini göster ...';
      ShowOutput:='MPlayer çıktısını göster ...';
    Help:='&yardım et';
      KeyHelp:='Klavye yardımı ...';
      About := 'hakkında ...';


    HelpFormCaption:='Klavye yardımı';
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
    HelpFormClose:='Kapat';

    //log form
    LogFormCaption:='MPlayer çıkışı';
    LogFormClose:='Kapat';

    //about form
    AboutFormCaption := 'hakkında ';
    AboutFormClose := 'Kapat';
    AboutVersionMPUI := '3nity Media Player versiyon:';
    AboutVersionMplayer := 'MPlayer versiyon:';

    //settings form
    SettingsformCaption := 'Video ayarları';
    Brightness := 'Parlaklık';
    Contrast := 'Kontrast';
    Hue := 'renk';
    Saturation := 'Doyma';
    Gamma := 'Gama';
    SubScale := 'Altyazı boyutu';
    ResetSetting := 'Sıfıra sıfırla';
    MResetSetting := 'Sıfıra sıfırla';

    //options form
    FullScreenMonitor := 'Tam ekran monitör';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Ayarlar';
    OptionsFormOK:='OK';
    OptionsFormApply:='Uygulamak';

    OptionsFormAssociate:='Kayıt etmek';
    OptionsFormSelectAll:='Hepsini seç';
    OptionsFormSelectNone:='Yok';
    OptionsFormSave:='Kayıt etmek';
    OptionsFormClose:='Kapat';
    OptionsFormHelp:='yardım et';
    OptionsFormParams:='Ek MPlayer parametreleri:';

    OptionsFormIndex:='Gerekirse dosya dizinini yeniden oluştur';
    OptionsFormPriorityBoost:='Daha yüksek önceliğe sahip koş';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Ses çıkışı sürücüsü';
    AudioOutNoDecode:='(sesin kodunu çözme)';
    AudioOutNoOut:='(ses çalma)';
    OptionsFormAudioDev:='DirectSound çıkış cihazı';
    OptionsFormAudioFilterChannels := 'Kanal filtreleme ve yönlendirme';
    OptionsFormSoftVol:='Yazılım ses kontrolü / Ses seviyesi yükseltme';
    OptionsFormUseVolcmd := 'Birim komut satırı seçeneğini kullan';
    OptionsFormAudioDecodeChannels := 'Maks. numara. çözülecek kanal sayısı';
    OptionsFormAc3Comp := 'AC3 sıkıştırma seviyesi';
    OptionsFormUseliba52 := 'Liba52 kütüphanesini kullan';

    OptionsFormVideoOut := 'Video çıkış sürücüsü';
    VideoOutUser := 'Diğer:';
    OptionsFormOverlay:= 'Bindirme rengi';
    ForceEvenWidth := 'Genişliği eşitle';
    DirectRender := 'Doğrudan işleme';
    DoubleBuffer := 'Çift tamponlama';
    DrawSlices := 'Dilimleri kullanarak çizin';

    OptionsFormVideoeq  := 'Yazılım video ekolayzer';
    VideoeqOff  := 'Off';
    VideoScaler := 'Yazılım video ölçekleyici';
    TryScaler := 'Hatalı ölçekleyici deneyin';

    OptionsFormPostproc:='Rötuş';
    PostprocOff:='Off';
    PostprocAuto:='Otomatik';
    PostprocMax:='Maksimum kalite';

    OptionsFormGeneral := 'Genel';
    OptionsFormAudio := 'Ses';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Caching';
    OptionsFormOSDSub := 'OSD ve altyazılar';

    MediaDefault := 'Varsayılan';
    MediaFixed := 'Sabit disk';
    MediaRamdisk := 'RAM disk';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Çıkarılabilir Aygıt';
    mediaNetwork := 'Yerel ağ';
    MediaInternet := 'Internet';
    MediaDvd := 'DVD oynatma';

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

    FontConfig := 'Yazı tipi taraması';
    SubAss := 'SSA / ASS kullan';
    SubAutoLoad := 'Harici altyazı dosyalarını yükle';

    SubAssBorderColor := 'Metin kenarlığı rengi';
    SubAssColor := 'Metin rengi';
    SubBgColor := 'Metin arka plan rengi';

    UseDvdNav := 'DVD menülerini etkinleştir ';
    DeinterlaceDVD := 'Her zaman deinterlace';

    //playlist form
    PlaylistFormCaption:='Oynatma Listesi';
    PlaylistFormPlay:='Oyun';
    PlaylistFormAdd:='Eklemek ...';
    PlaylistFormMoveUp:='Yukarı taşı';
    PlaylistFormMoveDown:='Aşağı inmek';
    PlaylistFormDelete:='Kaldır';
    PlaylistFormShuffle:='Karıştır';
    PlaylistFormLoop:='Tekrar et';
    PlaylistFormSave:='Kayıt etmek ...';
    PlaylistFormClose:='Kapat';

    InfoFormCaption:='Dosya bilgisi';
    InfoFormClose:='Kapat';
    InfoFormCopy := 'kopya';
    NoInfo:='Şu anda hiçbir dosya bilgisi mevcut değil.';
    InfoFileFormat:='Biçim';
    InfoPlaybackTime:='süre';
    InfoTags:='Meta';
    InfoVideo:='Video ';
    InfoAudio:='Ses ';
    InfoDecoder:='şifre çözücü';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='boyutlar';
    InfoVideoFPS:='Kare hızı';
    InfoVideoAspect:='Boy oranı';
    InfoAudioRate:='Aynı oran';
    InfoAudioChannels:='Kanallar';
    InfoInterlace:='çerçeve';
    InfoVideoInt := 'Interlaced';
    InfoVideoPro := 'ilerici';
    InfoTrack := 'Track';
    InfoFilesize := 'Dosya boyutu';
    InfoSub := 'Altyazı';
    InfoFormCopyAll := 'Hepsini kopyala';
  end
end;

begin
    RegisterLocale('Turkish - Türk',Activate,LANG_TURKISH,TURKISH_CHARSET);
end.
