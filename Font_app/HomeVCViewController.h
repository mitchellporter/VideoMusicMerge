//
//  HomeVCViewController.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface HomeVCViewController : UIViewController<MFMailComposeViewControllerDelegate> {
    IBOutlet UIButton *newsBtn;

}

	//Common button aciton method.
- (IBAction)commonButtonClicked:(UIButton*)button;
- (IBAction)inboxButtonClicked;


@end
