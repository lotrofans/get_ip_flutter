import 'dart:async';

import 'package:flutter/services.dart';

class GetIp {
  static const MethodChannel _channel = const MethodChannel('get_ip');

  ///
  /// Returns the users IPv4-Adress
  /// Can be null
  static Future<String> get ipAddress async {
    final String ip = await _channel.invokeMethod('getIpAdress');
    return ip;
  }

  ///
  /// Returns the users IPv6-Adress
  /// Is null on iOS
  static Future<String> get ipv6Address async {
    final String ip = await _channel.invokeMethod('getIpV6Adress');
    return ip;
  }
}
