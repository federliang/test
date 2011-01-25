//
//  FakeSMSAppDelegate.m
//  FakeSMS
//
//  Created by Feder on 10-5-1.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FakeSMSAppDelegate.h"
//#import "SMSPreview.h"

@implementation FakeSMSAppDelegate
@synthesize window;
@synthesize navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[window addSubview:navController.view];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"applicationWillterminate delegate");
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"ismymessage" 
	//												 ofType:@"plist"];
	//[ismyMessage writeToFile:path atomically:YES];
}

- (void)dealloc {
    [window release];
	[navController release];
    [super dealloc];
}


@end
