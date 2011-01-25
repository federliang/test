//
//  SettingView.h
//  FakeSMS
//
//  Created by Feder on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSTimingViewController.h"


@class SettingViewController;


@interface SettingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	NSMutableString		*currentRegion;
	NSMutableString		*currentTimeType;	//12 or 24
	NSMutableArray		*settingArray;
	SMSTimingViewController *childController;
}

@property (nonatomic, retain) NSMutableString *currentRegion;
@property (nonatomic, retain) NSMutableString *currentTimeType;
@property (nonatomic, retain) NSMutableArray *settingArray;

@end
