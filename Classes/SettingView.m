//
//  SettingView.m
//  FakeSMS
//
//  Created by Feder on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingView.h"


@implementation SettingViewController

@synthesize currentRegion;
@synthesize currentTimeType;
@synthesize settingArray;


-(id)init{
#if 0
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
	
	NSDate *formatterDate = [inputFormatter dateFromString:@"1999-07-11 at 10:30"];
	
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"HH:mm 'on' EEEE MMMM d"];
	
	NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
	
	NSLog(@"newDateString %@", newDateString);
	// For US English, the output is:
	// newDateString 10:30 on Sunday July 11
#endif
	
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	
	NSString *currentTime = [dateFormatter stringFromDate:today];
	NSLog(@"date = :%@", currentTime);
	
	
	
	NSLog(@"NSLocaleIdentifier = :%@", [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier]);
	NSLog(@"NSLocaleLanguageCode = :%@", [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]);
	NSLog(@"preferredLanguages = :%@", [[NSLocale preferredLanguages] objectAtIndex:0]);
	NSLog(@"NSLocaleCountryCode = :%@", [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]);

///////////////////////////////////////////////////////
	//NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	
	//[dateFormatter setDateStyle:dateStyle];
	
	NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:118800];
	
	NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	[dateFormatter setLocale:usLocale];
	
	NSLog(@"Date for locale %@: %@",
		  [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:date]);
	// Output:
	// Date for locale en_US: Jan 2, 2001
	
	NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
	[dateFormatter setLocale:frLocale];
	NSLog(@"Date for locale %@: %@",
		  [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:date]);
	// Output:
	// Date for locale fr_FR: 2 janv. 2001
	
	
	NSLocale *zhLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
	[dateFormatter setLocale:zhLocale];
	
	NSLog(@"Date for locale %@: %@",
		  [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:date]);
	// Output:
	// Date for locale zh_CN: 2001-1-2
	
	//NSLog(@"Style %@: %@",
	//	  [dateFormatter timeStyle], [dateFormatter dateStyle]);
	
/////////////////////////////////////////////////////////	
	settingArray = [[NSMutableArray alloc] initWithObjects:@"Time Setting", @"View Setting", @"SMS Timing", nil];
	
	
	return self;
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 372.0f) style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	//tableView.tag = TABLEVIEWTAG;
	[self.view addSubview:tableView];
	[tableView release];
	
    [super viewDidLoad];
}



#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	//NSLog(@"get count");
	return [settingArray count];
}



 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Change the height if Edit Unknown Contact is the row selected
	//NSLog(@"Set Height");
	return tableView.rowHeight;
	
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *SettingViewCellIdentifier = @"SettingViewCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingViewCellIdentifier];
	[tableView setSeparatorColor:[UIColor redColor]];
	//tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	NSLog(@"cellForRowAtIndexPath");
	if (cell == nil) {
		NSLog(@"cell = nil");

		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingViewCellIdentifier] autorelease];		
		cell.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	// Set up the cell...
	NSString *chatInfo = [settingArray objectAtIndex:[indexPath row]];
	for(UIView *subview in [cell.contentView subviews]){
		[subview removeFromSuperview];
	}
	cell.textLabel.text = chatInfo;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView
		   editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{

}




#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if (childController == nil){
        childController = [[SMSTimingViewController alloc] init];
    }
    childController.title = @"SMS Timing Settings";
 //   NSUInteger row = [indexPath row];
    
    //NSString *selectedMovie = [list objectAtIndex:row];
   // NSString *detailMessage  = [[NSString alloc] 
     //                           initWithFormat:@"You pressed the disclosure button for %@.", 
      //                          selectedMovie];
	NSString *detailMessage  = [[NSString alloc] initWithFormat:@"This is SMS Timing setting view"];
    childController.message = detailMessage;
  //  childController.title = selectedMovie;
    [detailMessage release];
	
    [self.navigationController pushViewController:childController
										 animated:YES];
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.settingArray = nil;
	childController = nil;
}


- (void)dealloc {
    [super dealloc];
	[settingArray release];
	[childController release];
}


@end
