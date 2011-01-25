//
//  EditableCellRenderer.m
//  Untitled
//
//  Created by Grueter Anna on 5/26/10.
//  Copyright 2010 Borkware. All rights reserved.
//

#import "EditableCell.h"


@implementation EditableCell

@synthesize textField, hint, secure, bgImage, celllabel, key, section, row;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// Adding the text field
		textField = [self newTextFieldWithPrimaryColor:[UIColor cyanColor] selectedColor:[UIColor cyanColor] fontSize:15.0 bold:NO];
		textField.clearsOnBeginEditing = NO;
		textField.returnKeyType = UIReturnKeyDone;
		textField.delegate = self;
		[self.contentView addSubview:textField];
	
		UIImageView *bgImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell11.png"]];
		self.backgroundView = bgImage2;
		[bgImage2 release];
		
		self.celllabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:15.0 bold:NO];
		[self.contentView addSubview:self.celllabel];

    }
    return self;
}
- (void)setContent:(NSMutableDictionary*)data{
	self.key = (NSString*)[data valueForKey:@"key"];
	self.celllabel.text = (NSString*)[data valueForKey:@"label"];
	self.textField.text = (NSString*)[data valueForKey:@"value"];
	NSNumber *test = (NSNumber*)[data valueForKey:@"editable"];
	BOOL test1 = [test boolValue];
	if(!test1){
		self.textField.enabled = FALSE;
	}

}
- (UITextField *)newTextFieldWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	/*
	 Create and configure a label.
	 */
	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	/*
	 Views are drawn most efficiently when they are opaque and do not have a clear background, so set these defaults.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  This is handled in setSelected:animated:.
	 */
	UITextField *newLabel = [[UITextField alloc] initWithFrame:CGRectZero];
	newLabel.opaque					= NO;
	newLabel.textColor				= primaryColor;
	newLabel.backgroundColor		= [UIColor clearColor];
	newLabel.font					= font;
	newLabel.textAlignment			= UITextAlignmentRight;
	
	return newLabel;
}
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	/*
	 Create and configure a label.
	 */
	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	
    /*
	 Views are drawn most efficiently when they are opaque and do not have a clear background, so set these defaults.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  This is handled in setSelected:animated:.
	 */
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.opaque					= NO;
	newLabel.textColor				= primaryColor;
	newLabel.backgroundColor		= [UIColor clearColor];
	newLabel.highlightedTextColor	= selectedColor;
	newLabel.font					= font;
	newLabel.adjustsFontSizeToFitWidth = YES;
	newLabel.textAlignment = UITextAlignmentLeft; 
	newLabel.adjustsFontSizeToFitWidth = TRUE;
	newLabel.minimumFontSize = 10;
	return newLabel;
}
- (void)dealloc {
	[celllabel release];
	[textField release];
    [super dealloc];
}
- (void)setHint:(NSString *)h{
	textField.placeholder = h;
	//	textField.text = @"test";
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

	return YES;
}
- (void)setSecure:(BOOL)sec{
	
	textField.secureTextEntry = sec;
	secure = sec;
	
}
- (BOOL)getSecure{
	
	return secure;
	
}
#pragma mark -
#pragma mark Laying out subviews

- (void)layoutSubviews {
	//CGRect frame = CGRectMake(0,0,320,42);
	//[self.bgImage setFrame:frame];
	
	textField.frame = CGRectMake(90.0, 
								 12.0, 
								 220.0, 
								 35.0);
	
	celllabel.frame = CGRectMake(20, 12,  60, 15);
}



@end
