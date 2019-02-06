unit mo_cn;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='開盤 ...';
      Status_Closing:='閉幕 ...';
      Status_Playing:='播放';
      Status_Paused:='已暫停';
      Status_Stopped:='停止';
      Status_Error:='無法播放媒體（點擊了解更多信息）';

    FullscreenControls:='全屏控制';
    OSD:='OSD模式';
      NoOSD:='沒有OSD';
      DefaultOSD:='默認OSD';
      TimeOSD:='開演時間';
      FullOSD:='顯示總時間';
    Escape:='按Escape退出全屏模式。';
    Filemenu:='&文件';
      OpenFile:='播放文件 ...';
      OpenURL:='播放網址 ...';
        OpenURL_Caption:='播放網址';
        OpenURL_Prompt:='您要打開哪個網址？';
      OpenDrive:='播放CD / DVD';
      InternetRadios:='互聯網收音機';
      OpenTV := 'Open TV/capture card';
      Close:='關';
      Quit:='出口';
    View:='&視圖';
      SizeAny:='自定義大小';
      Size50:='一半大小';
      Size100:='原始尺寸';
      Size200:='雙倍大小';
      VideoInside:='不要裁剪視頻';
      Fullscreen:='全屏';
      AudioEqu:='均衡器';
      Compact:='緊湊模式';
      TogOSD:='切換OSD';
      OnTop:='永遠在上面';
      Vis:='可視化';
      VisEnable:='顯示可視化';
      VisDirectRender:='直接渲染';
    Seek:='&玩';
      Play:='玩';
      Pause:='暫停';
      Stop:='停止';
      Prev:='以前的標題'^I'Ctrl Left';
      Next:='下一個標題'^I'Ctrl Right';
      ShowPlaylist:='播放列表 ...';
      Mute:='靜音';
      SeekF10:='前進10秒'^I'Right';
      SeekR10:='倒帶10秒'^I'Left';
      SeekF60:='前進1分鐘'^I'Up';
      SeekR60:='倒帶1分鐘'^I'Down';
      SeekF600:='前進10分鐘'^I'PgUp';
      SeekR600:='倒帶10分鐘'^I'PgDn';
    Navigation:='&導航';
      Menu := '菜單';
      Titles := '標題';
      Chapters:= '章';
    Extra:='&選項';
      Audio:='音軌';
      Subtitle:='字幕跟踪';
        NoSubtitle := '沒有字幕';
      AddSubtitle := '加載字幕...';

      Aspect:='寬高比';
        AspectAuto:='自動偵測';
        Aspect43:='部隊 4:3';
        Aspect169:='部隊 16:9';
        Aspect235:='部隊 2.35:1';
      DeinterlaceAlg:='去隔行算法';
        DeinterlaceBlend := '混合';
        DeinterlaceSimple := '簡單';
        DeinterlaceAdaptative := '自適應';
        DeinterlaceDoubleRate := '雙倍房價';
      Deinterlace:='隔行掃描';

      Off := 'Off';
      On:='On';
      Auto:='自動';

      Settings := '視頻調整 ...';
      Options:='設置 ...';
      Language:='語言';
      StreamInfo:='顯示文件信息 ...';
      ShowOutput:='顯示MPlayer輸出 ...';
    Help:='&救命';
      KeyHelp:='鍵盤幫助 ...';
      About := '關於 ...';


    HelpFormCaption:='鍵盤幫助';
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
    HelpFormClose:='關';

    //log form
    LogFormCaption:='MPlayer輸出';
    LogFormClose:='關';

    //about form
    AboutFormCaption := '關於';
    AboutFormClose := '關';
    AboutVersionMPUI := '3nity Media Player 版本:';
    AboutVersionMplayer := 'MPlayer版本:';

    //settings form
    SettingsformCaption := '視頻調整';
    Brightness := '亮度';
    Contrast := '對比';
    Hue := '色調';
    Saturation := '飽和';
    Gamma := '伽瑪';
    SubScale := '字幕大小';
    ResetSetting := '重啟';
    MResetSetting := '重啟';

    //options form
    FullScreenMonitor := '全屏顯示器';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='設置';
    OptionsFormOK:='OK';
    OptionsFormApply:='申請';

    OptionsFormAssociate:='保存';
    OptionsFormSelectAll:='全選';
    OptionsFormSelectNone:='沒有';
    OptionsFormSave:='保存';
    OptionsFormClose:='關';
    OptionsFormHelp:='救命';
    OptionsFormParams:='其他MPlayer參數：';

    OptionsFormIndex:='必要時重建文件索引';
    OptionsFormPriorityBoost:='以更高的優先級運行';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='聲音輸出驅動';
    AudioOutNoDecode:='(不解碼聲音)';
    AudioOutNoOut:='(不要播放聲音)';
    OptionsFormAudioDev:='DirectSound輸出設備';
    OptionsFormAudioFilterChannels := '通道過濾和路由';
    OptionsFormSoftVol:='軟件音量控制/音量提升';
    OptionsFormUseVolcmd := '使用volume命令行選項';
    OptionsFormAudioDecodeChannels := '要解碼的最大通道數';
    OptionsFormAc3Comp := 'AC3壓縮級別';
    OptionsFormUseliba52 := '使用liba52庫';

    OptionsFormVideoOut := '視頻輸出驅動';
    VideoOutUser := '其他:';
    OptionsFormOverlay:= '疊加顏色';
    ForceEvenWidth := '強制均勻寬度';
    DirectRender := '直接渲染';
    DoubleBuffer := '雙緩衝';
    DrawSlices := '使用切片繪製';

    OptionsFormVideoeq  := '軟件視頻均衡器';
    VideoeqOff  := 'Off';
    VideoScaler := '軟件視頻縮放器';
    TryScaler := '嘗試使用scaler出錯';

    OptionsFormPostproc:='後期處理';
    PostprocOff:='Off';
    PostprocAuto:='自動';
    PostprocMax:='最高品質';

    OptionsFormGeneral := '一般';
    OptionsFormAudio := '音頻';
    OptionsFormVideo := '視頻';
    OptionsFormCaching := '高速緩存';
    OptionsFormOSDSub := 'OSD和字幕';

    MediaDefault := '默認';
    MediaFixed := '固定磁盤';
    MediaRamdisk := 'RAM磁盤';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := '可移除設備';
    mediaNetwork := '本地網絡';
    MediaInternet := '互聯網';
    MediaDvd := 'DVD播放';

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

    FontConfig := '字體掃描';
    SubAss := '使用SSA / ASS';
    SubAutoLoad := '加載外部字幕文件';

    SubAssBorderColor := '文字邊框顏色';
    SubAssColor := '文字顏色';
    SubBgColor := '文本背景顏色';

    UseDvdNav := '啟用DVD菜單 ';
    DeinterlaceDVD := '總是去隔行';

    //playlist form
    PlaylistFormCaption:='播放列表';
    PlaylistFormPlay:='玩';
    PlaylistFormAdd:='加 ...';
    PlaylistFormMoveUp:='提升';
    PlaylistFormMoveDown:='向下移動';
    PlaylistFormDelete:='去掉';
    PlaylistFormShuffle:='拖曳';
    PlaylistFormLoop:='重複';
    PlaylistFormSave:='保存 ...';
    PlaylistFormClose:='關';

    InfoFormCaption:='文件信息';
    InfoFormClose:='關';
    InfoFormCopy := '複製';
    NoInfo:='目前沒有可用的文件信息。';
    InfoFileFormat:='格式';
    InfoPlaybackTime:='持續時間';
    InfoTags:='剪輯元數據';
    InfoVideo:='視頻軌道';
    InfoAudio:='音軌';
    InfoDecoder:='解碼器';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='外形尺寸';
    InfoVideoFPS:='幀率';
    InfoVideoAspect:='寬高比';
    InfoAudioRate:='採樣率';
    InfoAudioChannels:='通道';
    InfoInterlace:='幀';
    InfoVideoInt := '隔行';
    InfoVideoPro := '進步';
    InfoTrack := '跟踪';
    InfoFilesize := '文件大小';
    InfoSub := '字幕';
    InfoFormCopyAll := 'Copy All';
  end
end;

begin
  RegisterLocale('Chinese - 中文',Activate,LANG_CHINESE,GB2312_CHARSET);
end.
