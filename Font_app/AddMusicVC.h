//
//  AddMusicVC.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "WDJ_MBProgressHUD.h"

@interface AddMusicVC : UIViewController<MPMediaPickerControllerDelegate> {
	WDJ_MBProgressHUD               *mHUD;
	BOOL						isPlayingSong;

}
@property (weak, nonatomic) IBOutlet UIButton						*mPlayPauseButton;
@property (weak, nonatomic) IBOutlet UILabel						*mSongPositionInfoLabel;
@property (weak, nonatomic) IBOutlet UISlider						*mSlider;
@property (weak, nonatomic) IBOutlet UIView							*mSongView;
@property(nonatomic,retain)AVAudioPlayer							*mAVAudioPlayer;
@property(nonatomic,strong)AVAsset									*mAudioAsset;
@property(nonatomic,strong)AVAsset									*mAsset;
@property(nonatomic,strong)NSURL									*mURL;

- (IBAction)addCustomMusic:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)addMusic:(id)sender;
- (IBAction)mergeVideoAndAudio:(id)sender;
- (IBAction)startPostionOfMusic:(id)sender;

	//Play audio File.
- (IBAction)playAudioFile:(UIButton*)button;

- (void)songPlay;

@end
