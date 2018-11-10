import Flutter
import UIKit

public class SwiftGetIpPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "get_ip", binaryMessenger: registrar.messenger())
    let instance = SwiftGetIpPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(getWiFiAddress)
  }

  // Return IP address of WiFi interface (en0) as a String, or `nil`
  func getWiFiAddress() -> String? {
    var address : String?

    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
    if getifaddrs(&ifaddr) == 0 {

        // For each interface ...
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr.memory.ifa_next }

            let interface = ptr.memory

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.memory.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                if let name = String.fromCString(interface.ifa_name) where name == "en0" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.memory.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String.fromCString(hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
    }

    return address
  }
}
