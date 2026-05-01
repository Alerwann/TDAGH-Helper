// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get momentAff => 'Reset time';

  @override
  String momentRepas(String moment) {
    return '$moment time';
  }

  @override
  String get hour => 'hour';

  @override
  String get decidHour => 'Scheduled time';

  @override
  String get enterNumber => 'Please enter a number';

  @override
  String get errorTypeNumber => 'Please enter a valid number';

  @override
  String get errorHourToHeight => 'Invalid hour, it must be less than 24';

  @override
  String get errorHourNegative => 'Invalid hour, it must be positive';

  @override
  String get bestRecord => 'You beat the record!';

  @override
  String get egalRecord => 'You matched the record!';

  @override
  String recordMessage(int recordTape) {
    return 'The record is $recordTape taps.';
  }

  @override
  String labelFinAcces(int heure) {
    return 'Access ends at ${heure}H';
  }

  @override
  String labelOuverture(int heure) {
    return 'Opens at ${heure}H';
  }

  @override
  String get matin => 'Morning';

  @override
  String get reveilMoment => 'wake up';

  @override
  String get midi => 'Noon';

  @override
  String get soir => 'Evening';

  @override
  String get coucher => 'Bedtime';

  @override
  String get defouleToi => 'Let it out';

  @override
  String get tireTache => 'Task Draw';

  @override
  String get bingoQuot => 'Daily Bingo';

  @override
  String get aideDents => 'Brushing aid';

  @override
  String scoreMoment(String moment, int scoreByMoment) {
    return 'Score for $moment: $scoreByMoment/4';
  }

  @override
  String get permissionMiss => '⚠️ Missing permissions';

  @override
  String get instructionsAndroidNotifications =>
      'For notifications to work, you must:\n\n1. In app settings, then battery, choose: No restrictions\n2. Uncheck pause app activity\n3. Allow notifications\n\nClick \'Open\' to access settings.';

  @override
  String get instructionsIOSNotifications =>
      'For notifications to work, you must enable them in settings.\n\nDo you want to open settings now?';

  @override
  String get later => 'Later';

  @override
  String get ouvrirParam => 'Open Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get decriptionNotif => 'TDAHelpe uses notifications to:';

  @override
  String get rappelTask => '📅 Remind you of your daily tasks';

  @override
  String get routineHelp => '🎯 Help you remember your routine';

  @override
  String get nombreNotif =>
      'You will receive a maximum of 4 notifications per day.';

  @override
  String get notifChoix => 'Accepting notifications can be toggled in settings';

  @override
  String get modifNotifChoix =>
      'Changing notification preferences is available in settings.';

  @override
  String get refusNotif =>
      'The app will work without notifications, but you won\'t get automatic reminders.';

  @override
  String get notNow => 'Not now';

  @override
  String get autorise => 'Allow';

  @override
  String get ferme => 'Close';

  @override
  String get aucun => 'none';

  @override
  String get terminer => 'Finish!';

  @override
  String get valider => 'Validate';

  @override
  String get confirmer => 'Confirm';

  @override
  String get reinit => 'Reset';

  @override
  String get retour => 'Back';

  @override
  String get oui => 'yes';

  @override
  String get non => 'no';

  @override
  String get annuler => 'Cancel';

  @override
  String get commencer => 'Start';

  @override
  String get suivant => 'Next';

  @override
  String get retry => 'Retry';

  @override
  String get ouvrir => 'Open';

  @override
  String get activer => 'Enable';

  @override
  String get parametre => 'Settings';

  @override
  String get accueil => 'Home';

  @override
  String get bienvenue => 'Welcome';

  @override
  String get score => 'Score';

  @override
  String get formatErrorMusic =>
      'Unsupported audio format. Please choose an MP3, M4A, WAV, or AAC file.';

  @override
  String get noAccessFichier =>
      'Cannot access the file. Please choose a local file.';

  @override
  String get importImpossible => '⚠️ Unable to import music';

  @override
  String get error => '❌ An error occurred';

  @override
  String get pauseAll => 'Global Pause';

  @override
  String get finValidation => 'Finish and validate';

  @override
  String get pause => 'Pause';

  @override
  String get play => 'Start';

  @override
  String get selectMusique => 'Select music';

  @override
  String get iosErrorImport =>
      'Sound import only from Files, iCloud, or Downloads';

  @override
  String get musiceEcoute => 'Currently playing';

  @override
  String get addTache => 'Add activities';

  @override
  String get newTaskName => 'New task name:';

  @override
  String get activityName => 'Activity name';

  @override
  String get estimationDuree => 'Estimated duration:';

  @override
  String get court => 'short';

  @override
  String get moyen => 'Medium';

  @override
  String get long => 'Long';

  @override
  String get tresLong => 'Very long';

  @override
  String get saisiNomAct => 'Please enter an activity name';

  @override
  String get dureeAct => 'Please select a duration';

  @override
  String get succesAjoutAct => 'Task added successfully!';

  @override
  String get modifTache => 'Modify task';

  @override
  String get succesModif => 'Task modified successfully!';

  @override
  String get nombreTirage => 'Number of draws';

  @override
  String actuelNombreTirage(int tachesTimenombreT) {
    return 'Currently, $tachesTimenombreT tasks are drawn.';
  }

  @override
  String get nombrePiocheDemande => 'How many tasks do you want to draw?';

  @override
  String get nombrePioche => 'Number of draws';

  @override
  String get saisieNombre => 'Please enter a number';

  @override
  String get saisienombreInvalide => 'Please enter a valid number';

  @override
  String get nombreTacheMax => 'Maximum number of daily tasks is 10';

  @override
  String nombrePiocheSupMax(int tachesTimetaches) {
    return 'Max number of tasks => $tachesTimetaches';
  }

  @override
  String get listeEnregistre => 'List saved';

  @override
  String get explicationCouleur =>
      'Modify the task by tapping it.\nColor guide:\nGreen -> short\nYellow -> medium\nOrange -> long\nRed -> very long';

  @override
  String supprimeTache(String tacheName) {
    return 'Delete: $tacheName?';
  }

  @override
  String get ajouterTache => 'Add a task';

  @override
  String get modifierNombreTirage => 'Modify draw count';

  @override
  String get listeTAche => 'Task list';

  @override
  String get explicationRefairTAche => 'You can redraw';

  @override
  String get messageAttention =>
      '⚠️ If you have a daily draw in progress, modifying the list will cancel it.\nIf you already earned points, you won\'t get more XP.';

  @override
  String get regleTirage => 'Drawing rule';

  @override
  String get reset => 'reset';

  @override
  String get attenteTirage => 'Waiting for draw';

  @override
  String get actionTirage => 'Draw now';

  @override
  String get avancementQuete => 'Quest progress';

  @override
  String xpNiveau(int xpByLevel, int maxXpByLevel) {
    return 'XP for level $xpByLevel / $maxXpByLevel';
  }

  @override
  String get taches => 'Tasks';

  @override
  String get pointBonus => 'Bonus Points';

  @override
  String get fonctionnement => 'How it works';

  @override
  String get scoreBingo => 'Bingo Score';

  @override
  String get progressionquot => 'Overall daily progress';

  @override
  String get allerValidBing => 'Go to bingo validation';

  @override
  String get pointBonusSuivi => 'Go to bingo validation';

  @override
  String dentScore(int toothScore) {
    return 'Brushing score: $toothScore';
  }

  @override
  String nbrLavageRestant(int nbCleantooth) {
    return 'Brush $nbCleantooth more times to get max XP!';
  }

  @override
  String get validNbLavage =>
      'You brushed the recommended number of times! Well done';

  @override
  String get redictDent => 'Go to brushing';

  @override
  String defouleScore(int defouleScoreNb) {
    return 'Release game record score: $defouleScoreNb';
  }

  @override
  String resteDefoule(int nbRecord) {
    return 'You have $nbRecord records left to beat today';
  }

  @override
  String get felicitationRecord =>
      'Congrats! You beat 4 records today. \nYou earned max XP for this bonus.';

  @override
  String get redirectDefoul => 'Go beat some records';

  @override
  String get regleNiveau => 'Level rules';

  @override
  String explainXp(int maxXpByLevel) {
    return 'Every $maxXpByLevel XP, your level increases and unlocks spectacular ranks!';
  }

  @override
  String get regleReinitialisation => 'Reset rules';

  @override
  String reinitHeure(int reinitHours) {
    return 'Daily scores reset at $reinitHours:00.';
  }

  @override
  String get explainReinit => 'This can be configured in app settings 🤓';

  @override
  String get bingoExplainPoint => 'Earn points with bingo';

  @override
  String get bingoCount => '4 tasks completed = 5 XP points 🏆';

  @override
  String get explainTache => 'Earn points with task draws';

  @override
  String get countTAchePoint => 'Complete drawn tasks to earn 5 points 🏆.';

  @override
  String get explainDefoule => 'Earn points with bonus games';

  @override
  String get explainDent =>
      'Brushing aid and the release game can grant bonus points.';

  @override
  String get dentPoint => 'You earn 5 points per bonus task completion 🏆';

  @override
  String get maxPontAct =>
      'You can accumulate up to 15 points per bonus activity per day.';

  @override
  String get scoreTacheCount => 'Task score';

  @override
  String actuelNombreTache(int numberOfTrue) {
    return 'Currently, you have completed $numberOfTrue tasks.';
  }

  @override
  String nbTacheRestantes(int numberOfTrue) {
    return '$numberOfTrue left to complete the quest.';
  }

  @override
  String get redirectTaches => 'Go validate tasks';

  @override
  String get modifHoraire => 'Modify schedule';

  @override
  String get validMajAlarm => 'Alarms updated.';

  @override
  String get attentionPerteDonnee => '⚠️ All your data will be lost.';

  @override
  String get configProfil => 'Profile configuration';

  @override
  String get pseudo => 'Username';

  @override
  String get warningPseudoVide => 'Username field is empty';

  @override
  String get validMajPseudo => 'Username updated successfully!';

  @override
  String get enregistrePseudo => 'Save username';

  @override
  String get gestionProfil => 'Profile management';

  @override
  String get choixHeure => 'Time settings';

  @override
  String get modifChoixNotif => 'Modify notifications';

  @override
  String get aPropos => 'About';

  @override
  String get bienvenuOnboarding => 'Welcome to TDAH\'elp! 👋';

  @override
  String get explainApp => 'An app to help you organize your day';

  @override
  String get persoAvatar => 'Customize your avatar 👤';

  @override
  String get explainPersoAvatar =>
      'Set your photo and username for a personalized experience.';

  @override
  String get persoProfil => 'Customize your profile ⚙️';

  @override
  String get explainPersoProfil => 'Set your preferred times in the settings';

  @override
  String get bingoQuotOnBoard => 'Daily Bingo 🎯';

  @override
  String get explainBingoQuot => 'Complete the bingo throughout the day';

  @override
  String get tacheQuot => 'Daily Draw 🎰';

  @override
  String get explainTacheQuot =>
      'Draw any number of random tasks and complete them';

  @override
  String get notificationTitre => 'Notifications 🔔';

  @override
  String get explainNotificationTitre =>
      'Get reminders so you don\'t forget anything';

  @override
  String get descriptionApp =>
      'An app designed to support people with ADHD in their daily routines.';

  @override
  String get developBy => 'Developed by';

  @override
  String get politiqueConf => 'Privacy Policy';

  @override
  String get redirectSite => 'View on website';

  @override
  String errorRedirect(String url) {
    return 'Unable to open $url';
  }

  @override
  String get modifTimer => 'Modify timer';

  @override
  String get saisieTimerSecond => 'Enter desired timer duration in seconds.';

  @override
  String get nbSecondMax => 'Maximum seconds: 600';

  @override
  String get warningSupRecord =>
      '⚠️ Modifying this will delete the saved record ⚠️';

  @override
  String get temps => 'Time';

  @override
  String get tempsSecond => 'Time in seconds';

  @override
  String get tempsMax => 'Max tasks => 600';

  @override
  String get succesMajTime => '✅ Timer updated successfully!';

  @override
  String get errorMajtime => '⚠️ Error during update';

  @override
  String scorePerso(int score) {
    return 'Your score: $score';
  }

  @override
  String get resultats => 'Results';

  @override
  String messageFinScore(int score) {
    return 'Your score is: $score taps!';
  }

  @override
  String get erreurReinitScore => '⚠️ Unable to reset score';

  @override
  String get remiseAzero => 'Reset to 0';

  @override
  String get lerecord => 'The record:';

  @override
  String get tempsPartie => 'Game duration:';

  @override
  String get modifierTimer => 'Modify timer';

  @override
  String get scoreReinitValid => '✅ Score reset';

  @override
  String erreurAccesBingo(String titleMoment) {
    return '⏰ The $titleMoment period is no longer accessible';
  }

  @override
  String get erreurInitCarte => 'Sorry, bingo cards could not be initialized';

  @override
  String get erreurMajRappel => '⚠️ Reminders could not be scheduled';

  @override
  String get erreurChargeNiveau => '⚠️ Unable to load level';

  @override
  String get erreurChargeScore => '⚠️ Unable to load score';

  @override
  String get erreurChargeTime => '⚠️ Unable to load game duration';

  @override
  String get erreurReinit => '⚠️ Game duration could not be reset';

  @override
  String get erreurMajHeur => '⚠️ Time could not be updated';

  @override
  String get erreurChargerHeure => '⚠️ Reset time could not be loaded';

  @override
  String get erreurReinitTimer => '⚠️ Game duration could not be reset';

  @override
  String get erreurChargeXP => '⚠️ Unable to load global XP';

  @override
  String get erreurChargeEtatTache => '⚠️ Unable to load task state';

  @override
  String get erreurCritiqueCharge => '⚠️ Critical error during daily reset';

  @override
  String get faireLit => 'Make your bed';

  @override
  String get laverDent => 'Brush teeth';

  @override
  String get prendreTraitement => 'Take medication';

  @override
  String get douche => 'Shower';

  @override
  String get boire => 'Drink water';

  @override
  String get manger => 'Eat';

  @override
  String get soin => 'Take care of yourself';

  @override
  String get chosePositive => 'Find 3 positive things';

  @override
  String get faisLaVaisselle => 'Do the dishes';

  @override
  String get prepaDemain => 'Prepare for tomorrow';

  @override
  String get finEcran => 'No-screen activity';

  @override
  String get reveil => 'Set alarm';

  @override
  String get laveDouche => 'Clean the shower/bathtub';

  @override
  String get poussiere => 'Dust a room';

  @override
  String get listCourse => 'Prepare grocery list';

  @override
  String get comptes => 'Manage finances';

  @override
  String get laveWc => 'Clean the toilets';

  @override
  String get poubelles => 'Take out the trash';

  @override
  String get permSup => 'Additional permissions required';

  @override
  String get explainAndPermsup =>
      'For notifications to work, you must:\n\n1. Allow \'Alarms and reminders\' \n2. Disable battery optimization \n3. Enable automatic startup\n\nClick \'Open\' to access settings.';

  @override
  String get demandeActivNotif => 'Enable notifications to receive reminders';

  @override
  String get notifDesact => 'Notifications disabled';

  @override
  String get tirage => 'Draw';

  @override
  String get liste => 'List';

  @override
  String get grade_0 => 'Explorer';

  @override
  String get grade_desc_0 => 'Every journey begins with exploration.';

  @override
  String get grade_1 => 'Enduring';

  @override
  String get grade_desc_1 =>
      'Your journey is taking shape, you\'re holding on well.';

  @override
  String get grade_2 => 'Obstinate';

  @override
  String get grade_desc_2 => 'You want to reach the end, it shows.';

  @override
  String get grade_3 => 'Stubborn';

  @override
  String get grade_desc_3 =>
      'Usually not a compliment, but here it\'s more than that.';

  @override
  String get grade_4 => 'Routine Master';

  @override
  String get grade_desc_4 => 'You are the Yoda of habits: wise and constant.';

  @override
  String get grade_5 => 'Lord of Tasks';

  @override
  String get grade_desc_5 => 'Your reputation is starting to make some noise.';

  @override
  String get grade_6 => 'King of Organization';

  @override
  String get grade_desc_6 => 'Your daily management has no limits.';

  @override
  String get grade_7 => 'Dominator of Obstacles';

  @override
  String get grade_desc_7 => 'Everyone kneels as you pass.';

  @override
  String get grade_8 => 'Habit Angel';

  @override
  String get grade_desc_8 => 'You fly above difficulties.';

  @override
  String get grade_9 => 'Supreme Being of Daily Life';

  @override
  String get grade_desc_9 => 'Daily life holds no more secrets for you.';

  @override
  String get grade_10 => 'God of the Everyday';

  @override
  String get grade_10_desc => 'Nothing can stop you now, you dominate us all.';

  @override
  String get grad_error => 'Error';

  @override
  String get grad_error_desc => 'Unable to load grade';
}
