//
//  SMSTimingViewController.h
//  FakeSMS
//
//  Created by Feder on 10-12-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface SMSTimingViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate, ABPeoplePickerNavigationControllerDelegate>{
    UILabel    *label;
    NSString    *message;
	NSMutableArray *smsTimingArray;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSMutableArray *smsTimingArray;

@end
