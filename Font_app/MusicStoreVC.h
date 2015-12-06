//
//  MusicStoreVC.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddMusicVC;


@interface MusicStoreVC : UIViewController  {
    IBOutlet UIView *loadingView;
    int packIndexPurchased;
	NSMutableArray		*mMusicInfoArray;
}
@property (weak, nonatomic) AddMusicVC					*mParentVC;
@property (weak, nonatomic) IBOutlet UITableView		*mTableView;

- (IBAction)restore:(id)sender;

@end

