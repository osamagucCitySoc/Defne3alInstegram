//
//  InAdViewController.h
//  InstaLikePlus
//
//  Created by OsamaMac on 8/4/14.
//
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface InAdViewController : UIViewController


@property(nonatomic,strong)NSDictionary* adDict;
@property (strong, nonatomic) IBOutlet AsyncImageView *asyncImageView;
- (IBAction)dismissMeClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backButton;


@end
