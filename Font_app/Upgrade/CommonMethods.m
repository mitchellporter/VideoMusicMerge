//
//  CommonMethods.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "CommonMethods.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#include <sys/xattr.h>
#import "MKStoreKitConfigs.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation CommonMethods


+(BOOL) isSongAtIndexPurchased:(int)index
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey: [NSString stringWithFormat:@"isSong%dPurchased",index]]) {
        return YES;
    }
    return NO;
}
+(void) setSongAtIndexAsPurchased:(int)index
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"isSong%dPurchased",index]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*) identifierForSongAtIndex:(int)index
{
    
    switch (index) {
        case 0:
            return strBuyTrack1;
            break;
        case 1:
            return strBuyTrack2;
            break;
        case 2:
            return strBuyTrack3;
            break;
        case 3:
            return strBuyTrack4;
            break;
        case 4:
            return strBuyTrack5;
            break;
       
        default:
            return @"";
            break;
    }
}




//To show the alert with specific message
+ (void)showAlertWithMessage: (NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

+ (void)addSkipBackupAttributeToItemAtPath: (NSString *)pathURL {
    @try {
        NSURL *URL = [NSURL fileURLWithPath:pathURL];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.1")) {
            NSError *error = nil;
            [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        }
        else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0.1")) {
            const char* filePath = [[URL path] fileSystemRepresentation];
            const char* attrName = "com.apple.MobileBackup";
            u_int8_t attrValue = 1;
            int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
            NSLog(@"%d",result);
        }
    }
    @catch (NSException *exception) {
        
    }
    
}

//Returns the path to doc dir
+ (NSString *)pathToDocDir {
    
    if ([[[UIDevice currentDevice] systemVersion] isEqualToString:@"5.0"]) {
        NSArray* cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString* cachePath = [cachePathArray lastObject];
        return cachePath;
    }
    else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        return [paths objectAtIndex:0]; // Get documents folder
    }
}

//To generate a loading view, which can be used accross the app.
//This can be added to any view, and to remove it from there, we can use 
//LoadingViewTag
+(UIView *) addLoadingViewWithTitle:(NSString *)title
					 andDescription:(NSString *)description
{
	UIView *backGroundView = [[UIView alloc]
							  initWithFrame:CGRectMake(0, 0, 320, 480)];
	backGroundView.backgroundColor = [UIColor clearColor];
	backGroundView.tag = LoadingViewTag;
	backGroundView.alpha = 0.9;
	UIView *loadingView = [[UIView alloc] 
						   initWithFrame:CGRectMake(35, 145, 240, 100)];
	loadingView.backgroundColor = [UIColor blackColor];
	
	[loadingView.layer setCornerRadius:6.0];
	[loadingView.layer setBorderWidth:2.0];
	[loadingView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    backGroundView.frame = CGRectMake(0, 0, 320, 480);
    
	UILabel  *titleLabel = [[UILabel alloc] 
                            initWithFrame:CGRectMake(0, 5, 250, 30)];
	
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.text = [NSString stringWithFormat:@"%@",title];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
	titleLabel.textAlignment = NSTextAlignmentCenter;
    
	UILabel  *lineLabel = [[UILabel alloc] 
                           initWithFrame:CGRectMake(0, 37, 250, 1)];
	
	lineLabel.backgroundColor = [UIColor lightGrayColor];
	UILabel  *descriptionLabel = [[UILabel alloc] 
                                  initWithFrame:CGRectMake(34, 39, 215, 62)];
	
	descriptionLabel.backgroundColor = [UIColor clearColor];
	descriptionLabel.numberOfLines = 3;
	descriptionLabel.text = [NSString stringWithFormat:@"%@",description];
	descriptionLabel.textColor = [UIColor whiteColor];
	if ([description length] < 50) {
		descriptionLabel.font = [UIFont fontWithName:@"Arial" size:15];
    }
	else {
		descriptionLabel.font = [UIFont fontWithName:@"Arial" size:13];
	}
	
	UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] 
													  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	
	activityIndicatorView.center = CGPointMake(15.5f, 66.5f);
	[activityIndicatorView startAnimating];
	[loadingView addSubview:titleLabel];
	[loadingView addSubview:lineLabel];
	[loadingView addSubview:descriptionLabel];
	[loadingView addSubview:activityIndicatorView];
	[backGroundView addSubview:loadingView];
	[lineLabel release];
	[titleLabel release];
	[loadingView release];
	[descriptionLabel release];
	[activityIndicatorView release];
	return [backGroundView autorelease];
}


@end
