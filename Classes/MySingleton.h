//
//  MySingleton.h
//  FakeSMS
//
//  Created by Feder on 11-4-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MySingleton : NSObject {
	NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;

+ (MySingleton*) retriveSingletion;
- (void) sayHello;
@end
