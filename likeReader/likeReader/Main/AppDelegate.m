//
//  AppDelegate.m
//  JingHan
//
//  Created by ZY on 16/4/13.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "TBTabbarVC.h"
#import "TBNavigationVC.h"
#import "TBFirstGuideVC.h"
#import "AppDelegate.h"
#import "JPEngine.h"
#import "UMSocial.h"
#import <UMMobClick/MobClick.h>
#import <AdSupport/AdSupport.h>
#import "SvUDIDTools.h"
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import "INTULocationManager.h"

@interface AppDelegate ()

@end


#define UMENG_APPKEY @"5359f4d356240b7f9f0c995b"
#define UMENG_TrackAPPKEY @"5742aa2ee0f55a64f10000b3"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    这是JSPatch，热修复。暂时关闭。需要服务器提供一个JS脚本.
//    [JPEngine startEngine];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",script);
//        if (script) {
//            [JPEngine evaluateScript:script];
//        }
//    }];

    //这是INTULocationManager框架，有更新，具体用法没有变化
    INTULocationManager *mgr = [INTULocationManager sharedInstance];
    [mgr requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock
                                    timeout:3.0
                       delayUntilAuthorized:YES
                                      block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                          if (status == INTULocationStatusSuccess) {
                                              
                                          }else if (status == INTULocationStatusTimedOut){
                                              
                                          }else{
                                              
                                          }
                                      }];
    
    
    
    
    
    UMConfigInstance.appKey = UMENG_APPKEY;
    [MobClick startWithConfigure:UMConfigInstance];
    [AppDelegate requestTrackWithAppkey:UMENG_TrackAPPKEY];

    TBTabbarVC *tabbarVC = [TBTabbarVC tabBarController];
    self.window.rootViewController = tabbarVC;

    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(void)requestTrackWithAppkey:(NSString *)appkey
{
    if (!appkey || ![appkey length])
    {
        return;
    }
    //需要引入ADSupport框架
    ASIdentifierManager *asIM = [[ASIdentifierManager alloc] init];
    NSString *idfa = [asIM.advertisingIdentifier UUIDString];
    NSString *idfv = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *openudid = [SvUDIDTools UDID];
    NSString *mac = [self macString];
    
    size_t size;
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    // Allocate the space to store name
    char *name = malloc(size);
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    // Place name into a string
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    // Done with this
    free(name);
    
    NSString *requestURL = [[NSString alloc] initWithFormat:@"http://ar.umeng.com/stat.htm?ak=%@&device_name=%@&idfa=%@&openudid=%@&idfv=%@&mac=%@",appkey,machine,idfa,openudid,idfv,mac];
    
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData)
    {
        //
        // NSLog(@"ok");
    }
    
}


+ (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

@end
