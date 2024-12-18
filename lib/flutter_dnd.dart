import 'dart:async';

import 'package:flutter/services.dart';

class FlutterDnd {
  /// Unknown filter
  static const int INTERRUPTION_FILTER_UNKNOWN = 0;

  /// No notifications are suppressed.
  static const int INTERRUPTION_FILTER_ALL = 1;

  /// Allow priority notifications.
  static const int INTERRUPTION_FILTER_PRIORITY = 2;

  /// Suppress all notifications. (Turn off DND)
  static const int INTERRUPTION_FILTER_NONE = 3;

  /// Allow alarm notifications.
  static const int INTERRUPTION_FILTER_ALARMS = 4;

  static const MethodChannel _channel = const MethodChannel('flutter_dnd');

  /// Check the application has access to change the DND settings
  static Future<bool?> get isNotificationPolicyAccessGranted async {
    return await _channel.invokeMethod('isNotificationPolicyAccessGranted');
  }

  /// Takes to DND system settings.
  /// Where the application gains access to change the DND settings.
  static void gotoPolicySettings() {
    _channel.invokeMethod('gotoPolicySettings');
  }

  /// Set new interruption [filter]
  static Future<bool?> setInterruptionFilter(int filter) async {
    return await _channel.invokeMethod('setInterruptionFilter', filter);
  }

  /// Set notification policy
  /// Read more: https://developer.android.com/reference/android/app/NotificationManager.Policy
  static Future<bool?> setNotificationPolicy({
    required int priorityCategories,
    int priorityCallSenders = 0,
    int priorityMessageSenders = 0,
  }) async {
    return await _channel.invokeMethod('setNotificationPolicy', {
      'priorityCategories': priorityCategories,
      'priorityCallSenders': priorityCallSenders,
      'priorityMessageSenders': priorityMessageSenders,
    });
  }


  /// Returns currently applied notification [filter]
  static Future<int?> getCurrentInterruptionFilter() async {
    return await _channel.invokeMethod('getCurrentInterruptionFilter');
  }

  /// Returns Filter name from the [filter]
  static String getFilterName(int filter) {
    switch (filter) {
      case 1:
        return 'INTERRUPTION_FILTER_ALL';
      case 2:
        return 'INTERRUPTION_FILTER_PRIORITY';
      case 3:
        return 'INTERRUPTION_FILTER_NONE';
      case 4:
        return 'INTERRUPTION_FILTER_ALARMS';
      default:
        return 'INTERRUPTION_FILTER_UNKNOWN';
    }
  }
}
