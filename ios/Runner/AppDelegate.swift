import UIKit
import Flutter
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // ⚠️ IMPORTANT : Définir le delegate pour les notifications
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "alarm_channel",
                                      binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
      switch call.method {
      case "openAppSettings":
        if let url = URL(string: UIApplication.openSettingsURLString) {
          if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            result(nil)
          } else {
            result(FlutterError(code: "UNAVAILABLE",
                              message: "Cannot open settings",
                              details: nil))
          }
        }
        
      case "checkNotificationPermission":
        UNUserNotificationCenter.current().getNotificationSettings { settings in
          let authorized = settings.authorizationStatus == .authorized
          result(authorized)
        }
        
      case "requestNotificationPermission":
        UNUserNotificationCenter.current().requestAuthorization(
          options: [.alert, .sound, .badge]
        ) { granted, error in
          result(granted)
        }
        
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // ⚠️ NOUVEAU : Gérer quand l'utilisateur tape sur une notification (app au premier plan)
  @available(iOS 10.0, *)
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    // Afficher la notification même si l'app est au premier plan
    completionHandler([.alert, .sound, .badge])
  }
  
  // ⚠️ NOUVEAU : Gérer quand l'utilisateur tape sur une notification (app en arrière-plan ou fermée)
  @available(iOS 10.0, *)
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    print("🍎 AppDelegate: Notification tappée !")
    print("🍎 Notification ID: \(response.notification.request.identifier)")
    print("🍎 Payload: \(response.notification.request.content.userInfo)")
    
    // ⚠️ CRUCIAL : Appeler le parent pour que flutter_local_notifications soit informé
    super.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
  }
}