//
//  InAppPurchaseViewController.m
//  ParseStarterProject
//
//  Created by Kanwal on 4/23/14.
//
//

#import "InAppPurchaseViewController.h"
#import "DataHolder.h"
#import "InAppPurchaseManager.h"

@interface InAppPurchaseViewController ()

@end

@implementation InAppPurchaseViewController

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
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.adUnitID = @"ca-app-pub-2433238124854818/3042396798";
    bannerView_.rootViewController = self;
    

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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"removeads"] || ![[[NSUserDefaults standardUserDefaults]objectForKey:@"ads"] isEqualToString:@"0"]){
        [self.bannerAdView addSubview:bannerView_];
        [bannerView_ loadRequest:[GADRequest request]];
    }else{
        [bannerView_ removeFromSuperview];
    }
}
-(IBAction)PurchaseProduct:(id)sender{

    
    [[InAppPurchaseManager InAppPurchaseManagerSharedInstance] PurchaseProductWithNumber:[sender tag] Delegate:self WithSelector:@selector(Purchased:) WithErrorSelector:nil];
}
-(IBAction)Restore:(id)sender{

    [[InAppPurchaseManager InAppPurchaseManagerSharedInstance] Restore_ProductsWithDelegate:self WithSelector:@selector(Purchased:) WithErrorSelector:nil];
}
-(void)Purchased:(NSString*)product{
    //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ads"];
    
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
    
    //updating label only.
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
