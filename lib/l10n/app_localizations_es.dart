// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'Español';

  @override
  String get momentAff => 'Hora de reinicio';

  @override
  String momentRepas(String moment) {
    return 'Hora de $moment';
  }

  @override
  String get hour => 'hora';

  @override
  String get decidHour => 'Horario decidido';

  @override
  String get enterNumber => 'Por favor, introduce un número';

  @override
  String get errorTypeNumber => 'Por favor, introduce un número válido';

  @override
  String get errorHourToHeight => 'Hora inválida, debe ser inferior a 24';

  @override
  String get errorHourNegative => 'Hora inválida, debe ser positiva';

  @override
  String get bestRecord => '¡Has batido el récord!';

  @override
  String get egalRecord => '¡Has igualado el récord!';

  @override
  String recordMessage(int recordTape) {
    return 'El récord es de $recordTape toques.';
  }

  @override
  String labelFinAcces(int heure) {
    return 'Fin de acceso a las ${heure}H';
  }

  @override
  String labelOuverture(int heure) {
    return 'Apertura a las ${heure}H';
  }

  @override
  String get matin => 'Mañana';

  @override
  String get reveilMoment => 'Despertar';

  @override
  String get midi => 'Mediodía';

  @override
  String get soir => 'Tarde/Noche';

  @override
  String get coucher => 'Dormir';

  @override
  String get defouleToi => 'Desahógate';

  @override
  String get tireTache => 'Saca una tarea';

  @override
  String get bingoQuot => 'Bingo Diario';

  @override
  String get aideDents => 'Ayuda dental';

  @override
  String scoreMoment(String moment, int scoreByMoment) {
    return 'Puntuación de $moment: $scoreByMoment/4';
  }

  @override
  String get permissionMiss => '⚠️ Permisos faltantes';

  @override
  String get instructionsAndroidNotifications =>
      'Para que las notificaciones funcionen, debes:\n\n1. En ajustes de la app, en batería elegir: Sin restricciones\n2. Desmarcar pausar actividad\n3. Autorizar notificaciones\n\nHaz clic en \"Abrir\" para ir a los ajustes.';

  @override
  String get instructionsIOSNotifications =>
      'Para que las notificaciones funcionen, debes activarlas en los ajustes.\n\n¿Quieres abrir los ajustes ahora?';

  @override
  String get later => 'Más tarde';

  @override
  String get ouvrirParam => 'Abrir ajustes';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get decriptionNotif => 'TDAHelpe usa notificaciones para:';

  @override
  String get rappelTask => '📅 Recordarte tus tareas diarias';

  @override
  String get routineHelp => '🎯 No olvidar nada en tu rutina';

  @override
  String get nombreNotif => 'Recibirás un máximo de 4 notificaciones al día.';

  @override
  String get notifChoix =>
      'Puedes aceptar o no las notificaciones en los ajustes.';

  @override
  String get modifNotifChoix =>
      'La modificación de las notificaciones está disponible en ajustes.';

  @override
  String get refusNotif =>
      'Sin notificaciones la app funcionará, pero no tendrás recordatorios automáticos.';

  @override
  String get notNow => 'Ahora no';

  @override
  String get autorise => 'Autorizar';

  @override
  String get ferme => 'Cerrar';

  @override
  String get aucun => 'ninguno';

  @override
  String get terminer => '¡Terminar!';

  @override
  String get valider => 'Validar';

  @override
  String get confirmer => 'Confirmar';

  @override
  String get reinit => 'Reiniciar';

  @override
  String get retour => 'Volver';

  @override
  String get oui => 'sí';

  @override
  String get non => 'no';

  @override
  String get annuler => 'Cancelar';

  @override
  String get commencer => 'Empezar';

  @override
  String get suivant => 'Siguiente';

  @override
  String get retry => 'Reintentar';

  @override
  String get ouvrir => 'Abrir';

  @override
  String get activer => 'Activar';

  @override
  String get parametre => 'Ajustes';

  @override
  String get accueil => 'Inicio';

  @override
  String get bienvenue => 'Bienvenido';

  @override
  String get score => 'Puntuación';

  @override
  String get formatErrorMusic =>
      'Formato de audio no soportado. Elige MP3, M4A, WAV o AAC.';

  @override
  String get noAccessFichier =>
      'Imposible acceder al archivo. Elige un archivo local.';

  @override
  String get importImpossible => '⚠️ Imposible importar la música';

  @override
  String get error => '❌ Ha ocurrido un error';

  @override
  String get pauseAll => 'Pausa Global';

  @override
  String get finValidation => 'Fin y validación';

  @override
  String get pause => 'Pausa';

  @override
  String get play => 'Lanzar';

  @override
  String get selectMusique => 'Seleccionar música';

  @override
  String get iosErrorImport =>
      'Importación de sonido solo desde Archivos, iCloud o Descargas';

  @override
  String get musiceEcoute => 'Música escuchada';

  @override
  String get addTache => 'Añadir actividades';

  @override
  String get newTaskName => 'Nombre de la nueva tarea:';

  @override
  String get activityName => 'Nombre de la actividad';

  @override
  String get estimationDuree => 'Estimación de duración:';

  @override
  String get court => 'corto';

  @override
  String get moyen => 'medio';

  @override
  String get long => 'largo';

  @override
  String get tresLong => 'muy largo';

  @override
  String get saisiNomAct => 'Introduce un nombre de actividad';

  @override
  String get dureeAct => 'Selecciona una duración';

  @override
  String get succesAjoutAct => '¡Tarea añadida con éxito!';

  @override
  String get modifTache => 'Modificación de la tarea';

  @override
  String get succesModif => '¡Tarea modificada con éxito!';

  @override
  String get nombreTirage => 'Número de sorteos';

  @override
  String actuelNombreTirage(int tachesTimenombreT) {
    return 'Actualmente se sacan $tachesTimenombreT tareas.';
  }

  @override
  String get nombrePiocheDemande => '¿Cuántas tareas quieres sacar?';

  @override
  String get nombrePioche => 'Número de tareas sacadas';

  @override
  String get saisieNombre => 'Introduce un número';

  @override
  String get saisienombreInvalide => 'Introduce un número válido';

  @override
  String get nombreTacheMax => 'El número máximo de tareas diarias es 10';

  @override
  String nombrePiocheSupMax(int tachesTimetaches) {
    return 'Máximo de tareas => $tachesTimetaches';
  }

  @override
  String get listeEnregistre => 'Lista guardada';

  @override
  String get explicationCouleur =>
      'Modifica la tarea pulsando sobre ella.\nExplicación de colores:\nVerde -> corto\nAmarillo -> medio\nNaranja -> largo\nRojo -> muy largo';

  @override
  String supprimeTache(String tacheName) {
    return '¿Eliminar $tacheName?';
  }

  @override
  String get ajouterTache => 'Añadir una tarea';

  @override
  String get modifierNombreTirage => 'Modificar número de sorteos';

  @override
  String get listeTAche => 'Lista de tareas';

  @override
  String get explicationRefairTAche => 'Puedes repetir el sorteo';

  @override
  String get messageAttention =>
      '⚠️ Si ya tienes un sorteo en curso, al modificar la lista se anulará.\nSi ya tienes tus puntos, no ganarás más XP.';

  @override
  String get regleTirage => 'Regla de sorteo';

  @override
  String get reset => 'reiniciar';

  @override
  String get attenteTirage => 'Esperando sorteo';

  @override
  String get actionTirage => 'Hacer el sorteo';

  @override
  String get avancementQuete => 'Progreso de misiones';

  @override
  String xpNiveau(int xpByLevel, int maxXpByLevel) {
    return 'XP para el nivel $xpByLevel / $maxXpByLevel';
  }

  @override
  String get taches => 'Tareas';

  @override
  String get pointBonus => 'Puntos Bonus';

  @override
  String get fonctionnement => 'Funcionamiento';

  @override
  String get scoreBingo => 'Puntuación Bingo';

  @override
  String get progressionquot => 'Progreso global del día';

  @override
  String get allerValidBing => 'Ir a validar el bingo';

  @override
  String get pointBonusSuivi => 'Ir a validar el bingo';

  @override
  String dentScore(int toothScore) {
    return 'Puntuación lavado de dientes: $toothScore';
  }

  @override
  String nbrLavageRestant(int nbCleantooth) {
    return '¡Lávate los dientes $nbCleantooth veces más para el XP máximo!';
  }

  @override
  String get validNbLavage =>
      '¡Te has lavado los dientes las veces recomendadas! Bravo';

  @override
  String get redictDent => 'Ir al lavado de dientes';

  @override
  String defouleScore(int defouleScoreNb) {
    return 'Récord de toques desahogo: $defouleScoreNb';
  }

  @override
  String resteDefoule(int nbRecord) {
    return 'Te quedan $nbRecord récords por batir hoy';
  }

  @override
  String get felicitationRecord =>
      'Bravo, has batido 4 récords hoy. \n Has ganado el XP máximo para este bonus';

  @override
  String get redirectDefoul => 'Ve a batir récords';

  @override
  String get regleNiveau => 'Regla de niveles';

  @override
  String explainXp(int maxXpByLevel) {
    return '¡Cada $maxXpByLevel de XP el nivel aumenta y desbloquea rangos espectaculares!';
  }

  @override
  String get regleReinitialisation => 'Regla de reinicio';

  @override
  String reinitHeure(int reinitHours) {
    return 'La hora de reinicio de puntuaciones diarias es las $reinitHours H.';
  }

  @override
  String get explainReinit =>
      'Es configurable en los ajustes de la aplicación 🤓';

  @override
  String get bingoExplainPoint => 'Obtener puntos con el bingo';

  @override
  String get bingoCount => '4 tareas completadas = 5 puntos de XP 🏆';

  @override
  String get explainTache => 'Obtener puntos con el sorteo de tareas';

  @override
  String get countTAchePoint =>
      'Realiza las tareas sacadas para ganar 5 puntos 🏆.';

  @override
  String get explainDefoule => 'Obtener puntos con juegos bonus';

  @override
  String get explainDent =>
      'La ayuda al cepillado y el juego de desahogo pueden dar puntos bonus.';

  @override
  String get dentPoint => 'Tendrás 5 puntos por realizar tareas bonus 🏆';

  @override
  String get maxPontAct =>
      'Puedes acumular máximo 15 puntos por actividad bonus al día.';

  @override
  String get scoreTacheCount => 'Puntuación de tareas';

  @override
  String actuelNombreTache(int numberOfTrue) {
    return 'Actualmente has hecho $numberOfTrue tareas.';
  }

  @override
  String nbTacheRestantes(int numberOfTrue) {
    return 'Te quedan $numberOfTrue para validar la misión.';
  }

  @override
  String get redirectTaches => 'Ir a validar tareas';

  @override
  String get modifHoraire => 'Modificación de horarios';

  @override
  String get validMajAlarm => 'Alarmas actualizadas.';

  @override
  String get attentionPerteDonnee => '⚠️ Todos tus datos se perderán.';

  @override
  String get configProfil => 'Configuración del perfil';

  @override
  String get pseudo => 'Apodo';

  @override
  String get warningPseudoVide => 'Campo de apodo vacío';

  @override
  String get validMajPseudo => '¡Apodo actualizado con éxito!';

  @override
  String get enregistrePseudo => 'Guardar apodo';

  @override
  String get gestionProfil => 'Gestión del perfil';

  @override
  String get choixHeure => 'Elección de horas';

  @override
  String get modifChoixNotif => 'Modificar notificaciones';

  @override
  String get aPropos => 'Acerca de';

  @override
  String get bienvenuOnboarding => '¡Bienvenido a TDAH\'elp! 👋';

  @override
  String get explainApp => 'Una aplicación para ayudarte a organizar tu día';

  @override
  String get persoAvatar => 'Personaliza tu avatar 👤';

  @override
  String get explainPersoAvatar =>
      'Configura tu foto y apodo para una experiencia personalizada.';

  @override
  String get persoProfil => 'Personaliza tu perfil ⚙️';

  @override
  String get explainPersoProfil =>
      'Configura tus horas preferidas en los ajustes';

  @override
  String get bingoQuotOnBoard => 'Bingo diario 🎯';

  @override
  String get explainBingoQuot => 'Valida el bingo a lo largo del día';

  @override
  String get tacheQuot => 'Saca tareas diarias 🎰';

  @override
  String get explainTacheQuot =>
      'Saca el número de tareas que quieras y hazlas';

  @override
  String get notificationTitre => 'Notificaciones 🔔';

  @override
  String get explainNotificationTitre =>
      'Recibe recordatorios para no olvidar nada';

  @override
  String get descriptionApp =>
      'App diseñada para acompañar a personas con TDAH en sus rutinas diarias.';

  @override
  String get developBy => 'Desarrollado por';

  @override
  String get politiqueConf => 'Política de privacidad';

  @override
  String get redirectSite => 'Ver sitio web';

  @override
  String errorRedirect(String url) {
    return 'Imposible abrir $url';
  }

  @override
  String get modifTimer => 'Modificación del temporizador';

  @override
  String get saisieTimerSecond => 'Introduce la duración deseada en segundos.';

  @override
  String get nbSecondMax => 'Máximo de segundos: 600';

  @override
  String get warningSupRecord =>
      '⚠️ La modificación borrará el récord guardado ⚠️';

  @override
  String get temps => 'Tiempo';

  @override
  String get tempsSecond => 'Tiempo en segundos';

  @override
  String get tempsMax => 'Máximo de tareas => 600';

  @override
  String get succesMajTime => '✅ ¡Temporizador actualizado!';

  @override
  String get errorMajtime => '⚠️ Error al actualizar';

  @override
  String scorePerso(int score) {
    return 'Tu puntuación: $score';
  }

  @override
  String get resultats => 'Resultados';

  @override
  String messageFinScore(int score) {
    return '¡Tienes una puntuación de $score toques!';
  }

  @override
  String get erreurReinitScore => '⚠️ Imposible reiniciar la puntuación';

  @override
  String get remiseAzero => 'Poner a 0';

  @override
  String get lerecord => 'El récord:';

  @override
  String get tempsPartie => 'Tiempo de partida:';

  @override
  String get modifierTimer => 'Modificar temporizador';

  @override
  String get scoreReinitValid => '✅ Puntuación reiniciada';

  @override
  String erreurAccesBingo(String titleMoment) {
    return '⏰ El periodo $titleMoment ya no es accesible';
  }

  @override
  String get erreurInitCarte =>
      'Lo sentimos, no se pudieron iniciar las tarjetas de bingo';

  @override
  String get erreurMajRappel => '⚠️ No se pudieron programar los recordatorios';

  @override
  String get erreurChargeNiveau => '⚠️ Imposible cargar el nivel';

  @override
  String get erreurChargeScore => '⚠️ Imposible cargar la puntuación';

  @override
  String get erreurChargeTime => '⚠️ Imposible cargar la duración del juego';

  @override
  String get erreurReinit => '⚠️ No se pudo reiniciar la duración del juego';

  @override
  String get erreurMajHeur => '⚠️ No se pudo actualizar la hora';

  @override
  String get erreurChargerHeure => '⚠️ No se pudo cargar la hora de reinicio';

  @override
  String get erreurReinitTimer => '⚠️ No se pudo reiniciar el tiempo';

  @override
  String get erreurChargeXP => '⚠️ Imposible cargar el XP global';

  @override
  String get erreurChargeEtatTache =>
      '⚠️ Imposible cargar el estado de las tareas';

  @override
  String get erreurCritiqueCharge => '⚠️ Error crítico en el reinicio diario';

  @override
  String get faireLit => 'Hacer la cama';

  @override
  String get laverDent => 'Lavar los dientes';

  @override
  String get prendreTraitement => 'Tomar el tratamiento';

  @override
  String get douche => 'Ducha';

  @override
  String get boire => 'Beber agua';

  @override
  String get manger => 'Comer';

  @override
  String get soin => 'Cuidarte';

  @override
  String get chosePositive => 'Encontrar 3 cosas positivas';

  @override
  String get faisLaVaisselle => 'Fregar los platos';

  @override
  String get prepaDemain => 'Preparar las cosas para mañana';

  @override
  String get finEcran => 'Ocuparse sin pantallas';

  @override
  String get reveil => 'Poner la alarma';

  @override
  String get laveDouche => 'Limpiar ducha/bañera';

  @override
  String get poussiere => 'Quitar el polvo de una habitación';

  @override
  String get listCourse => 'Preparar lista de la compra';

  @override
  String get comptes => 'Revisar cuentas';

  @override
  String get laveWc => 'Limpiar el WC';

  @override
  String get poubelles => 'Sacar la basura';

  @override
  String get permSup => 'Permisos adicionales requeridos';

  @override
  String get explainAndPermsup =>
      'Para que las notificaciones funcionen, debes:\n\n1. Autorizar \'Alarmas y recordatorios\'\n2. Desactivar optimización de batería\n3. Activar inicio automático\n\nHaz clic en \'Abrir\' para ir a los ajustes.';

  @override
  String get demandeActivNotif =>
      'Activa las notificaciones para recibir recordatorios';

  @override
  String get notifDesact => 'Notificaciones desactivadas';

  @override
  String get tirage => 'sorteo';

  @override
  String get liste => 'lista';

  @override
  String get grade_0 => 'Explorador';

  @override
  String get grade_desc_0 => 'Todo viaje comienza con una exploración.';

  @override
  String get grade_1 => 'Resistente';

  @override
  String get grade_desc_1 => 'Tu viaje toma forma, aguantas bien.';

  @override
  String get grade_2 => 'Obstinado';

  @override
  String get grade_desc_2 => 'Se nota que quieres llegar hasta el final.';

  @override
  String get grade_3 => 'Tercos';

  @override
  String get grade_desc_3 =>
      'Normalmente no es un cumplido, pero aquí es más que eso.';

  @override
  String get grade_4 => 'Maestro de la Rutina';

  @override
  String get grade_desc_4 => 'Eres el Yoda de los hábitos: sabio y constante.';

  @override
  String get grade_5 => 'Señor de las Tareas';

  @override
  String get grade_desc_5 => 'Tu fama empieza a hacer ruido.';

  @override
  String get grade_6 => 'Rey de la organización';

  @override
  String get grade_desc_6 => 'Tu gestión del día a día no tiene límites.';

  @override
  String get grade_7 => 'Dominador de obstáculos';

  @override
  String get grade_desc_7 => 'Todos se arrodillan a tu paso.';

  @override
  String get grade_8 => 'Ángel del hábito';

  @override
  String get grade_desc_8 => 'Vuelas por encima de las dificultades.';

  @override
  String get grade_9 => 'Ser supremo de la vida diaria';

  @override
  String get grade_desc_9 => 'La vida cotidiana ya no tiene secretos para ti.';

  @override
  String get grade_10 => 'Dios del día a día';

  @override
  String get grade_10_desc =>
      'Nada puede detenerte ahora, nos dominas a todos.';

  @override
  String get grad_error => 'Error';

  @override
  String get grad_error_desc => 'Imposible cargar el rango';

  @override
  String get langue => 'Idioma';

  @override
  String get french => 'Francés';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get deutsche => 'Alemán';

  @override
  String get choisiLangue => 'Por favor, selecciona un idioma';

  @override
  String get succesLangue => '✅ El idioma se ha actualizado correctamente';

  @override
  String get erreurLangue => '⛔️ No se ha podido actualizar el idioma';
}
