//
//  FirstLevelViewController.m
//  FakeSMS
//
//  Created by Feder on 10-5-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirstLevelViewController.h"
#import "SecondLevelViewController.h"
#import "SMSPreview.h"
#import "SettingView.h"

@implementation FirstLevelViewController
@synthesize controllers;

- (void)viewDidLoad{
	self.title = @"First Level";
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	//SMSPreviewController *smsPreviewController = [[SMSPreviewController alloc]initWithStyle:UITableViewStylePlain];
	SMSPreviewController *smsPreviewController = [[SMSPreviewController alloc] init];
	smsPreviewController.title = @"SMS Preview";
	//	smsPreviewController.rowImage = [UIImage imageNamed:@"smsPreview.png"];
	[array addObject:smsPreviewController];
	[smsPreviewController release];

	SettingViewController *settingViewController = [[SettingViewController alloc] init];
	settingViewController.title = @"Settings";
	//	smsPreviewController.rowImage = [UIImage imageNamed:@"smsPreview.png"];
	[array addObject:settingViewController];
	[settingViewController release];	
	
	
	self.controllers = array;
	[array release];
	[super viewDidLoad];		//???????
}

- (void)viewDidUnload{
	self.controllers = nil;
	[super viewDidUnload];		//???????
}

- (void)dealloc{
	[controllers release];
	[super dealloc];
}


#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *FirstLevelCell = @"FirstLevelCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
	if (cell == nil){
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell] autorelease];
	}
	//Config the cell
	NSUInteger row = [indexPath row];
	SecondLevelViewController *controller = [controllers objectAtIndex:row];
	cell.textLabel.text = controller.title;
	//cell.imageView.image = controller.rowImage;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSUInteger row = [indexPath row];
	SecondLevelViewController *nextController = [self.controllers objectAtIndex:row];
	NSLog(@"Selected!");
	[self.navigationController pushViewController:nextController animated:YES];
	NSLog(@"Push OK");
}



@end
