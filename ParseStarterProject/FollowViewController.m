//
//  FollowViewController.m
//  ParseStarterProject
//
//  Created by Kanwal on 5/24/14.
//
//

#import "FollowViewController.h"
#import "DataHolder.h"
#import "WebManager.h"
#import "JSONParser.h"
#import "UserProfile.h"
#import "UIImageView+WebCache.h"
#import "InAppPurchaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ProfileViewController.h"
#import "ParseStarterProjectAppDelegate.h"
#import "GoProViewController.h"


@interface FollowViewController ()

    
@end

@implementation FollowViewController{

    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UICollisionBehavior* _collision;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(Login)
                                                     name:@"login"
                                                   object:nil];
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    
    ParseStarterProjectAppDelegate *controller = (ParseStarterProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	for(UIView *view in controller.tabbar.tabBar.subviews)
	{
		if([view isKindOfClass:[UIImageView class]])
		{
			[view removeFromSuperview];
		}
	}
	[controller.tabbar.tabBar insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar0.png"]] atIndex:0];

    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    mycoinsLabel.text=[NSString stringWithFormat:@"%@",[DataHolder DataHolderSharedInstance].UserObject[@"coins"]];
    
    
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"removeads"] || ![[[NSUserDefaults standardUserDefaults]objectForKey:@"ads"] isEqualToString:@"0"]){
        [bannerAdView addSubview:bannerView_];
        [bannerView_ loadRequest:[GADRequest request]];
    }else{
        [bannerView_ removeFromSuperview];
    }

    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"autoFollowAd"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"autoFollowAd"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self ShowMenu:nil];
    }
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"noFbAd"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"noFbAd"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self performSelector:@selector(ProTapped:) withObject:nil afterDelay:1.0];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = @"ca-app-pub-2433238124854818/2263667594";
    [interstitial_ setDelegate:self];
//    [interstitial_ loadRequest:request];
    
    followed = 1;
    
    if ([UIScreen mainScreen].bounds.size.height==568) {
        FollowView.frame=CGRectMake(FollowView.frame.origin.x, FollowView.frame.origin.y, FollowView.frame.size.width, FollowView.frame.size.height+88);
    }
    
    isShowingMenu=NO;
    self.navigationController.navigationBarHidden=YES;
    myimageView.layer.cornerRadius=50;
    userimageView.layer.cornerRadius=50;
    //userroundView.layer.cornerRadius=10;
    myimageView.layer.borderWidth=5.0;
    userimageView.layer.borderWidth=5.0;
    userroundView.layer.borderWidth=3.0;
    myimageView.layer.borderColor=[UIColor colorWithRed:70.0/255 green:70.0/255 blue:70.0/255 alpha:1.0].CGColor;
    userimageView.layer.borderColor=[UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:1.0].CGColor;
    userroundView.layer.borderColor=[UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:1.0].CGColor;
    [self ChangeSartStopButtonImageTiltle];
    
    //temp
    //return;
    
   
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"showPointsInfo"])
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"showPointsInfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"شكرا لك" message:@"مع كل عملية تابع تحصل عليها سيتم الخصم من نقاطك نقتطين.\nو عند نفاذ نقاطك لن تحصل على متابعين جدد لذلك ننصح بمتابعة دائمة لنقاطك و تزويدها إما بمتابعة الأخرين أو شراء نقاط.\nملحوظة: كلما قمت بعمل فولو أكثر كلما زاد ترتيب حسابك ليظهر كأول الحسابات أولوية في المتابعة" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.adUnitID = @"ca-app-pub-2433238124854818/3042396798";
    bannerView_.rootViewController = self;
    
    
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"ads"] isEqualToString:@"0"])
    {
        NSString *post = @"";
            
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
            
            NSURL *url = [NSURL URLWithString:@"http://osamalogician.com/arabDevs/DefneAdefak/sendComm2.php"];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
            [request setHTTPMethod:@"POST"];
            
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:postData];
            
            getAdsConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self    startImmediately:NO];
            
            [getAdsConnection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                                  forMode:NSDefaultRunLoopMode];
            [getAdsConnection start];
    }
}

