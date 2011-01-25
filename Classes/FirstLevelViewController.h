//
//  FirstLevelViewController.h
//  FakeSMS
//
//  Created by Feder on 10-5-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FirstLevelViewController : UITableViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate>{
	NSArray *controllers;
}

@property (nonatomic, retain) NSArray *controllers;

@end
