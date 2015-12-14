//
//  ViewController.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "ViewController.h"
#import "HomeVCViewController.h"

#import "AddMusicVC.h"


@interface ViewController ()

@end

@implementation ViewController

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
    
    //create the docmnetdictinary path
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
	NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MyFolder"];
	NSError *error;
	if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
		[[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
      //Create folder
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)getStartButtonClicked:(id)sender {

    
	HomeVCViewController *vc = [[HomeVCViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	
}


@end