-(void)Login{

    mytypeLabel.text=[DataHolder DataHolderSharedInstance].UserObject[@"usertype"];
    usertypeLabel.text=@"All Topics";
    [DataHolder DataHolderSharedInstance].userSelectedType=@"All Topics";
    mycoinsLabel.text=[NSString stringWithFormat:@"%@",[DataHolder DataHolderSharedInstance].UserObject[@"coins"]];
    [self LoadMyData];
    [self LoadNewUser:nil];
}
-(void)LoadMyData{

    [[WebManager WebManagerSharedInstance] FetchUserObjectsWithUserID:@"self" Delegate:self WithSelector:@selector(UserDataParser:) WithErrorSelector:@selector(Error:)];
}
-(void)UserDataParser:(NSData*)data{

    [DataHolder DataHolderSharedInstance].UserProfile=[[JSONParser JSONParserSharedInstance] ParseUserProfileObjects:data];
    [self LoadMyDataLabels];
}
-(void)LoadMyDataLabels{

    myName.text=[DataHolder DataHolderSharedInstance].UserProfile.username;
    myNumberOfFollowers.text=[DataHolder DataHolderSharedInstance].UserProfile.followed_by;
    myNumberOfFollowing.text=[DataHolder DataHolderSharedInstance].UserProfile.follows;
    [myimageView setImageWithURL:[NSURL URLWithString:[DataHolder DataHolderSharedInstance].UserProfile.profile_picture]];
    mytypeLabel.text=[DataHolder DataHolderSharedInstance].UserObject[@"usertype"];
    usertypeLabel.text=@"All Topics";
    [DataHolder DataHolderSharedInstance].userSelectedType=@"All Topics";
    mycoinsLabel.text=[NSString stringWithFormat:@"%@",[DataHolder DataHolderSharedInstance].UserObject[@"coins"]];
    if (![[DataHolder DataHolderSharedInstance].UserObject[@"username"] isEqualToString:[DataHolder DataHolderSharedInstance].UserProfile.username]) {
        [DataHolder DataHolderSharedInstance].UserObject[@"username"]=[DataHolder DataHolderSharedInstance].UserProfile.username;
        [[DataHolder DataHolderSharedInstance].UserObject saveInBackground];
    }
    
    
}
-(void)loadUserLabels{

    usersName.text=CurrentUSerProfile.username;
    userNumberOfFollowers.text=CurrentUSerProfile.followed_by;
    userNumberOfFollowing.text=CurrentUSerProfile.follows;
    userDescription.text=CurrentUSerProfile.bio;
    userNumberOfPosts.text=CurrentUSerProfile.media;
    [userimageView setImageWithURL:[NSURL URLWithString:CurrentUSerProfile.profile_picture]];
    [ActivityIndicator setAlpha:0.0];
    [self SetEnableUserInteraction];
    
}
-(IBAction)LoadNewUser:(id)sender{

    [RefreshButton setHidden:YES];
    ActivityIndicator.hidden=NO;
    [self SetDisableUserInteraction];
    PFQuery *query=[PFQuery queryWithClassName:@"user"];
    [query whereKey:@"coins" greaterThan:[NSNumber numberWithInt:0]];
    [query whereKey:@"appfollows" notEqualTo:[DataHolder DataHolderSharedInstance].UserObject[@"userId"]];
    [query orderByDescending:@"isOnPromotion"];
    [query addDescendingOrder:@"lastFollow"];
    [query setLimit:[[[NSUserDefaults standardUserDefaults] objectForKey:@"accountlimit"] intValue]];
    
    if (![[DataHolder DataHolderSharedInstance].userSelectedType isEqualToString:@"All Topics"]) {
        [query whereKey:@"usertype" equalTo:[DataHolder DataHolderSharedInstance].userSelectedType];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            if (objects.count!=0) {
            
                [[DataHolder DataHolderSharedInstance].usersArray removeAllObjects];
                [[DataHolder DataHolderSharedInstance].usersArray addObjectsFromArray:objects];
                [self CheckUserFromInstagramAndShow];
                
            }
            else{
                [RefreshButton setTitle:@"تمت متابعة كل الحسابات. أضغط هنا بعد قليل." forState:UIControlStateNormal];
                RefreshButton.hidden=NO;
                ActivityIndicator.hidden=YES;
                userroundView.hidden=YES;
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            //[self LoadNewUser:nil];
            RefreshButton.hidden=NO;
            ActivityIndicator.hidden=YES;
            userroundView.hidden=YES;

        }
    }];
    

    
    
}
-(void)CheckUserFromInstagramAndShow{

    [self SetDisableUserInteraction];
    if ([DataHolder DataHolderSharedInstance].usersArray.count!=0) {
        CurrentUserObject=[[DataHolder DataHolderSharedInstance].usersArray objectAtIndex:0];
        [CurrentUserObject refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (CurrentUserObject[@"isOnPromotion"]) {
                //[[WebManager WebManagerSharedInstance] GetRelationWithUserWithID:CurrentUserObject[@"userId"] Delegate:self WithSelector:@selector(RelationCallBack:) WithErrorSelector:@selector(Error:)];
                [[WebManager WebManagerSharedInstance] FetchUserObjectsWithUserID:CurrentUserObject[@"userId"] Delegate:self WithSelector:@selector(UserDataCallBack:) WithErrorSelector:@selector(Error:)];
            }
            else{
            
                [[DataHolder DataHolderSharedInstance].usersArray removeObject:CurrentUserObject];
                [self CheckUserFromInstagramAndShow];
            }
        }];
    }
    else{
    
        [self performSelectorOnMainThread:@selector(LoadNewUser:) withObject:nil waitUntilDone:YES];
        //[self LoadNewUser:nil];
        /*RefreshButton.hidden=NO;
        ActivityIndicator.hidden=YES;
        userroundView.hidden=YES;*/

    }
    
}
-(void)RelationCallBack:(NSData*)data{

    if ([[JSONParser JSONParserSharedInstance] ParseRelationObject:data]) {
        [[WebManager WebManagerSharedInstance] FetchUserObjectsWithUserID:CurrentUserObject[@"userId"] Delegate:self WithSelector:@selector(UserDataCallBack:) WithErrorSelector:@selector(Error:)];
    }
    else{
    
        
        [[DataHolder DataHolderSharedInstance].usersArray removeObject:CurrentUserObject];
        [self CheckUserFromInstagramAndShow];
        
    }
    
}
-(void)UserDataCallBack:(NSData*)data{

    CurrentUSerProfile=[[JSONParser JSONParserSharedInstance] ParseUserProfileObjects:data];
    [self loadUserLabels];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Follow:(id)sender{

    [self SetDisableUserInteraction];
    [ActivityIndicator setAlpha:1.0];
    followed ++;
    
    if( followed%5 == 0 && ![[NSUserDefaults standardUserDefaults]boolForKey:@"removeads"] && ![[[NSUserDefaults standardUserDefaults]objectForKey:@"ads"] isEqualToString:@"0"]){
        GADRequest* request = [GADRequest request];
        [interstitial_ loadRequest:request];
    }
    
    NSNumber* noFbEnd = [DataHolder DataHolderSharedInstance].UserObject[@"noFollowBackEnd"];
    
    NSNumber* current = [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]];

    followed = 11;
    if(![[DataHolder DataHolderSharedInstance].UserObject[@"isOnPromotion"] boolValue] && followed % 7 == 0)
    {
        InAdProductViewController *Obj=[[InAdProductViewController alloc] initWithNibName:@"InAdProductViewController" bundle:nil];
        [Obj setTag:888];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"autoFollowAd"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self presentViewController:Obj animated:YES completion:nil];
    }else if([noFbEnd longLongValue]<[current longLongValue] && followed % 11 == 0)
    {
        InAdProductViewController *Obj=[[InAdProductViewController alloc] initWithNibName:@"InAdProductViewController" bundle:nil];
        [Obj setTag:999];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"noFbAd"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self presentViewController:Obj animated:YES completion:nil];
    }
    /*[[WebManager WebManagerSharedInstance] FollowUserWithID:CurrentUserObject[@"userId"] Delegate:self WithSelector:@selector(FollowCallBack:) WithErrorSelector:@selector(Error:)];*/
}

