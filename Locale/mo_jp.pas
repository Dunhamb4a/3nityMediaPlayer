unit mo_jp;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='オープニング ...';
      Status_Closing:='閉鎖 ...';
      Status_Playing:='遊ぶ';
      Status_Paused:='一時停止';
      Status_Stopped:='停止';
      Status_Error:='メディアを再生できません（詳細はクリック）';

    FullscreenControls:='フルスクリーンコントロールを表示する';
    OSD:='OSD モード';
      NoOSD:='OSD なし';
      DefaultOSD:='デフォルト OSD';
      TimeOSD:='時間を表示';
      FullOSD:='総計時間を表示';
    Escape:='全画面モードを終了するには、Escキーを押します。';
    Filemenu:='&ファイル';
      OpenFile:='ファイルから再生 ...';
      OpenURL:='URLから再生 ...';
        OpenURL_Caption:='URLから再生';
        OpenURL_Prompt:='どのURLを開きますか？';
      OpenDrive:='CD / DVDを再生する';
      OpenTV := 'オープンTV /キャプチャカード';
      InternetRadios:='インターネットラジオ';
      Close:='閉じる';
      Quit:='終了';
    View:='&見る';
      SizeAny:='カスタムサイズ ';
      Size50:='1/2 サイズ';
      Size100:='オリジナルサイズ';
      Size200:='X2 サイズ';
      VideoInside:='ビデオをトリミングしない';
      Fullscreen:='全画面';
      AudioEqu:='イコライザ';
      Compact:='コンパクトモード';
      TogOSD:='OSDを切り替える';
      OnTop:='常に手前に表示';
      Vis:='可視化';
      VisEnable:='視覚化を表示';
      VisDirectRender:='直接レンダリング';
    Seek:='&再生';
      Play:='再生';
      Pause:='一時停止';
      Stop:='やめる';
      Prev:='前のタイトル'^I'Ctrl Left';
      Next:='次のタイトル'^I'Ctrl Right';
      ShowPlaylist:='再生リスト ...';
      Mute:='ミュート';
      SeekF10:='10 秒早送り'^I'Right';
      SeekR10:='10 秒巻き戻す'^I'Left';
      SeekF60:='1 分早送り'^I'Up';
      SeekR60:='1 分巻き戻す'^I'Down';
      SeekF600:='10 分早送り'^I'PgUp';
      SeekR600:='10 分巻き戻す'^I'PgDn';
    Navigation:='&ナビゲーション';
      Menu := 'DVDメニュー';
      Titles := 'DVDタイトル';
      Chapters:= 'DVDチャプター';
    Extra:='&ツール';
      Audio:='音声トラック';
      Subtitle:='字幕トラック';
        NoSubtitle := '字幕なし';
      AddSubtitle := '字幕を読み込む...';

      Aspect:='アスペクト比';
        AspectAuto:='自動検知';
        Aspect43:='4:3 に強制';
        Aspect169:='16:9 に強制';
        Aspect235:='2.35:1 に強制';
      DeinterlaceAlg:='インターレース解除アルゴリズム';
        DeinterlaceBlend := 'ブレンド';
        DeinterlaceSimple := '単純な';
        DeinterlaceAdaptative := 'アダプティブ';
        DeinterlaceDoubleRate := 'ダブルレート';
      Deinterlace:='デインターレース';

      Off := 'Off';
      On:='On';
      Auto:='自動';

      Settings := 'ビデオ調整 ...';
      Options:='設定 ...';
      Language:='言語';
      StreamInfo:='ファイル情報を表示する ...';
      ShowOutput:='MPlayerの出力を表示する ...';
    Help:='&助けて';
      KeyHelp:='キーボードヘルプ ...';
      About := '約 ...';


    HelpFormCaption:='キーボードヘルプ';
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
    HelpFormClose:='閉じる';

    //log form
    LogFormCaption:='MPlayerの出力';
    LogFormClose:='閉じる';

    //about form
    AboutFormCaption := '約 3nity Media Player';
    AboutFormClose := '閉じる';
    AboutVersionMPUI := 'プログラムバージョン:';
    AboutVersionMplayer := 'MPlayer バージョン:';

    //settings form
    SettingsformCaption := 'ビデオ調整';
    Brightness := '輝度';
    Contrast := 'コントラスト';
    Hue := '色相';
    Saturation := '飽和';
    Gamma := 'ガンマ';
    SubScale := '字幕サイズ';
    ResetSetting := 'リセット';
    MResetSetting := 'リセット';

    //options form
    FullScreenMonitor := 'フルスクリーンモニター';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='設定';
    OptionsFormOK:='OK';
    OptionsFormApply:='適用する';

    OptionsFormAssociate:='交じる';
    OptionsFormSelectAll:='すべて選択';
    OptionsFormSelectNone:='無し';
    OptionsFormSave:='保存';
    OptionsFormClose:='閉じる';
    OptionsFormHelp:='助けて';
    OptionsFormParams:='追加のMPlayerパラメータ：';

    OptionsFormIndex:='必要に応じてファイルインデックスを再構築する';
    OptionsFormPriorityBoost:='高い優先順位で実行する';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='音声出力ドライバ';
    AudioOutNoDecode:='音声をデコードしない';
    AudioOutNoOut:='音を鳴らさない';
    OptionsFormAudioDev:='DirectSound出力デバイス';
    OptionsFormAudioFilterChannels := 'チャネルフィルタリングとルーティング';
    OptionsFormSoftVol:='ソフトウェア音量調整/音量ブースト';
    OptionsFormUseVolcmd := 'ボリュームコマンドラインオプションを使用する';
    OptionsFormAudioDecodeChannels := 'デコードする最大チャンネル数';
    OptionsFormAc3Comp := 'AC3圧縮レベル';
    OptionsFormUseliba52 := 'liba52ライブラリを使用';

    OptionsFormVideoOut := 'ビデオ出力ドライバ';
    VideoOutUser := 'その他';
    OptionsFormOverlay:= 'オーバーレイカラー';
    ForceEvenWidth := '幅を均等にする';
    DirectRender := '直接レンダリング';
    DoubleBuffer := 'ダブルバッファリング';
    DrawSlices := 'スライスを使って描く';

    OptionsFormVideoeq  := 'ソフトウェアビデオイコライザー';
    VideoeqOff  := 'Off';
    VideoScaler := 'ソフトウェアビデオスケーラー';
    TryScaler := 'エラー時にスケーラーを試す';

    OptionsFormPostproc:='後処理';
    PostprocOff:='Off';
    PostprocAuto:='自動';
    PostprocMax:='最高品質';

    OptionsFormGeneral := '全般';
    OptionsFormAudio := 'オーディオ';
    OptionsFormVideo := 'ビデオ';
    OptionsFormCaching := 'キャッシング';
    OptionsFormOSDSub := 'OSDと字幕';

    MediaDefault := 'デフォルト';
    MediaFixed := '固定ディスク';
    MediaRamdisk := 'RAMディスク';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := '取り外し可能な装置';
    mediaNetwork := 'ローカルネットワーク';
    MediaInternet := 'インターネット';
    MediaDvd := 'DVDの再生';

    FontPath := 'フォント';
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

    FontConfig := 'フォントスキャン';
    SubAss := 'SSA/ASS';
    SubAutoLoad := '外部字幕ファイルを読み込む';

    SubAssBorderColor := 'テキスト枠の色';
    SubAssColor := 'テキストの色';
    SubBgColor := 'テキストの背景色';

    UseDvdNav := 'DVDメニューを有効にする';
    DeinterlaceDVD := '常にインターレース解除';

    //playlist form
    PlaylistFormCaption:='再生リスト';
    PlaylistFormPlay:='再生';
    PlaylistFormAdd:='追加 ...';
    PlaylistFormMoveUp:='上に移動';
    PlaylistFormMoveDown:='下に移動';
    PlaylistFormDelete:='除去';
    PlaylistFormShuffle:='シャッフル';
    PlaylistFormLoop:='繰り返し';
    PlaylistFormSave:='保存 ...';
    PlaylistFormClose:='閉じる';

    InfoFormCaption:='クリップ情報';
    InfoFormClose:='閉じる';
    InfoFormCopy := 'コピーする';
    NoInfo:='利用可能なクリップ情報がありません';
    InfoFileFormat:='形式';
    InfoPlaybackTime:='合計時間';
    InfoTags:='クリップのメタデータ';
    InfoVideo:='映像トラック';
    InfoAudio:='音声トラック';
    InfoDecoder:='デコーダ';
    InfoCodec:='コーデック';
    InfoBitrate:='ビットレート';
    InfoVideoSize:='サイズ';
    InfoVideoFPS:='フレームレート';
    InfoVideoAspect:='アスペクト比';
    InfoAudioRate:='サンプルレート';
    InfoAudioChannels:='チャンネル';
    InfoInterlace:='フレーム';
    InfoVideoInt := 'インターレース';
    InfoVideoPro := 'プログレッシブ';
    InfoTrack := 'トラック';
    InfoFilesize := 'ファイルサイズ';
    InfoSub := '字幕';
    InfoFormCopyAll := 'すべてコピー';
  end
end;

begin
   RegisterLocale('Japanese - 日本人', Activate, LANG_JAPANESE, SHIFTJIS_CHARSET);
end.
