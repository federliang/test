//
//  SMSPreview.h
//  FakeSMS
//
//  Created by Feder on 10-5-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//#import	<CoreData/CoreData.h>
#import <Foundation/Foundation.h>
//#import "SecondLevelViewController.h"
@class SMSDetailController;

@interface SMSPreviewViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate>{
	NSMutableDictionary	*currentSMSInfo;
	NSMutableString		*currentString;
	//SMSDetailController *childController;
	BOOL				storingCharacters;
	BOOL				isMySpeaking;
	BOOL				loadingLog;
	NSString			*chatFile;
	NSMutableArray		*smsArray;
}

@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) NSString	*chatFile;
@property (nonatomic, retain) NSMutableArray *smsArray;
@property (nonatomic, retain) NSMutableDictionary	*currentSMSInfo;

- (void) clearAction;
- (void) saveAction;
- (void) loadAction;
- (void) loadThread:(NSString *)xmlFile;
- (void) finshLoadFile;
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf datetime:(NSString *)currentDate;
@end
