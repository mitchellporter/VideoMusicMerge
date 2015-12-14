//
//  AddMusicVC.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "AddMusicVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PreviewVC.h"
#import "MusicStoreVC.h"

#define FRAME_WIDTH  640
#define FRAME_HEIGHT 640

@interface AddMusicVC ()

@end

@implementation AddMusicVC

#pragma mark - Memory Managment.

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
}

#pragma mark - Initialization

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
	
	_mSongView.alpha = 0;
	self.mSlider.value = 0.0;

	isPlayingSong = NO;
}

#pragma mark- Button Action Method.

	//Used to add custom music.
- (IBAction)addCustomMusic:(id)sender {
	
	isPlayingSong = NO;
	[self.mAVAudioPlayer pause];

    //push to the MusicStoreVC
	MusicStoreVC *vc = [[MusicStoreVC alloc] init];
	vc.mParentVC = self;
	[self.navigationController pushViewController:vc animated:YES];
		
}

- (IBAction)backButtonClicked:(id)sender {
	
	[self.navigationController popViewControllerAnimated:TRUE];
	
}

- (IBAction)addMusic:(id)sender {
	
	isPlayingSong = NO;
	[self.mAVAudioPlayer pause];

	MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAny];
    mediaPicker.delegate = self;
    mediaPicker.prompt = @"Select Audio";
    
    
    @try {
        [mediaPicker loadView]; // Will throw an exception in iOS simulator
        [self presentViewController:mediaPicker animated:YES completion:nil];
        }
    @catch (NSException *exception) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Oops!",@"Error title")
                                    message:NSLocalizedString(@"The music library is not available.",@"Error message when MPMediaPickerController fails to load")
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }

}

- (IBAction)mergeVideoAndAudio:(id)sender {
	
	if (self.mAudioAsset) {
			//Add loading view.
        mHUD = [[WDJ_MBProgressHUD alloc] initWithView:self.view];
        mHUD.labelText = @"Merging Video & Audio.";
        mHUD.detailsLabelText = @"Please wait";
        mHUD.mode = WDJ_MBProgressHUDModeIndeterminate;
        [self.view addSubview:mHUD];
        [mHUD show:YES];
		
		isPlayingSong = NO;
		[self.mAVAudioPlayer pause];
		[self performSelector:@selector(mergeFiles) withObject:nil afterDelay:.1];
		}
	else {
        //alert message display
		[Helper showAlert:@"Message" withMessage:@"Please add audio."];
	}
}

- (IBAction)startPostionOfMusic:(id)sender {
	
	int totaltime = self.mSlider.value;
	self.mAVAudioPlayer.currentTime = totaltime;
	self.mSongPositionInfoLabel.text = [NSString stringWithFormat:@"%02d:%02d",totaltime/60,totaltime%60];
	
}

#pragma mark - Media Picker Delegate Methods.

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    NSArray * SelectedSong = [mediaItemCollection items];
    
	if([SelectedSong count]>0){
		
        MPMediaItem * SongItem = [SelectedSong objectAtIndex:0];
        self.mURL = [SongItem valueForProperty: MPMediaItemPropertyAssetURL];
        self.mAudioAsset = [AVAsset assetWithURL:self.mURL];
		[Helper showAlert:@"Message" withMessage:@"Audio loaded successully."];
//		[self songPlay];

    }
    
	[mediaPicker dismissViewControllerAnimated:YES completion:^{
        [self songPlay];
    }];
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
	[mediaPicker dismissViewControllerAnimated:YES completion:nil];
}

	//Merge Audio and Video File
