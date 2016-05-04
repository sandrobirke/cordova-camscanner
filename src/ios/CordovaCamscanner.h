#import <Cordova/CDVPlugin.h>
#import <Cordova/CDV.h>

@interface CordovaCamscanner : CDVPlugin <UIApplicationDelegate>

@property (strong, nonatomic) CDVInvokedUrlCommand *command;

- (void)scan: (CDVInvokedUrlCommand*)mycommand;
- (void) returnBase64: (NSString*) base64EncodedString;

@end
