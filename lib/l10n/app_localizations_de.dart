// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get language => 'Deutsch';

  @override
  String get momentAff => 'Reset-Zeit';

  @override
  String momentRepas(String moment) {
    return 'Zeit für $moment';
  }

  @override
  String get hour => 'Stunde';

  @override
  String get decidHour => 'Festgelegte Zeit';

  @override
  String get enterNumber => 'Bitte geben Sie eine Zahl ein';

  @override
  String get errorTypeNumber => 'Bitte geben Sie eine gültige Zahl ein';

  @override
  String get errorHourToHeight =>
      'Ungültige Uhrzeit, sie muss kleiner als 24 sein';

  @override
  String get errorHourNegative => 'Ungültige Uhrzeit, sie muss positiv sein';

  @override
  String get bestRecord => 'Du hast den Rekord gebrochen!';

  @override
  String get egalRecord => 'Du hast den Rekord eingestellt!';

  @override
  String recordMessage(int recordTape) {
    return 'Der Rekord liegt bei $recordTape Taps.';
  }

  @override
  String labelFinAcces(int heure) {
    return 'Zugriffsende um $heure Uhr';
  }

  @override
  String labelOuverture(int heure) {
    return 'Öffnung um $heure Uhr';
  }

  @override
  String get matin => 'Morgen';

  @override
  String get reveilMoment => 'Aufwachen';

  @override
  String get midi => 'Mittag';

  @override
  String get soir => 'Abend';

  @override
  String get coucher => 'Schlafengehen';

  @override
  String get defouleToi => 'Lass es raus';

  @override
  String get tireTache => 'Zieh eine Aufgabe';

  @override
  String get bingoQuot => 'Tägliches Bingo';

  @override
  String get aideDents => 'Zahnputz-Hilfe';

  @override
  String scoreMoment(String moment, int scoreByMoment) {
    return 'Punktzahl für $moment: $scoreByMoment/4';
  }

  @override
  String get permissionMiss => '⚠️ Fehlende Berechtigungen';

  @override
  String get instructionsAndroidNotifications =>
      'Damit Benachrichtigungen funktionieren, musst du:\n\n1. In den App-Einstellungen unter Akku wählen: Keine Einschränkung\n2. Aktivität bei Nichtnutzung stoppen deaktivieren\n3. Benachrichtigungen zulassen\n\nKlicke auf \"Öffnen\", um zu den Einstellungen zu gelangen.';

  @override
  String get instructionsIOSNotifications =>
      'Damit Benachrichtigungen funktionieren, musst du sie in den Einstellungen aktivieren.\n\nMöchtest du die Einstellungen jetzt öffnen?';

  @override
  String get later => 'Später';

  @override
  String get ouvrirParam => 'Einstellungen öffnen';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get decriptionNotif => 'TDAHelpe nutzt Benachrichtigungen für:';

  @override
  String get rappelTask => '📅 Erinnerung an deine täglichen Aufgaben';

  @override
  String get routineHelp => '🎯 Nichts in deiner Routine vergessen';

  @override
  String get nombreNotif => 'Du erhältst maximal 4 Benachrichtigungen pro Tag.';

  @override
  String get notifChoix =>
      'Die Annahme von Benachrichtigungen kann in den Einstellungen geändert werden.';

  @override
  String get modifNotifChoix =>
      'Die Änderung der Benachrichtigungseinstellungen ist in den Parametern verfügbar.';

  @override
  String get refusNotif =>
      'Ohne Benachrichtigungen funktioniert die App, aber du erhältst keine automatischen Erinnerungen.';

  @override
  String get notNow => 'Nicht jetzt';

  @override
  String get autorise => 'Zulassen';

  @override
  String get ferme => 'Schließen';

  @override
  String get aucun => 'keine';

  @override
  String get terminer => 'Beenden!';

  @override
  String get valider => 'Bestätigen';

  @override
  String get confirmer => 'Bestätigen';

  @override
  String get reinit => 'Zurücksetzen';

  @override
  String get retour => 'Zurück';

  @override
  String get oui => 'ja';

  @override
  String get non => 'nein';

  @override
  String get annuler => 'Abbrechen';

  @override
  String get commencer => 'Starten';

  @override
  String get suivant => 'Weiter';

  @override
  String get retry => 'Wiederholen';

  @override
  String get ouvrir => 'Öffnen';

  @override
  String get activer => 'Aktivieren';

  @override
  String get parametre => 'Einstellungen';

  @override
  String get accueil => 'Home';

  @override
  String get bienvenue => 'Willkommen';

  @override
  String get score => 'Punktzahl';

  @override
  String get formatErrorMusic =>
      'Audioformat nicht unterstützt. Bitte wählen Sie MP3, M4A, WAV oder AAC.';

  @override
  String get noAccessFichier =>
      'Zugriff auf Datei nicht möglich. Bitte wählen Sie eine lokale Datei.';

  @override
  String get importImpossible => '⚠️ Musikimport fehlgeschlagen';

  @override
  String get error => '❌ Ein Fehler ist aufgetreten';

  @override
  String get pauseAll => 'Globale Pause';

  @override
  String get finValidation => 'Abschluss & Validierung';

  @override
  String get pause => 'Pause';

  @override
  String get play => 'Starten';

  @override
  String get selectMusique => 'Musik auswählen';

  @override
  String get iosErrorImport =>
      'Tonimport nur über Dateien, iCloud oder Downloads möglich';

  @override
  String get musiceEcoute => 'Aktuelle Musik';

  @override
  String get addTache => 'Aktivitäten hinzufügen';

  @override
  String get newTaskName => 'Name der neuen Aufgabe:';

  @override
  String get activityName => 'Name der Aktivität';

  @override
  String get estimationDuree => 'Geschätzte Dauer:';

  @override
  String get court => 'kurz';

  @override
  String get moyen => 'mittel';

  @override
  String get long => 'lang';

  @override
  String get tresLong => 'sehr lang';

  @override
  String get saisiNomAct => 'Bitte geben Sie einen Aktivitätsnamen ein';

  @override
  String get dureeAct => 'Bitte wählen Sie eine Dauer';

  @override
  String get succesAjoutAct => 'Aufgabe erfolgreich hinzugefügt!';

  @override
  String get modifTache => 'Aufgabe bearbeiten';

  @override
  String get succesModif => 'Aufgabe erfolgreich geändert!';

  @override
  String get nombreTirage => 'Anzahl der Ziehungen';

  @override
  String actuelNombreTirage(int tachesTimenombreT) {
    return 'Derzeit werden $tachesTimenombreT Aufgaben gezogen.';
  }

  @override
  String get nombrePiocheDemande => 'Wie viele Aufgaben möchtest du ziehen?';

  @override
  String get nombrePioche => 'Anzahl der Ziehungen';

  @override
  String get saisieNombre => 'Bitte eine Zahl eingeben';

  @override
  String get saisienombreInvalide => 'Bitte eine gültige Zahl eingeben';

  @override
  String get nombreTacheMax => 'Maximal 10 tägliche Aufgaben';

  @override
  String nombrePiocheSupMax(int tachesTimetaches) {
    return 'Maximale Anzahl an Aufgaben => $tachesTimetaches';
  }

  @override
  String get listeEnregistre => 'Liste gespeichert';

  @override
  String get explicationCouleur =>
      'Aufgabe durch Antippen bearbeiten.\nFarberklärung:\nGrün -> kurz\nGelb -> mittel\nOrange -> lang\nRot -> sehr lang';

  @override
  String supprimeTache(String tacheName) {
    return '$tacheName löschen?';
  }

  @override
  String get ajouterTache => 'Aufgabe hinzufügen';

  @override
  String get modifierNombreTirage => 'Ziehungsanzahl ändern';

  @override
  String get listeTAche => 'Aufgabenliste';

  @override
  String get explicationRefairTAche => 'Du kannst die Ziehung wiederholen';

  @override
  String get messageAttention =>
      '⚠️ Wenn bereits eine tägliche Ziehung läuft, wird diese durch Ändern der Liste abgebrochen.\nWenn du deine Punkte bereits hast, erhältst du keine zusätzlichen XP.';

  @override
  String get regleTirage => 'Ziehungsregeln';

  @override
  String get reset => 'Reset';

  @override
  String get attenteTirage => 'Warten auf Ziehung';

  @override
  String get actionTirage => 'Ziehung durchführen';

  @override
  String get avancementQuete => 'Quest-Fortschritt';

  @override
  String xpNiveau(int xpByLevel, int maxXpByLevel) {
    return 'XP für Level $xpByLevel / $maxXpByLevel';
  }

  @override
  String get taches => 'Aufgaben';

  @override
  String get pointBonus => 'Bonuspunkte';

  @override
  String get fonctionnement => 'Funktionsweise';

  @override
  String get scoreBingo => 'Bingo-Punktzahl';

  @override
  String get progressionquot => 'Gesamtfortschritt für heute';

  @override
  String get allerValidBing => 'Bingo bestätigen';

  @override
  String get pointBonusSuivi => 'Bingo bestätigen';

  @override
  String dentScore(int toothScore) {
    return 'Zähneputzen-Score: $toothScore';
  }

  @override
  String nbrLavageRestant(int nbCleantooth) {
    return 'Putze noch $nbCleantooth Mal die Zähne für maximale XP!';
  }

  @override
  String get validNbLavage => 'Du hast die Zähne wie empfohlen geputzt! Bravo';

  @override
  String get redictDent => 'Zum Zähneputzen';

  @override
  String defouleScore(int defouleScoreNb) {
    return 'Rekord-Score Austoben: $defouleScoreNb';
  }

  @override
  String resteDefoule(int nbRecord) {
    return 'Noch $nbRecord Rekorde für heute zu brechen';
  }

  @override
  String get felicitationRecord =>
      'Bravo, du hast heute 4 Rekorde gebrochen. \n Du hast die maximale XP für diesen Bonus erhalten';

  @override
  String get redirectDefoul => 'Rekorde brechen';

  @override
  String get regleNiveau => 'Level-Regeln';

  @override
  String explainXp(int maxXpByLevel) {
    return 'Alle $maxXpByLevel XP steigt das Level und schaltet spektakuläre Ränge frei!';
  }

  @override
  String get regleReinitialisation => 'Reset-Regeln';

  @override
  String reinitHeure(int reinitHours) {
    return 'Die Reset-Zeit für tägliche Scores ist $reinitHours Uhr.';
  }

  @override
  String get explainReinit =>
      'Dies kann in den App-Einstellungen konfiguriert werden 🤓';

  @override
  String get bingoExplainPoint => 'Punkte mit Bingo sammeln';

  @override
  String get bingoCount => '4 erledigte Aufgaben = 5 XP 🏆';

  @override
  String get explainTache => 'Punkte mit der Aufgabenziehung sammeln';

  @override
  String get countTAchePoint =>
      'Erledige die gezogenen Aufgaben, um 5 Punkte zu verdienen 🏆.';

  @override
  String get explainDefoule => 'Punkte mit Bonusspielen sammeln';

  @override
  String get explainDent =>
      'Die Zahnputzhilfe und das Austobe-Spiel können Bonuspunkte bringen.';

  @override
  String get dentPoint => 'Du erhältst 5 Punkte pro erledigter Bonusaufgabe 🏆';

  @override
  String get maxPontAct =>
      'Du kannst maximal 15 Punkte pro Bonusaktivität und Tag sammeln.';

  @override
  String get scoreTacheCount => 'Aufgaben-Punktzahl';

  @override
  String actuelNombreTache(int numberOfTrue) {
    return 'Du hast aktuell $numberOfTrue Aufgaben erledigt.';
  }

  @override
  String nbTacheRestantes(int numberOfTrue) {
    return 'Noch $numberOfTrue bis zum Quest-Abschluss.';
  }

  @override
  String get redirectTaches => 'Aufgaben bestätigen';

  @override
  String get modifHoraire => 'Zeitplan ändern';

  @override
  String get validMajAlarm => 'Alarme wurden aktualisiert.';

  @override
  String get attentionPerteDonnee => '⚠️ Alle deine Daten gehen verloren.';

  @override
  String get configProfil => 'Profil-Konfiguration';

  @override
  String get pseudo => 'Benutzername';

  @override
  String get warningPseudoVide => 'Benutzername darf nicht leer sein';

  @override
  String get validMajPseudo => 'Benutzername erfolgreich aktualisiert!';

  @override
  String get enregistrePseudo => 'Benutzername speichern';

  @override
  String get gestionProfil => 'Profil-Verwaltung';

  @override
  String get choixHeure => 'Zeitauswahl';

  @override
  String get modifChoixNotif => 'Benachrichtigungen ändern';

  @override
  String get aPropos => 'Über uns';

  @override
  String get bienvenuOnboarding => 'Willkommen bei TDAH\'elp! 👋';

  @override
  String get explainApp =>
      'Eine App, die dir hilft, deinen Tag zu organisieren';

  @override
  String get persoAvatar => 'Personalisiere deinen Avatar 👤';

  @override
  String get explainPersoAvatar =>
      'Konfiguriere dein Foto und deinen Benutzernamen für ein persönliches Erlebnis.';

  @override
  String get persoProfil => 'Personalisiere dein Profil ⚙️';

  @override
  String get explainPersoProfil =>
      'Konfiguriere deine bevorzugten Zeiten in den Einstellungen';

  @override
  String get bingoQuotOnBoard => 'Tägliches Bingo 🎯';

  @override
  String get explainBingoQuot => 'Vervollständige das Bingo im Laufe des Tages';

  @override
  String get tacheQuot => 'Tägliche Aufgabenziehung 🎰';

  @override
  String get explainTacheQuot =>
      'Zieh so viele Aufgaben wie du willst und erledige sie';

  @override
  String get notificationTitre => 'Benachrichtigungen 🔔';

  @override
  String get explainNotificationTitre =>
      'Erhalte Erinnerungen, um nichts zu vergessen';

  @override
  String get descriptionApp =>
      'Eine App für Menschen mit ADHS zur Unterstützung ihrer täglichen Routinen.';

  @override
  String get developBy => 'Entwickelt von';

  @override
  String get politiqueConf => 'Datenschutzerklärung';

  @override
  String get redirectSite => 'Website ansehen';

  @override
  String errorRedirect(String url) {
    return '$url konnte nicht geöffnet werden';
  }

  @override
  String get modifTimer => 'Timer ändern';

  @override
  String get saisieTimerSecond =>
      'Gib die gewünschte Timer-Dauer in Sekunden ein.';

  @override
  String get nbSecondMax => 'Maximale Sekunden: 600';

  @override
  String get warningSupRecord =>
      '⚠️ Die Änderung löscht den gespeicherten Rekord ⚠️';

  @override
  String get temps => 'Zeit';

  @override
  String get tempsSecond => 'Zeit in Sekunden';

  @override
  String get tempsMax => 'Maximale Zeit => 600';

  @override
  String get succesMajTime => '✅ Timer erfolgreich aktualisiert!';

  @override
  String get errorMajtime => '⚠️ Fehler beim Aktualisieren';

  @override
  String scorePerso(int score) {
    return 'Deine Punktzahl: $score';
  }

  @override
  String get resultats => 'Ergebnisse';

  @override
  String messageFinScore(int score) {
    return 'Deine Punktzahl ist: $score Taps!';
  }

  @override
  String get erreurReinitScore => '⚠️ Score konnte nicht zurückgesetzt werden';

  @override
  String get remiseAzero => 'Auf 0 zurücksetzen';

  @override
  String get lerecord => 'Der Rekord:';

  @override
  String get tempsPartie => 'Spielzeit:';

  @override
  String get modifierTimer => 'Timer ändern';

  @override
  String get scoreReinitValid => '✅ Score zurückgesetzt';

  @override
  String erreurAccesBingo(String titleMoment) {
    return '⏰ Der Zeitraum $titleMoment ist nicht mehr verfügbar';
  }

  @override
  String get erreurInitCarte =>
      'Bingo-Karten konnten nicht initialisiert werden';

  @override
  String get erreurMajRappel =>
      '⚠️ Erinnerungen konnten nicht programmiert werden';

  @override
  String get erreurChargeNiveau => '⚠️ Level konnte nicht geladen werden';

  @override
  String get erreurChargeScore => '⚠️ Score konnte nicht geladen werden';

  @override
  String get erreurChargeTime => '⚠️ Spieldauer konnte nicht geladen werden';

  @override
  String get erreurReinit => '⚠️ Spieldauer konnte nicht zurückgesetzt werden';

  @override
  String get erreurMajHeur => '⚠️ Zeit konnte nicht aktualisiert werden';

  @override
  String get erreurChargerHeure => '⚠️ Reset-Zeit konnte nicht geladen werden';

  @override
  String get erreurReinitTimer =>
      '⚠️ Spieldauer konnte nicht zurückgesetzt werden';

  @override
  String get erreurChargeXP => '⚠️ Gesamt-XP konnte nicht geladen werden';

  @override
  String get erreurChargeEtatTache =>
      '⚠️ Aufgabenstatus konnte nicht geladen werden';

  @override
  String get erreurCritiqueCharge =>
      '⚠️ Kritischer Fehler beim täglichen Reset';

  @override
  String get faireLit => 'Bett machen';

  @override
  String get laverDent => 'Zähneputzen';

  @override
  String get prendreTraitement => 'Medikamente nehmen';

  @override
  String get douche => 'Duschen';

  @override
  String get boire => 'Trinken';

  @override
  String get manger => 'Essen';

  @override
  String get soin => 'Sich um sich selbst kümmern';

  @override
  String get chosePositive => '3 positive Dinge finden';

  @override
  String get faisLaVaisselle => 'Abwaschen';

  @override
  String get prepaDemain => 'Sachen für morgen vorbereiten';

  @override
  String get finEcran => 'Zeit ohne Bildschirm verbringen';

  @override
  String get reveil => 'Wecker stellen';

  @override
  String get laveDouche => 'Dusche/Badewanne reinigen';

  @override
  String get poussiere => 'Staub wischen in einem Zimmer';

  @override
  String get listCourse => 'Einkaufsliste schreiben';

  @override
  String get comptes => 'Finanzen prüfen';

  @override
  String get laveWc => 'WC reinigen';

  @override
  String get poubelles => 'Müll rausbringen';

  @override
  String get permSup => 'Zusätzliche Berechtigungen erforderlich';

  @override
  String get explainAndPermsup =>
      'Damit Benachrichtigungen funktionieren, musst du:\n\n1. \'Alarme und Erinnerungen\' zulassen\n2. Akku-Optimierung deaktivieren\n3. Autostart aktivieren\n\nKlicke auf \'Öffnen\', um zu den Einstellungen zu gelangen.';

  @override
  String get demandeActivNotif =>
      'Aktiviere Benachrichtigungen für Erinnerungen';

  @override
  String get notifDesact => 'Benachrichtigungen deaktiviert';

  @override
  String get tirage => 'Ziehung';

  @override
  String get liste => 'Liste';

  @override
  String get grade_0 => 'Entdecker';

  @override
  String get grade_desc_0 => 'Jede Reise beginnt mit einer Entdeckung.';

  @override
  String get grade_1 => 'Ausdauernder';

  @override
  String get grade_desc_1 =>
      'Deine Reise nimmt Gestalt an, du hältst gut durch.';

  @override
  String get grade_2 => 'Beharrlicher';

  @override
  String get grade_desc_2 =>
      'Man merkt, dass du es bis zum Ende schaffen willst.';

  @override
  String get grade_3 => 'Dickköpfig';

  @override
  String get grade_desc_3 =>
      'Normalerweise kein Kompliment, aber hier ist es mehr als das.';

  @override
  String get grade_4 => 'Meister der Routine';

  @override
  String get grade_desc_4 =>
      'Du bist der Yoda der Gewohnheiten: weise und beständig.';

  @override
  String get grade_5 => 'Herr der Aufgaben';

  @override
  String get grade_desc_5 => 'Dein Ruf verbreitet sich.';

  @override
  String get grade_6 => 'König der Organisation';

  @override
  String get grade_desc_6 => 'Dein Alltagsmanagement kennt keine Grenzen.';

  @override
  String get grade_7 => 'Bezwinger der Hindernisse';

  @override
  String get grade_desc_7 => 'Alle verneigen sich vor dir.';

  @override
  String get grade_8 => 'Engel der Gewohnheit';

  @override
  String get grade_desc_8 => 'Du fliegst über alle Schwierigkeiten hinweg.';

  @override
  String get grade_9 => 'Höchstes Wesen des Alltags';

  @override
  String get grade_desc_9 =>
      'Das tägliche Leben hat keine Geheimnisse mehr für dich.';

  @override
  String get grade_10 => 'Gott des Alltags';

  @override
  String get grade_10_desc =>
      'Niemand kann dich jetzt noch aufhalten, du beherrschst uns alle.';

  @override
  String get grad_error => 'Fehler';

  @override
  String get grad_error_desc => 'Rang konnte nicht geladen werden';

  @override
  String get langue => 'Sprache';

  @override
  String get french => 'Französisch';

  @override
  String get english => 'Englisch';

  @override
  String get spanish => 'Spanisch';

  @override
  String get deutsche => 'Deutsch';

  @override
  String get choisiLangue => 'Bitte wählen Sie eine Sprache';

  @override
  String get succesLangue => '✅ Sprache erfolgreich aktualisiert';

  @override
  String get erreurLangue => '⛔️ Sprache konnte nicht aktualisiert werden';
}
