#import <Cordova/CDVPlugin.h>
#import <Cordova/CDV.h>

@interface CordovaCamscanner : CDVPlugin

@property (strong, nonatomic) CDVInvokedUrlCommand *command;

@end

@interface CordovaCamscannerStaticService : NSObject

+(CordovaCamscannerStaticService*) instance;

@property (strong, nonatomic) CDVInvokedUrlCommand* command;
@property (strong, nonatomic) CDVPlugin* plugin;

@end
