//
//  StateTableCellView.h
//  States
//
//  Created by Julio Barros on 1/26/09.
//  Copyright 2009 E-String Technologies, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomCell;
@protocol CustomDelegate<NSObject>;
@optional
-(void)sendCallBack:(int)value;
-(void)sendCallBack2:(int)value2;
-(void)sendCallBack3:(int)value3;
-(void)sendCallBack4:(int)value4;
-(void)sendCallBack5:(int)value5;
@end

@interface CustomCell : UITableViewCell {
	
	IBOutlet UIImageView *v1;
	IBOutlet UIImageView *v2;
	IBOutlet UIImageView *v3;
	IBOutlet UIImageView *v4;
	IBOutlet UIButton *b1;
	IBOutlet UIButton *b2;
	IBOutlet UIButton *b3;
	IBOutlet UIButton *b4;
    IBOutlet UILabel *unv1;
    IBOutlet UILabel*unv2;
    IBOutlet UILabel *unv3;
    IBOutlet UILabel *unv4;
    int cellflage;
   	SEL callback;
    
}

@property (nonatomic,retain) IBOutlet UIImageView* v1;
@property (nonatomic,retain) IBOutlet UIImageView* v2;
@property (nonatomic,retain) IBOutlet UIImageView* v3;
@property (nonatomic,retain) IBOutlet UIImageView* v4;

@property (nonatomic,retain) IBOutlet UIImageView* h1;
@property (nonatomic,retain) IBOutlet UIImageView* h2;
@property (nonatomic,retain) IBOutlet UIImageView* h3;
@property (nonatomic,retain) IBOutlet UIImageView* h4;

@property(nonatomic,retain) IBOutlet UIButton *b1;
@property(nonatomic,retain) IBOutlet UIButton *b2;
@property(nonatomic,retain) IBOutlet UIButton *b3;
@property(nonatomic,retain) IBOutlet UIButton *b4;
@property (nonatomic,retain) IBOutlet UILabel* unv1;
@property (nonatomic,retain) IBOutlet UILabel* unv2;
@property (nonatomic,retain) IBOutlet UILabel* unv3;
@property (nonatomic,retain) IBOutlet UILabel* unv4;
@property(nonatomic,assign)int cellflage;
@property(nonatomic,assign)SEL callback;
@property(nonatomic, assign) id<CustomDelegate> delegate;
-(IBAction)imageHandlerController:(id)sender;
@end
