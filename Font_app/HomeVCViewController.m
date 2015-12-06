//
//  HomeVCViewController.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//
#import "HomeVCViewController.h"
#import "VideoListVC.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "AppoxeeManager.h"
#import "CommonMethods.h"
#import "SNAdsManager.h"

@interface HomeVCViewController ()

@end

@implementation HomeVCViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBadge) name:@"ap_badge_changed" object:nil];
    [[SNAdsManager sharedManager] giveMeFullScreenAd];
}

- (void)changeBadge {
    
    NSString *badgeText = NULL;
    //fetch the value store in key @"apBadge"
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"apBadge"]) {
        badgeText = [[NSUserDefaults standardUserDefaults] objectForKey:@"apBadge"];
    }
    
    [[AppoxeeManager sharedManager] addBadgeToView:newsBtn badgeText:badgeText badgeLocation:CGPointMake(newsBtn.frame.size.width-5,-10) shouldFlashBadge:YES];
}

- (IBAction)inboxButtonClicked {
    //Get the Appoxee UIViewController
    [[AppoxeeManager sharedManager] show];
}
#pragma mark - Button Action Methods

	//Common button aciton method.
- (IBAction)commonButtonClicked:(UIButton*)button {
	
	
	switch (button.tag) {
		
				//add video
		case 100: {
			
            //push to the VideoListVC
			VideoListVC *vc = [[VideoListVC alloc] init];
			[self.navigationController pushViewController:vc animated:YES];

			break;
		}
			
				//Follow Us
		case 101: {
            NSString *urlString = @"instagram://user?username=jaloxin";
            NSURL *instaURL = [NSURL URLWithString:urlString];
            if([[UIApplication sharedApplication] canOpenURL:instaURL]) {
                //open the URL
                [[UIApplication sharedApplication] openURL:instaURL];
            }
            else {
                [CommonMethods showAlertWithMessage:@"Please ensure you have instagram app installed!"];
            }
            break;
		}
			
				//Rate Us
		case 102: {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=685833962&mt=8"]];
			break;
		}
			
				//Mailbox
		case 103: {
			[self sendMail];
			break;
		}
			
		default:
			break;
	}
	
}

#pragma mark - Send Mail

- (void)sendMail {
	
		//check if mail feaature is there.
	if ([MFMailComposeViewController canSendMail]) {
		
        //open the mail sheet
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		picker.mailComposeDelegate = self;
		
		[self presentViewController:picker animated:YES completion:nil];
	}
	else {
        //mail sheet is not available the give alert message
		[Helper showAlert:@"Message" withMessage:@"This feature is not avaialble on your device."];
	}
	
}

#pragma mark - Delegate Methods

	// -------------------------------------------------------------------------------
	//	mailComposeController:didFinishWithResult:
	//  Dismisses the email composition interface when users tap Cancel or Send.
	//  Proceeds to update the message field with the result of the operation.
	// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
		  didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
		// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled: {
		
			[Helper showAlert:@"Message" withMessage:@"Result: Mail sending canceled"];
			break;
		}
		
		case MFMailComposeResultSaved: {
			
			[Helper showAlert:@"Message" withMessage:@"Result: Mail saved"];
			break;
			
		}
		
		case MFMailComposeResultSent: {
			
			[Helper showAlert:@"Message" withMessage:@"Result: Mail sent"];
			break;
			
		}
		
		case MFMailComposeResultFailed: {
			
			[Helper showAlert:@"Message" withMessage:@"Result: Mail sending failed"];
			break;
		}
		
		default: {
			
			[Helper showAlert:@"Message" withMessage:@"Result: Mail not sent"];
			break;
			
		}
		
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}



@end
