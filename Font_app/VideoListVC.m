//  forever
//
//  VideoListVC.m
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "VideoListVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AddMusicVC.h"


@interface VideoListVC ()

@end

@implementation VideoListVC

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
	
	mImagePickerController = [[UIImagePickerController alloc] init];
    mImagePickerController.delegate = self;
	
}

#pragma mark - Button Action Method

	//Pick video
- (IBAction)pickVideo:(id)sender {
	
    //check the photo availabel in the PhotosAlbum
	if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO) {
		[Helper showAlert:@"Error" withMessage:@"No Saved Album Found"];
	}
	else{
		[self startMediaBrowserFromViewController: self
									usingDelegate: self];
	}
}

-(BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
		// Hides the controls for moving & scaling pictures, or for
		// trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
	[controller presentViewController:mediaUI animated:YES completion:nil];
	
    return YES;
}

	//go to next view.
- (IBAction)nextView:(id)sender {
	
	if (self.mAsset) {
        //push to the AddMusicVC
		AddMusicVC *vc = [[AddMusicVC alloc] init];
		vc.mAsset = self.mAsset;
		[self.navigationController pushViewController:vc animated:YES];
	}
	else {
		[Helper showAlert:@"Message" withMessage:@"Please add a video."];
	}
	
}

//back to the HomeVCViewController
- (IBAction)backButtonClicked:(id)sender {
	[self.navigationController popViewControllerAnimated:TRUE];
}


#pragma mark - Image Picker Delegate Methods.

	// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
	NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
		// Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
		self.mAsset = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
    }
	
	[self dismissViewControllerAnimated:YES completion:^{

        AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:[info objectForKey:UIImagePickerControllerMediaURL] options:nil];
        AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
          generator.appliesPreferredTrackTransform=TRUE;
        CMTime thumbTime = CMTimeMakeWithSeconds(0,1);
        previewImgView.image = [UIImage imageWithCGImage:[generator copyCGImageAtTime:thumbTime actualTime:NULL error:nil]];
        generator = nil;
        asset = nil;
//        CMTime thumbTime = CMTimeMakeWithSeconds(0,1);
//        
//        //NSLog(@"Starting Async Queue");
//        
//        AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
//            if (result != AVAssetImageGeneratorSucceeded) {
//                NSLog(@"couldn't generate thumbnail, error:%@", error);
//            }
//            
//            //NSLog(@"Updating UI");
//            
//            //Convert CGImage thumbnail to UIImage.
//            UIImage * thumbnail = [UIImage imageWithCGImage:im];
//            
//            int checkSizeW = thumbnail.size.width;
//            int checkSizeH = thumbnail.size.height;
//            NSLog(@"Image width is %d", checkSizeW);
//            NSLog(@"Image height is %d", checkSizeH);
//            
//            //Set the image once resized.
//            previewImgView.image = thumbnail;
//        };
//        
//          [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
    }];
}

	//Called on the click on cancel button.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:nil];
}


@end
