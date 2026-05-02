// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get language => 'Français';

  @override
  String get momentAff => 'Heure de réinitialisation';

  @override
  String momentRepas(String moment) {
    return 'Heure du $moment';
  }

  @override
  String get hour => 'hour';

  @override
  String get decidHour => 'Horaire décidé';

  @override
  String get enterNumber => 'Veuillez entrer un nombre';

  @override
  String get errorTypeNumber => 'Veuillez entrer un nombre valide';

  @override
  String get errorHourToHeight =>
      'Heure invalide, elle doit être inférieur à 24';

  @override
  String get errorHourNegative => 'Heure invalide, elle doit être positive';

  @override
  String get bestRecord => 'Tu as batut le record';

  @override
  String get egalRecord => 'Tu as égalé le record!';

  @override
  String recordMessage(int recordTape) {
    return 'Le record est de $recordTape tapes.';
  }

  @override
  String labelFinAcces(int heure) {
    return 'Fin d\'accès à ${heure}H';
  }

  @override
  String labelOuverture(int heure) {
    return 'Ouverture à ${heure}H';
  }

  @override
  String get matin => 'Matin';

  @override
  String get reveilMoment => 'Réveil';

  @override
  String get midi => 'Midi';

  @override
  String get soir => 'Soir';

  @override
  String get coucher => 'Coucher';

  @override
  String get defouleToi => 'Défoule toi';

  @override
  String get tireTache => 'Fais pas Tâche';

  @override
  String get bingoQuot => 'Bingo Quotidien';

  @override
  String get aideDents => 'Aide des dents';

  @override
  String scoreMoment(String moment, int scoreByMoment) {
    return ' Le score pour le $moment : $scoreByMoment/4';
  }

  @override
  String get permissionMiss => '⚠️ Permissions manquantes';

  @override
  String get instructionsAndroidNotifications =>
      'Pour que les notifications fonctionnent, tu dois :\n\n1. Dans les paramètres de l\'application, puis batterie choisir : Pas de restriction\n2. Décocher interrompre l\'activité\n3. Autoriser les notifications\n\nClique sur \"Ouvrir\" pour accéder aux paramètres.';

  @override
  String get instructionsIOSNotifications =>
      'Pour que les notifications fonctionnent, tu dois les activer dans les paramètres.\n\nVeux-tu ouvrir les paramètres maintenant ?';

  @override
  String get later => 'Plus tard';

  @override
  String get ouvrirParam => 'Ouvrir les paramètres';

  @override
  String get notifications => 'Notifications';

  @override
  String get decriptionNotif => 'TDAHelpe utilise des notifications pour :';

  @override
  String get rappelTask => '📅 Te rappeler tes tâches quotidiennes';

  @override
  String get routineHelp => '🎯 Ne rien oublier dans ta routine';

  @override
  String get nombreNotif => 'Tu recevras au maximum 4 notifications par jour.';

  @override
  String get notifChoix =>
      'L\'acception ou non des notifications est disponible dans les paramètres';

  @override
  String get modifNotifChoix =>
      'La modification de l\'acception ou non des notifications est disponible dans les paramètres.';

  @override
  String get refusNotif =>
      'Sans les notifications, l\'app fonctionnera, mais tu n\'auras pas de rappels automatiques.';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String get autorise => 'Autoriser';

  @override
  String get ferme => 'Fermer';

  @override
  String get aucun => 'aucun';

  @override
  String get terminer => 'Terminer !';

  @override
  String get valider => 'Valider';

  @override
  String get confirmer => 'Confirmer';

  @override
  String get reinit => 'Réinitialiser';

  @override
  String get retour => 'Retour';

  @override
  String get oui => 'oui';

  @override
  String get non => 'non';

  @override
  String get annuler => 'Annuler';

  @override
  String get commencer => 'Commencer';

  @override
  String get suivant => 'Suivant';

  @override
  String get retry => 'Réessayer';

  @override
  String get ouvrir => 'Open';

  @override
  String get activer => 'Activer';

  @override
  String get parametre => 'Paramètre';

  @override
  String get accueil => 'Accueil';

  @override
  String get bienvenue => 'Bienvenue';

  @override
  String get score => 'Score';

  @override
  String get formatErrorMusic =>
      'Format audio non supporté. Veuillez choisir un fichier MP3, M4A, WAV ou AAC.';

  @override
  String get noAccessFichier =>
      'Impossible d’accéder au fichier. Veuillez choisir un fichier local.';

  @override
  String get importImpossible => '⚠️ Impossible d\'importer la musique';

  @override
  String get error => '❌ Une erreur est survenue';

  @override
  String get pauseAll => 'Pause Globale';

  @override
  String get finValidation => 'Fin et validation';

  @override
  String get pause => 'Pause';

  @override
  String get play => 'Lancer';

  @override
  String get selectMusique => 'Selectionner une musique';

  @override
  String get iosErrorImport =>
      'Importation de son uniquement depuis Fichiers, iCloud ou Téléchargements';

  @override
  String get musiceEcoute => 'Musique à l\'écoute';

  @override
  String get addTache => 'Ajout d\'activités';

  @override
  String get newTaskName => 'Nom de la nouvelle tache :';

  @override
  String get activityName => 'Nom de l\'activité';

  @override
  String get estimationDuree => 'Estimation de la durée :';

  @override
  String get court => 'court';

  @override
  String get moyen => 'moyen';

  @override
  String get long => 'Long';

  @override
  String get tresLong => 'Très long';

  @override
  String get saisiNomAct => 'Veuillez saisir un nom d\'activité';

  @override
  String get dureeAct => 'Veuillez sélectionner une durée';

  @override
  String get succesAjoutAct => 'Tâche ajoutée avec succès !';

  @override
  String get modifTache => 'Modifications de la tache';

  @override
  String get succesModif => 'Tâche modifiée avec succès !';

  @override
  String get nombreTirage => 'Nombre de tirage';

  @override
  String actuelNombreTirage(int tachesTimenombreT) {
    return 'Actuellement $tachesTimenombreT tâches sont piochées.';
  }

  @override
  String get nombrePiocheDemande => 'Combien de Tâches tu veux piocher?';

  @override
  String get nombrePioche => 'Nombre de pioches';

  @override
  String get saisieNombre => 'Veuillez entrer un nombre';

  @override
  String get saisienombreInvalide => 'Veuillez entrer un nombre valide';

  @override
  String get nombreTacheMax =>
      'Nombre maximal de tâches quotidiennes est de 10';

  @override
  String nombrePiocheSupMax(int tachesTimetaches) {
    return 'Nombre de tache maximal => $tachesTimetaches';
  }

  @override
  String get listeEnregistre => 'Liste enregistrée';

  @override
  String get explicationCouleur =>
      'Modificaiton de la tâche en appuyant dessus.\nExplication des couleurs \nVert-> court \nJaune -> moyen \nOrange ->long \nRouge -> Très long';

  @override
  String supprimeTache(String tacheName) {
    return 'Supprimer : $tacheName ?';
  }

  @override
  String get ajouterTache => 'Ajouter une tâche';

  @override
  String get modifierNombreTirage => 'Modifier le nombre de tirage';

  @override
  String get listeTAche => 'Liste des tâches';

  @override
  String get explicationRefairTAche => 'Tu peux refaire le tirage';

  @override
  String get messageAttention =>
      '⚠️ Si tu as déjà un tirage quotidien en cours, en modifiant la liste celui-ci sera annulé.\n Si tu as déjà tes points tu n\'auras pas plus d\'XP';

  @override
  String get regleTirage => 'Règle de tirage';

  @override
  String get reset => 'reset';

  @override
  String get attenteTirage => 'En attente d\'un tirage';

  @override
  String get actionTirage => 'Faire le tirage';

  @override
  String get avancementQuete => 'Avancement des quêtes';

  @override
  String xpNiveau(int xpByLevel, int maxXpByLevel) {
    return 'Xp pour le niveau  $xpByLevel / $maxXpByLevel';
  }

  @override
  String get taches => 'Tâches';

  @override
  String get pointBonus => 'Points Bonus';

  @override
  String get fonctionnement => 'Fonctionnement';

  @override
  String get scoreBingo => 'Score du Bingo';

  @override
  String get progressionquot => 'Progression global pour la journée';

  @override
  String get allerValidBing => 'Aller valider le bingo';

  @override
  String get pointBonusSuivi => 'Aller valider le bingo';

  @override
  String dentScore(int toothScore) {
    return 'Score de lavage de dents : $toothScore';
  }

  @override
  String nbrLavageRestant(int nbCleantooth) {
    return 'Lave toi encore $nbCleantooth les dents pour avoir l\'Xp maximal!';
  }

  @override
  String get validNbLavage =>
      'Tu t\'es lavé le nombre recommandé de fois! Bravo';

  @override
  String get redictDent => 'Aller vers le lavage de dent';

  @override
  String defouleScore(int defouleScoreNb) {
    return 'Score de record de tappe défoule $defouleScoreNb';
  }

  @override
  String resteDefoule(int nbRecord) {
    return 'Il te reste $nbRecord records à battre pour aujourd\'hui';
  }

  @override
  String get felicitationRecord =>
      'Bravo tu as battu 4 records aujourdhui. \n Tu as gagné l\'XP maximal pour ce bonus';

  @override
  String get redirectDefoul => 'Va battre des records';

  @override
  String get regleNiveau => 'Règle des niveaux ';

  @override
  String explainXp(int maxXpByLevel) {
    return 'Tous les $maxXpByLevel d\'Xp le niveau augmente et cela débloque des grades spectaculaires !';
  }

  @override
  String get regleReinitialisation => 'Règle de réinitialisation ';

  @override
  String reinitHeure(int reinitHours) {
    return 'L\'heure de réinitialisation des scores quotidien est $reinitHours H.';
  }

  @override
  String get explainReinit =>
      'Elle configurable dans les paramètres de l\'application 🤓';

  @override
  String get bingoExplainPoint => 'Obternir des points avec le bingo ';

  @override
  String get bingoCount => '4 tâches remplis = 5 points d\'Xp 🏆';

  @override
  String get explainTache => 'Obternir des points avec le tirage des tâches ';

  @override
  String get countTAchePoint =>
      'Réalise les tâches piochées pour gagner 5 points 🏆.';

  @override
  String get explainDefoule => 'Obternir des points avec les jeux bonus ';

  @override
  String get explainDent =>
      'L\'aide au brossage de dent et le jeu pour défouler peut apporter des points bonus.';

  @override
  String get dentPoint =>
      'Tu auras 5 points par réalisation de tâches bonus 🏆 ';

  @override
  String get maxPontAct =>
      'Tu peux accumuler au maximum 15 points par activité bonus et par jour. ';

  @override
  String get scoreTacheCount => 'Score des taches';

  @override
  String actuelNombreTache(int numberOfTrue) {
    return 'Actuellement tu as fais $numberOfTrue tâches.';
  }

  @override
  String nbTacheRestantes(int numberOfTrue) {
    return 'Il te reste $numberOfTrue pour valider la quête.';
  }

  @override
  String get redirectTaches => 'Aller valider ses tâches';

  @override
  String get modifHoraire => 'Modification d\'horaires';

  @override
  String get validMajAlarm => 'Les alarmes sont mises à jour.';

  @override
  String get attentionPerteDonnee => '⚠️ Toutes tes données seront perdues.';

  @override
  String get configProfil => 'Configuration du profil';

  @override
  String get pseudo => 'Pseudo';

  @override
  String get warningPseudoVide => 'Champs du pseudo vide';

  @override
  String get validMajPseudo => 'Pseudo mis à jour avec succès !';

  @override
  String get enregistrePseudo => 'Enregistrer le pseudo';

  @override
  String get gestionProfil => 'Gestion du profil';

  @override
  String get choixHeure => 'Choix des heures';

  @override
  String get modifChoixNotif => 'Modifier les notifications';

  @override
  String get aPropos => 'À propos';

  @override
  String get bienvenuOnboarding => 'Bienvenue sur TDAH\'elp ! 👋';

  @override
  String get explainApp =>
      'Une application pour t\'aider à organiser ta journée';

  @override
  String get persoAvatar => 'Personnalise ton avatar 👤';

  @override
  String get explainPersoAvatar =>
      'Configure ta photo et ton pseudo pour une personnalisation de l\'expérience.';

  @override
  String get persoProfil => 'Personnalise ton profil ⚙️';

  @override
  String get explainPersoProfil =>
      'Configure tes heures préférées dans les paramètres';

  @override
  String get bingoQuotOnBoard => 'Bingo quotidien 🎯';

  @override
  String get explainBingoQuot => 'Valide toutes le bingo au fil de la journée';

  @override
  String get tacheQuot => 'Tire Tache quotidien 🎰';

  @override
  String get explainTacheQuot =>
      'Tire le nombre que tu veux de tache au hasard et réalise les';

  @override
  String get notificationTitre => 'Notifications 🔔';

  @override
  String get explainNotificationTitre =>
      'Reçois des rappels pour ne rien oublier';

  @override
  String get descriptionApp =>
      'Une application conçue pour accompagner les personnes atteintes de TDAH dans leurs routines quotidiennes.';

  @override
  String get developBy => 'Développé par';

  @override
  String get politiqueConf => 'Politique de confidentialité';

  @override
  String get redirectSite => 'Voir sur le site';

  @override
  String errorRedirect(String url) {
    return 'Impossible d’ouvrir $url';
  }

  @override
  String get modifTimer => 'Modification du timer';

  @override
  String get saisieTimerSecond =>
      'Saisie la durée souhaité du timer en seconde.';

  @override
  String get nbSecondMax => 'Nombre maximal de seconde : 600';

  @override
  String get warningSupRecord =>
      '⚠️ La modification va supprimer le record enregistré ⚠️';

  @override
  String get temps => 'Temps';

  @override
  String get tempsSecond => 'Temps en second';

  @override
  String get tempsMax => 'Nombre de tache maximal => 600';

  @override
  String get succesMajTime => '✅ Timer mis à jour avec succès !';

  @override
  String get errorMajtime => '⚠️ Erreur lors de la mise à jour';

  @override
  String scorePerso(int score) {
    return 'Ton score :$score';
  }

  @override
  String get resultats => 'Résultats';

  @override
  String messageFinScore(int score) {
    return 'Tu as  un score de : $score tapes !';
  }

  @override
  String get erreurReinitScore => '⚠️ Impossible de réinitialiser le score';

  @override
  String get remiseAzero => 'Remise à 0';

  @override
  String get lerecord => 'Le record :';

  @override
  String get tempsPartie => 'Temps d\'une partie :';

  @override
  String get modifierTimer => 'Modifier timer';

  @override
  String get scoreReinitValid => '✅ Score réinitialisé';

  @override
  String erreurAccesBingo(String titleMoment) {
    return '⏰ La période $titleMoment n\'est plus accessible';
  }

  @override
  String get erreurInitCarte =>
      'Désolé les cartes du bingo n\'ont pas pu être initialisées';

  @override
  String get erreurMajRappel => '⚠️ Les rappels n\'ont pas pu être programmés';

  @override
  String get erreurChargeNiveau => '⚠️ Impossible de charger le niveau';

  @override
  String get erreurChargeScore => '⚠️ Impossible de charger le score ';

  @override
  String get erreurChargeTime => '⚠️ Impossible de charger la durée du jeu';

  @override
  String get erreurReinit => '⚠️ La durée du jeu n\'a pas pu être réinitialisé';

  @override
  String get erreurMajHeur => '⚠️ L\'heure n\'a pas pu être mis à jour';

  @override
  String get erreurChargerHeure =>
      '⚠️L\'heure de réinitialisation n\'a pas pu être chargée';

  @override
  String get erreurReinitTimer =>
      '⚠️ La durée du jeu n\'a pas pu être réinitialisé';

  @override
  String get erreurChargeXP => '⚠️ Impossible de charger l\'XP global';

  @override
  String get erreurChargeEtatTache =>
      '⚠️ Impossible de charger l\'état des tâches';

  @override
  String get erreurCritiqueCharge =>
      '⚠️ Erreur critique lors de la réinitialisation quotidienne';

  @override
  String get faireLit => 'Faire ton lit';

  @override
  String get laverDent => 'Laver les dents';

  @override
  String get prendreTraitement => 'Prendre le traitement';

  @override
  String get douche => 'Douche';

  @override
  String get boire => 'Boire';

  @override
  String get manger => 'Manger';

  @override
  String get soin => 'Prends soin de toi';

  @override
  String get chosePositive => 'Trouve 3 choses positives';

  @override
  String get faisLaVaisselle => 'Fais la vaisselle';

  @override
  String get prepaDemain => 'Prépare tes affaires pour demain';

  @override
  String get finEcran => 'Occupe toi sans écran';

  @override
  String get reveil => 'Règle le réveil';

  @override
  String get laveDouche => 'Nettoyer la douche/ baignoire';

  @override
  String get poussiere => 'Faire la poussiere dans une pièce';

  @override
  String get listCourse => 'Préparer une liste de course';

  @override
  String get comptes => 'Faire ses comptes';

  @override
  String get laveWc => 'Nettoyer les WC';

  @override
  String get poubelles => 'Sortir les poubelles';

  @override
  String get permSup => 'Permissions supplémentaires requises';

  @override
  String get explainAndPermsup =>
      'Pour que les notifications fonctionnent, tu dois :\n\n1. Autoriser les \'Alarmes et rappels\'\n2. Désactiver l\'optimisation batterie\n3. Activer le démarrage automatique\n\nClique sur \'Ouvrir\' pour accéder aux paramètres.';

  @override
  String get demandeActivNotif =>
      'Active les notifications pour recevoir les rappels';

  @override
  String get notifDesact => 'Notifications désactivées';

  @override
  String get tirage => 'tirage';

  @override
  String get liste => 'liste';

  @override
  String get grade_0 => 'Explorateur';

  @override
  String get grade_desc_0 => 'Tout voyage commence par une exploration.';

  @override
  String get grade_1 => 'Endurant';

  @override
  String get grade_desc_1 =>
      'Ton voyage commence à prendre forme tu tiens bien.';

  @override
  String get grade_2 => 'Obstiné';

  @override
  String get grade_desc_2 => 'Tu veux aller au bout, ça se sent.';

  @override
  String get grade_3 => 'Têtu';

  @override
  String get grade_desc_3 =>
      'D’habitude c’est pas un compliment mais là c’est plus que ça.';

  @override
  String get grade_4 => 'Maitre de la Routine';

  @override
  String get grade_desc_4 => 'Tu es le Yoda des habitudes : sage et constant.';

  @override
  String get grade_5 => 'Seigneur des Tâches';

  @override
  String get grade_desc_5 => 'Ta notoriété commence à faire du bruit.';

  @override
  String get grade_6 => 'Roi de l’organisation';

  @override
  String get grade_desc_6 => 'Ta gestion du quotidien n’a plus de limite.';

  @override
  String get grade_7 => 'Dominateur des entraves';

  @override
  String get grade_desc_7 => 'Tout le monde s’agenouille à ton passage.';

  @override
  String get grade_8 => 'Ange de l’habitude';

  @override
  String get grade_desc_8 => 'Tu voles au dessus des difficultés.';

  @override
  String get grade_9 => 'Être suprême de la vie quotidienne';

  @override
  String get grade_desc_9 => 'La vie quotidienne n’a plus de secret.';

  @override
  String get grade_10 => 'Dieu du quotidien';

  @override
  String get grade_10_desc =>
      'On ne peut t’arrêter maintenant, tu nous domines tous.';

  @override
  String get grad_error => 'Erreur';

  @override
  String get grad_error_desc => 'Impossible de charger le grade';

  @override
  String get langue => 'Langue';

  @override
  String get french => 'Français';

  @override
  String get english => 'Anglais';

  @override
  String get spanish => 'Espagnol';

  @override
  String get deutsche => 'Allemand';

  @override
  String get choisiLangue => 'Merci de sélectionner une langue';

  @override
  String get succesLangue => '✅ La langue a bien été mise à jour';

  @override
  String get erreurLangue => '⛔️ La langue n\'a pas pu être mise à jour';
}
