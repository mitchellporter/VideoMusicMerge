//
//  SNManager.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Availability.h>

/*
 #if !__has_feature(objc_arc)
 #error This class requires automatic reference counting
 #endif
 */
#define IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#ifdef DEBUG
#define DebugLog(f, ...) NSLog(f, ## __VA_ARGS__)
#else
#define DebugLog(f, ...)
#endif


//TODO:For your app you need to define your preprocessor macros

#define kPlayHavenAdTimeOutThresholdValue 4.0
#define kRevMobAdTimeOutThresholdValue 3.0
#define kAppLovinTimeOutThresholdValue 5.0
#define kChartBoostTimeOutThresholdValue 5.0


#ifdef FreeApp
#define kRevMobId @"51cd0b0abbcad7ff4200002b"

#define ChartBoostAppID @"51ccc3ad17ba47034c000001"
#define ChartBoostAppSignature @"60dd68a9dd7e1c6608125f4cf960e3e72387f145"


#define kPlayHavenAppToken @"77cecc1543214ee79df9f0b763ac6dcc"
#define kPlayHavenSecret @"2675dc06211044d68f3c5fcd6a61339d"
#define kPlayHavenPlacement @"main_menu"
#ifdef IS_IOS7_AND_UP
    #define kRateURL @"itms-apps://itunes.apple.com/app/id668182190"
#else
    #define kRateURL @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=668182190"
#endif

#endif

#ifdef PaidApp
#define kRevMobId @"51aefdb0bf777e388700020c"

#define ChartBoostAppID @"51540b9517ba474233000019" //
#define ChartBoostAppSignature @"9953afb75246c3a03b10b526a0ea05dded6572cd" //

#define kPlayHavenAppToken @""
#define kPlayHavenSecret @""
#define kPlayHavenPlacement @"main_menu"

#ifdef IS_IOS7_AND_UP
    #define kRateURL @"itms-apps://itunes.apple.com/app/id668182919"
#else
    #define kRateURL @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=668182919"
#endif

#endif


typedef NS_ENUM(NSUInteger, adPriorityLevel){
    kPriorityLOWEST = 10,
    kPriorityNORMAL,
    kPriorityHIGHEST
};

typedef NS_ENUM(NSUInteger, ConnectionStatus) {
    
    kNotAvailable,
    kWANAvailable,
    kWifiAvailable
    
};

/*
 These are the default values before changing them do consult Angela
 */
#define kRevMobBannerAdPriority kPriorityHIGHEST  //In Game banner Ads
#define kRevMobFullScreenAdPriority kPriorityLOWEST //Full Screen Pop-ups
#define kRevMobButtonAdPriority kPriorityHIGHEST //Button ads this is not currently used in games, its just a wrapper on Link Ads
#define kRevMobLinkAdPriority kPriorityHIGHEST  //This is the Ad that is displayed on buttons on game over screens
#define kRevMobPopAdPriority kPriorityHIGHEST  //UIAlert type pop-up Ads in games
#define kRevMobLocalNotificationAdPriority kPriorityHIGHEST // UILocalNotification Ads //Currently we're not using it

#define kChartBoostFullScreeAdPriority kPriorityNORMAL
#define kChartBoostMoreAppsAd kPriorityHIGHEST

//#define kMobClixBannerAdPriority -1
//#define kMobClixFullScreenAdPriority -1


#define kPlayHavenFullScreenAdPriority kPriorityNORMAL

#define kAppLovinBannerAdPriority kPriorityNORMAL
#define kAppLovinFullScreenAdPriority kPriorityHIGHEST

#define kNumberOfAdNetworks 4





@interface SNManager : NSObject



@end
