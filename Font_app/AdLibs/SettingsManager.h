//
//  SettingsManager.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RootViewController;

@interface SettingsManager : NSObject

enum ratedStatus{
    kAppHasNotBeenRated,
    kAppHasBeenRated,
    kMaybeLater,
    kNever
};



//Device Check Boolean Variables
@property(nonatomic, assign)BOOL isIPhone5;
@property(nonatomic, assign)BOOL isIPhone;
@property(nonatomic, assign)BOOL isIPad;
@property(nonatomic, strong)RootViewController *rootViewController;
@property(nonatomic, assign)BOOL hasInAppPurchaseBeenMade;
@property(nonatomic, assign)NSInteger gameOverCounter;
@property(nonatomic, assign)NSInteger ammoAtHand;

+ (SettingsManager *)sharedManager;

@end
