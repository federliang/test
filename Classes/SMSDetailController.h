//
//  SMSDeailController.h
//  FakeSMS
//
//  Created by Feder on 10-5-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SMSDetailController : UIViewController {
	UILabel *label;
	NSString *message;
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) NSString *message;

@end
