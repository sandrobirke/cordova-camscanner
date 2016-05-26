#import "CordovaCamscanner.h"
#import <Cordova/CDVPlugin.h>
#import <CamScannerOpenAPIFramework/CamScannerOpenAPIController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ISBlockActionSheet.h"

@interface CordovaCamscanner () <UIApplicationDelegate>
@end

@implementation CordovaCamscanner

@synthesize command;

UIImage *srcImage;

- (void) scan: (CDVInvokedUrlCommand*)mycommand
{
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"entering plugin" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
   NSString *srcUri = [mycommand.arguments objectAtIndex:0];
   NSString *appKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CamscannerAppKey"];
   NSURL *asseturl = [NSURL URLWithString:srcUri];

   self.command = mycommand;

   ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
   {
       ALAssetRepresentation *rep = [myasset defaultRepresentation];
       @autoreleasepool {
           CGImageRef iref = [rep fullScreenImage];
           if (iref) {

               UIImage *srcImage = [UIImage imageWithCGImage:iref];
               
               NSArray *applications = [CamScannerOpenAPIController availableApplications];
               NSMutableArray *appNames = [[NSMutableArray alloc] init];
               for (NSString *application in applications)
               {
                   NSString *appName = [self appName:application];
                   if ([appName length] > 0)
                   {
                       [appNames addObject:appName];
                   }
               }

               if ([applications count] > 0)
               {
                   @try {
                       ISBlockActionSheet *actionSheet = [[ISBlockActionSheet alloc] initWithTitle:@"Choose application" cancelButtonTitle:@"Cancel" cancelBlock:^{
                           
                       } destructiveButtonTitle:nil destructiveBlock:^{
                           
                       } otherButtonTitles:appNames otherButtonBlock:^(NSInteger index) {
                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"calling scanner" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
                           [CamScannerOpenAPIController sendImage:srcImage toTargetApplication:CamScannerLite appKey:appKey subAppKey:nil];
                       }];
                       [actionSheet showInView:self.viewController.view];
                   } @catch (NSException *exception) {
                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Can't get image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                       [alertView show];
                   }
               }
               else
               {
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"You should install CamScanner First" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                   [alertView show];
               }
           }
       }
   };

   ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
   {
       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Can't get image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
       [alertView show];
   };

   ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
   [assetslibrary assetForURL:asseturl resultBlock:resultblock failureBlock:failureblock];

}

- (void) returnBase64: (NSString*) base64EncodedString {
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"sending result again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
   CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:base64EncodedString];
   [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSString *) appName:(NSString *) inputName
{
    if ([inputName isEqualToString:CamScannerLite])
    {
        return @"CamScanner Free";
    }
    if ([inputName isEqualToString:CamScanner])
    {
        return @"CamScanner+";
    }
    if ([inputName isEqualToString:CamScannerPro])
    {
        return @"CamScanner Pro";
    }
    if ([inputName isEqualToString:CamScannerHD])
    {
        return @"CamScanner HD";
    }
    if ([inputName isEqualToString:CamScannerHDPro])
    {
        return @"CamScanner HD Pro";
    }
    return nil;
}

@end
