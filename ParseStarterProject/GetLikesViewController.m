//
//  GetLikesViewController.m
//  ParseStarterProject
//
//  Created by Kanwal on 4/22/14.
//
//

#import "GetLikesViewController.h"
#import "InAppPurchaseViewController.h"
#import "ParseStarterProjectAppDelegate.h"

@interface GetLikesViewController ()

@end

@implementation GetLikesViewController
@synthesize index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    coinsLabel.layer.cornerRadius = 10;
    MediaObj=[[DataHolder DataHolderSharedInstance].MediaObjectsArray objectAtIndexedSubscript:index];
    [imageView setImageWithURL:[NSURL URLWithString:MediaObj.low_resolution]];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self UpdateCoinsLabel];
    ParseStarterProjectAppDelegate *controller = (ParseStarterProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	for(UIView *view in controller.tabbar.tabBar.subviews)
	{
		if([view isKindOfClass:[UIImageView class]])
		{
			[view removeFromSuperview];
		}
	}
	[controller.tabbar.tabBar insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar1.png"]] atIndex:0];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)GetLikes:(id)sender{

    act.hidden=NO;
    self.view.userInteractionEnabled=NO;
    if ([sender tag]==0) {
        [self GetLikedWithcoin:16 andLikes:10];
    }
    else if ([sender tag]==1) {
        [self GetLikedWithcoin:40 andLikes:25];
    }
    else if ([sender tag]==2) {
        [self GetLikedWithcoin:75 andLikes:50];
    }
    else if ([sender tag]==3) {
        [self GetLikedWithcoin:300 andLikes:200];
    }
    else if ([sender tag]==4) {
        [self GetLikedWithcoin:560 andLikes:400];
    }
    else if ([sender tag]==5) {
        [self GetLikedWithcoin:2800 andLikes:2000];
    }
}
-(void)GetLikedWithcoin:(int)coins andLikes:(int)likes{

    
    PFObject *user= [DataHolder DataHolderSharedInstance].UserObject;
    [user refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        int currentCoins=[[user objectForKey:@"coins"] integerValue];
        if (currentCoins>coins) {
            CoinsUsed=coins;
            PFObject *gameScore = [PFObject objectWithClassName:@"MediaLikes"];
            gameScore[@"mediaId"] = MediaObj.Id;
            gameScore[@"likesDue"] = [NSNumber numberWithInt:likes];
            gameScore[@"userId"] = [DataHolder DataHolderSharedInstance].UserID;
            gameScore[@"url"] = MediaObj.low_resolution;
            
            PFACL *postACL = [PFACL ACLWithUser:[PFUser currentUser]];
            [postACL setPublicReadAccess:YES];
            [postACL setPublicWriteAccess:YES];
            gameScore.ACL = postACL;
            
            [gameScore saveInBackgroundWithTarget:self selector:@selector(useCoins)];
            [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"Congradulations!" message:@"Your media will be start liking soon"];
        }
        else{
            
            [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"عذراً" message:@"ليس لديك نقاط كافية"];
            
            [self InApp:nil];
            
        }
    }];
    act.hidden=YES;
    self.view.userInteractionEnabled=YES;
    
}
-(IBAction)InApp:(id)sender{

    InAppPurchaseViewController *obj=[[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    [self presentViewController:obj animated:YES completion:nil];
}
-(void)useCoins{

    PFObject *user=[DataHolder DataHolderSharedInstance].UserObject;
    int coins=[[user objectForKey:@"coins"] integerValue]-CoinsUsed;
    user[@"coins"]=[NSNumber numberWithInt:coins];
    [user save];
    [self.navigationController popViewControllerAnimated:YES];


}
-(IBAction)Back:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)UpdateCoinsLabel{
    
    PFObject *user=[DataHolder DataHolderSharedInstance].UserObject;
    [user refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        coinsLabel.text=[NSString stringWithFormat:@" %@",user[@"coins"]];

    }];
    
}
@end
