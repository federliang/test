//
//  SMSPreview.m
//  FakeSMS
//
//  Created by Feder on 10-5-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SMSPreview.h"
#import "FakeSMSAppDelegate.h"
//#import "SMSDetailController.h"

@implementation SMSPreviewController

@synthesize currentString;
@synthesize chatFile;
@synthesize smsArray;
@synthesize currentSMSInfo;


#define CHATFILENAME	@"chatLog.xml"

//Common Compile Selection
#define TABLE_VIEW_CELL
#define	COMPLEX_TABLE	1
#define COMPLEX_TABLE_ARRAYVIEW

#define FONT_SIZE 12
#define POSITION_WRAP 200

//Tag define
#define kMessageValueTag 1
#define kDateTimeValueTag 2
#define TEXTFIELDTAG	100
#define TOOLBARTAG		200
#define TABLEVIEWTAG	300
#define LOADINGVIEWTAG	400



- (id)init{
	
	NSLog(@"init");
	//NSLog(@"Date =%@", getCurrentDate);

	
	smsArray = [[NSMutableArray alloc] initWithCapacity:0];
	currentString = [[NSMutableString alloc] initWithCapacity:0];
	currentSMSInfo = [[NSMutableDictionary alloc] initWithCapacity:3];
	isMySpeaking = YES;
	loadingLog = NO;
	
	//log file exsist check
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	chatFile = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:CHATFILENAME]];
	//bar button
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"clear chat log" 
																			   style:UIBarButtonItemStyleBordered 
																			  target:self
																			  action:@selector(rightButtonAction)] autorelease];
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"load chat log" 
																			  style:UIBarButtonItemStyleBordered
																			 target:self
																			 action:@selector(leftButtonAction)] autorelease];
	if(![[NSFileManager defaultManager] fileExistsAtPath:chatFile]) {
		self.navigationItem.leftBarButtonItem.enabled = NO;
	}
	if (![smsArray count]) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}else {
		self.navigationItem.rightBarButtonItem.enabled =YES;
	}

	return self;
}

- (void)viewDidLoad{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 372.0f) style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	tableView.tag = TABLEVIEWTAG;
	[self.view addSubview:tableView];
	[tableView release];
	
	//Text Field
	UITextField *textfield = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 31.0f)] autorelease];
	textfield.tag = TEXTFIELDTAG;
	textfield.delegate = self;
	textfield.autocorrectionType = UITextAutocorrectionTypeNo;
	textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
	textfield.enablesReturnKeyAutomatically = YES;
	textfield.borderStyle = UITextBorderStyleRoundedRect;
	textfield.returnKeyType = UIReturnKeySend;
	textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 372.0f, 320.0f, 44.0f)];
	toolBar.tag = TOOLBARTAG;
	NSMutableArray* allitems = [[NSMutableArray alloc] init];
	[allitems addObject:[[[UIBarButtonItem alloc] initWithCustomView:textfield] autorelease]];
	[toolBar setItems:allitems];
	[allitems release];
	[self.view addSubview:toolBar];
	[toolBar release];	
	
	NSLog(@"view did load");
	[super viewDidLoad];
}

- (void)viewDidUnLoad{
	NSLog(@"viewDidUnload");
	//[childController release];
	//childController = nil;
}

- (void)dealloc{
	[smsArray release];
	[currentSMSInfo release];
	[currentString release];
	[chatFile release];

	//[childController release];
	NSLog(@"dealloc!");
	[super dealloc];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"applicationWillterminate sms preview");
	//[super applicationWillTerminate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark navigation button methods
- (BOOL) hideKeyboard {
	UITextField *textField = (UITextField *)[self.view viewWithTag:TEXTFIELDTAG];
	if(textField.editing) {
		textField.text = @"";
		[self.view endEditing:YES];
		return YES;
	}
	[textField resignFirstResponder];
	return NO;
}

- (void) rightButtonAction {
	if (![self hideKeyboard]) {
		// clear log
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOTICE"
														message:@"Clear Log"
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		self.navigationItem.leftBarButtonItem.title = @"load chat log";
		if(![[NSFileManager defaultManager] fileExistsAtPath:chatFile]){
			self.navigationItem.leftBarButtonItem.enabled = NO;
		}
		[smsArray removeAllObjects];
		if (![smsArray count]) {
			self.navigationItem.rightBarButtonItem.enabled = NO;
		}else {
			self.navigationItem.rightBarButtonItem.enabled = YES;
		}
		UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
		[tableView reloadData];
		[alert show];
		[alert release];
	}
}