- (void)mergeFiles {
	
        //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
	AVMutableComposition* mixComposition = [[AVMutableComposition alloc] init];
    
        //VIDEO TRACK
	AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
	[firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, _mAsset.duration) ofTrack:[[_mAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
	
	
        //AUDIO TRACK
	if(_mAudioAsset!=nil){
		AVMutableCompositionTrack *AudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];		
	
		int startPositionVal = (int)self.mSlider.value;
		
		NSLog(@"tracks = %@",[_mAudioAsset tracks]);
		if ([[_mAudioAsset tracks] count]) {
			[AudioTrack insertTimeRange:CMTimeRangeMake(CMTimeMake(startPositionVal, 1), _mAsset.duration) ofTrack:[[_mAudioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];

		}
		else {
			
			
			[AudioTrack insertTimeRange:CMTimeRangeMake(CMTimeMake(startPositionVal, 1), _mAsset.duration) ofTrack:nil atTime:kCMTimeZero error:nil];

		}

	}
        //CMTimeMake(5, 1)
	AVMutableVideoCompositionInstruction * MainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
	MainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, _mAsset.duration);
    
		//        //FIXING ORIENTATION//
	AVMutableVideoCompositionLayerInstruction *FirstlayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:firstTrack];
	AVAssetTrack *FirstAssetTrack = [[_mAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
	UIImageOrientation FirstAssetOrientation_  = UIImageOrientationUp;
	BOOL  isFirstAssetPortrait_  = NO;
	CGAffineTransform firstTransform = FirstAssetTrack.preferredTransform;
	if(firstTransform.a == 0 && firstTransform.b == 1.0 && firstTransform.c == -1.0 && firstTransform.d == 0)  {FirstAssetOrientation_= UIImageOrientationRight; isFirstAssetPortrait_ = YES;}
	if(firstTransform.a == 0 && firstTransform.b == -1.0 && firstTransform.c == 1.0 && firstTransform.d == 0)  {FirstAssetOrientation_ =  UIImageOrientationLeft; isFirstAssetPortrait_ = YES;}
	if(firstTransform.a == 1.0 && firstTransform.b == 0 && firstTransform.c == 0 && firstTransform.d == 1.0)   {FirstAssetOrientation_ =  UIImageOrientationUp;}
	if(firstTransform.a == -1.0 && firstTransform.b == 0 && firstTransform.c == 0 && firstTransform.d == -1.0) {FirstAssetOrientation_ = UIImageOrientationDown;}
	
	NSLog(@"width%f height = %f",FirstAssetTrack.naturalSize.width,FirstAssetTrack.naturalSize.height);
	
	CGFloat FirstAssetScaleToFitRatio = 640.0/FirstAssetTrack.naturalSize.width;
	if(isFirstAssetPortrait_){
		FirstAssetScaleToFitRatio = 640.0/FirstAssetTrack.naturalSize.height;
		CGAffineTransform FirstAssetScaleFactor = CGAffineTransformMakeScale(FirstAssetScaleToFitRatio,FirstAssetScaleToFitRatio);
		[FirstlayerInstruction setTransform:CGAffineTransformConcat(FirstAssetTrack.preferredTransform, FirstAssetScaleFactor) atTime:kCMTimeZero];
	}else{
		CGAffineTransform FirstAssetScaleFactor = CGAffineTransformMakeScale(FirstAssetScaleToFitRatio,FirstAssetScaleToFitRatio);
		[FirstlayerInstruction setTransform:CGAffineTransformConcat(CGAffineTransformConcat(FirstAssetTrack.preferredTransform, FirstAssetScaleFactor),CGAffineTransformMakeTranslation(0, 160)) atTime:kCMTimeZero];
	}
		
	MainInstruction.layerInstructions = [NSArray arrayWithObjects:FirstlayerInstruction,nil];;
	AVMutableVideoComposition *MainCompositionInst = [AVMutableVideoComposition videoComposition];
	MainCompositionInst.instructions = [NSArray arrayWithObject:MainInstruction];
	MainCompositionInst.frameDuration = CMTimeMake(1, 30);
	MainCompositionInst.renderSize = CGSizeMake(FRAME_WIDTH, FRAME_HEIGHT);

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"mergeVideo-%d.mov",arc4random() % 1000]];
	
	NSURL *url = [NSURL fileURLWithPath:myPathDocs];
	
	AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
	exporter.outputURL=url;
	exporter.outputFileType = AVFileTypeQuickTimeMovie;
	exporter.videoComposition = MainCompositionInst;
	exporter.shouldOptimizeForNetworkUse = YES;
	[exporter exportAsynchronouslyWithCompletionHandler:^
	 {
	 dispatch_async(dispatch_get_main_queue(), ^{
		 [self exportDidFinish:exporter];
	 });
	 }];
	
}

- (void)exportDidFinish:(AVAssetExportSession*)session
{
    if(session.status == AVAssetExportSessionStatusCompleted){
        NSURL *outputURL = session.outputURL;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
            [library writeVideoAtPathToSavedPhotosAlbum:outputURL
                                        completionBlock:^(NSURL *assetURL, NSError *error){
                                            dispatch_async(dispatch_get_main_queue(), ^{
												
												if (mHUD) {
													
													[mHUD hide:YES];
												}
												
                                                if (error) {
                                                    //show alert mwssage
													[Helper showAlert:@"Error" withMessage:@"Video Saving Failed"];
													[self.navigationController popToRootViewControllerAnimated:NO];
                                                   
												}else{
                                                    //display the alert message
													[Helper showAlert:@"Message" withMessage:@"Video Saved to Photo Album"];
													
                                                    //push to the PreviewVC
													PreviewVC *vc = [[PreviewVC alloc] init];
													vc.mURL = assetURL;
													[self.navigationController pushViewController:vc animated:YES];

												}
												
                                                
                                            });
                                            
                                        }];
        }
    }
	
}

	//Play audio File.
- (IBAction)playAudioFile:(UIButton*)button {
	
	if (isPlayingSong) {
		[button setTitle:@"Play" forState:UIControlStateNormal];
		isPlayingSong = NO;
		[self.mAVAudioPlayer pause];
	}
	else {
		self.mAVAudioPlayer.currentTime = self.mSlider.value;
		[button setTitle:@"Stop" forState:UIControlStateNormal];
		[self.mAVAudioPlayer play];
		isPlayingSong = YES;
	}

}

- (void)songPlay {
	
	isPlayingSong = NO;
	_mSongView.alpha = 1.0;
	[self.mPlayPauseButton setTitle:@"Play" forState:UIControlStateNormal];
    if (self.mAVAudioPlayer) {
        if ([self.mAVAudioPlayer isPlaying]) {
            [self.mAVAudioPlayer stop];
        }
    }
	self.mAVAudioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:self.mURL error:nil];
    [self.mAVAudioPlayer prepareToPlay];
	AudioSessionInitialize (NULL, NULL, NULL, NULL);
	AudioSessionSetActive(true);
	
		// Allow playback even if Ring/Silent switch is on mute
	UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
	AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,
							 sizeof(sessionCategory),&sessionCategory);
	self.mAVAudioPlayer.volume = 1.0;
	isPlayingSong = NO;
	
	self.mSlider.maximumValue = self.mAVAudioPlayer.duration;
	self.mSlider.value = 0.0;
	self.mSongPositionInfoLabel.text = @"0:00";
}

@end
