import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:tdahelpe/services/notifications/ios_notification_handler.dart';
import 'package:tdahelpe/utils/permission_state.dart';

class PermissionBanner extends StatefulWidget {
  const PermissionBanner({super.key});

  @override
  State<PermissionBanner> createState() => _PermissionBannerState();
}

class _PermissionBannerState extends State<PermissionBanner> {
  bool _showBanner = false;
  StreamSubscription<bool>? _permissionSubscription;

  @override
  void initState() {
    print("😜 init de permission banner");
    super.initState();

    _checkPermissions();

    _permissionSubscription = PermissionState.permissionStream.listen((
      needsWarning,
    ) {
      setState(() {
        _showBanner = needsWarning;
      });
    });
  }

  Future<void> _checkPermissions() async {
    final prefs = await SharedPreferences.getInstance();

    final firstConnect = prefs.getBool('first_launch') ?? true;

    final needsWarning = prefs.getBool('needs_permission_warning') ?? false;



    if (needsWarning && !firstConnect) {
      setState(() {
        _showBanner = true;
      });
    }
  }

  Future<void> _dismissBanner() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('needs_permission_warning', false);

    setState(() {
      _showBanner = false;
    });
  }

  @override
  void dispose() {
    _permissionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showBanner) {
      return SizedBox.shrink();
    }

    return Container(
      color: Colors.orange.shade100,
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.orange.shade700),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Notifications désactivées',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900,
                  ),
                ),
                Text(
                  'Active les notifications pour recevoir tes rappels',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                AndroidNotificationHandler.openSettingsAndroid();
              } else if (Platform.isIOS) {
                IosNotificationHandler.openSettingsIos();
              }
              _dismissBanner();
            },
            child: Text('Activer'),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 20),
            onPressed: _dismissBanner,
          ),
        ],
      ),
    );
  }
}
