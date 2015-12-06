//
//  LocalNotificationManager.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNManager.h"
#import <UIKit/UIKit.h>
@interface LocalNotificationManager : SNManager


@property(nonatomic, strong)NSString *message;

-(id)initWithMessage:(NSString*)message;
-(id)initWithDayIntervalArray: (NSArray*)daysArray withText: (NSString*)message andSoundFile: (NSString*)soundFileName;
-(void) scheduleNotifications:(NSString *)soundFileName andDaysArray:(NSArray*)daysArray;



/* CAUTION * Please Beware you cannot  not   64 notifications at one time
 * If there are more notifications and you also schedule testNotifications the
 * old notifications will get truncated.
 * So to be on safe side dont use this code in production code.
 */
- (void)testNotificationsSecondsWithSoundFileName:(NSString *)soundFileName andMessage:(NSString*)message;


@end
