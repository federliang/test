//
//  SMSTimingViewController.m
//  FakeSMS
//
//  Created by Feder on 10-12-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SMSSetViewController.h"
#import "EditableCell.h"
#import "SMSPreviewViewController.h"
#import "MySingleton.h"

@implementation SMSSetViewController

@synthesize label;
@synthesize message;
@synthesize smsTimingArray;
@synthesize pickNameBtn;
@synthesize sendBtn;
@synthesize pickNumber;

#define TAG_TEXTFIELD	0x1
#define TAG_TOOLBAR		0x2
#define TAG_TABLEVIEW	0x3
#define TAG_TEXTFIELD2	0x4

-(id)init{
	//NSDictionary *row1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"Number", @"title", nil];
	//NSDictionary *row2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"SMS", @"title", @"This is a SMS.", @"detail", nil];
	//NSArray *array = [[NSArray alloc]initWithObjects:row1, row2, nil];
	//smsTimingArray = [[NSMutableArray alloc] initWithObjects:row1, row2, nil];
	//NSMutableArray array = [smsTimingArray objectForKey:@"title"];
	smsTimingArray = [[NSMutableArray alloc] initWithObjects:@"Number Setting", nil];

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
	tableView.delegate						= self;
	tableView.dataSource					= self;
	tableView.separatorStyle				= UITableViewCellSeparatorStyleNone;
	//tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	tableView.tag							= TAG_TABLEVIEW;
	[self.view addSubview:tableView];
	[tableView release];
	
	//Text Field
	UITextField *textfield = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, 31.0f)] autorelease];
	textfield.tag							= TAG_TEXTFIELD;
	textfield.delegate						= self;
	textfield.autocorrectionType			= UITextAutocorrectionTypeNo;
	textfield.autocapitalizationType		= UITextAutocapitalizationTypeNone;
	textfield.enablesReturnKeyAutomatically = YES;
	textfield.borderStyle					= UITextBorderStyleRoundedRect;
	textfield.returnKeyType					= UIReturnKeySend;
	textfield.clearButtonMode				= UITextFieldViewModeWhileEditing;
	
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 372.0f, 320.0f, 44.0f)];
	toolBar.tag								= TAG_TOOLBAR;
	NSMutableArray* allitems = [[NSMutableArray alloc] init];
	[allitems addObject:[[[UIBarButtonItem alloc] initWithCustomView:textfield] autorelease]];
	
	//UIBarButtonItem addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertMe)] autorelease];
	UIImage *image = [UIImage imageNamed:@"bubble.png"];
	UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 0, 40, 31)];
	[addBtn addTarget						:self 
			action							:@selector(insertMe:) 
			forControlEvents				:UIControlEventTouchUpInside];
	[addBtn setBackgroundImage				:image 
			forState						:UIControlStateNormal];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
	addButton.style							= UIBarButtonSystemItemAdd;
	
	[allitems addObject:addButton];
	[addBtn release];
	[addButton release];
	[image release];
	//[allitems addObject:addBtn autorelease]];
	[toolBar setItems:allitems];
	[allitems release];
	[self.view addSubview:toolBar];
	[toolBar release];	
	
    [super viewDidLoad];
}



-(void)insertMe:(id)sender{
	NSLog(@"insert me");
}

#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [smsTimingArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return tableView.rowHeight;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *SMSSetViewCellIdentifier = @"SMSSetViewCellIdentifier";
	EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:SMSSetViewCellIdentifier];
	[tableView setSeparatorColor:[UIColor redColor]];
	tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	if (cell == nil) {
		cell = [[[EditableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SMSSetViewCellIdentifier] autorelease];		
		//cell.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
		//cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	//cell.textLabel = [smsTimingArray objectAtIndex:[indexPath row]];
	pickNameBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
	[pickNameBtn setTitle:@"PickName" forState:UIControlStateNormal];
	pickNameBtn.backgroundColor					= [UIColor clearColor];
	pickNameBtn.frame							= CGRectMake(270.0,	5.0,	40.0,	25.0);
	[pickNameBtn addTarget:self
					action:@selector(buttonPressed:)
		  forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:pickNameBtn];

	
	sendBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
	[sendBtn setTitle:@"PickName" forState:UIControlStateNormal];
	sendBtn.backgroundColor					= [UIColor clearColor];
	sendBtn.frame							= CGRectMake(270.0,	65.0,	40.0,	25.0);
	[sendBtn addTarget:self
					action:@selector(sendButtonPressed:)
		  forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:sendBtn];
	
	
	cell.numberField.text	= pickNumber;
	NSLog(@"pick Number: %@", pickNumber);
	MySingleton.retriveSingletion.someProperty = pickNumber;
	cell.timeField.text = @"6";
	cell.smsField.text = @"";
	cell.numberLabel.text	= @"Number";
	cell.timeLabel.text		= @"Time";
	cell.smsLabel.text		= @"Content";
	return cell;
}

#pragma mark Text field methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// called when 'return' key pressed. return NO to ignore.
	[textField resignFirstResponder];
	return YES;
}


