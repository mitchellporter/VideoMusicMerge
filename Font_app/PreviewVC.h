//
//  PreviewVC.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewVC : UIViewController {
	
}

@property(nonatomic,strong) NSURL							*mURL;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)previewVideo:(id)sender;
- (IBAction)promotVideo:(id)sender;

@end
