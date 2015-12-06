//
//  VideoListVC.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface VideoListVC : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> {

	UIImagePickerController         *mImagePickerController;
                              
    IBOutlet UIImageView *previewImgView;
}
@property(nonatomic,strong)AVAsset							*mAsset;

@property (nonatomic, strong) NSString						*mPath;
- (IBAction)pickVideo:(id)sender;
- (IBAction)nextView:(id)sender;

- (IBAction)backButtonClicked:(id)sender;

@end
