//
//  GetLikesViewController.h
//  ParseStarterProject
//
//  Created by Kanwal on 4/22/14.
//
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "MediaObject.h"
#import "DataHolder.h"

@interface GetLikesViewController : UIViewController{


    IBOutlet UIImageView *imageView;
    int index;
    MediaObject *MediaObj;
        int CoinsUsed;
    IBOutlet UILabel *coinsLabel;
    IBOutlet UIActivityIndicatorView *act;
}
@property(nonatomic,assign)int index;
@end
