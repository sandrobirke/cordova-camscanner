//
//  AppDelegate+camscanner.m
//  Tafs
//
//  Created by Juan Jose Guevara on 5/2/16.
//
//

#import <Foundation/Foundation.h>
#import "AppDelegate+camscanner.h"
#import "CordovaCamscanner.h"
#import <CamScannerOpenAPIFramework/CamScannerOpenAPIController.h>

@implementation AppDelegate(camscanner)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   if ([CamScannerOpenAPIController isSourceApplicationCamScanner:sourceApplication])
   {
       NSDictionary *userInfo = [CamScannerOpenAPIController userInfoFromURL:url andSourceApplication:sourceApplication];
       NSData *data = [CamScannerOpenAPIController getJPEGDataFromCamScannerWithUserInfo:userInfo];
       NSString *encodedString = [data base64EncodedStringWithOptions:0];
       CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:encodedString];
       [[CordovaCamscannerStaticService instance].plugin.commandDelegate sendPluginResult:pluginResult callbackId:[CordovaCamscannerStaticService instance].command.callbackId];
   }
   return YES;
}

@end
