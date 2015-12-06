//
//  CommonMethods.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LoadingViewTag 2121

@interface CommonMethods : NSObject {
    
    
}

+ (void)showAlertWithMessage: (NSString *)message;
+(UIView *) addLoadingViewWithTitle:(NSString *)title
					 andDescription:(NSString *)description;



+ (NSString *)pathToDocDir;

+(BOOL) isSongAtIndexPurchased:(int)index;
+(void) setSongAtIndexAsPurchased:(int)index;
+(NSString*) identifierForSongAtIndex:(int)index;

+ (void)addSkipBackupAttributeToItemAtPath: (NSString *)pathURL;

@end
