//
//  SettingsManager.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "SettingsManager.h"


@interface SettingsManager()
- (void)checkForDeviceType;
@end

@implementation SettingsManager

static SettingsManager *sharedManager = nil;

+ (SettingsManager*)sharedManager{
    if (sharedManager != nil)
    {
        return sharedManager;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void)
                  {
                      sharedManager = [[SettingsManager alloc] init];
                     
                  });
#else
    @synchronized([SettingsManager class])
    {
        if (sharedManager == nil)
        {
            sharedManager = [[SettingsManager alloc] init];
            
        }
    }
#endif
    return sharedManager;
}



- (id)copyWithZone:(NSZone *)zone{
	return self;
}

- (id) init{
    
	self = [super init];
	if(self !=nil){
        [self checkForDeviceType];
	}
	return self;
	
}//end init

- (void)dealloc {
	NSLog(@"dealloc called");
    return;
//	[super dealloc]; //do not deallocate 
}

- (void)checkForDeviceType{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        self.isIPhone5 = YES;
        self.isIPad = NO;
        self.isIPhone = NO;
    } else if(screenBounds.size.height > 578) {
        self.isIPad = YES;
        self.isIPhone = NO;
        self.isIPhone5 = NO;
    }else{
        self.isIPhone = YES;
        self.isIPad = NO;
        self.isIPhone5 = NO;
    }
}

@end
