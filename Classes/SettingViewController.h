//
//  SettingView.h
//  FakeSMS
//
//  Created by Feder on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSSetViewController.h"


@class SettingViewController;


@interface SettingViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate>{
	NSMutableString			*currentRegion;
	NSMutableString			*currentTimeType;	//12 or 24
	NSMutableArray			*settingArray;
	SMSSetViewController	*childController;
	BOOL					loadingLog;
	NSString				*saveFile;
}

@property (nonatomic, retain) NSMutableString *currentRegion;
@property (nonatomic, retain) NSMutableString *currentTimeType;
@property (nonatomic, retain) NSMutableArray *settingArray;

- (void) clearAction;
- (void) saveAction;
- (void) loadAction;


@end
