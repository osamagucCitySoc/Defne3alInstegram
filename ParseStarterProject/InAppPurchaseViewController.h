//
//  InAppPurchaseViewController.h
//  ParseStarterProject
//
//  Created by Kanwal on 4/23/14.
//
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

@interface InAppPurchaseViewController : UIViewController
{
    GADBannerView *bannerView_;
}
@property (strong, nonatomic) IBOutlet UIView *bannerAdView;

@end
