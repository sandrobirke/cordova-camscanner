#import "CordovaCamscanner.h"
#import <Cordova/CDVPlugin.h>
#import <CamScannerOpenAPIFramework/CamScannerOpenAPIController.h>

@implementation CordovaCamscanner
- (void) scan: (CDVInvokedUrlCommand*)command
{
    NSString *appKey =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CamscannerAppKey"];
    NSString *srcUri = [command.arguments objectAtIndex:0];
    NSString *outputUri = [command.arguments objectAtIndex:1];
    UIImage *srcImage = [UIImage imageWithContentsOfFile:srcUri];
    
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
        //ISBlockActionSheet *UIActionSheet = [[ISBlockActionSheet alloc] initWithTitle:@"Choose application" cancelButtonTitle:@"Cancel" cancelBlock:^{
            
        //} destructiveButtonTitle:nil destructiveBlock:^{
            
        //} otherButtonTitles:appNames otherButtonBlock:^(NSInteger index) {
            [CamScannerOpenAPIController sendImage:srcImage toTargetApplication:[applications objectAtIndex:0] appKey:appKey subAppKey:nil];
        //}];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"You should install CamScanner First" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
   //pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:appKey];
   //[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
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