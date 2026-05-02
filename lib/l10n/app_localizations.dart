import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// Language choice
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @momentAff.
  ///
  /// In en, this message translates to:
  /// **'Reset time'**
  String get momentAff;

  /// Message based on the time of day
  ///
  /// In en, this message translates to:
  /// **'{moment} time'**
  String momentRepas(String moment);

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get hour;

  /// No description provided for @decidHour.
  ///
  /// In en, this message translates to:
  /// **'Scheduled time'**
  String get decidHour;

  /// No description provided for @enterNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number'**
  String get enterNumber;

  /// No description provided for @errorTypeNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get errorTypeNumber;

  /// No description provided for @errorHourToHeight.
  ///
  /// In en, this message translates to:
  /// **'Invalid hour, it must be less than 24'**
  String get errorHourToHeight;

  /// No description provided for @errorHourNegative.
  ///
  /// In en, this message translates to:
  /// **'Invalid hour, it must be positive'**
  String get errorHourNegative;

  /// No description provided for @bestRecord.
  ///
  /// In en, this message translates to:
  /// **'You beat the record!'**
  String get bestRecord;

  /// No description provided for @egalRecord.
  ///
  /// In en, this message translates to:
  /// **'You matched the record!'**
  String get egalRecord;

  /// Message displaying the tap record
  ///
  /// In en, this message translates to:
  /// **'The record is {recordTape} taps.'**
  String recordMessage(int recordTape);

  /// No description provided for @labelFinAcces.
  ///
  /// In en, this message translates to:
  /// **'Access ends at {heure}H'**
  String labelFinAcces(int heure);

  /// No description provided for @labelOuverture.
  ///
  /// In en, this message translates to:
  /// **'Opens at {heure}H'**
  String labelOuverture(int heure);

  /// No description provided for @matin.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get matin;

  /// No description provided for @reveilMoment.
  ///
  /// In en, this message translates to:
  /// **'wake up'**
  String get reveilMoment;

  /// No description provided for @midi.
  ///
  /// In en, this message translates to:
  /// **'Noon'**
  String get midi;

  /// No description provided for @soir.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get soir;

  /// No description provided for @coucher.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get coucher;

  /// task name
  ///
  /// In en, this message translates to:
  /// **'Let it out'**
  String get defouleToi;

  /// task name
  ///
  /// In en, this message translates to:
  /// **'Task Draw'**
  String get tireTache;

  /// task name
  ///
  /// In en, this message translates to:
  /// **'Daily Bingo'**
  String get bingoQuot;

  /// task name
  ///
  /// In en, this message translates to:
  /// **'Brushing aid'**
  String get aideDents;

  /// No description provided for @scoreMoment.
  ///
  /// In en, this message translates to:
  /// **'Score for {moment}: {scoreByMoment}/4'**
  String scoreMoment(String moment, int scoreByMoment);

  /// No description provided for @permissionMiss.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Missing permissions'**
  String get permissionMiss;

  /// Help text for Android notification settings
  ///
  /// In en, this message translates to:
  /// **'For notifications to work, you must:\n\n1. In app settings, then battery, choose: No restrictions\n2. Uncheck pause app activity\n3. Allow notifications\n\nClick \'Open\' to access settings.'**
  String get instructionsAndroidNotifications;

  /// Text for iOS notification validation
  ///
  /// In en, this message translates to:
  /// **'For notifications to work, you must enable them in settings.\n\nDo you want to open settings now?'**
  String get instructionsIOSNotifications;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @ouvrirParam.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get ouvrirParam;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @decriptionNotif.
  ///
  /// In en, this message translates to:
  /// **'TDAHelpe uses notifications to:'**
  String get decriptionNotif;

  /// No description provided for @rappelTask.
  ///
  /// In en, this message translates to:
  /// **'📅 Remind you of your daily tasks'**
  String get rappelTask;

  /// No description provided for @routineHelp.
  ///
  /// In en, this message translates to:
  /// **'🎯 Help you remember your routine'**
  String get routineHelp;

  /// No description provided for @nombreNotif.
  ///
  /// In en, this message translates to:
  /// **'You will receive a maximum of 4 notifications per day.'**
  String get nombreNotif;

  /// No description provided for @notifChoix.
  ///
  /// In en, this message translates to:
  /// **'Accepting notifications can be toggled in settings'**
  String get notifChoix;

  /// No description provided for @modifNotifChoix.
  ///
  /// In en, this message translates to:
  /// **'Changing notification preferences is available in settings.'**
  String get modifNotifChoix;

  /// No description provided for @refusNotif.
  ///
  /// In en, this message translates to:
  /// **'The app will work without notifications, but you won\'t get automatic reminders.'**
  String get refusNotif;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @autorise.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get autorise;

  /// No description provided for @ferme.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get ferme;

  /// No description provided for @aucun.
  ///
  /// In en, this message translates to:
  /// **'none'**
  String get aucun;

  /// No description provided for @terminer.
  ///
  /// In en, this message translates to:
  /// **'Finish!'**
  String get terminer;

  /// No description provided for @valider.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get valider;

  /// No description provided for @confirmer.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmer;

  /// No description provided for @reinit.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reinit;

  /// No description provided for @retour.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get retour;

  /// No description provided for @oui.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get oui;

  /// No description provided for @non.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get non;

  /// No description provided for @annuler.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get annuler;

  /// No description provided for @commencer.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get commencer;

  /// No description provided for @suivant.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get suivant;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @ouvrir.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get ouvrir;

  /// No description provided for @activer.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get activer;

  /// No description provided for @parametre.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get parametre;

  /// No description provided for @accueil.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get accueil;

  /// No description provided for @bienvenue.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get bienvenue;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @formatErrorMusic.
  ///
  /// In en, this message translates to:
  /// **'Unsupported audio format. Please choose an MP3, M4A, WAV, or AAC file.'**
  String get formatErrorMusic;

  /// No description provided for @noAccessFichier.
  ///
  /// In en, this message translates to:
  /// **'Cannot access the file. Please choose a local file.'**
  String get noAccessFichier;

  /// No description provided for @importImpossible.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Unable to import music'**
  String get importImpossible;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'❌ An error occurred'**
  String get error;

  /// No description provided for @pauseAll.
  ///
  /// In en, this message translates to:
  /// **'Global Pause'**
  String get pauseAll;

  /// No description provided for @finValidation.
  ///
  /// In en, this message translates to:
  /// **'Finish and validate'**
  String get finValidation;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get play;

  /// No description provided for @selectMusique.
  ///
  /// In en, this message translates to:
  /// **'Select music'**
  String get selectMusique;

  /// No description provided for @iosErrorImport.
  ///
  /// In en, this message translates to:
  /// **'Sound import only from Files, iCloud, or Downloads'**
  String get iosErrorImport;

  /// No description provided for @musiceEcoute.
  ///
  /// In en, this message translates to:
  /// **'Currently playing'**
  String get musiceEcoute;

  /// No description provided for @addTache.
  ///
  /// In en, this message translates to:
  /// **'Add activities'**
  String get addTache;

  /// No description provided for @newTaskName.
  ///
  /// In en, this message translates to:
  /// **'New task name:'**
  String get newTaskName;

  /// No description provided for @activityName.
  ///
  /// In en, this message translates to:
  /// **'Activity name'**
  String get activityName;

  /// No description provided for @estimationDuree.
  ///
  /// In en, this message translates to:
  /// **'Estimated duration:'**
  String get estimationDuree;

  /// No description provided for @court.
  ///
  /// In en, this message translates to:
  /// **'short'**
  String get court;

  /// No description provided for @moyen.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get moyen;

  /// No description provided for @long.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get long;

  /// No description provided for @tresLong.
  ///
  /// In en, this message translates to:
  /// **'Very long'**
  String get tresLong;

  /// No description provided for @saisiNomAct.
  ///
  /// In en, this message translates to:
  /// **'Please enter an activity name'**
  String get saisiNomAct;

  /// No description provided for @dureeAct.
  ///
  /// In en, this message translates to:
  /// **'Please select a duration'**
  String get dureeAct;

  /// No description provided for @succesAjoutAct.
  ///
  /// In en, this message translates to:
  /// **'Task added successfully!'**
  String get succesAjoutAct;

  /// No description provided for @modifTache.
  ///
  /// In en, this message translates to:
  /// **'Modify task'**
  String get modifTache;

  /// No description provided for @succesModif.
  ///
  /// In en, this message translates to:
  /// **'Task modified successfully!'**
  String get succesModif;

  /// No description provided for @nombreTirage.
  ///
  /// In en, this message translates to:
  /// **'Number of draws'**
  String get nombreTirage;

  /// No description provided for @actuelNombreTirage.
  ///
  /// In en, this message translates to:
  /// **'Currently, {tachesTimenombreT} tasks are drawn.'**
  String actuelNombreTirage(int tachesTimenombreT);

  /// No description provided for @nombrePiocheDemande.
  ///
  /// In en, this message translates to:
  /// **'How many tasks do you want to draw?'**
  String get nombrePiocheDemande;

  /// No description provided for @nombrePioche.
  ///
  /// In en, this message translates to:
  /// **'Number of draws'**
  String get nombrePioche;

  /// No description provided for @saisieNombre.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number'**
  String get saisieNombre;

  /// No description provided for @saisienombreInvalide.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get saisienombreInvalide;

  /// No description provided for @nombreTacheMax.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of daily tasks is 10'**
  String get nombreTacheMax;

  /// No description provided for @nombrePiocheSupMax.
  ///
  /// In en, this message translates to:
  /// **'Max number of tasks => {tachesTimetaches}'**
  String nombrePiocheSupMax(int tachesTimetaches);

  /// No description provided for @listeEnregistre.
  ///
  /// In en, this message translates to:
  /// **'List saved'**
  String get listeEnregistre;

  /// No description provided for @explicationCouleur.
  ///
  /// In en, this message translates to:
  /// **'Modify the task by tapping it.\nColor guide:\nGreen -> short\nYellow -> medium\nOrange -> long\nRed -> very long'**
  String get explicationCouleur;

  /// No description provided for @supprimeTache.
  ///
  /// In en, this message translates to:
  /// **'Delete: {tacheName}?'**
  String supprimeTache(String tacheName);

  /// No description provided for @ajouterTache.
  ///
  /// In en, this message translates to:
  /// **'Add a task'**
  String get ajouterTache;

  /// No description provided for @modifierNombreTirage.
  ///
  /// In en, this message translates to:
  /// **'Modify draw count'**
  String get modifierNombreTirage;

  /// No description provided for @listeTAche.
  ///
  /// In en, this message translates to:
  /// **'Task list'**
  String get listeTAche;

  /// No description provided for @explicationRefairTAche.
  ///
  /// In en, this message translates to:
  /// **'You can redraw'**
  String get explicationRefairTAche;

  /// No description provided for @messageAttention.
  ///
  /// In en, this message translates to:
  /// **'⚠️ If you have a daily draw in progress, modifying the list will cancel it.\nIf you already earned points, you won\'t get more XP.'**
  String get messageAttention;

  /// No description provided for @regleTirage.
  ///
  /// In en, this message translates to:
  /// **'Drawing rule'**
  String get regleTirage;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'reset'**
  String get reset;

  /// No description provided for @attenteTirage.
  ///
  /// In en, this message translates to:
  /// **'Waiting for draw'**
  String get attenteTirage;

  /// No description provided for @actionTirage.
  ///
  /// In en, this message translates to:
  /// **'Draw now'**
  String get actionTirage;

  /// No description provided for @avancementQuete.
  ///
  /// In en, this message translates to:
  /// **'Quest progress'**
  String get avancementQuete;

  /// No description provided for @xpNiveau.
  ///
  /// In en, this message translates to:
  /// **'XP for level {xpByLevel} / {maxXpByLevel}'**
  String xpNiveau(int xpByLevel, int maxXpByLevel);

  /// No description provided for @taches.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get taches;

  /// No description provided for @pointBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus Points'**
  String get pointBonus;

  /// No description provided for @fonctionnement.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get fonctionnement;

  /// No description provided for @scoreBingo.
  ///
  /// In en, this message translates to:
  /// **'Bingo Score'**
  String get scoreBingo;

  /// No description provided for @progressionquot.
  ///
  /// In en, this message translates to:
  /// **'Overall daily progress'**
  String get progressionquot;

  /// No description provided for @allerValidBing.
  ///
  /// In en, this message translates to:
  /// **'Go to bingo validation'**
  String get allerValidBing;

  /// No description provided for @pointBonusSuivi.
  ///
  /// In en, this message translates to:
  /// **'Go to bingo validation'**
  String get pointBonusSuivi;

  /// No description provided for @dentScore.
  ///
  /// In en, this message translates to:
  /// **'Brushing score: {toothScore}'**
  String dentScore(int toothScore);

  /// No description provided for @nbrLavageRestant.
  ///
  /// In en, this message translates to:
  /// **'Brush {nbCleantooth} more times to get max XP!'**
  String nbrLavageRestant(int nbCleantooth);

  /// No description provided for @validNbLavage.
  ///
  /// In en, this message translates to:
  /// **'You brushed the recommended number of times! Well done'**
  String get validNbLavage;

  /// No description provided for @redictDent.
  ///
  /// In en, this message translates to:
  /// **'Go to brushing'**
  String get redictDent;

  /// No description provided for @defouleScore.
  ///
  /// In en, this message translates to:
  /// **'Release game record score: {defouleScoreNb}'**
  String defouleScore(int defouleScoreNb);

  /// No description provided for @resteDefoule.
  ///
  /// In en, this message translates to:
  /// **'You have {nbRecord} records left to beat today'**
  String resteDefoule(int nbRecord);

  /// No description provided for @felicitationRecord.
  ///
  /// In en, this message translates to:
  /// **'Congrats! You beat 4 records today. \nYou earned max XP for this bonus.'**
  String get felicitationRecord;

  /// No description provided for @redirectDefoul.
  ///
  /// In en, this message translates to:
  /// **'Go beat some records'**
  String get redirectDefoul;

  /// No description provided for @regleNiveau.
  ///
  /// In en, this message translates to:
  /// **'Level rules'**
  String get regleNiveau;

  /// No description provided for @explainXp.
  ///
  /// In en, this message translates to:
  /// **'Every {maxXpByLevel} XP, your level increases and unlocks spectacular ranks!'**
  String explainXp(int maxXpByLevel);

  /// No description provided for @regleReinitialisation.
  ///
  /// In en, this message translates to:
  /// **'Reset rules'**
  String get regleReinitialisation;

  /// No description provided for @reinitHeure.
  ///
  /// In en, this message translates to:
  /// **'Daily scores reset at {reinitHours}:00.'**
  String reinitHeure(int reinitHours);

  /// No description provided for @explainReinit.
  ///
  /// In en, this message translates to:
  /// **'This can be configured in app settings 🤓'**
  String get explainReinit;

  /// No description provided for @bingoExplainPoint.
  ///
  /// In en, this message translates to:
  /// **'Earn points with bingo'**
  String get bingoExplainPoint;

  /// No description provided for @bingoCount.
  ///
  /// In en, this message translates to:
  /// **'4 tasks completed = 5 XP points 🏆'**
  String get bingoCount;

  /// No description provided for @explainTache.
  ///
  /// In en, this message translates to:
  /// **'Earn points with task draws'**
  String get explainTache;

  /// No description provided for @countTAchePoint.
  ///
  /// In en, this message translates to:
  /// **'Complete drawn tasks to earn 5 points 🏆.'**
  String get countTAchePoint;

  /// No description provided for @explainDefoule.
  ///
  /// In en, this message translates to:
  /// **'Earn points with bonus games'**
  String get explainDefoule;

  /// No description provided for @explainDent.
  ///
  /// In en, this message translates to:
  /// **'Brushing aid and the release game can grant bonus points.'**
  String get explainDent;

  /// No description provided for @dentPoint.
  ///
  /// In en, this message translates to:
  /// **'You earn 5 points per bonus task completion 🏆'**
  String get dentPoint;

  /// No description provided for @maxPontAct.
  ///
  /// In en, this message translates to:
  /// **'You can accumulate up to 15 points per bonus activity per day.'**
  String get maxPontAct;

  /// No description provided for @scoreTacheCount.
  ///
  /// In en, this message translates to:
  /// **'Task score'**
  String get scoreTacheCount;

  /// No description provided for @actuelNombreTache.
  ///
  /// In en, this message translates to:
  /// **'Currently, you have completed {numberOfTrue} tasks.'**
  String actuelNombreTache(int numberOfTrue);

  /// No description provided for @nbTacheRestantes.
  ///
  /// In en, this message translates to:
  /// **'{numberOfTrue} left to complete the quest.'**
  String nbTacheRestantes(int numberOfTrue);

  /// No description provided for @redirectTaches.
  ///
  /// In en, this message translates to:
  /// **'Go validate tasks'**
  String get redirectTaches;

  /// No description provided for @modifHoraire.
  ///
  /// In en, this message translates to:
  /// **'Modify schedule'**
  String get modifHoraire;

  /// No description provided for @validMajAlarm.
  ///
  /// In en, this message translates to:
  /// **'Alarms updated.'**
  String get validMajAlarm;

  /// No description provided for @attentionPerteDonnee.
  ///
  /// In en, this message translates to:
  /// **'⚠️ All your data will be lost.'**
  String get attentionPerteDonnee;

  /// No description provided for @configProfil.
  ///
  /// In en, this message translates to:
  /// **'Profile configuration'**
  String get configProfil;

  /// No description provided for @pseudo.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get pseudo;

  /// No description provided for @warningPseudoVide.
  ///
  /// In en, this message translates to:
  /// **'Username field is empty'**
  String get warningPseudoVide;

  /// No description provided for @validMajPseudo.
  ///
  /// In en, this message translates to:
  /// **'Username updated successfully!'**
  String get validMajPseudo;

  /// No description provided for @enregistrePseudo.
  ///
  /// In en, this message translates to:
  /// **'Save username'**
  String get enregistrePseudo;

  /// No description provided for @gestionProfil.
  ///
  /// In en, this message translates to:
  /// **'Profile management'**
  String get gestionProfil;

  /// No description provided for @choixHeure.
  ///
  /// In en, this message translates to:
  /// **'Time settings'**
  String get choixHeure;

  /// No description provided for @modifChoixNotif.
  ///
  /// In en, this message translates to:
  /// **'Modify notifications'**
  String get modifChoixNotif;

  /// No description provided for @aPropos.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aPropos;

  /// No description provided for @bienvenuOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Welcome to TDAH\'elp! 👋'**
  String get bienvenuOnboarding;

  /// No description provided for @explainApp.
  ///
  /// In en, this message translates to:
  /// **'An app to help you organize your day'**
  String get explainApp;

  /// No description provided for @persoAvatar.
  ///
  /// In en, this message translates to:
  /// **'Customize your avatar 👤'**
  String get persoAvatar;

  /// No description provided for @explainPersoAvatar.
  ///
  /// In en, this message translates to:
  /// **'Set your photo and username for a personalized experience.'**
  String get explainPersoAvatar;

  /// No description provided for @persoProfil.
  ///
  /// In en, this message translates to:
  /// **'Customize your profile ⚙️'**
  String get persoProfil;

  /// No description provided for @explainPersoProfil.
  ///
  /// In en, this message translates to:
  /// **'Set your preferred times in the settings'**
  String get explainPersoProfil;

  /// No description provided for @bingoQuotOnBoard.
  ///
  /// In en, this message translates to:
  /// **'Daily Bingo 🎯'**
  String get bingoQuotOnBoard;

  /// No description provided for @explainBingoQuot.
  ///
  /// In en, this message translates to:
  /// **'Complete the bingo throughout the day'**
  String get explainBingoQuot;

  /// No description provided for @tacheQuot.
  ///
  /// In en, this message translates to:
  /// **'Daily Draw 🎰'**
  String get tacheQuot;

  /// No description provided for @explainTacheQuot.
  ///
  /// In en, this message translates to:
  /// **'Draw any number of random tasks and complete them'**
  String get explainTacheQuot;

  /// No description provided for @notificationTitre.
  ///
  /// In en, this message translates to:
  /// **'Notifications 🔔'**
  String get notificationTitre;

  /// No description provided for @explainNotificationTitre.
  ///
  /// In en, this message translates to:
  /// **'Get reminders so you don\'t forget anything'**
  String get explainNotificationTitre;

  /// No description provided for @descriptionApp.
  ///
  /// In en, this message translates to:
  /// **'An app designed to support people with ADHD in their daily routines.'**
  String get descriptionApp;

  /// No description provided for @developBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by'**
  String get developBy;

  /// No description provided for @politiqueConf.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get politiqueConf;

  /// No description provided for @redirectSite.
  ///
  /// In en, this message translates to:
  /// **'View on website'**
  String get redirectSite;

  /// No description provided for @errorRedirect.
  ///
  /// In en, this message translates to:
  /// **'Unable to open {url}'**
  String errorRedirect(String url);

  /// No description provided for @modifTimer.
  ///
  /// In en, this message translates to:
  /// **'Modify timer'**
  String get modifTimer;

  /// No description provided for @saisieTimerSecond.
  ///
  /// In en, this message translates to:
  /// **'Enter desired timer duration in seconds.'**
  String get saisieTimerSecond;

  /// No description provided for @nbSecondMax.
  ///
  /// In en, this message translates to:
  /// **'Maximum seconds: 600'**
  String get nbSecondMax;

  /// No description provided for @warningSupRecord.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Modifying this will delete the saved record ⚠️'**
  String get warningSupRecord;

  /// No description provided for @temps.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get temps;

  /// No description provided for @tempsSecond.
  ///
  /// In en, this message translates to:
  /// **'Time in seconds'**
  String get tempsSecond;

  /// No description provided for @tempsMax.
  ///
  /// In en, this message translates to:
  /// **'Max tasks => 600'**
  String get tempsMax;

  /// No description provided for @succesMajTime.
  ///
  /// In en, this message translates to:
  /// **'✅ Timer updated successfully!'**
  String get succesMajTime;

  /// No description provided for @errorMajtime.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Error during update'**
  String get errorMajtime;

  /// No description provided for @scorePerso.
  ///
  /// In en, this message translates to:
  /// **'Your score: {score}'**
  String scorePerso(int score);

  /// No description provided for @resultats.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get resultats;

  /// No description provided for @messageFinScore.
  ///
  /// In en, this message translates to:
  /// **'Your score is: {score} taps!'**
  String messageFinScore(int score);

  /// No description provided for @erreurReinitScore.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Unable to reset score'**
  String get erreurReinitScore;

  /// No description provided for @remiseAzero.
  ///
  /// In en, this message translates to:
  /// **'Reset to 0'**
  String get remiseAzero;

  /// No description provided for @lerecord.
  ///
  /// In en, this message translates to:
  /// **'The record:'**
  String get lerecord;

  /// No description provided for @tempsPartie.
  ///
  /// In en, this message translates to:
  /// **'Game duration:'**
  String get tempsPartie;

  /// No description provided for @modifierTimer.
  ///
  /// In en, this message translates to:
  /// **'Modify timer'**
  String get modifierTimer;

  /// No description provided for @scoreReinitValid.
  ///
  /// In en, this message translates to:
  /// **'✅ Score reset'**
  String get scoreReinitValid;

  /// No description provided for @erreurAccesBingo.
  ///
  /// In en, this message translates to:
  /// **'⏰ The {titleMoment} period is no longer accessible'**
  String erreurAccesBingo(String titleMoment);

  /// No description provided for @erreurInitCarte.
  ///
  /// In en, this message translates to:
  /// **'Sorry, bingo cards could not be initialized'**
  String get erreurInitCarte;

  /// No description provided for @erreurMajRappel.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Reminders could not be scheduled'**
  String get erreurMajRappel;

  /// No description provided for @erreurChargeNiveau.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Unable to load level'**
  String get erreurChargeNiveau;

  /// No description provided for @erreurChargeScore.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Unable to load score'**
  String get erreurChargeScore;

  /// No description provided for @erreurChargeTime.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Unable to load game duration'**
  String get erreurChargeTime;

  /// No description provided for @erreurReinit.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Game duration could not be reset'**
  String get erreurReinit;

  /// No description provided for @erreurMajHeur.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Time could not be updated'**
  String get erreurMajHeur;

  /// No description provided for @erreurChargerHeure.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Reset time could not be loaded'**
  String get erreurChargerHeure;

  /// No description provided for @erreurReinitTimer.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Game duration could not be reset'**
  String get erreurReinitTimer;

  /// No description provided for @erreurChargeXP.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Unable to load global XP'**
  String get erreurChargeXP;

  /// No description provided for @erreurChargeEtatTache.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Unable to load task state'**
  String get erreurChargeEtatTache;

  /// No description provided for @erreurCritiqueCharge.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Critical error during daily reset'**
  String get erreurCritiqueCharge;

  /// No description provided for @faireLit.
  ///
  /// In en, this message translates to:
  /// **'Make your bed'**
  String get faireLit;

  /// No description provided for @laverDent.
  ///
  /// In en, this message translates to:
  /// **'Brush teeth'**
  String get laverDent;

  /// No description provided for @prendreTraitement.
  ///
  /// In en, this message translates to:
  /// **'Take medication'**
  String get prendreTraitement;

  /// No description provided for @douche.
  ///
  /// In en, this message translates to:
  /// **'Shower'**
  String get douche;

  /// No description provided for @boire.
  ///
  /// In en, this message translates to:
  /// **'Drink water'**
  String get boire;

  /// No description provided for @manger.
  ///
  /// In en, this message translates to:
  /// **'Eat'**
  String get manger;

  /// No description provided for @soin.
  ///
  /// In en, this message translates to:
  /// **'Take care of yourself'**
  String get soin;

  /// No description provided for @chosePositive.
  ///
  /// In en, this message translates to:
  /// **'Find 3 positive things'**
  String get chosePositive;

  /// No description provided for @faisLaVaisselle.
  ///
  /// In en, this message translates to:
  /// **'Do the dishes'**
  String get faisLaVaisselle;

  /// No description provided for @prepaDemain.
  ///
  /// In en, this message translates to:
  /// **'Prepare for tomorrow'**
  String get prepaDemain;

  /// No description provided for @finEcran.
  ///
  /// In en, this message translates to:
  /// **'No-screen activity'**
  String get finEcran;

  /// No description provided for @reveil.
  ///
  /// In en, this message translates to:
  /// **'Set alarm'**
  String get reveil;

  /// No description provided for @laveDouche.
  ///
  /// In en, this message translates to:
  /// **'Clean the shower/bathtub'**
  String get laveDouche;

  /// No description provided for @poussiere.
  ///
  /// In en, this message translates to:
  /// **'Dust a room'**
  String get poussiere;

  /// No description provided for @listCourse.
  ///
  /// In en, this message translates to:
  /// **'Prepare grocery list'**
  String get listCourse;

  /// No description provided for @comptes.
  ///
  /// In en, this message translates to:
  /// **'Manage finances'**
  String get comptes;

  /// No description provided for @laveWc.
  ///
  /// In en, this message translates to:
  /// **'Clean the toilets'**
  String get laveWc;

  /// No description provided for @poubelles.
  ///
  /// In en, this message translates to:
  /// **'Take out the trash'**
  String get poubelles;

  /// No description provided for @permSup.
  ///
  /// In en, this message translates to:
  /// **'Additional permissions required'**
  String get permSup;

  /// No description provided for @explainAndPermsup.
  ///
  /// In en, this message translates to:
  /// **'For notifications to work, you must:\n\n1. Allow \'Alarms and reminders\' \n2. Disable battery optimization \n3. Enable automatic startup\n\nClick \'Open\' to access settings.'**
  String get explainAndPermsup;

  /// No description provided for @demandeActivNotif.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications to receive reminders'**
  String get demandeActivNotif;

  /// No description provided for @notifDesact.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get notifDesact;

  /// No description provided for @tirage.
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get tirage;

  /// No description provided for @liste.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get liste;

  /// No description provided for @grade_0.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get grade_0;

  /// No description provided for @grade_desc_0.
  ///
  /// In en, this message translates to:
  /// **'Every journey begins with exploration.'**
  String get grade_desc_0;

  /// No description provided for @grade_1.
  ///
  /// In en, this message translates to:
  /// **'Enduring'**
  String get grade_1;

  /// No description provided for @grade_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Your journey is taking shape, you\'re holding on well.'**
  String get grade_desc_1;

  /// No description provided for @grade_2.
  ///
  /// In en, this message translates to:
  /// **'Obstinate'**
  String get grade_2;

  /// No description provided for @grade_desc_2.
  ///
  /// In en, this message translates to:
  /// **'You want to reach the end, it shows.'**
  String get grade_desc_2;

  /// No description provided for @grade_3.
  ///
  /// In en, this message translates to:
  /// **'Stubborn'**
  String get grade_3;

  /// No description provided for @grade_desc_3.
  ///
  /// In en, this message translates to:
  /// **'Usually not a compliment, but here it\'s more than that.'**
  String get grade_desc_3;

  /// No description provided for @grade_4.
  ///
  /// In en, this message translates to:
  /// **'Routine Master'**
  String get grade_4;

  /// No description provided for @grade_desc_4.
  ///
  /// In en, this message translates to:
  /// **'You are the Yoda of habits: wise and constant.'**
  String get grade_desc_4;

  /// No description provided for @grade_5.
  ///
  /// In en, this message translates to:
  /// **'Lord of Tasks'**
  String get grade_5;

  /// No description provided for @grade_desc_5.
  ///
  /// In en, this message translates to:
  /// **'Your reputation is starting to make some noise.'**
  String get grade_desc_5;

  /// No description provided for @grade_6.
  ///
  /// In en, this message translates to:
  /// **'King of Organization'**
  String get grade_6;

  /// No description provided for @grade_desc_6.
  ///
  /// In en, this message translates to:
  /// **'Your daily management has no limits.'**
  String get grade_desc_6;

  /// No description provided for @grade_7.
  ///
  /// In en, this message translates to:
  /// **'Dominator of Obstacles'**
  String get grade_7;

  /// No description provided for @grade_desc_7.
  ///
  /// In en, this message translates to:
  /// **'Everyone kneels as you pass.'**
  String get grade_desc_7;

  /// No description provided for @grade_8.
  ///
  /// In en, this message translates to:
  /// **'Habit Angel'**
  String get grade_8;

  /// No description provided for @grade_desc_8.
  ///
  /// In en, this message translates to:
  /// **'You fly above difficulties.'**
  String get grade_desc_8;

  /// No description provided for @grade_9.
  ///
  /// In en, this message translates to:
  /// **'Supreme Being of Daily Life'**
  String get grade_9;

  /// No description provided for @grade_desc_9.
  ///
  /// In en, this message translates to:
  /// **'Daily life holds no more secrets for you.'**
  String get grade_desc_9;

  /// No description provided for @grade_10.
  ///
  /// In en, this message translates to:
  /// **'God of the Everyday'**
  String get grade_10;

  /// No description provided for @grade_10_desc.
  ///
  /// In en, this message translates to:
  /// **'Nothing can stop you now, you dominate us all.'**
  String get grade_10_desc;

  /// No description provided for @grad_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get grad_error;

  /// No description provided for @grad_error_desc.
  ///
  /// In en, this message translates to:
  /// **'Unable to load grade'**
  String get grad_error_desc;

  /// No description provided for @langue.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get langue;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @deutsche.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get deutsche;

  /// No description provided for @choisiLangue.
  ///
  /// In en, this message translates to:
  /// **'Please select a language'**
  String get choisiLangue;

  /// No description provided for @succesLangue.
  ///
  /// In en, this message translates to:
  /// **'✅ Language updated successfully'**
  String get succesLangue;

  /// No description provided for @erreurLangue.
  ///
  /// In en, this message translates to:
  /// **'⛔️ Language could not be updated'**
  String get erreurLangue;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
