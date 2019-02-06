unit mo_kr;

interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='열리는 ...';
      Status_Closing:='폐쇄 ...';
      Status_Playing:='연주 중';
      Status_Paused:='일시 중지됨';
      Status_Stopped:='중지됨';
      Status_Error:='미디어를 재생할 수 없습니다 (자세한 정보를 보려면 클릭하십시오).';

    FullscreenControls:='전체 화면 컨트롤';
    OSD:='OSD 모드';
      NoOSD:='OSD 없음';
      DefaultOSD:='기본 OSD';
      TimeOSD:='시간 표시';
      FullOSD:='총 시간 표시';
    Escape:='전체 화면 모드를 종료하려면 Esc 키를 누릅니다.';
    Filemenu:='&파일';
      OpenFile:='파일 재생 ...';
      OpenURL:='재생 URL ...';
        OpenURL_Caption:='재생 URL';
        OpenURL_Prompt:='어떤 URL을 열시겠습니까?';
      OpenDrive:='CD / DVD 재생';
      InternetRadios:='인터넷 라디오';
      OpenTV := 'Open TV/capture card';
      Close:='닫기';
      Quit:='떠나다';
    View:='&전망';
      SizeAny:='사용자 정의 크기';
      Size50:='절반 크기';
      Size100:='원래 크기';
      Size200:='더블 사이즈';
      VideoInside:='비디오를 자르지 마라.';
      Fullscreen:='전체 화면';
      AudioEqu:='평형 장치';
      Compact:='압축 모드';
      TogOSD:='OSD 토글';
      OnTop:='항상 위에';
      Vis:='심상';
      VisEnable:='시각화 표시';
      VisDirectRender:='직접 렌더링';
    Seek:='&놀이';
      Play:='놀이';
      Pause:='중지';
      Stop:='중지';
      Prev:='이전 제목'^I'Ctrl Left';
      Next:='다음 제목'^I'Ctrl Right';
      ShowPlaylist:='재생 목록 ...';
      Mute:='묵자';
      SeekF10:='앞으로 10 초'^I'Right';
      SeekR10:='되감기 10 초'^I'Left';
      SeekF60:='1 분 앞으로'^I'Up';
      SeekR60:='되감기 1 분'^I'Down';
      SeekF600:='앞으로 10 분'^I'PgUp';
      SeekR600:='되감기 10 분'^I'PgDn';
    Navigation:='&항해';
      Menu := '메뉴';
      Titles := '제목';
      Chapters:= '챕터';
    Extra:='&옵션';
      Audio:='오디오 트랙';
      Subtitle:='자막 트랙';
        NoSubtitle := '부제 없음';
      AddSubtitle := '자막로드...';

      Aspect:='종횡비';
        AspectAuto:='자동 감지';
        Aspect43:='포스 4:3';
        Aspect169:='포스 16:9';
        Aspect235:='포스 2.35:1';
      DeinterlaceAlg:='디인터레이스 알고리즘';
        DeinterlaceBlend := '혼합';
        DeinterlaceSimple := '단순한';
        DeinterlaceAdaptative := '적응 형';
        DeinterlaceDoubleRate := '더블 레이트';
      Deinterlace:='디인터레이스';

      Off := 'Off';
      On:='On';
      Auto:='오토매틱';

      Settings := '비디오 조정 ...';
      Options:='설정 ...';
      Language:='언어';
      StreamInfo:='파일 정보 표시 ...';
      ShowOutput:='MPlayer 출력보기 ...';
    Help:='&도움';
      KeyHelp:='키보드 도움말 ...';
      About := '약 ...';


    HelpFormCaption:='키보드 도움말';
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
    HelpFormClose:='닫기';

    //log form
    LogFormCaption:='MPlayer 출력';
    LogFormClose:='닫기';

    //about form
    AboutFormCaption := '약 ';
    AboutFormClose := '닫기';
    AboutVersionMPUI := '3nity Media Player 번역:';
    AboutVersionMplayer := 'MPlayer 번역:';

    //settings form
    SettingsformCaption := '비디오 조정';
    Brightness := '명도';
    Contrast := '대조';
    Hue := '색조';
    Saturation := '포화';
    Gamma := '감마';
    SubScale := '자막 크기';
    ResetSetting := '다시 놓기';
    MResetSetting := '다시 놓기';

    //options form
    FullScreenMonitor := '전체 화면 모니터';
    AutoLocale:='(Auto-select)';

    OptionsFormCaption:='설정';
    OptionsFormOK:='OK';
    OptionsFormApply:='대다';

    OptionsFormAssociate:='구하다';
    OptionsFormSelectAll:='모두 선택';
    OptionsFormSelectNone:='없음';
    OptionsFormSave:='구하다';
    OptionsFormClose:='닫기';
    OptionsFormHelp:='도움';
    OptionsFormParams:='추가 MPlayer 매개 변수 :';

    OptionsFormIndex:='필요한 경우 파일 색인 다시 작성';
    OptionsFormPriorityBoost:='높은 우선 순위로 실행';

    Autosync := 'Autosync factor';
    AVsyncperframe := 'A-V sync per frame (us.)';

    OptionsFormAudioOut:='사운드 출력 드라이버';
    AudioOutNoDecode:='(소리를 디코딩하지 마라.)';
    AudioOutNoOut:='(소리를 내지 마라.)';
    OptionsFormAudioDev:='DirectSound 출력 장치';
    OptionsFormAudioFilterChannels := '채널 필터링 및 라우팅';
    OptionsFormSoftVol:='소프트웨어 볼륨 컨트롤 / 볼륨 부스트';
    OptionsFormUseVolcmd := '볼륨 명령 행 옵션 사용';
    OptionsFormAudioDecodeChannels := '맥스. 번호. 디코딩 할 채널 수';
    OptionsFormAc3Comp := 'AC3 압축 수준';
    OptionsFormUseliba52 := 'liba52 라이브러리 사용';

    OptionsFormVideoOut := '비디오 출력 드라이버';
    VideoOutUser := '다른:';
    OptionsFormOverlay:= '오버레이 색상';
    ForceEvenWidth := '강제 너비';
    DirectRender := '직접 렌더링';
    DoubleBuffer := '더블 버퍼링';
    DrawSlices := '분할 영역을 사용하여 그리기';

    OptionsFormVideoeq  := '소프트웨어 비디오 이퀄라이저';
    VideoeqOff  := 'Off';
    VideoScaler := '소프트웨어 비디오 스케일러';
    TryScaler := '오류 발생시 스케일러 사용';

    OptionsFormPostproc:='후 처리';
    PostprocOff:='Off';
    PostprocAuto:='오토매틱';
    PostprocMax:='최대 품질';

    OptionsFormGeneral := '일반';
    OptionsFormAudio := '오디오';
    OptionsFormVideo := '비디오';
    OptionsFormCaching := '캐싱';
    OptionsFormOSDSub := 'OSD 및 자막';

    MediaDefault := '태만';
    MediaFixed := '고정 디스크';
    MediaRamdisk := 'RAM 디스크';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := '이동식 장치';
    mediaNetwork := '지역 네트워크';
    MediaInternet := '인터넷';
    MediaDvd := 'DVD 재생';

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

    FontConfig := '글꼴 스캐닝';
    SubAss := 'SSA / ASS 사용';
    SubAutoLoad := '외부 자막 파일로드';

    SubAssBorderColor := '텍스트 테두리 색';
    SubAssColor := '텍스트 색상';
    SubBgColor := '텍스트 배경색';

    UseDvdNav := 'DVD 메뉴 사용 ';
    DeinterlaceDVD := '항상 인터레이스 해제';

    //playlist form
    PlaylistFormCaption:='재생 목록';
    PlaylistFormPlay:='놀이';
    PlaylistFormAdd:='더하다 ...';
    PlaylistFormMoveUp:='이동';
    PlaylistFormMoveDown:='아래로 이동';
    PlaylistFormDelete:='풀다';
    PlaylistFormShuffle:='혼합';
    PlaylistFormLoop:='반복';
    PlaylistFormSave:='구하다 ...';
    PlaylistFormClose:='닫기';

    InfoFormCaption:='파일 정보';
    InfoFormClose:='닫기';
    InfoFormCopy := '부';
    NoInfo:='현재 사용할 수있는 파일 정보가 없습니다.';
    InfoFileFormat:='체재';
    InfoPlaybackTime:='지속';
    InfoTags:='메타 데이터';
    InfoVideo:='비디오 트랙';
    InfoAudio:='오디오 트랙';
    InfoDecoder:='디코더';
    InfoCodec:='Codec';
    InfoBitrate:='Bitrate';
    InfoVideoSize:='치수';
    InfoVideoFPS:='프레임 속도';
    InfoVideoAspect:='종횡비';
    InfoAudioRate:='샘플 속도';
    InfoAudioChannels:='채널';
    InfoInterlace:='Frame';
    InfoVideoInt := '인터레이스 된';
    InfoVideoPro := '프로그레시브';
    InfoTrack := '선로';
    InfoFilesize := '파일 크기';
    InfoSub := '자막';
    InfoFormCopyAll := '모두 복사';
  end
end;

begin
   RegisterLocale('Korean',Activate,LANG_KOREAN,HANGEUL_CHARSET);
end.
