//
//  StateTableCellView.m
//  States
//
//  Created by Julio Barros on 1/26/09.
//  Copyright 2009 E-String Technologies, Inc.. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

@synthesize v1,v2,v3,v4,b1,b2,b3,b4,unv1,unv2,unv3,unv4,delegate,callback,cellflage,h1,h2,h3,h4;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
       
    }
    return self;
}
/*

    UIButton *button=(UIButton*)sender;
    NSLog(@"%d",button.tag);
    
    if(unv1.image==nil&&b1.tag==button.tag)
    {
         unv1.image=[UIImage imageNamed: @"tick.png"];          
    }
    else
    {
       unv1.image=nil;    
    }
    
    if(unv1.image==nil&&b2.tag==button.tag)
    {
        //unv2.image=nil;
    }
    else{
        unv2.image=nil;    
    }
    
    if(unv1.image==nil&&b3.tag==button.tag)
    {
        unv3.image=nil;
    }
    else{
        unv3.image=nil;    
    }
    
    
    if(unv1.image==nil&&b4.tag==button.tag)
    {
        unv4.image=nil;
    }
    else{
        unv4.image=nil;    
    }
    
}*/
-(IBAction)imageHandlerController:(id)sender{
  
    [delegate performSelector:callback withObject:sender];

}

/*- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}*/


- (void)dealloc {
}


@end