-(void)FollowCallBack:(NSData*)data{

    if([[JSONParser JSONParserSharedInstance] ParseFollowResponseObject:data]){
    
        int coins=[CurrentUserObject[@"coins"] integerValue];
        coins-=2;
        if (coins<100) {
            CurrentUserObject[@"isOnPromotion"]=[NSNumber numberWithBool:NO];
        }
        CurrentUserObject[@"coins"]=[NSNumber numberWithInt:coins];

        NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:CurrentUserObject[@"appfollows"]];
        [arr addObject:[DataHolder DataHolderSharedInstance].UserID];
        CurrentUserObject[@"appfollows"]=arr;
        [CurrentUserObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [[DataHolder DataHolderSharedInstance].usersArray removeObject:CurrentUserObject];
            [self CheckUserFromInstagramAndShow];
        }];
        int mycoins=[[DataHolder DataHolderSharedInstance].UserObject[@"coins"] integerValue];
        [DataHolder DataHolderSharedInstance].UserObject[@"coins"]=[NSNumber numberWithInt:mycoins+1];
         [DataHolder DataHolderSharedInstance].UserObject[@"lastFollow"] = [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]];
        [[DataHolder DataHolderSharedInstance].UserObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self LoadMyDataLabels];
        }];
    }
    else{
    
        [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"عذراً" message:@"لاتستطيع المتابعة حالياً، هذه المشكلة من الانستغرام وليست من البرنامج، حاول مرة أخرى بعد قليل."];
    }
}

