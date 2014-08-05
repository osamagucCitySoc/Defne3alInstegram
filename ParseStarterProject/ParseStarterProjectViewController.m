#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>
#import "IGLoginViewController.h"

@implementation ParseStarterProjectViewController

@synthesize busyIndicator,loginBtn;

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.busyIndicator];
    [self.busyIndicator setAlpha:1.0];
    [self.loginBtn setAlpha:0.0];
    [self loadInstagram];
    [self loadAccountLimit];
    [self loadAds];
}

#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.view addSubview:self.busyIndicator];
    [self.navigationController setNavigationBarHidden:YES];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        bg.image=[UIImage imageNamed:@"Default-blur.png"];
        bg.frame=CGRectMake(0, 0, 320, 568);
    }
    loginBtn.layer.cornerRadius=10;
}

-(IBAction)LoginIG:(id)sender{
    
    IGLoginViewController *Obj=[[IGLoginViewController alloc] initWithNibName:@"IGLoginViewController" bundle:nil];
    [self.navigationController pushViewController:Obj animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark connection delegate
-(void)loadInstagram
{
    NSString *post = @"";
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSURL *url = [NSURL URLWithString:@"http://osamalogician.com/arabDevs/DefneOnInstagram/getInstagramSource.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    getInstagramSourceConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self    startImmediately:NO];
    
    [getInstagramSourceConnection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                            forMode:NSDefaultRunLoopMode];
    [getInstagramSourceConnection start];
    
}

-(void)loadAccountLimit
{
    NSString *post = @"";
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSURL *url = [NSURL URLWithString:@"http://osamalogician.com/arabDevs/DefneOnInstagram/getAccountLimit.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    getAccountsLimitConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self    startImmediately:NO];
    
    [getAccountsLimitConnection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                          forMode:NSDefaultRunLoopMode];
    [getAccountsLimitConnection start];
    
}

-(void)loadAds
{
    NSString *post = @"";
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSURL *url = [NSURL URLWithString:@"http://osamalogician.com/arabDevs/DefneOnInstagram/getAds.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    getAdsConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self    startImmediately:NO];
    
    [getAdsConnection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                          forMode:NSDefaultRunLoopMode];
    [getAdsConnection start];
    
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection == getInstagramSourceConnection)
    {
        NSString* string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"instagramurl"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.busyIndicator setAlpha:0.0];
        [self.loginBtn setAlpha:1.0];
    }else if(connection == getAccountsLimitConnection)
    {
        NSString* string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"accountlimit"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else if(connection == getAdsConnection)
    {
        NSString* string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"ads"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}



@end



