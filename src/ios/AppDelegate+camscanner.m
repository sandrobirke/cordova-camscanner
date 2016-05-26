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
   UIAlertView *alertView6 = [[UIAlertView alloc] initWithTitle:nil message:@"app delegate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView6 show];
   if ([CamScannerOpenAPIController isSourceApplicationCamScanner:sourceApplication])
   {
   UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:nil message:@"is source application ok" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView7 show];
       NSDictionary *userInfo = [CamScannerOpenAPIController userInfoFromURL:url andSourceApplication:sourceApplication];
       NSString *fileFormat = [userInfo objectForKey:kReturnFileType];
       NSData *data = [CamScannerOpenAPIController getJPEGDataFromCamScannerWithUserInfo:userInfo];
       NSString *encodedString = [data base64EncodedStringWithOptions:0];
       UIAlertView *alertView8 = [[UIAlertView alloc] initWithTitle:nil message:@"sending result" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView8 show];
    CordovaCamscanner *camscanner = [self.viewController getCommandInstance:@"CordovaCamscanner"];
    UIAlertView *alertView9 = [[UIAlertView alloc] initWithTitle:nil message:camscanner.command.callbackId delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
       [alertView9 show];
       [camscanner returnBase64:encodedString];
   }
   return YES;
}

@end
