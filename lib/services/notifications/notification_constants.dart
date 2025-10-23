class NotificationConstants {
  // IDs des notifications
  static const int morningNotificationId = 1;
  static const int midiNotificationId = 2;
  static const int soirNotificationId = 3;
  static const int coucherNotificationId = 4;

  // Identifiants iOS
  static const String iosCategoryId = 'tdahelpe_category';
  static const String iosThreadId = 'tdahelpe_thread';
  static const String iosActionId = 'open_action';

  // Messages
  static const Map<int, Map<String, String>> notificationMessages = {
    morningNotificationId: {
      'title': '🌅 La journée commence !!',
      'body': 'Passe une excellente journée',
    },
    midiNotificationId: {
      'title': '🌅 La période du matin va finir !!',
      'body': 'N\'oublie pas de valider tes tâches du matin',
    },
    soirNotificationId: {
      'title': '🍽️ La période du midi va finir !!',
      'body': 'N\'oublie pas de valider tes tâches du midi',
    },
    coucherNotificationId: {
      'title': '⭐ Prêt pour dormir?',
      'body': 'N\'oublie pas de valider tes tâches avant de dormir',
    },
  };

  static String getTitle(int id) {
    return notificationMessages[id]?['title'] ?? 'Notification';
  }

  static String getBody(int id) {
    return notificationMessages[id]?['body'] ?? '';
  }

  static ({String title, String body}) getMessage(int id) {
    final data = notificationMessages[id];
    return (title: data?['title'] ?? 'Notification', body: data?['body'] ?? '');
  }

  // Conversion ID → Moment
  static String getMomentFromId(int id) {
    switch (id) {
      case morningNotificationId:
        return 'matin';
      case midiNotificationId:
        return 'midi';
      case soirNotificationId:
        return 'soir';
      case coucherNotificationId:
        return 'coucher';
      default:
        return 'inconnu';
    }
  }
}
