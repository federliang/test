//
//  SMSDeailController.m
//  FakeSMS
//
//  Created by Feder on 10-5-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SMSDetailController.h"


@implementation SMSDetailController
@synthesize label;
@synthesize message;


- (void)viewWillAppear:(BOOL)animated{
	label.text = message;
	NSLog(@"SMS Detail view Will Appear");
	[super viewWillAppear:animated];
}

- (void)viewDidUnload{
	self.label = nil;
	self.message = nil;
	[super viewDidUnload];
}


- (void)dealloc{
	[label release];
	[message release];
	[super dealloc];
}
@end