- (void) leftButtonAction {
	if ([smsArray count]) {
		// save log
		NSMutableString *xmlString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>"];
		[xmlString appendString:@"<chats>"];
		[xmlString appendString:@"\r\n"];
		for(NSDictionary *chatInfo in smsArray) {
			[xmlString appendFormat:@"<chat>\r\n<speaker><![CDATA[%@]]></speaker>\r\n<text><![CDATA[%@]]></text>\r\n<date><![CDATA[%@]]></date>\r\n</chat>", [chatInfo objectForKey:@"speaker"], [chatInfo objectForKey:@"text"], [chatInfo objectForKey:@"date"]];
		}
		[xmlString appendString:@"\r\n"];
		[xmlString appendString:@"</chats>"];
		NSError *error;
		BOOL saveRes = [xmlString writeToFile:chatFile atomically:YES encoding:NSUTF8StringEncoding error:&error];		

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOTICE"
														message:saveRes?[NSString stringWithFormat:@"save to file: %@", CHATFILENAME]:[NSString stringWithFormat:@"error: save ng"]
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
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
		[NSThread detachNewThreadSelector:@selector(loadThread:) toTarget:self withObject:chatFile];
		[alert show];
		[alert release];
	}
}



- (void) finshLoadFile {
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	[tableView reloadData];
	
	UIView *loadingView = (UIView *)[self.view viewWithTag:LOADINGVIEWTAG];
	loadingView.hidden = YES;
	
	loadingLog = NO;
	self.navigationItem.leftBarButtonItem.enabled = YES;
	self.navigationItem.rightBarButtonItem.enabled = YES;
	
	NSDictionary *chatInfo = [smsArray lastObject];
	if([[chatInfo objectForKey:@"speaker"] isEqualToString:@"self"]){
		isMySpeaking = NO;
	}else{
		isMySpeaking = YES;
	}
}

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

#pragma mark Text field methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	// return NO to disallow editing.
	if(loadingLog){
		return NO;
	}
	self.navigationItem.rightBarButtonItem.title = @"hidde keyboard";
	if (!self.navigationItem.rightBarButtonItem.enabled) {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}	
	UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBARTAG];
	toolbar.frame = CGRectMake(0.0f, 156.0f, 320.0f, 44.0f);
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	tableView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 156.0f);

	if ([smsArray count]) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[smsArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	}
	NSLog(@"textFieldShouldBeginEditing");
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
	self.navigationItem.rightBarButtonItem.title = @"clear chat log";
	UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBARTAG];
	toolbar.frame = CGRectMake(0.0f, 372.0f, 320.0f, 44.0f);
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	tableView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 372.0f);
	
	if (![smsArray count]) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}else {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
	NSLog(@"textFieldShouldEndEditing");
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// called when 'return' key pressed. return NO to ignore.
	self.navigationItem.leftBarButtonItem.title = @"save chat log";
	self.navigationItem.leftBarButtonItem.enabled = YES;
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	if ([textField.text isEqualToString: @"888888"]) {
		NSLog(@"You'll enter edit mode!");
		textField.text = @"";
		[tableView setEditing:!tableView.editing animated:YES];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOTICE"
														message:@"You'll enter edit mode!"
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		
		[alert show];
		[alert release];
	}else if ([textField.text isEqualToString: @"666666"]) {
		NSLog(@"You'll quit edit mode!");
		textField.text = @"";
		[tableView setEditing:!tableView.editing animated:YES];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NOTICE"
														message:@"You'll quit edit mode!"
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		
		[alert show];
		[alert release];
	}else{
		NSDate *today = [NSDate date];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
		NSString *currentTime = [dateFormatter stringFromDate:today];
		NSLog(@"date = :%@", currentTime);
		[dateFormatter release];
		UIView *smsView = [self bubbleView:[NSString stringWithFormat:@"%@: %@", isMySpeaking?@"self":@"other", textField.text] 
									  from:isMySpeaking datetime:currentTime];
		[smsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:textField.text, @"text", isMySpeaking?@"self":@"other", @"speaker", currentTime, @"date", smsView, @"view", nil]];
		isMySpeaking = !isMySpeaking;
		UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
		//tableView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 156.0f);	
		//NSString *date = getcurrentdate;
		//NSLog(@"Date =%@", getCurrentDate);
		[tableView reloadData];
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[smsArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
		textField.text = @"";
	}
	[textField resignFirstResponder];
	NSLog(@"textFieldShouldReturn");
	return YES;
}

