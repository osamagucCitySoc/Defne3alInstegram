//
//  FollowViewController.h
//  ParseStarterProject
//
//  Created by Kanwal on 5/24/14.
//
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "GADInterstitial.h"
#import "GADBannerView.h"
#import "InAdViewController.h"
#import "InAdProductViewController.h"

@interface FollowViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,GADInterstitialDelegate,NSURLConnectionDataDelegate,NSURLConnectionDownloadDelegate>{

    NSURLConnection* getAdsConnection;
    
    IBOutlet UIImageView *myimageView;
    IBOutlet UILabel *myName;
    IBOutlet UILabel *myNumberOfFollowers;
    IBOutlet UILabel *myNumberOfFollowing;
    IBOutlet UILabel *mytypeLabel;
    IBOutlet UILabel *mycoinsLabel;
    IBOutlet UILabel *noFbStatusLabel;
    //UITapGestureRecognizer *tapRecognizer;
    int followed;
    int load;
    
    IBOutlet UIImageView *userimageView;
    IBOutlet UILabel *usersName;
    IBOutlet UILabel *userNumberOfFollowers;
    IBOutlet UILabel *userNumberOfFollowing;
    IBOutlet UILabel *userNumberOfPosts;
    IBOutlet UILabel *userDescription;
    IBOutlet UILabel *usertypeLabel;
    IBOutlet UIView *userroundView;
    IBOutlet UIView *bannerAdView;
    PFObject *CurrentUserObject;
    UserProfile *CurrentUSerProfile;
    
    BOOL isShowingMenu;
    IBOutlet UIView *FollowView;
    UITapGestureRecognizer *HideTapGesture;
    
    IBOutlet UIButton *PromotionButton;
    IBOutlet UIButton *SkipButton;
    IBOutlet UIButton *LikeButton;
    
    IBOutlet UIButton *RefreshButton;
    IBOutlet UIActivityIndicatorView *ActivityIndicator;

    GADInterstitial *interstitial_;
    GADBannerView *bannerView_;
}
- (IBAction)settingsClicked:(id)sender;
- (IBAction)adClicked:(id)sender;

@end