-(IBAction)Skip:(id)sender{

    
    followed ++;
    
    if( followed%5 == 0 && ![[NSUserDefaults standardUserDefaults]boolForKey:@"removeads"] && ![[[NSUserDefaults standardUserDefaults]objectForKey:@"ads"] isEqualToString:@"0"]){
        GADRequest* request = [GADRequest request];
        [interstitial_ loadRequest:request];
    }
    int mycoins=[[DataHolder DataHolderSharedInstance].UserObject[@"coins"] integerValue];
    
    if(mycoins < 1)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"عفوا" message:@"لا تملك النقاط الكافية برجاء زيادة النقاط بالمتابعة أو الشراء" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else
    {
        [ActivityIndicator setAlpha:1.0];
        [self SetDisableUserInteraction];
        mycoinsLabel.text=[NSString stringWithFormat:@"%i",(mycoins-1)];
        [mycoinsLabel setNeedsDisplay];
        [DataHolder DataHolderSharedInstance].UserObject[@"coins"]=[NSNumber numberWithInt:mycoins-1];
    
        [[DataHolder DataHolderSharedInstance].UserObject saveInBackground];
    
      //  [[DataHolder DataHolderSharedInstance].usersArray removeObject:CurrentUserObject];
      //  [self CheckUserFromInstagramAndShow];
        
        NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:CurrentUserObject[@"appfollows"]];
        [arr addObject:[DataHolder DataHolderSharedInstance].UserID];
        CurrentUserObject[@"appfollows"]=arr;
        [CurrentUserObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [[DataHolder DataHolderSharedInstance].usersArray removeObject:CurrentUserObject];
            [self CheckUserFromInstagramAndShow];
        }];
        
    }
    
}


