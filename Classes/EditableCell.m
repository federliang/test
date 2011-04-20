//
//  EditableCellRenderer.m
//  Untitled
//
//  Created by Grueter Anna on 5/26/10.
//  Copyright 2010 Borkware. All rights reserved.
//

#import "EditableCell.h"


@implementation EditableCell

@synthesize numberField, smsField, timeField, hint, secure, bgImage, numberLabel, timeLabel, smsLabel, key, section, row;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// Adding the text field
		numberField = [self newTextFieldWithPrimaryColor:[UIColor greenColor] selectedColor:[UIColor cyanColor] fontSize:15.0 bold:NO];
		numberField.clearsOnBeginEditing			= NO;
		numberField.returnKeyType					= UIReturnKeyDone;
		numberField.delegate						= self;
		[self.contentView addSubview:numberField];

		smsField = [self newTextFieldWithPrimaryColor:[UIColor greenColor] selectedColor:[UIColor cyanColor] fontSize:15.0 bold:NO];
		smsField.clearsOnBeginEditing				= NO;
		smsField.returnKeyType						= UIReturnKeyDone;
		smsField.delegate							= self;
		[self.contentView addSubview:smsField];

		timeField = [self newTextFieldWithPrimaryColor:[UIColor greenColor] selectedColor:[UIColor cyanColor] fontSize:15.0 bold:NO];
		timeField.clearsOnBeginEditing				= NO;
		timeField.returnKeyType						= UIReturnKeyDone;
		timeField.delegate							= self;
		[self.contentView addSubview:timeField];
		
		self.numberLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:15.0 bold:NO];
		[self.contentView addSubview:self.numberLabel];

		self.timeLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:15.0 bold:NO];
		[self.contentView addSubview:self.timeLabel];
		
		self.smsLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:15.0 bold:NO];
		[self.contentView addSubview:self.smsLabel];
		

	}
    return self;
}

- (void)setContent:(NSMutableDictionary*)data{
	self.key = (NSString*)[data valueForKey:@"key"];
	self.numberLabel.text = (NSString*)[data valueForKey:@"label"];
	self.numberField.text = (NSString*)[data valueForKey:@"value"];
	NSNumber *test = (NSNumber*)[data valueForKey:@"editable"];
	BOOL test1 = [test boolValue];
	if(!test1){
		self.numberField.enabled = FALSE;
	}
}

-(UITextField *)newTextFieldWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	/*	 Create and configure a textfield.	 */	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	/*	 Views are drawn most efficiently when they are opaque and do not have a clear background, so set these defaults.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  This is handled in setSelected:animated:.	 */
	UITextField *newTextField = [[UITextField alloc] initWithFrame:CGRectZero];
	newTextField.opaque					= NO;
	//newTextField.textColor				= primaryColor;
	newTextField.backgroundColor		= [UIColor blueColor];
	newTextField.font					= font;
	newTextField.textAlignment			= UITextAlignmentLeft;
	return newTextField;
}
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	/*	 Create and configure a label.	 */
	UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	
    /*	 Views are drawn most efficiently when they are opaque and do not have a clear background, so set these defaults.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  This is handled in setSelected:animated:.	 */
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.opaque						= NO;
	newLabel.textColor					= primaryColor;
	newLabel.backgroundColor			= [UIColor clearColor];
	newLabel.highlightedTextColor		= selectedColor;
	newLabel.font						= font;
	newLabel.adjustsFontSizeToFitWidth	= YES;
	newLabel.textAlignment				= UITextAlignmentLeft; 
	newLabel.adjustsFontSizeToFitWidth	= TRUE;
	newLabel.minimumFontSize = 10;
	return newLabel;
}
-(void)dealloc {
	[numberLabel release];
	[numberField release];
	[smsField release];
	[smsLabel release];
	[timeField release];
	[timeLabel release];
    [super dealloc];
}

-(void)setHint:(NSString *)h{
	numberField.placeholder = h;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
	
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField1{
	[textField1 resignFirstResponder];
	return YES;
}

-(void)setSecure:(BOOL)sec{
	numberField.secureTextEntry = sec;
	secure = sec;
}

-(BOOL)getSecure{
	return secure;
}





#pragma mark Laying out subviews
-(void)layoutSubviews {
	//CGRect frame = CGRectMake(0,0,320,42);
	//[self.bgImage setFrame:frame];
	numberField.frame	= CGRectMake(60.0,	5.0,	210.0,	25.0);
	timeField.frame		= CGRectMake(60.0,	35.0,	210.0,	25.0);
	smsField.frame		= CGRectMake(60.0,	65.0,	210.0,	25.0);
	numberLabel.frame	= CGRectMake(0,		5.0,	60.0,	25.0);
	timeLabel.frame		= CGRectMake(0.0,	35.0,	60.0,	25.0);
	smsLabel.frame		= CGRectMake(0.0,	65.0,	60.0,	25.0);
}



@end
