import 'dart:async';

class PermissionState {
  // Stream pour notifier les changements
  static final StreamController<bool> _permissionStreamController =
      StreamController<bool>.broadcast();

  static Stream<bool> get permissionStream =>
      _permissionStreamController.stream;

  // Notifier qu'il faut afficher/cacher le banner
  static void notifyPermissionChanged(bool needsWarning) {
    _permissionStreamController.add(needsWarning);
  }

  // Fermer le stream (à appeler dans dispose si nécessaire)
  static void dispose() {
    _permissionStreamController.close();
  }
}
