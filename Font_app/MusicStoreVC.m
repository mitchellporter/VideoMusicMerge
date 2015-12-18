//
//  MusicStoreVC.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "MusicStoreVC.h"
#import "MusicFileInfo.h"
#import "AddMusicVC.h"
#import "CommonMethods.h"
#import "MKStoreManager.h"

@interface MusicStoreVC ()

@end

@implementation MusicStoreVC

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
	
	mMusicInfoArray = [[NSMutableArray alloc] init];

    _mTableView.backgroundView = nil;
    _mTableView.backgroundColor = [UIColor clearColor];
    
	NSArray *descInfoArray = @[@"Your Little Planet Corp",@"Inspire",@"Playtime",@"Rock",@"Soul"];
	NSArray *nameInfoArray = @[@"Your Little Planet Corp",@"Inspire",@"Playtime",@"Rock",@"Soul"];
	for (int index = 0; index < descInfoArray.count; index++) {
		
		MusicFileInfo *musicFileInfo = [[MusicFileInfo alloc] init];
		musicFileInfo.mDesc = [descInfoArray objectAtIndex:index];
		musicFileInfo.mFileName = [nameInfoArray objectAtIndex:index];
		[mMusicInfoArray addObject:musicFileInfo];
		
	}
	[self.mTableView reloadData];
	
}

#pragma mark - Table View Delegate Methods.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
		// Return the number of rows in the section.
	    return mMusicInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

	// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
		//If there is no cell in queue, create new one.
    if (cell == nil) {
        
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
			//Set cell selection style & accessory view.
			
    }
    else { //If there is  cell in queue, remove the subview, so that content doen't overlap.
		for (UIView *subView in cell.contentView.subviews) {
			[subView removeFromSuperview];
		}
	}
	
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 225, 55)];
    
	MusicFileInfo *musicFileInfo = [mMusicInfoArray objectAtIndex:indexPath.row];
	titleLabel.text = musicFileInfo.mDesc;
    titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont fontWithName:@"Verdana" size:17.0];
    [cell.contentView addSubview:titleLabel];
  
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"playBtn.png"] forState:UIControlStateNormal];
    playBtn.frame = CGRectMake(5, 5, 45, 45);
    [cell.contentView addSubview:playBtn];
    [playBtn addTarget:self action:@selector(playPreview:) forControlEvents:UIControlEventTouchUpInside];
    playBtn.tag = indexPath.row;
    
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [purchaseBtn addTarget:self action:@selector(purchaseClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = purchaseBtn;
    purchaseBtn.tag = indexPath.row;
    return cell;

}

- (void)playPreview: (UIButton *)sender {
	MusicFileInfo *musicFileInfo = [mMusicInfoArray objectAtIndex:sender.tag];
		NSLog(@"%@", [NSString stringWithFormat:@"file://%@", [[[NSBundle mainBundle] pathForResource:musicFileInfo.mFileName ofType:@"mp3"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
	self.mParentVC.mURL = [NSURL URLWithString:[NSString stringWithFormat:@"file:///%@", [[[NSBundle mainBundle] pathForResource:musicFileInfo.mFileName ofType:@"mp3"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	self.mParentVC.mAudioAsset = [AVAsset assetWithURL:self.mParentVC.mURL];
	[self.mParentVC songPlay];
    [self.mParentVC playAudioFile:nil];
    [self.mParentVC.mAVAudioPlayer performSelector:@selector(pause) withObject:nil afterDelay:10];
}

- (void)selectSong: (int)indexSelected {
    MusicFileInfo *musicFileInfo = [mMusicInfoArray objectAtIndex:indexSelected];
	self.mParentVC.mURL = [NSURL URLWithString:[NSString stringWithFormat:@"file:///%@", [[[NSBundle mainBundle] pathForResource:musicFileInfo.mFileName ofType:@"mp3"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	self.mParentVC.mAudioAsset = [AVAsset assetWithURL:self.mParentVC.mURL];
	[self.mParentVC songPlay];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Purchase methods
//click on purchase this method call
- (IBAction)purchaseClicked:(id)sender {
    packIndexPurchased = [sender tag];
 
    if ([CommonMethods isSongAtIndexPurchased:packIndexPurchased]) {
        [self selectSong:packIndexPurchased];
           return;
    }
           
    [self buyItemNumber:packIndexPurchased];

}


-(void) buyItemNumber:(int)index
{
    [self.view addSubview:loadingView];
    
    NSString *identifier;
    
    identifier = [CommonMethods identifierForSongAtIndex:index];
    
    [[MKStoreManager sharedManager] buyFeature:identifier
                                    onComplete:^(NSString* purchasedFeature,
                                                 NSData* purchasedReceipt,
                                                 NSArray* availableDownloads)
     {
         @try
         {

             if([purchasedFeature isEqualToString:[CommonMethods identifierForSongAtIndex:index]])
             {
                 [CommonMethods setSongAtIndexAsPurchased:index];
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"In-App Purchase" message:@"Successfully Purchased" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                 [alert show];
                 
                 [self selectSong:packIndexPurchased];
             }
             else
             {
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"In-App Purchase" message:@"Unkown Error Occurred" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                 [alert show];
             }
             
             
              [loadingView removeFromSuperview];

             
         }
         @catch (NSException *exception)
         {
             NSLog(@"Track IAP Error");
             UIAlertView *newAlertView = [[UIAlertView alloc] initWithTitle:@"Request Error" message:@"Problem in retreiving products from iTunes store"    delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [newAlertView show];

              [loadingView removeFromSuperview];
         }
     }
                                   onCancelled:^
     {

          [loadingView removeFromSuperview];
     }];

}

- (IBAction)restore:(id)sender {

    
    //Adding the Loading View
    [self.view addSubview:loadingView];
    //call the restorePurchasesNOw method
    [self restorePurchasesNOw];
}

- (void)restorePurchasesNOw {
    
    
        int restoreCount =0;
        
        for (int i = 0; i< mMusicInfoArray.count; i++) {
            if([MKStoreManager isFeaturePurchased: [CommonMethods identifierForSongAtIndex:i]])
            {
                [CommonMethods setSongAtIndexAsPurchased:i];
                restoreCount++;
            }
        }
        
        if (restoreCount==0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Restore In-App Purchases" message:@"No IAP found." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];

        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Restore In-App Purchase" message:@"Successfully Restored" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
   
        
         [loadingView removeFromSuperview];

}

#pragma mark- Button Action Method.

- (IBAction)backButtonClicked:(id)sender {
    [self.mParentVC.mAVAudioPlayer pause];
    //back to the previous screen
	[self.navigationController popViewControllerAnimated:TRUE];
	
}


@end
