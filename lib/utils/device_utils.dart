import 'dart:io' show Platform;

class DeviceUtils {
  static bool isBatteryOptimizationNeeded() {
    if (!Platform.isAndroid) return false;

    final brand = Platform.operatingSystemVersion.toLowerCase();
    return brand.contains('xiaomi') ||
        brand.contains('huawei') ||
        brand.contains('oppo') ||
        brand.contains('vivo') ||
        brand.contains('realme') ||
        brand.contains('oneplus');
  }
}
