//
//  Helper.m
//  CustomRegistrationForm
//
//  Created by GS on 28/01/13.
//  Copyright (c) 2013 Netsmartz. All rights reserved.
//

#import "Helper.h"
@implementation Helper
#define BORDER_WIDTH 1.0
#define CORNER_RADIUS 3.0

#pragma mark- Alert Helper

//Show the alert message.
+ (void)showAlert:(NSString*)title withMessage:(NSString*)message {
    //create the alert message
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark- Set Border.

	//Used to set border, corner radius of obj.
+ (void)setBorderColor:(UIImageView*)imageView button:(UIButton*)button {
    
		//Set border color of image.
    if (imageView) {
        imageView.layer.cornerRadius = CORNER_RADIUS;
        imageView.layer.borderWidth = BORDER_WIDTH;
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.layer.masksToBounds = YES;
        
    }
    else { //Set border color of button.
        button.layer.cornerRadius = CORNER_RADIUS;
        button.layer.borderWidth = BORDER_WIDTH;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.masksToBounds = YES;
    }
    
}

@end


