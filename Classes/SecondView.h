//
//  SecondView.h
//  WindowTabBar
//
//  Created by zaab on 04/011/10.
//  Copyright fizaboun 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondView : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	
	NSArray *itemsList;
	NSArray *totalList;
	UITableView *myTableView;
	UIImageView *imageView;
}

@property(nonatomic,retain)NSArray *itemsList;
@property(nonatomic,retain)NSArray *totalList;
@property(nonatomic,retain)UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;



@end
