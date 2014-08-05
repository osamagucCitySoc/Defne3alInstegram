//
//  LikeViewController.h
//  ParseStarterProject
//
//  Created by Kanwal on 4/21/14.
//
//

#import <UIKit/UIKit.h>

@interface LikeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{

    IBOutlet UIImageView *ImageView;
    IBOutlet UIButton *skipBtn;
    IBOutlet UIButton *likeBtn;
    IBOutlet UIButton *reloadBtn;
    IBOutlet UIView *getlikesView;
    IBOutlet UITableView *table;
    IBOutlet UILabel *coinsLabel;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UIButton *getlikesBtn;
    IBOutlet UIButton *getcoinsBtn;
    IBOutlet UIActivityIndicatorView *act;
    IBOutlet UIActivityIndicatorView *act2;
    IBOutlet UIButton *reloadUserMedia;
    UITapGestureRecognizer *HideTapGesture;

    NSArray *DataArray;
    BOOL isShowing;
}

@end
