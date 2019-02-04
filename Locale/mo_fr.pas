﻿{

	3nity Media Player, an MPlayer frontend for Windows

	Copyright (C) 2010-2019 Nicolas DEOUX  < nicolas.deoux@gmail.com >
									<http://3nitysoftwares.com>

    Original source code 2008-2010 Visenri  <http://sourceforge.net/projects/mpui-ve/>
    Original source code (2005) by Martin J. Fiedler <martin.fiedler@gmx.net>>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}
{   to compile:

    This code can be compiled using Embarcadero Delphi XE2 -> to Delphi 10.3 Rio( here using XE7  )
    You will need to install Alphaskin and OmniThreadLibrary components.
    For special questions or if you want to hire a delphi developer you can contact me:  nicolas.deoux@gmail.com
}

unit mo_fr;
interface
implementation
uses Windows,Locale;

procedure Activate;
begin
  with LOCstr do begin
    Title:='3nity Media Player';
      Status_Opening:='Ouverture ...';
      Status_Closing:='Fermeture ...';
      Status_Playing:='Joue';
      Status_Paused:='Suspendu';
      Status_Stopped:='Arrêté';
      Status_Error:='Incapable de jouer le média (Cliquer pour plus d''information)';

    FullscreenControls:='Controls plein écran';
    OSD:='Choisir le mode OSD';
      NoOSD:='Aucun OSD';
      DefaultOSD:='OSD par défaut';
      TimeOSD:='Afficher le temps';
      FullOSD:='Afficher le temps total';
    Escape:='Appuyez sur Echap pour quitter le mode plein écran.';
    Filemenu:='&Fichier';
      OpenFile:='Jouer un fichier ...';
      OpenURL:='Jouer un URL ...';
        OpenURL_Caption:='Jouer un URL';
        OpenURL_Prompt:='Quel URL voulez-vous jouer?';
      OpenDrive:='Jouer un CD/DVD';
      OpenTV := 'Jouer TV/carte de capture';
      InternetRadios:='Radios sur Internet';
      Close:='Fermer';
      Quit:='Quitter';
    View:='&Affichage';
      SizeAny:='Dimension sur mesure';
      Size50:='Demi taille';
      Size100:='Taille originale';
      Size200:='Double taille';
      VideoInside:='Ne couper pas le video';
      Fullscreen:='Plein écran';
      AudioEqu:='Egaliseur audio';
      Compact:=   'Mode compact';
      TogOSD:=    'Cycler les modes OSD';
      OnTop:=     'Toujours sur le dessus';
      Vis:='Visualisation';
      VisEnable:='Afficher visualisation';
      VisDirectRender:='Renderization directe';
    Seek:='&Visualisation';
      Play:='Jouer';
      Pause:='Suspendre';
      Stop:='Stop';
      Prev:='Titre précédent'^I'Ctrl Gauche';
      Next:='Titre suivant'^I'Ctrl Droite';
      ShowPlaylist:='Liste d''écoute ...';
      Mute:='Muet';
      SeekF10:='Avancer 10 secondes'^I'Droite';
      SeekR10:='Reculer 10 secondes'^I'Gauche';
      SeekF60:='Avancer 1 minute'^I'Haut';
      SeekR60:='Reculer 1 minute'^I'Bas';
      SeekF600:='Avancer 10 minutes'^I'PgHaut';
      SeekR600:='Reculer 10 minutes'^I'PgBas';
    Navigation:='&Navigation';
      Menu := 'Menu';
      Titles := 'Titres';
      Chapters:= 'Chapitres';
    Extra:='&Préférences';
      Audio:='Audio';
      Subtitle:='Sous-titres';
        NoSubtitle := 'Pas de sous-titres';
      AddSubtitle := 'Ajouter sous-titres...';

      Aspect:='Rapport largeur/hauteur';
        AspectAuto:='Auto-détection';
        Aspect43:='Forcer 4:3';
        Aspect169:='Forcer 16:9';
        Aspect235:='Forcer 2.35:1';
      DeinterlaceAlg:='Algorithme désentrelacement';
        DeinterlaceBlend := 'Inter-trame';
        DeinterlaceSimple := 'Simple';
        DeinterlaceAdaptative := 'Adaptatif';
        DeinterlaceDoubleRate := 'Double fréquence';
      Deinterlace:='Dé-entrelacer';

      Off := 'Débranché';
      On:='Déclenché';
      Auto:='Automatique';

      Settings := 'Réglages ...';
      Options:='Préférences ...';
      Language:='Langue';
      StreamInfo:='Information sur fichier ...';
      ShowOutput:='Afficher la sortie de MPlayer';
    Help:='A&ide';
      KeyHelp:='Aide du clavier ...';
      About:='À propos ...';
      
      
  HelpFormCaption:='Aide du clavier';
  HelpFormHelpText:=
