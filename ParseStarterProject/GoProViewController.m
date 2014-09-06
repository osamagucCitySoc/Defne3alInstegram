//
//  GoProViewController.m
//  ParseStarterProject
//
//  Created by Kanwal on 5/24/14.
//
//

#import "GoProViewController.h"
#import "DataHolder.h"
#import "InAppPurchaseManager.h"
@interface GoProViewController ()

@end

@implementation GoProViewController
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
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)PurchaseProduct:(id)sender{
    if([sender tag] == 7)
    {
        int coins = [[DataHolder DataHolderSharedInstance].UserObject[@"coins"] integerValue];
        if(coins < 3000)
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"عفوا" message:@"لا تملك النقاط الكافية لتفعيل الخدمة. يجب على الأقل أن تملك ٣٠٠٠ نقطة" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else
        {
            [self AddCoins:-3000];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:no_follow_back];
            [self setNoFollowBack:YES];
        }
    }else
    {
    [[InAppPurchaseManager InAppPurchaseManagerSharedInstance] PurchaseProductWithNumber:[sender tag] Delegate:self WithSelector:@selector(Purchased:) WithErrorSelector:nil];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"ads"] isEqualToString:@"0"])
    {
        [self.noFbLabel setAlpha:0.0f];
    }else
    {
        [self.noFbLabel setAlpha:1.0f];
    }
}
-(IBAction)Restore:(id)sender{
    
    [[InAppPurchaseManager InAppPurchaseManagerSharedInstance] Restore_ProductsWithDelegate:self WithSelector:@selector(Purchased:) WithErrorSelector:nil];
}
-(void)Purchased:(NSString*)product{
    
    if ([product isEqualToString:Coins_500]) {
        [self AddCoins:500];
    }
    if ([product isEqualToString:Coins_1000]) {
        [self AddCoins:1000];
    }
    if ([product isEqualToString:Coins_3000]) {
        [self AddCoins:3000];
    }
    if ([product isEqualToString:Coins_8000]) {
        [self AddCoins:8000];
    }
    if ([product isEqualToString:Coins_25000]) {
        [self AddCoins:25000];
    }
    if ([product isEqualToString:remove_ads]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"removeads"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if ([product isEqualToString:no_follow_back]) {
    }
    
    //updating label only.
}
-(void)setNoFollowBack:(BOOL)status
{
    [DataHolder DataHolderSharedInstance].UserObject[@"noFollowBack"]=[NSNumber numberWithBool:YES];;
    [DataHolder DataHolderSharedInstance].UserObject[@"noFollowBackEnd"]=[NSNumber numberWithLongLong:([[NSDate date] timeIntervalSince1970]+(14*24*60*60))];
    [[DataHolder DataHolderSharedInstance].UserObject saveInBackground];
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"تم" message:@"تم التفعيل. شكرا لك" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
-(void)AddCoins:(int)coins{
    
    [[DataHolder DataHolderSharedInstance].UserObject refresh];
    [DataHolder DataHolderSharedInstance].UserObject[@"coins"]=[NSNumber numberWithInt:[[DataHolder DataHolderSharedInstance].UserObject[@"coins"] intValue]+coins];
    [[DataHolder DataHolderSharedInstance].UserObject saveInBackground];
    
}
-(void)Error:(NSError*)error{
    
    // [[AppManager AppManagerSharedInstance ] Show_Alert_With_Title:@"Error!" message:@"Unexpected Error Occured.Please Try Again Later"];
}

-(IBAction)Back:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
