//
//  TableViewDetailViewController.h
//  WindowTabBar
//
//  Created by zaab on 04/011/10.
//  Copyright fizaboun 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FliteTTS;
@interface TableViewDetailViewController : UIViewController {
	
	IBOutlet UILabel *displayText1;
	IBOutlet UILabel *displayText2;
	IBOutlet UILabel *displayText3;

	NSString *selectVerb1;
	NSString *selectVerb2;
	NSString *selectVerb3;
	FliteTTS *fliteEngine;
}

@property (nonatomic, retain) NSString *selectVerb1;
@property (nonatomic, retain) NSString *selectVerb2;
@property (nonatomic, retain) NSString *selectVerb3;
-(IBAction)ListenButtonPressed:(id)sender;

@end
