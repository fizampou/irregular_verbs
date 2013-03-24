//
//  TableViewDetailViewController.m
//  WindowTabBar
//
//  Created by zaab on 04/011/10.
//  Copyright fizaboun 2010. All rights reserved.
//

#import "TableViewDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FliteTTS.h"

@implementation TableViewDetailViewController



@synthesize selectVerb1;
@synthesize selectVerb2;
@synthesize selectVerb3;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */
-(IBAction)ListenButtonPressed:(id)sender{
	if ([sender tag]==1) {
		[fliteEngine speakText: displayText1.text];
	}else if ([sender tag]==2) {
		[fliteEngine speakText: displayText2.text];
	}else if ([sender tag]==3) {
		[fliteEngine speakText: displayText3.text];
	}
	

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	fliteEngine = [[FliteTTS alloc] init];
	displayText1.text = selectVerb1;
	displayText2.text = selectVerb2;
	displayText3.text = selectVerb3;
	self.navigationItem.title = @"Selected Verb";
	
	//[fliteEngine speakText:@"It works."];       // Make it talk
    [fliteEngine setPitch:100.0 variance:15.0 speed:1.0];       // Change the voice properties
	[fliteEngine setVoice:@"cmu_us_awb"];   // Switch to a different voice
	[fliteEngine stopTalking];                              // stop talking
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[selectVerb1 release];
    [super dealloc];
}

@end

