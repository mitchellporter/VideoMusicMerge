//
//  PreviewVC.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "PreviewVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SNAdsManager.h"

@interface PreviewVC ()

@end

@implementation PreviewVC

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
    
    [[SNAdsManager sharedManager] giveMeFullScreenAd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Button Action Method.
//go to the previous screen
- (IBAction)backButtonClicked:(id)sender {
	
	[self.navigationController popViewControllerAnimated:YES];
	
}

- (IBAction)previewVideo:(id)sender {
	
	MPMoviePlayerViewController* theMovie = [[MPMoviePlayerViewController alloc] initWithContentURL:self.mURL];
	[self presentMoviePlayerViewControllerAnimated:theMovie];
	
        // Register for the playback finished notification
	[[NSNotificationCenter defaultCenter]
	 addObserver: self
	 selector: @selector(myMovieFinishedCallback:)
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object: theMovie];

}

	// When the movie is done, release the controller.
-(void) myMovieFinishedCallback: (NSNotification*) aNotification
{
    [self dismissMoviePlayerViewControllerAnimated];
    
    MPMoviePlayerController* theMovie = [aNotification object];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver: self
     name: MPMoviePlayerPlaybackDidFinishNotification
     object: theMovie];
		// Release the movie instance created in playMovieAtURL:
}

- (IBAction)promotVideo:(id)sender {
	
}



@end
