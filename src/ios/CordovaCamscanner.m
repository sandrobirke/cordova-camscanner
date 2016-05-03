#import "CordovaCamscanner.h"
#import <Cordova/CDVPlugin.h>
#import <CamScannerOpenAPIFramework/CamScannerOpenAPIController.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CordovaCamscanner () <UIApplicationDelegate>
@end

@implementation CordovaCamscanner

@synthesize command;

UIImage *srcImage;

- (void) scan: (CDVInvokedUrlCommand*)mycommand
{
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
               
               BOOL isCamscannerInstalled =[CamScannerOpenAPIController canOpenCamScannerLite];
               
               if (isCamscannerInstalled)
               {
                   @try {
                       [CamScannerOpenAPIController sendImage:srcImage toTargetApplication:CamScannerLite appKey:appKey subAppKey:nil];
                   } @catch (NSException *exception) {
                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Can't get image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                       [alertView show];
                   }
               }
               else
               {
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"You should install CamScanner Free First" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
   CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:base64EncodedString];
   [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
