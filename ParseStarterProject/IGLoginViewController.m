//
//  IGLoginViewController.m
//  ParseStarterProject
//
//  Created by Kanwal on 4/21/14.
//
//

#import "IGLoginViewController.h"
#import "DataHolder.h"
#import "WebManager.h"
#import "JSONParser.h"
#import "FollowViewController.h"

@interface IGLoginViewController ()

@end

@implementation IGLoginViewController

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
    NSString *fullURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"instagramurl"];
    //@"https://instagram.com/oauth/authorize/?client_id=00fae446774e404e84875960bbdd851a&redirect_uri=http://localhost:8888/MAMP/&response_type=token&scope=likes+comments+relationships";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [mywebview loadRequest:requestObj];
    

    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{

    //temp
  //  [self GoNext];
    return;
    

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* urlString = [[request URL] absoluteString];
    NSLog(@"Recieved String:::::::: %@", urlString);
    NSURL *Url = [request URL];
    NSArray *UrlParts = [Url pathComponents];
    // do any of the following here
    if ([[UrlParts objectAtIndex:(1)] isEqualToString:@"MAMP"]) {
        //if ([urlString hasPrefix: @"localhost"]) {
        NSRange tokenParam = [urlString rangeOfString: @"access_token="];
        if (tokenParam.location != NSNotFound) {
            NSString* token = [urlString substringFromIndex: NSMaxRange(tokenParam)];
            
            // If there are more args, don't include them in the token:
            NSRange endRange = [token rangeOfString: @"&"];
            if (endRange.location != NSNotFound)
                token = [token substringToIndex: endRange.location];
            
            NSLog(@"access token %@", token);
            if ([token length] > 0 ) {
                [DataHolder DataHolderSharedInstance].AccessToken=token;
                [DataHolder DataHolderSharedInstance].UserID=[[token componentsSeparatedByString:@"."] objectAtIndex:0];
                [self CehckRegistration];
            }
            // use delegate if you want
            //[self.delegate instagramLoginSucceededWithToken: token];
            
        }
        else {
            // Handle the access rejected case here.
            NSLog(@"rejected case, user denied request");
        }
        return NO;
    }
    return YES;
}
-(void)CehckRegistration{

    // Finds barbecue sauces that start with "Big Daddy's".
    PFQuery *query = [PFQuery queryWithClassName:@"user"];
    [query whereKey:@"userId" hasPrefix:[DataHolder DataHolderSharedInstance].UserID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            if(objects.count==0){
            
                [self RegisterUser];
                return;
            }
            // Do something with the found objects
            PFObject *object=[objects objectAtIndex:0];
            object[@"accessToken"]=[DataHolder DataHolderSharedInstance].AccessToken;
            [object saveInBackgroundWithTarget:self selector:@selector(GoNext)];
            [DataHolder DataHolderSharedInstance].UserObject=object;
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            //[self RegisterUser];
        }
    }];
    

}
-(void)Login{

}

-(void)GetFollowers{
    
    [[WebManager WebManagerSharedInstance] FetchSelfFollowerObjectsWithDelegate:self WithSelector:@selector(GetFollowers:) WithErrorSelector:@selector(Error:)];
}
-(void)Error:(NSError*)error{

    [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"خطأ" message:@"الرجاء المحاولة لاحقاً"];
}
-(void)GetFollowers:(NSData*)data{
    
    [[JSONParser JSONParserSharedInstance] ParseUsersObjects:data];
    if (![[DataHolder DataHolderSharedInstance].NextMaxId isEqualToString:@""]) {
        [self GetFollowers];
    }
    else{
        
        [DataHolder DataHolderSharedInstance].UserObject[@"igfollows"]=[DataHolder DataHolderSharedInstance].follows;
        [[DataHolder DataHolderSharedInstance].UserObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self GoNext];
            }
        }];
        
        //[self GetAccomlishedArray];
    }
    
}


-(void)RegisterUser{
    
    PFObject *user = [PFObject objectWithClassName:@"user"];
    user[@"userId"] = [DataHolder DataHolderSharedInstance].UserID;
    user[@"accessToken"] = [DataHolder DataHolderSharedInstance].AccessToken;
    user[@"coins"] = [NSNumber numberWithInt:0];
    user[@"usertype"] = @"Abstract";
    user[@"appfollows"]=[NSArray arrayWithObject:[DataHolder DataHolderSharedInstance].UserID];
    user[@"isOnPromotion"] = [NSNumber numberWithBool:NO];
    
    PFACL *postACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [postACL setPublicReadAccess:YES];
    [postACL setPublicWriteAccess:YES];
    user.ACL = postACL;
    
    [user saveInBackgroundWithTarget:self selector:@selector(CehckRegistration)];
    
}


-(void)GoNext{

//     [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"Instagram Login" message:@"You are successfully logged in"];
//    
//    FollowViewController *Obj=[[FollowViewController alloc] initWithNibName:@"FollowViewController" bundle:nil];
//    [self.navigationController pushViewController:Obj animated:YES];
 
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"login"
     object:self];

    
    
}
-(void)GetParseLogin{
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"user"];
    [query1 whereKey:@"userId" hasPrefix:[DataHolder DataHolderSharedInstance].UserID];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            if(objects.count==0){
                
                [self RegisterUser];
                return;
            }
            // Do something with the found objects
            PFObject *object=[objects objectAtIndex:0];
            object[@"accessToken"]=[DataHolder DataHolderSharedInstance].AccessToken;
            [object saveInBackgroundWithTarget:self selector:@selector(GetFollowers)];
            [DataHolder DataHolderSharedInstance].UserObject=object;
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            //[self RegisterUser];
        }
    }];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
  [[AppManager AppManagerSharedInstance] Hide_Waiting_Alert];
    LoadingLabel.hidden=YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [[AppManager AppManagerSharedInstance] Show_Waiting_Alert];
    LoadingLabel.hidden=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Back:(id)sender{

    
}

@end
//{"*":{"read":true},"stsrntLKYM":{"write":true,"read":true}}