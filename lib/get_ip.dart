import 'dart:async';

import 'package:flutter/services.dart';

class GetIp {
  static const MethodChannel _channel = const MethodChannel('get_ip');

  ///
  /// Android: Returns the users IPv4-Address.
  ///          Can be null.
  ///     iOS: Returns either IPv4- or IPv6-Address.
  ///          Can be null.
  static Future<String> get ipAddress async {
    final String ip = await _channel.invokeMethod('getIpAdress');
    return ip;
  }

  ///
  /// Android: returns the users IPv6-Address.
  /// iOS: null
  static Future<String> get ipv6Address async {
    final String ip = await _channel.invokeMethod('getIpV6Adress');
    return ip;
  }
}
