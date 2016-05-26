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

@implementation AppDelegate (camscanner)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   
       CordovaCamscanner *camscanner = [self.viewController getCommandInstance:@"CordovaCamscanner"];
       [camscanner returnBase64:@"qwerty2"];
   if ([CamScannerOpenAPIController isSourceApplicationCamScanner:sourceApplication])
   {
       NSDictionary *userInfo = [CamScannerOpenAPIController userInfoFromURL:url andSourceApplication:sourceApplication];
       NSString *fileFormat = [userInfo objectForKey:kReturnFileType];
       NSData *data = [CamScannerOpenAPIController getJPEGDataFromCamScannerWithUserInfo:userInfo];
       NSString *encodedString = [data base64EncodedStringWithOptions:0];
   }
   return YES;
}

@end
