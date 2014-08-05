//
//  InAdProductViewController.h
//  InstaLikePlus
//
//  Created by OsamaMac on 8/5/14.
//
//

#import <UIKit/UIKit.h>

@interface InAdProductViewController : UIViewController
- (IBAction)backPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic)int tag;
@end
