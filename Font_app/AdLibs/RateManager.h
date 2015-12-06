//
//  RateManager.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "SNManager.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RateManager : SNManager <UIAlertViewDelegate>

- (void)showReviewApp;
+ (RateManager *)sharedManager;

@end