-(void)sendButtonPressed:(id)sender{
	//[self.view insertSubview:yellowViewController.view atIndex:0];

}

#pragma mark Table Delegate Methods
//选中哪一行
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return indexPath;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark Show all contacts
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
	// The application only shows the phone, email, and birthdate information of the selected contact.
	//NSLog(@"选中了=%@", indexpath);
	NSUInteger row = [indexPath row];
	if(row == 0)
	{
	
	}
	
}

#pragma mark Contact list picker
-(void)buttonPressed:(id)sender{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty], 
							   [NSNumber numberWithInt:kABPersonEmailProperty],
							   [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	
	picker.displayedProperties = displayedItems;
	// Show the picker 
	[self presentModalViewController:picker animated:YES];
	[[MySingleton retriveSingletion] sayHello];
	
	[picker release];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
	  shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	//获取联系人姓名
	pickNumber = (NSString*)ABRecordCopyCompositeName(person);
	//获取联系人电话
	ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
	NSMutableArray *phones = [[NSMutableArray alloc] init];
	int i;
	for (i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
		NSString *aPhone = [(NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i) autorelease];
		NSString *aLabel = [(NSString*)ABMultiValueCopyLabelAtIndex(phoneMulti, i) autorelease];
		NSLog(@"PhoneLabel:%@ Phone#:%@",aLabel,aPhone);
		if([aLabel isEqualToString:@"_$!<Mobile>!$_"])
		{
			[phones addObject:aPhone];
		}
	}
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TAG_TABLEVIEW];
	[tableView reloadData];
	/*.text=@"";
	if([phones count]>0)
	{
		NSString *mobileNo = [phones objectAtIndex:0];
		phoneNo.text = mobileNo;
		//NSLog(mobileNo);
	}
	//获取联系人邮箱
	ABMutableMultiValueRef emailMulti = ABRecordCopyValue(person, kABPersonEmailProperty);
	NSMutableArray *emails = [[NSMutableArray alloc] init];
	for (i = 0;i < ABMultiValueGetCount(emailMulti); i++)
	{
		NSString *emailAdress = [(NSString*)ABMultiValueCopyValueAtIndex(emailMulti, i) autorelease];
		[emails addObject:emailAdress];
	}
/*	email.text=@"";
	if([emails count]>0)
	{
		NSString *emailFirst=[emails objectAtIndex:0];
		email.text = emailFirst;
		//NSLog(emailFirst);
	}
*/
	[peoplePicker dismissModalViewControllerAnimated:YES];
	return NO;
//	return YES;
}


// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
	  shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property 
							  identifier:(ABMultiValueIdentifier)identifier
{
	NSLog(@"Select person!");
	return NO;
	//return YES;
}


// Dismisses the people picker and shows the application when users tap Cancel. 
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController 
shouldPerformDefaultActionForPerson:(ABRecordRef)person 
					property:(ABPropertyID)property 
				  identifier:(ABMultiValueIdentifier)identifierForValue
{
	return NO;
}


#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller. 
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController 
	   didCompleteWithNewPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark ABUnknownPersonViewControllerDelegate methods
// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact. 
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView 
				 didResolveToPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController 
shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property 
						 identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
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
	smsTimingArray = nil;
}


- (void)dealloc {
	[smsTimingArray release];
    [super dealloc];
}


@end