'Clefs de navigation:'^M^J+
'Espace'^I'Jouer/Suspendre'^M^J+
'Droite'^I'Avancer 10 secondes'^M^J+
'Gauche'^I'Reculer 10 secondes'^M^J+
'Haut'^I'Avancer 1 minute'^M^J+
'Bas'^I'Reculer 1 minute'^M^J+
'PgHaut'^I'Avancer 10 minutes'^M^J+
'PgBas'^I'Reculer 10 minutes'^M^J+
^M+^J+
'Autre clefs:'^M^J+
'O'^I'Cycler les modes OSD'^M^J+
'F'^I'Basculer en plein écran'^M^J+
'Q'^I'Quitter immediatement'^M^J+
'9/0'^I'Ajuster le volume'^M^J+
'-/+'^I'Ajuster la sync audio/video'^M^J+
'1/2'^I'Ajuster la luminosité'^M^J+
'3/4'^I'Ajuster le contraste'^M^J+
'5/6'^I'Ajuster la hue'^M^J+
'7/8'^I'Ajuster la saturation'^M^J+
'M'^I'Muet'^M^J+
'//*'^I'Ajuster le volume'^M^J+
'D'^I'frame_drop'^M^J+
'C'^I'Mode Compact'^M^J+
'T'^I'Toujours au premier plan'^M^J+
//'S'^I'Faire une Capture photo'^M^J+
'L'^I'Afficher Playlist'^M^J+
'RETURN'^I'Play'^M^J+
'P'^I'Pause'^M^J+
'TAB'^I'Controles en Plein Ecran'^M^J+
'NUMPAD9'^I'Zoom +'^M^J+
'NUMPAD5'^I'Zoom Reset'^M^J+
'NUMPAD1'^I'Zoom -'^M^J+
'NUMPAD6'^I'Aspet +'^M^J+
'NUMPAD8'^I'Reset Aspet'^M^J+
'NUMPAD4'^I'Aspet -'^M^J+
'NUMPAD7'^I'Ne pas couper la vidéo'^M^J+
'V'^I^I'Sous-titres'^M^J+
'CTRL+0'^I^I'Reset Speed'^M^J+
'CTRL+/'^I^I'Speed -'^M^J+
'CTRL+*'^I^I'Speed +'^M^J+
'CTRL+O'^I^I'Ouvrir un Fichier'^M^J+
'CTRL+L'^I^I'Ouvrir une URL'^M^J+
'CTRL+W'^I^I'Fermer'^M^J+
'CTRL+LEFT'^I'Jouer la piste précédente'^M^J+
'CTRL+RIGHT'^I'Jouer la piste suivante'^M^J+
'Alt+0'^I^I'Dimension sur mesure'^M^J+
'Alt+1'^I^I'Demi Taille'^M^J+
'Alt+2'^I^I'Taille originale'^M^J+
'Alt+3'^I^I'Taille double'^M^J+
'Alt+F4'^I^I'Fermer le programme'^M^J+
'Alt+Return'^I'Plein Ecran'^M^J+
'CTRL+LEFT'^I'Jouer la piste précédente'^M^J+
'CTRL+RIGHT'^I'Jouer la piste suivante'^M^J+
'MEDIA_STOP'^I^I'Stop '^M^J+
'MEDIA_PREV_TRACK'^I'Jouer la piste précédente'^M^J+
'MEDIA_NEXT_TRACK'^I'Jouer la piste suivante'
  ;
  HelpFormClose:='Fermer';

  //log form
  LogFormCaption:='Sortie MPlayer';
  LogFormClose:='Fermer';

  //about form
  AboutFormCaption:='À propos de 3nity Media Player';
  AboutFormClose:='Fermer';
  AboutVersionMPUI:='3nity Media Player version:';
  AboutVersionMplayer:='MPlayer version:';

  //settings form
  SettingsformCaption := 'Réglages';
    Brightness := 'Luminosité';
    Contrast := 'Contraste';
    Hue := 'Teinte';
    Saturation := 'Saturation';
    Gamma := 'Gamma';
    SubScale := 'Sous. taille';
    ResetSetting := 'Restaurer';
    MResetSetting := 'Restaurer tout';

  //options form
    FullScreenMonitor := 'Moniteur plein écran';
    AutoLocale:='(Auto-sélection)';

    OptionsFormCaption:='Préférences';
    OptionsFormOK:='OK';
    OptionsFormApply:='Appliquer';

            OptionsFormAssociate:='Associer';
    OptionsFormSelectAll:='Tous';
    OptionsFormSelectNone:='Aucun';

    
    OptionsFormSave:='Sauver';
    OptionsFormClose:='Fermer';
    OptionsFormHelp:='Aide';
    OptionsFormParams:='Paramètres MPlayer additionnels:';

    OptionsFormIndex:='Reconstruire l''index du fichier au besoin';
    OptionsFormPriorityBoost:='Exécuter avec priorité plus élevée';

    Autosync := 'Facteur auto-synchronisation';
    AVsyncperframe := 'Synchronisation A-V par photogramme(us.)';

    OptionsFormAudioOut:='Pilote de sortie audio';
      AudioOutNoDecode:='(ne pas décoder le son)';
      AudioOutNoOut:='(ne pas jouer le son)';
    OptionsFormAudioDev:='Unité de sortie DirectSound';
    OptionsFormAudioFilterChannels := 'Filtrage et redirection des canaux';
    OptionsFormSoftVol:='Reglage du volume par logiciel / Amplification du volume';
    OptionsFormUseVolcmd := 'Employer option volume sur ligne de commande';
    OptionsFormAudioDecodeChannels := 'Máx de canaux a décoder';
    OptionsFormAc3Comp := 'Compression dynamique AC3';
    OptionsFormUseliba52 := 'Employer la librairie liba52';

    OptionsFormVideoOut := 'Pilote de sortie video';
      VideoOutUser := 'Un Autre:';
    OptionsFormOverlay:= 'Couleur pour la superposition';
    ForceEvenWidth := 'Forcer largeur pair';
    DirectRender := 'Renderization directe';
    DoubleBuffer := 'Double mémoire tampon';
    DrawSlices := 'Dessin en morceaux';

    OptionsFormVideoeq  := 'Équaliseur video';
      VideoeqOff  := 'Débranché';
    VideoScaler := 'Changer taille par logiciel';
    TryScaler := 'Essayer taille en erreur';

    OptionsFormPostproc:='Post-traitement';
      PostprocOff:='Aucun';
      PostprocAuto:='Automatique';
      PostprocMax:='Qualité maximum';

    OptionsFormGeneral := 'Général';
    OptionsFormAudio := 'Audio';
    OptionsFormVideo := 'Vidéo';
    OptionsFormCaching := 'Cache';
    OptionsFormOSDSub := 'OSD et sous-titres';

    MediaDefault := 'Défaut';
    MediaFixed := 'Disque dur';
    MediaRamdisk := 'Disque RAM';
    MediaCdrom := 'CD-ROM / DVD-ROM';
    MediaRemovable := 'Support amovible';
    mediaNetwork := 'Réseau local';
    MediaInternet := 'Internet';
    MediaDvd := 'Format DVD';

    FontPath := 'Fonte de caractères';
    FontEncoding := 'Codage des caractères';
    FontEncodings[0] := 'Défaut';
    FontEncodings[1] := 'Unicode';
    FontEncodings[2] := 'Langues Européennes Occidentales (ISO-8859-1)';
    FontEncodings[3] := 'Langues Européeenes Occidentales avec Euro (ISO-8859-15)';
    FontEncodings[4] := 'Langues Européeenes Slaves/Centrales (ISO-8859-2)';
    FontEncodings[5] := 'Esperanto, Galicien, Maltais, Turc (ISO-8859-3)';
    FontEncodings[6] := 'Caractères Old Baltic (ISO-8859-4)';
    FontEncodings[7] := 'Cyrillique (ISO-8859-5)';
    FontEncodings[8] := 'Arabe (ISO-8859-6)';
    FontEncodings[9] := 'Grec Moderne (ISO-8859-7)';
    FontEncodings[10] := 'Turc (ISO-8859-9)';
    FontEncodings[11] := 'Balte (ISO-8859-13)';
    FontEncodings[12] := 'Celte (ISO-8859-14)';
    FontEncodings[13] := 'Hebreu (ISO-8859-8)';
    FontEncodings[14] := 'Russe (KOI8-R)';
    FontEncodings[15] := 'Ukrainien, Biélorusse (KOI8-U/RU)';
    FontEncodings[16] := 'Chinois Simplifié (CP936)';
    FontEncodings[17] := 'Chinois Traditionnel (BIG5)';
    FontEncodings[18] := 'Japonais (SHIFT-JIS)';
    FontEncodings[19] := 'Coréen (CP949)';
    FontEncodings[20] := 'Thaïlandais (CP874)';
    FontEncodings[21] := 'Cyrillique Windows (CP1251)';
    FontEncodings[22] := 'Slave/Europe Centrale Windows (CP1250)';

    FontConfig := 'Fontconfig (scruter polices de caractères)';
    SubAss := 'Employer SSA/ASS';
    SubAutoLoad := 'Ajouter sous-titres externes';

    SubAssBorderColor := 'Couleur de la bordure du texte';
    SubAssColor := 'Couleur du texte';
    SubBgColor := 'Couleur de fond du text';

    UseDvdNav := 'DVD menus ';
    DeinterlaceDVD := 'Dé-entrelacer toujours';

  //playlist form
  PlaylistFormCaption:='Liste d''écoute';
  PlaylistFormPlay:='Jouer';
  PlaylistFormAdd:='Ajouter ...';
  PlaylistFormMoveUp:='Monter';
  PlaylistFormMoveDown:='Descendre';
  PlaylistFormDelete:='Enlever';
  PlaylistFormShuffle:='Mode aléatoire';
  PlaylistFormLoop:='Répéter';
  PlaylistFormSave:='Sauver ...';
  PlaylistFormClose:='Fermer';

  InfoFormCaption:='Information sur fichier';
  InfoFormClose:='Fermer';
  InfoFormCopy := 'Copier'; InfoFormCopyAll := 'Copier Tout';
  NoInfo:='Aucune information disponible.';
  InfoFileFormat:='Format';
  InfoPlaybackTime:='Duration';
  InfoTags:='Métadonnée';
  InfoVideo:='Video';
  InfoAudio:='Audio';
  InfoDecoder:='Decodeur';
  InfoCodec:='Codec';
  InfoBitrate:='Débit binaire';
  InfoVideoSize:='Dimensions';
  InfoVideoFPS:='Images par seconde';
  InfoVideoAspect:='Rapp. larg./haut.';
  InfoAudioRate:='Fréquence';
  InfoAudioChannels:='Canaux';
  InfoInterlace:='Photogramme';
  InfoVideoInt := 'Entrelacé';
  InfoVideoPro := 'progressif';
  InfoTrack := 'Piste';
  InfoFilesize := 'Taille';
  InfoSub := 'Sous-titres';
  end;
end;

begin
  RegisterLocale('French - Français',Activate,LANG_FRENCH,DEFAULT_CHARSET);
end.
