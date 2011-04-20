//
//  MySingleton.m
//  FakeSMS
//
//  Created by Feder on 11-4-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MySingleton.h"


@implementation MySingleton
@synthesize someProperty;

static MySingleton* sharedSingleton = nil;

+ (MySingleton *) retriveSingletion {
	@synchronized([MySingleton class]) {
		if (sharedSingleton == nil) {
			sharedSingleton = [[MySingleton alloc] init];
		}
	}
	return sharedSingleton;
}

+(id)alloc
{
	@synchronized([MySingleton class])
	{
		NSAssert(sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedSingleton = [super alloc];
		return sharedSingleton;
	}
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
	
	return self;
}


- (void) sayHello{
	NSLog(@"Say Hello!");
}
@end
