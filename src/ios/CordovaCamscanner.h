#import <Cordova/CDVPlugin.h>
#import <Cordova/CDV.h>

@interface CordovaCamscanner : CDVPlugin

@property (strong, nonatomic) CDVInvokedUrlCommand *command;

- (void)scan: (CDVInvokedUrlCommand*)mycommand;
- (void) returnBase64: (NSString*) base64EncodedString;

@end

@interface CordovaCamscannerStaticService : NSObject

+(CordovaCamscannerStaticService*) instance;

@property (strong, nonatomic) CDVInvokedUrlCommand* command;
@property (strong, nonatomic) CDVPlugin* plugin;

@end
