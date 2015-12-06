//
//  AppDelegate.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SNAdsManager.h"
#import "MKStoreManager.h"

#import "RateManager.h"
#import "LocalNotificationManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    [[AppoxeeManager sharedManager] initManagerWithDelegate:self andOptions:NULL];

    [MKStoreManager sharedManager];

    //go to the viewcontroller
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];

    //create the navigationcontroller
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
	navController.navigationBarHidden = YES;
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    //Make sure you call this method after loading any splash screens you might have.
    [[AppoxeeManager sharedManager] managerParseLaunchOptions:launchOptions];
    
    
    [[SNAdsManager sharedManager] giveMeBootUpAd];
    

    return YES;
}


- (NSString *) AppoxeeDelegateAppSDKID
{
    //Replace the "xxx" with your SDK key.
    //Copy the SDK key as it was generated when you added a new app.
    //You can now find it under Settings -> Apps & SDK Keys -> App Name
    return AppoxeeID;
}

- (NSString *) AppoxeeDelegateAppSecret
{
    //Replace the "xxx" with your SDK Secret key.
    //Copy the SDK Secret key as it was generated when you added a new app.
    //You can now find it under Settings -> Apps & SDK Keys -> App Name
    return AppoxeeSecret;
}


- (void) AppoxeeNeedsToUpdateBadge:(int)badgeNum hasNumberChanged:(BOOL)hasNumberChanged
{
    //Here you should update your display to let the user know about the unread messages.
    //Here's an example code which uses Appoxee's inherent badge view:
    NSString *badgeText = NULL;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"apBadge"];
    if(badgeNum > 0)
    {
        badgeText = [NSString stringWithFormat:@"%d",badgeNum];
        [[NSUserDefaults standardUserDefaults] setObject:badgeText forKey:@"apBadge"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ap_badge_changed" object:nil];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Here for example we use the badgeNum to update the external app badge.
    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeNum;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // UALOG(@"APN device token: %@", deviceToken);
    // Updates the device token and registers the token with UA
    [[AppoxeeManager sharedManager]     didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    // UALOG(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// Copy and paste this method into your AppDelegate to recieve push
// notifications for your application while the app is running.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Forward the call to the AppoxeeManager
    if([[AppoxeeManager sharedManager] didReceiveRemoteNotification:userInfo])
    {
        // If the manager handled the event.. return
        return;
    }
    //Otherwise do what you want because the push didn't came from Appoxee.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[LocalNotificationManager alloc] initWithMessage:@"Want to merge videos and audios?"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[SNAdsManager sharedManager] giveMeWillEnterForegroundAd];
    
    [[RateManager sharedManager] showReviewApp];
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {     
}
@end
