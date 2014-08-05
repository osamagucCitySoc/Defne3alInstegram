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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
    
    [[InAppPurchaseManager InAppPurchaseManagerSharedInstance] PurchaseProductWithNumber:[sender tag] Delegate:self WithSelector:@selector(Purchased:) WithErrorSelector:nil];
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
    }
    if ([product isEqualToString:no_follow_back]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:no_follow_back];
        [self setNoFollowBack:YES];
    }
    
    //updating label only.
}
-(void)setNoFollowBack:(BOOL)status
{
    [DataHolder DataHolderSharedInstance].UserObject[@"noFollowBack"]=[NSNumber numberWithBool:YES];;
    [DataHolder DataHolderSharedInstance].UserObject[@"noFollowBackEnd"]=[NSNumber numberWithLongLong:([[NSDate date] timeIntervalSince1970]+(14*24*60*60))];
    [[DataHolder DataHolderSharedInstance].UserObject saveInBackground];
}
-(void)AddCoins:(int)coins{
    
    PFQuery *query = [PFQuery queryWithClassName:@"user"];
    [query getObjectInBackgroundWithId:[DataHolder DataHolderSharedInstance].UserObjectID block:^(PFObject *user, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        int coins=[[user objectForKey:@"coins"] integerValue]+coins;
        user[@"coins"]=[NSNumber numberWithInt:coins];
        [user save];
    }];
}
-(void)Error:(NSError*)error{
    
    // [[AppManager AppManagerSharedInstance ] Show_Alert_With_Title:@"Error!" message:@"Unexpected Error Occured.Please Try Again Later"];
}

-(IBAction)Back:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
