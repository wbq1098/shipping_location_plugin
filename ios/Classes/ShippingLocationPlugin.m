#import "ShippingLocationPlugin.h"

@implementation ShippingLocationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"shipping_location_plugin"
                                     binaryMessenger:[registrar messenger]];
    ShippingLocationPlugin* instance = [[ShippingLocationPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"init" isEqualToString:call.method]) {
        result(@"init");
    } else if ([@"start" isEqualToString:call.method]) {
        result(@"start");
    } else if ([@"stop" isEqualToString:call.method]) {
        result(@"stop");
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