#pragma mark Table view methods
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf datetime:(NSString *)currentDate
{
	// build single chat bubble cell with given text
	UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
	returnView.backgroundColor = [UIColor clearColor];
	
	UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"bubbleSelf":@"bubble" ofType:@"png"]];
	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
	
	UIFont *font = [UIFont systemFontOfSize:16];
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
	
	UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5.0f, size.width+5, size.height+5)];
	bubbleText.backgroundColor = [UIColor clearColor];
	bubbleText.font = font;
	[font release];
	bubbleText.numberOfLines = 0;
	bubbleText.lineBreakMode = UILineBreakModeCharacterWrap;
	bubbleText.text = text;
	NSLog(@"text = %@", text);
	
	bubbleImageView.frame = CGRectMake(0.0f, 0.0f, 200.0f, size.height+20.0f);
	
	//For Date&Time Display
	UILabel *datetimeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
	datetimeLabel.font = [UIFont boldSystemFontOfSize:12];
	datetimeLabel.tag = kDateTimeValueTag;
	datetimeLabel.textAlignment = UITextAlignmentCenter;
	datetimeLabel.text = currentDate;
	datetimeLabel.textColor = [UIColor lightGrayColor];
	[datetimeLabel setBackgroundColor:[UIColor clearColor]];
	
	if(fromSelf){
		returnView.frame = CGRectMake(120.0f, 10.0f, 200.0f, size.height+20.0f);
		datetimeLabel.frame = CGRectMake(-60.0f, 40.0f, 200.0f, 20.0f);
	}else{
		returnView.frame = CGRectMake(0.0f, 10.0f, 200.0f, size.height+20.0f);
		datetimeLabel.frame = CGRectMake(60.0f, 40.0f, 200.0f, 20.0f);
	}
			
	[returnView addSubview:bubbleImageView];
	[bubbleImageView release];
	[returnView addSubview:bubbleText];
	[bubbleText release];
	[returnView addSubview:datetimeLabel];
	[datetimeLabel release];

	return [returnView autorelease];
}


#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSLog(@"get count");
	return [smsArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Change the height if Edit Unknown Contact is the row selected
	NSLog(@"Set Height");
	if ([smsArray count]) {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
	UIView *chatView = [[smsArray objectAtIndex:[indexPath row]] objectForKey:@"view"];
	//positionDateTime = chatView.frame.size.height+10.0f;
	return chatView.frame.size.height+30.0f;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *SMSPreviewCellIdentifier = @"SMSPreviewCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SMSPreviewCellIdentifier];
	[tableView setSeparatorColor:[UIColor redColor]];
	//tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	NSLog(@"cellForRowAtIndexPath");
	if (cell == nil) {
		NSLog(@"cell = nil");
		//for (int i = 0; i < [self.messageDetail count]; i++) {
		//	NSLog(@"message %d : %@", i, [self.messageDetail objectAtIndex:i]);
		//}
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SMSPreviewCellIdentifier] autorelease];		
		cell.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	// Set up the cell...
	NSDictionary *chatInfo = [smsArray objectAtIndex:[indexPath row]];
	for(UIView *subview in [cell.contentView subviews]){
		[subview removeFromSuperview];
	}
	[cell.contentView insertSubview:[chatInfo objectForKey:@"view"] atIndex:1];
	return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView
		   editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
	int section = indexPath.section;
	int row = indexPath.row;
	if (self.editing && section == 0 && row == 0) {
		return UITableViewCellEditingStyleInsert;
	}
	return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete){
		NSLog(@"Deleted section %d, cell %d",  [indexPath indexAtPosition: 0], [indexPath indexAtPosition: 1]);  
		NSUInteger row = [indexPath row];
		[smsArray removeObjectAtIndex:row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert){
		//invaild, why?
		NSLog(@"Insert");
        //[self.messageDetail insertObject:@"Tutorial" atIndex:[self.messageDetail count]];
		[tableView reloadData];
    }
}




#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
//	if (childController == nil) {
//		childController = [[SMSPreviewController alloc]initWithNibName:@"SMSPreview" bundle:nil];
//	}
//	childController.title = "SMS Preview";
//	NSUInteger row = [indexPath row];
	
}

@end
