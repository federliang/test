//
//  EditableCell.h
//  Untitled
//
//  Created by Grueter Anna on 5/26/10.
//  Copyright 2010 Borkware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableCell : UITableViewCell <UITextFieldDelegate>{
	UITextField *numberField;	//input number text
	UITextField *smsField;		//input content of SMS
	UITextField *timeField;		//input when recieve this SMS
	UILabel *numberLabel;		//
	UILabel *timeLabel;			//
	UILabel *smsLabel;			//
	
	BOOL secure;
	NSString *hint;
	UIImageView *bgImage;
	NSString *key;
	NSInteger section;
	NSInteger row;
}



@property (nonatomic, retain) UITextField *numberField;
@property (nonatomic, retain) UITextField *smsField;
@property (nonatomic, retain) UITextField *timeField;
@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *smsLabel;


@property (nonatomic, retain) NSString *key;
@property (assign) BOOL secure;
@property (assign) NSInteger section;
@property (assign) NSInteger row;
@property (nonatomic, retain)NSString *hint;
@property (nonatomic, retain) UIImageView *bgImage;
- (UITextField *)newTextFieldWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
//-(void)setRowStyle:(int)rowStyle; 
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

- (void)setContent:(NSMutableDictionary*)data;
@end