-(IBAction)GetTokenTapped:(id)sender{

    InAppPurchaseViewController *Obj=[[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    [self presentViewController:Obj animated:YES completion:nil];
}
-(IBAction)ProTapped:(id)sender{
    
    GoProViewController *Obj=[[GoProViewController alloc] initWithNibName:@"GoProViewController" bundle:nil];
    [self presentViewController:Obj animated:YES completion:nil];
}
-(IBAction)StartStopPromotion:(id)sender{

    [[DataHolder DataHolderSharedInstance].UserObject refresh];
    if ([[DataHolder DataHolderSharedInstance].UserObject[@"isOnPromotion"] boolValue]) {
        [DataHolder DataHolderSharedInstance].UserObject[@"isOnPromotion"]=[NSNumber numberWithBool:NO];
        [[DataHolder DataHolderSharedInstance].UserObject saveInBackground];
    }
    else{
        if ([[DataHolder DataHolderSharedInstance].UserObject[@"coins"] integerValue]>=500) {
            [DataHolder DataHolderSharedInstance].UserObject[@"isOnPromotion"]=[NSNumber numberWithBool:YES];
            [[DataHolder DataHolderSharedInstance].UserObject saveInBackground];
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"شكرا لك" message:@"الأن حسابك ضمن الحسابات المميزة التي ستظهر لكل شخص.\nو مع كل عملية تابع تحصل عليها سيتم الخصم من نقاطك نقتطين.\nو عند نفاذ نقاطك لن تحصل على متابعين جدد لذلك ننصح بمتابعة دائمة لنقاطك و تزويدها إما بمتابعة الأخرين أو شراء نقاط." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
        
            [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"عذراً" message:@"أنت بحاجة ل 500 نقاط على الأقل لتفعيل الفولو التلقائي."];
        }
        
    }
    //[self ChangeSartStopButtonImageTiltle];
}
-(void)ChangeSartStopButtonImageTiltle{

    if ([[DataHolder DataHolderSharedInstance].UserObject[@"isOnPromotion"] boolValue]) {
    
        [PromotionButton setBackgroundImage:[UIImage imageNamed:@"logout.png.png"] forState:UIControlStateNormal];
        [PromotionButton setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else{
    
        [PromotionButton setBackgroundImage:[UIImage imageNamed:@"promote.png"] forState:UIControlStateNormal];
        [PromotionButton setTitle:@"الفولو التلقائي" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         PromotionButton.transform=CGAffineTransformMakeScale(1.1, 1.1);
                     }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.3
                                               delay:0.0
                                             options: UIViewAnimationCurveLinear
                                          animations:^{
                                              PromotionButton.transform=CGAffineTransformMakeScale(1.0, 1.0);
                                          }
                                          completion:^(BOOL finished){
                                              
                                              [self performSelector:@selector(ChangeSartStopButtonImageTiltle) withObject:nil afterDelay:0.2];
                                          }];
                     }];
}
-(IBAction)LogoutTapped:(id)sender{

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"الخروج؟" message:@"هل تريد الخروج حقاً?" delegate:self cancelButtonTitle:@"لا" otherButtonTitles:@"نعم", nil];
    [alert setTag:777];
    [alert show];
}
-(IBAction)SetCategoryTapped:(id)sender{

    UIActionSheet *actionsheet=[[UIActionSheet alloc] initWithTitle:@"Select your category" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"All Topics", @"Abstract",@"Advertising",@"Architecture",@"Art",@"Cars",@"Cities",@"Entertainment",@"Fashion",@"Food",@"Health & Fittness",@"Nature",@"Personal Life",@"Sports",@"Travel", nil];
    actionsheet.tag=1;
    [actionsheet showInView:self.view];
}
-(IBAction)SetMyCategory:(id)sender{

    UIActionSheet *actionsheet=[[UIActionSheet alloc] initWithTitle:@"Select your category" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Abstract",@"Advertising",@"Architecture",@"Art",@"Cars",@"Cities",@"Entertainment",@"Fashion",@"Food",@"Health & Fittness",@"Nature",@"Personal Life",@"Sports",@"Travel", nil];
    actionsheet.tag=0;
    [actionsheet showInView:self.view];
}
-(IBAction)ShowMenu:(id)sender{

    if (isShowingMenu) {
        [self HideMenu:nil];
        return;
    }
    
    
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         FollowView.frame=CGRectMake(0, self.view.frame.size.height-120, FollowView.frame.size.width, FollowView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                
                         HideTapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideMenu:)];
                         [self.view addGestureRecognizer:HideTapGesture];
                         isShowingMenu=YES;
                     }];
    
}
-(IBAction)HideMenu:(id)sender{

    [self.view removeGestureRecognizer:HideTapGesture];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         FollowView.frame=CGRectMake(0, 70, FollowView.frame.size.width, FollowView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         isShowingMenu=NO;
                     }];
    
}
-(void)Error:(NSError*)error{
    
    [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"خطأ" message:@"الرجاء المحاولة لاحقاً"];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 777 && buttonIndex==1) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
        //[self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"logout"
         object:self];
    }

}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{

    NSLog(@"%d",buttonIndex);
    if (actionSheet.tag==0) {
        if (buttonIndex!=14) {
            [DataHolder DataHolderSharedInstance].UserObject[@"usertype"]=[[DataHolder DataHolderSharedInstance].userTypes objectAtIndex:buttonIndex];
            [[DataHolder DataHolderSharedInstance].UserObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                mytypeLabel.text=[DataHolder DataHolderSharedInstance].UserObject[@"usertype"];
            }];
        }
    }
    else if (actionSheet.tag==1) {
        if (buttonIndex!=15) {
            if (buttonIndex==0) {
                [DataHolder DataHolderSharedInstance].userSelectedType=@"All Topics";
            }
            else{
            
                [DataHolder DataHolderSharedInstance].userSelectedType=[[DataHolder DataHolderSharedInstance].userTypes objectAtIndex:buttonIndex-1];
            }
            usertypeLabel.text=[DataHolder DataHolderSharedInstance].userSelectedType;
            [self LoadNewUser:nil];
        }
        
    }
}
-(void)SetDisableUserInteraction{

    [userroundView setHidden:YES];
    LikeButton.enabled=NO;
    SkipButton.enabled=NO;
}
-(void)SetEnableUserInteraction{

    [userroundView setHidden:NO];
    LikeButton.enabled=YES;
    SkipButton.enabled=YES;
}
-(IBAction)GotouserProfile{

    ProfileViewController *OBj=[[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    OBj.username=CurrentUserObject[@"username"];
    [self.navigationController pushViewController:OBj animated:YES];
    
}
- (IBAction)settingsClicked:(id)sender {
    ParseStarterProjectAppDelegate *controller = (ParseStarterProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
    [controller.tabbar setSelectedIndex:1];
}


- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [interstitial_ presentFromRootViewController:self];
}


#pragma mark connection delegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection == getAdsConnection)
    {
        NSError* error2;
        NSArray* dataSource = [NSJSONSerialization
                               JSONObjectWithData:data
                               options:kNilOptions
                               error:&error2];
        NSDictionary* ad = [dataSource lastObject];
        if(![[ad objectForKey:@"version"]isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"adversion"]])
        {
            [[NSUserDefaults standardUserDefaults]setObject:[ad objectForKey:@"version"] forKey:@"adversion"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            InAdViewController *Obj=[[InAdViewController alloc] initWithNibName:@"InAdViewController" bundle:nil];
            [Obj setAdDict:ad];
            [self presentViewController:Obj animated:YES completion:nil];
        }
    }
}
@end
