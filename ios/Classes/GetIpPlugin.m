#import "GetIpPlugin.h"
#import <get_ip/get_ip-Swift.h>

@implementation GetIpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGetIpPlugin registerWithRegistrar:registrar];
}
@end
