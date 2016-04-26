#import <Cordova/CDVPlugin.h>

@interface CordovaCamscanner : CDVPlugin

- (void)scan: (CDVInvokedUrlCommand*)command;

@end