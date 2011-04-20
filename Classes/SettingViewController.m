//
//  SettingView.m
//  FakeSMS
//
//  Created by Feder on 10-12-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

@synthesize currentRegion;
@synthesize currentTimeType;
@synthesize settingArray;

#define SET_FILE_NAME	@"settings.xml"

//Tags for different components
#define TEXTFIELDTAG	1
#define TOOLBARTAG		2
#define TABLEVIEWTAG	3
#define LOADINGVIEWTAG	4

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
	//Table view, show SMS which will be sent out
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 372.0f) style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.tag = TABLEVIEWTAG;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	//tableView.tag = TABLEVIEWTAG;
	[self.view addSubview:tableView];
	[tableView release];
	
	//Control iterms on bottom
	NSMutableArray* controlItems = [[NSMutableArray alloc] init];
	
	//Clear button
	UIImage *clearButtonImage = [UIImage imageNamed:@"clear_log.jpg"];
	UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 0, 31, 31)];
	[clearButton addTarget			:self 
					action			:@selector(clearAction) 
		  forControlEvents			:UIControlEventTouchUpInside];
	[clearButton setBackgroundImage	:clearButtonImage 
						   forState	:UIControlStateNormal];
	UIBarButtonItem *clearButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
	clearButtonItem.style = UIBarButtonSystemItemTrash;
	[controlItems addObject:clearButtonItem];	//add to control iterms
	[clearButton release];
	[clearButtonItem release];
	[clearButtonImage release];
	
	//Input textfield = Add button
	UITextField *textfield = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 220.0f, 31.0f)] autorelease];
	//textfield.tag							= TEXTFIELDTAG;
	textfield.delegate						= self;
	textfield.autocorrectionType			= UITextAutocorrectionTypeNo;
	textfield.autocapitalizationType		= UITextAutocapitalizationTypeNone;
	textfield.enablesReturnKeyAutomatically = YES;
	textfield.borderStyle					= UITextBorderStyleRoundedRect;
	textfield.returnKeyType					= UIReturnKeySend;
	textfield.clearButtonMode				= UITextFieldViewModeWhileEditing;
	[controlItems addObject:[[[UIBarButtonItem alloc] initWithCustomView:textfield] autorelease]];	//add to control iterms
	
	//Save button
	UIImage *saveButtonImage = [UIImage imageNamed:@"save.jpg"];
	UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 0, 31, 31)];
	[saveButton addTarget			:self 
				   action			:@selector(saveAction) 
		 forControlEvents			:UIControlEventTouchUpInside];
	[saveButton setBackgroundImage	:saveButtonImage 
						  forState	:UIControlStateNormal];
	UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
	saveButtonItem.style = UIBarButtonSystemItemSave;
	[controlItems addObject:saveButtonItem];	//add to control iterms
	[saveButton release];
	[saveButtonItem release];
	[saveButtonImage release];
		
	//Bottom ToolBar
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 372.0f, 320.0f, 44.0f)];
	//toolBar.tag = TOOLBARTAG;
	[toolBar setItems:controlItems];
	[controlItems release];
	[self.view addSubview:toolBar];
	[toolBar release];	

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
	return UITableViewCellEditingStyleNone;
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
        childController = [[SMSSetViewController alloc] init];
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


#pragma mark Control iterms
- (void) clearAction {
	// clear log
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOTICE"
													message:@"Clear Log"
												   delegate:self 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	self.navigationItem.leftBarButtonItem.title = @"load chat log";
	[settingArray removeAllObjects];
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	[tableView reloadData];
	[alert show];
	[alert release];
}

- (void) saveAction {
	if ([settingArray count]) {
		// save log
		NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
		[xmlString appendString:@"<chats>"];
		[xmlString appendString:@"\r\n"];
		for(NSDictionary *chatInfo in settingArray) {
			[xmlString appendFormat:@"<chat>\r\n<speaker><![CDATA[%@]]></speaker>\r\n<text><![CDATA[%@]]></text>\r\n<date><![CDATA[%@]]></date>\r\n</chat>", [chatInfo objectForKey:@"speaker"], [chatInfo objectForKey:@"text"], [chatInfo objectForKey:@"date"]];
		}
		[xmlString appendString:@"\r\n"];
		[xmlString appendString:@"</chats>"];
		NSError *error;
		BOOL saveRes = [xmlString writeToFile:saveFile atomically:YES encoding:NSUTF8StringEncoding error:&error];		
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOTICE"
														message:saveRes ? [NSString stringWithFormat:@"save to file: %@", SET_FILE_NAME]:[NSString stringWithFormat:@"error: save ng"]
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	} 
}


- (void) loadAction{
	if (![settingArray count]){
		// load log
		loadingLog = YES;
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOTICE"
														message:@"Load Log"
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];		
		self.navigationItem.leftBarButtonItem.enabled = NO;
		self.navigationItem.rightBarButtonItem.enabled = NO;
		UIView *loadingView = (UIView *)[self.view viewWithTag:LOADINGVIEWTAG];
		loadingView.hidden = NO;
		[NSThread detachNewThreadSelector:@selector(loadThread:) toTarget:self withObject:saveFile];
		[alert show];
		[alert release];
	}
}
/*
- (void) loadThread:(NSString *)xmlFile {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSXMLParser *chatLogParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:xmlFile]];
	[chatLogParser setDelegate:self];
	[currentString setString:@""];
	[currentSMSInfo removeAllObjects];
	
	[chatLogParser parse];
	[chatLogParser release];
	
	[self performSelectorOnMainThread:@selector(finshLoadFile) withObject:nil waitUntilDone:YES];
	[pool release];
}

#pragma mark saved chat xml parser	
static NSString *kName_Chats = @"chats";
static NSString *kName_Chat = @"chat";
static NSString *kName_Speaker = @"speaker";
static NSString *kName_Text = @"text";
static NSString *kName_Date = @"date";

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:kName_Chats]) {
		[smsArray removeAllObjects];
	} else if ([elementName isEqualToString:kName_Chat]) {
		[currentSMSInfo removeAllObjects];
	} else if ([elementName isEqualToString:kName_Speaker] || 
			   [elementName isEqualToString:kName_Text] ||
			   [elementName isEqualToString:kName_Date]) {
		[currentString setString:@""];
		storingCharacters = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:kName_Chats]) {
		
	} else if ([elementName isEqualToString:kName_Chat]) {
		UIView *smsView = [self bubbleView:[NSString stringWithFormat:@"%@: %@", [currentSMSInfo objectForKey:@"speaker"], [currentSMSInfo objectForKey:@"text"]] 
									  from:[[currentSMSInfo objectForKey:@"speaker"] isEqualToString:@"self"] datetime:[currentSMSInfo objectForKey:@"date"]];
		[currentSMSInfo setObject:smsView forKey:@"view"];
		[smsArray addObject:[NSDictionary dictionaryWithDictionary:currentSMSInfo]];
	} else if ([elementName isEqualToString:kName_Speaker] || [elementName isEqualToString:kName_Text] || [elementName isEqualToString:kName_Date]) {
		[currentSMSInfo setObject:[NSString stringWithString:currentString] forKey:elementName];
	}
	storingCharacters = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (storingCharacters) {
		[currentString appendString:string];
	}
}
*/


#pragma mark Memory control
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
