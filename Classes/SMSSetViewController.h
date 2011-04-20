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


@interface SMSSetViewController : UIViewController <UITextFieldDelegate,
														UITableViewDelegate, 
														UITableViewDataSource, 
														UINavigationBarDelegate, 
														UINavigationControllerDelegate,
														ABPeoplePickerNavigationControllerDelegate,
														ABPersonViewControllerDelegate,
														ABNewPersonViewControllerDelegate,
														ABUnknownPersonViewControllerDelegate>{
	UIButton		*pickNameBtn;		//pick the number/name from contact list
	UIButton		*sendBtn;
    UILabel			*label;
    NSString		*message;
	NSMutableArray	*smsTimingArray;
	NSString		*pickNumber;
}

@property (nonatomic, retain) UILabel			*label;
@property (nonatomic, retain) NSString			*message;
@property (nonatomic, retain) NSMutableArray	*smsTimingArray;
@property (nonatomic, retain) UIButton			*pickNameBtn;
@property (nonatomic, retain) UIButton			*sendBtn;
@property (nonatomic, retain) NSString			*pickNumber;

@end
