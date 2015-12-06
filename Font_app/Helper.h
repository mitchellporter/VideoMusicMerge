//
//  Helper.h
//  CustomRegistrationForm
//
//  Created by GS on 28/01/13.
//  Copyright (c) 2013 Netsmartz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

//Show the alert message.
+ (void)showAlert:(NSString*)title withMessage:(NSString*)message;

	//Used to set border, corner radius of obj.
+ (void)setBorderColor:(UIImageView*)imageView button:(UIButton*)button;

@end
