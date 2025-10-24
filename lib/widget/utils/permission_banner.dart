import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/services/notifications/android_notification_handler.dart';
import 'package:app_settings/app_settings.dart';

class PermissionBanner extends StatefulWidget {
  const PermissionBanner({super.key});

  @override
  State<PermissionBanner> createState() => _PermissionBannerState();
}

class _PermissionBannerState extends State<PermissionBanner> {
  bool _showBanner = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  // ✅ VÉRIFIE LES PERMISSIONS À CHAQUE BUILD
  Future<void> _checkPermissions() async {
    if (!mounted) return;
    
    bool needsWarning = false;
    
    if (Platform.isAndroid) {
      // Vérifier en temps réel
      needsWarning = !await AndroidNotificationHandler.checkPermissions();
    } else if (Platform.isIOS) {
      // Pour iOS, vérifier via SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      needsWarning = prefs.getBool('needs_permission_warning') ?? false;
    }
    
    if (mounted) {
      setState(() {
        _showBanner = needsWarning;
        _isChecking = false;
      });
    }
  }

  Future<void> _dismissBanner() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('needs_permission_warning', false);
    
    if (mounted) {
      setState(() {
        _showBanner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ne rien afficher pendant la vérification
    if (_isChecking) {
      return SizedBox.shrink();
    }

    if (!_showBanner) {
      return SizedBox.shrink();
    }

    return Material(
      elevation: 4,
      child: Container(
        color: Colors.orange.shade100,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Icon(
                Icons.notifications_off,
                color: Colors.orange.shade700,
                size: 24,
              ),
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
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Tu ne recevras pas de rappels',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () async {
                  if (Platform.isAndroid) {
                    await AndroidNotificationHandler.openSettings();
                  } else if (Platform.isIOS) {
                    await AppSettings.openAppSettings();
                  }
                  
                  // Attendre 2 secondes et revérifier
                  await Future.delayed(Duration(seconds: 2));
                  _checkPermissions();
                },
                icon: Icon(Icons.settings, size: 16),
                label: Text('Activer', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20),
                onPressed: _dismissBanner,
                tooltip: 'Masquer (jusqu\'à demain)',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

