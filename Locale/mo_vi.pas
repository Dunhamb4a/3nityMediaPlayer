unit mo_vi;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Khai mạc ...';
      Status_Closing:='Đóng cửa ...';
      Status_Playing:='Đang chơi';
      Status_Paused:='Tạm dừng';
      Status_Stopped:='Ngừng';
      Status_Error:='Không thể phát phương tiện (Bấm để biết thêm)';

    FullscreenControls:='Điều khiển toàn màn hình';
    OSD:='Chế độ OSD';
      NoOSD:='Không có OSD';
      DefaultOSD:='OSD mặc định';
      TimeOSD:='Hiển thị thời gian';
      FullOSD:='Hiển thị tổng thời gian';
    Escape:='Nhấn Escape để thoát chế độ toàn màn hình.';
    Filemenu:='&Tập tin';
      OpenFile:='Chơi tập tin ...';
      OpenURL:='Chơi URL ...';
        OpenURL_Caption:='Chơi URL';
        OpenURL_Prompt:='URL nào bạn muốn mở?';
      OpenDrive:='Chơi CD / DVD';
      InternetRadios:='Internet radios';
      OpenTV := 'Open TV/capture card';
      Close:='Gần';
      Quit:='Lối thoát hiểm';
    View:='&Lượt xem';
      SizeAny:='Kích thước tùy chỉnh';
      Size50:='Nửa cỡ';
      Size100:='Kích thước nguyên mẫu';
      Size200:='Kích thước gấp đôi';
      VideoInside:='Không cắt video';
      Fullscreen:='Toàn màn hình';
      AudioEqu:='Bộ cân bằng';
      Compact:='Chế độ nhỏ gọn';
      TogOSD:='Chuyển đổi OSD';
      OnTop:='Luôn luôn ở trên';
      Vis:='Hình dung';
      VisEnable:='Hiển thị trực quan';
      VisDirectRender:='Kết xuất trực tiếp';
    Seek:='&Chơi';
      Play:='Chơi';
      Pause:='Tạm ngừng';
      Stop:='Dừng lại';
      Prev:='Tiêu đề trước'^I'Ctrl Left';
      Next:='Tiêu đề tiếp theo'^I'Ctrl Right';
      ShowPlaylist:='Danh sách phát ...';
      Mute:='người câm';
      SeekF10:='Chuyển tiếp 10 giây'^I'Right';
      SeekR10:='Tua lại 10 giây'^I'Left';
      SeekF60:='Chuyển tiếp 1 phút'^I'Up';
      SeekR60:='Tua lại 1 phút'^I'Down';
      SeekF600:='Chuyển tiếp 10 phút'^I'PgUp';
      SeekR600:='Tua lại 10 phút'^I'PgDn';
    Navigation:='&dẫn đường';
      Menu := 'Thực đơn';
      Titles := 'Tiêu đề';
      Chapters:= 'Chương';
    Extra:='&Tùy chọn';
      Audio:='Âm thanh';
      Subtitle:='Phụ đề';
        NoSubtitle := 'Không có phụ đề';
      AddSubtitle := 'Tải phụ đề ...';

      Aspect:='Tỷ lệ khung hình';
        AspectAuto:='Tự động phát hiện';
        Aspect43:='Lực lượng 4:3';
        Aspect169:='Lực lượng  16:9';
        Aspect235:='Lực lượng  2.35:1';
      DeinterlaceAlg:='Thuật toán khử xen kẽ';
        DeinterlaceBlend := 'trộn';
        DeinterlaceSimple := 'Đơn giản';
        DeinterlaceAdaptative := 'Thích nghi';
        DeinterlaceDoubleRate := 'Tỷ lệ gấp đôi';
      Deinterlace:='Khử nhiễu';

      Off := 'Off';
      On:='On';
      Auto:='Tự động';

      Settings := 'Điều chỉnh video ...';
      Options:='Cài đặt ...';
      Language:='Ngôn ngữ';
      StreamInfo:='Hiển thị thông tin tập tin ...';
      ShowOutput:='Hiển thị đầu ra MPlayer ...';
    Help:='&Cứu giúp';
      KeyHelp:='Bàn phím trợ giúp ...';
      About := 'Trong khoảng ...';


    HelpFormCaption:='Bàn phím trợ giúp';
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
    HelpFormClose:='Gần';

    //log form
    LogFormCaption:='Đầu ra MPlayer';
    LogFormClose:='Gần';

    //about form
    AboutFormCaption := 'Trong khoảng ';
    AboutFormClose := 'Gần';
    AboutVersionMPUI := '3nity Media Player phiên bản:';
    AboutVersionMplayer := 'MPlayer phiên bản:';

    //settings form
    SettingsformCaption := 'Điều chỉnh video ';
    Brightness := 'độ sáng';
    Contrast := 'Tương phản';
    Hue := 'Huế';
    Saturation := 'Độ bão hòa';
    Gamma := 'Gamma';
    SubScale := 'Kích thước phụ đề';
    ResetSetting := 'Cài lại';
    MResetSetting := 'Cài lại';

    //options form
    FullScreenMonitor := 'Màn hình toàn màn hình';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='Cài đặt';
    OptionsFormOK:='OK';
    OptionsFormApply:='Ứng dụng';

    OptionsFormAssociate:='Tiết kiệm';
    OptionsFormSelectAll:='Chọn tất cả';
    OptionsFormSelectNone:='không ai';
    OptionsFormSave:='Tiết kiệm';
    OptionsFormClose:='Gần';
    OptionsFormHelp:='Cứu giúp';
    OptionsFormParams:='Các thông số MPlayer bổ sung:';

    OptionsFormIndex:='Xây dựng lại chỉ mục tập tin nếu cần thiết';
    OptionsFormPriorityBoost:='Chạy với mức độ ưu tiên cao hơn';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='Trình điều khiển đầu ra âm thanh';
    AudioOutNoDecode:='(không giải mã âm thanh)';
    AudioOutNoOut:='(không chơi âm thanh)';
    OptionsFormAudioDev:='Thiết bị đầu ra DirectSound';
    OptionsFormAudioFilterChannels := 'Lọc và định tuyến kênh';
    OptionsFormSoftVol:='Điều khiển âm lượng phần mềm / Tăng âm lượng';
    OptionsFormUseVolcmd := 'Sử dụng tùy chọn dòng lệnh âm lượng';
    OptionsFormAudioDecodeChannels := 'Tối đa con số. của các kênh để giải mã';
    OptionsFormAc3Comp := 'Mức nén AC3';
    OptionsFormUseliba52 := 'Sử dụng thư viện liba52';

    OptionsFormVideoOut := 'Trình điều khiển đầu ra video';
    VideoOutUser := 'Khác:';
    OptionsFormOverlay:= 'Lớp phủ màu';
    ForceEvenWidth := 'Buộc chiều rộng';
    DirectRender := 'Kết xuất trực tiếp';
    DoubleBuffer := 'Bộ đệm đôi';
    DrawSlices := 'Vẽ bằng lát';

    OptionsFormVideoeq  := 'Bộ cân bằng video phần mềm';
    VideoeqOff  := 'Off';
    VideoScaler := 'Phần mềm mở rộng video';
    TryScaler := 'Thử lỗi scaler';

    OptionsFormPostproc:='Hậu xử lý';
    PostprocOff:='Off';
    PostprocAuto:='Tự động';
    PostprocMax:='Chất lượng tối đa';

    OptionsFormGeneral := 'Chung';
    OptionsFormAudio := 'Âm thanh';
    OptionsFormVideo := 'Video';
    OptionsFormCaching := 'Bộ nhớ đệm';
    OptionsFormOSDSub := 'OSD và phụ đề';

    MediaDefault := 'Mặc định';
    MediaFixed := 'Đĩa cố định';
    MediaRamdisk := 'Đĩa RAM';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Thiết bị tháo rời';
    mediaNetwork := 'Mạng nội bộ';
    MediaInternet := 'Internet';
    MediaDvd := 'Phát lại DVD';

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

    FontConfig := 'Quét phông chữ';
    SubAss := 'Sử dụng SSA / ASS';
    SubAutoLoad := 'Tải tập tin phụ đề bên ngoài';

    SubAssBorderColor := 'Màu viền văn bản';
    SubAssColor := 'Văn bản màu';
    SubBgColor := 'Màu nền văn bản';

    UseDvdNav := 'Bật menu DVD ';
    DeinterlaceDVD := 'Luôn luôn xen kẽ';

    //playlist form
    PlaylistFormCaption:='Danh sách phát';
    PlaylistFormPlay:='Chơi';
    PlaylistFormAdd:='Thêm vào ...';
    PlaylistFormMoveUp:='Đi lên';
    PlaylistFormMoveDown:='Đi xuống';
    PlaylistFormDelete:='Tẩy';
    PlaylistFormShuffle:='Xáo trộn';
    PlaylistFormLoop:='Nói lại';
    PlaylistFormSave:='Tiết kiệm ...';
    PlaylistFormClose:='Gần';

    InfoFormCaption:='Thông tin tập tin';
    InfoFormClose:='Gần';
    InfoFormCopy := 'Sao chép';
    NoInfo:='Không có thông tin tập tin có sẵn tại thời điểm này.';
    InfoFileFormat:='định dạng';
    InfoPlaybackTime:='Thời lượng';
    InfoTags:='Clip siêu dữ liệu';
    InfoVideo:='Video';
    InfoAudio:='Âm thanh';
    InfoDecoder:='Bộ giải mã';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='Kích thước';
    InfoVideoFPS:='Tỷ lệ khung hình';
    InfoVideoAspect:='Tỷ lệ khung hình';
    InfoAudioRate:='Tỷ lệ mẫu';
    InfoAudioChannels:='Kênh truyền hình';
    InfoInterlace:='Khung';
    InfoVideoInt := 'Xen kẽ';
    InfoVideoPro := 'Cấp tiến';
    InfoTrack := 'Track';
    InfoFilesize := 'Kích thước tập tin';
    InfoSub := 'Phụ đề';
    InfoFormCopyAll := 'Sao chép tất cả';
  end
end;

begin
   RegisterLocale('Vietnamese - Tiếng Việt',Activate,LANG_VIETNAMESE,VIETNAMESE_CHARSET);
end.
