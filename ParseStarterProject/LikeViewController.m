//
//  LikeViewController.m
//  ParseStarterProject
//
//  Created by Kanwal on 4/21/14.
//
//

#import "LikeViewController.h"
#import "DataHolder.h"
#import "MediaObject.h"
#import "WebManager.h"
#import "JSONParser.h"
#import "UIImageView+WebCache.h"
#import "InAppPurchaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ParseStarterProjectAppDelegate.h"
#import "CustomCell.h"
#import "GetLikesViewController.h"
#import "ParseStarterProjectAppDelegate.h"

@interface LikeViewController ()

@end

@implementation LikeViewController

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    act.hidden=YES;
    [self GetImagesToLikedFromParse];
       getcoinsBtn.enabled=NO;
    
    isShowing=NO;
    //[self GetImageFromArray];
    //coinsLabel.layer.borderColor = [UIColor blueColor].CGColor;
    //coinsLabel.layer.borderWidth = 1.0;
    coinsLabel.layer.cornerRadius = 10;
    if ([UIScreen mainScreen].bounds.size.height==568) {
        getlikesView.frame=CGRectMake(0, 50, 320, 500);
        ImageView.frame=CGRectMake(ImageView.frame.origin.x, ImageView.frame.origin.y, 280, 280);
    }
    // Do any additional setup after loading the view from its nib.
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
    
    
    coinsLabel.text=[NSString stringWithFormat:@"%@",[DataHolder DataHolderSharedInstance].UserObject[@"coins"]];
    }
-(void)Login{

    [self UpdateCoinsLabel];
    [self HideGetLikes];

}
-(IBAction)GetImagesToLikedFromParse{

    act.hidden=NO;
    reloadBtn.hidden=YES;
    likeBtn.enabled=NO;
    skipBtn.enabled=NO;
    self.view.userInteractionEnabled=NO;
    PFQuery *query = [PFQuery queryWithClassName:@"MediaLikes"];
    [query whereKey:@"liked" notEqualTo:[DataHolder DataHolderSharedInstance].UserID];
    [query whereKey:@"skip" notEqualTo:[DataHolder DataHolderSharedInstance].UserID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            [[DataHolder DataHolderSharedInstance].OBjectsTobeLiked removeAllObjects];
            [[DataHolder DataHolderSharedInstance].OBjectsTobeLiked addObjectsFromArray:objects];
            [self GetImageFromArray];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            //[self RegisterUser];
        }
    }];

}
-(void)GetImageFromArray{

    //act.hidden=NO;
    self.view.userInteractionEnabled=NO;
    likeBtn.enabled=NO;
    skipBtn.enabled=NO;
    if ([DataHolder DataHolderSharedInstance].OBjectsTobeLiked.count>0) {
        PFObject *Object=[[DataHolder DataHolderSharedInstance].OBjectsTobeLiked objectAtIndex:0];
        [Object refresh];
        NSArray *arr=[Object objectForKey:@"liked"];
        if ([[Object objectForKeyedSubscript:@"likesDue"] integerValue]==arr.count) {
        
            [[DataHolder DataHolderSharedInstance].OBjectsTobeLiked removeObjectAtIndex:0];
            [self GetImageFromArray];
        }
        NSString *imageID=[Object objectForKey:@"mediaId"];
        [[WebManager WebManagerSharedInstance] FetchMediaObjectsWithMediaId:imageID Delegate:self WithSelector:@selector(MediaFetched:) WithErrorSelector:@selector(Error:)];
        
        
    }
    else{
    
        act.hidden=YES;
        reloadBtn.hidden=NO;
        self.view.userInteractionEnabled=YES;
        
    }
}
-(void)MediaFetched:(NSData*)data{

    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" Media Data: %@", a);
    MediaObject *obj=[[JSONParser JSONParserSharedInstance] ParseMediaObject:data];
    NSLog(@" link: %@", obj.low_resolution);
    [self loadFromURL:[NSURL URLWithString:obj.low_resolution] callback:^(UIImage *image) {
        ImageView.image=image;
        likeBtn.enabled=YES;
        skipBtn.enabled=YES;
        act.hidden=YES;
    }];
    self.view.userInteractionEnabled=YES;

}
-(IBAction)LikeCurrentMedia{

    act.hidden=NO;
    likeBtn.enabled=NO;
    skipBtn.enabled=NO;
    if ([DataHolder DataHolderSharedInstance].OBjectsTobeLiked.count>0) {
    PFObject *Object=[[DataHolder DataHolderSharedInstance].OBjectsTobeLiked objectAtIndex:0];
    [[WebManager WebManagerSharedInstance] LikeMediaObjectWithID:[Object objectForKey:@"mediaId"] Delegate:self WithSelector:@selector(Liked:) WithErrorSelector:@selector(Error:)];
    }
}
-(IBAction)SkipCurrentMedia{
    act.hidden=NO;
    likeBtn.enabled=NO;
    skipBtn.enabled=NO;
    PFObject *Object=[[DataHolder DataHolderSharedInstance].OBjectsTobeLiked objectAtIndex:0];
    [Object refresh];
    NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:[Object objectForKey:@"skip"]];
    [arr addObject:[DataHolder DataHolderSharedInstance].UserID];
    Object[@"skip"]=arr;
    [Object saveInBackground];
    [[DataHolder DataHolderSharedInstance].OBjectsTobeLiked removeObjectAtIndex:0];
    if ([DataHolder DataHolderSharedInstance].OBjectsTobeLiked.count==0) {
        [self GetImagesToLikedFromParse];
    }
    [self GetImageFromArray];
}
-(void)Liked:(NSData*)data{

    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" liked Data: %@", a);
    
    PFObject *Object=[[DataHolder DataHolderSharedInstance].OBjectsTobeLiked objectAtIndex:0];
    [Object refresh];
    NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:[Object objectForKey:@"liked"]];
    [arr addObject:[DataHolder DataHolderSharedInstance].UserID];
    Object[@"liked"]=arr;
    [Object saveInBackground];
    PFObject *user=[DataHolder DataHolderSharedInstance].UserObject;
    int coins=[[user objectForKey:@"coins"] integerValue]+1;
    user[@"coins"]=[NSNumber numberWithInt:coins];
    [user save];
    
    [self UpdateCoinsLabel];
    [[DataHolder DataHolderSharedInstance].OBjectsTobeLiked removeObjectAtIndex:0];
    if ([DataHolder DataHolderSharedInstance].OBjectsTobeLiked.count==0) {
        [self GetImagesToLikedFromParse];
    }
    [self GetImageFromArray];

    
}
-(void)UpdateCoinsLabel{

    PFObject *user=[DataHolder DataHolderSharedInstance].UserObject;
    [user refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        coinsLabel.text=[NSString stringWithFormat:@" %@",user[@"coins"]];
    }];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            callback(image);
        });
    });
}
-(void)Error:(NSError*)error{
    self.view.userInteractionEnabled=YES;
    act2.hidden=YES;
    reloadUserMedia.hidden=NO;
    act.hidden=YES;
}
-(IBAction)ShowGetLikes{

    if (isShowing) {
        [self HideGetLikes];
        return;
    }
    [UIView beginAnimations:@"share_out" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
  	[UIView setAnimationRepeatCount:0];
	[UIView setAnimationDuration:0.5];
	getlikesView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-100, getlikesView.frame.size.width, getlikesView.frame.size.height);
	[UIView commitAnimations];
    getlikesBtn.enabled=NO;
    getcoinsBtn.enabled=YES;
    isShowing=YES;
    [self GetUserMedia];
    HideTapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideGetLikes)];
    [self.view addGestureRecognizer:HideTapGesture];
    

}
-(IBAction)HideGetLikes{

    isShowing=NO;
    [UIView beginAnimations:@"share_out" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
  	[UIView setAnimationRepeatCount:0];
	[UIView setAnimationDuration:0.5];
	getlikesView.frame=CGRectMake(0, 50, getlikesView.frame.size.width, getlikesView.frame.size.height);
	[UIView commitAnimations];
    getlikesBtn.enabled=YES;
    getcoinsBtn.enabled=NO;
    [self.view removeGestureRecognizer:HideTapGesture];
    
}
-(IBAction)GetUserMedia{

    self.view.userInteractionEnabled=NO;
    act2.hidden=NO;
    reloadUserMedia.hidden=YES;
    [[DataHolder DataHolderSharedInstance].MediaObjectsArray removeAllObjects];
    [self GetMedia];
    
}
-(void)GetMedia{

    [[WebManager WebManagerSharedInstance] FetchMediaObjectsWithUSerId:[DataHolder DataHolderSharedInstance].UserID Delegate:self WithSelector:@selector(MediaFectched:) WithErrorSelector:@selector(Error:)];
}
-(void)MediaFectched:(NSData*)data{

    [[JSONParser JSONParserSharedInstance] ParseMediaObjects:data];
    if (![[DataHolder DataHolderSharedInstance].NextMaxId isEqualToString:@""]) {
        [self GetMedia];
    }
    else{
    
        
        [self GetAccomlishedArray];
    }
    
}
-(void)GetAccomlishedArray{

    PFQuery *query = [PFQuery queryWithClassName:@"MediaLikes"];
    [query whereKey:@"userId" equalTo:[DataHolder DataHolderSharedInstance].UserID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully Accomplished REtrived %d", objects.count);
            [[DataHolder DataHolderSharedInstance].MyObjectsTobeLiked removeAllObjects];
            [[DataHolder DataHolderSharedInstance].MyObjectsTobeLiked addObjectsFromArray:objects];
            [self DisplayUSerMedia];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
    act2.hidden=YES;
    reloadUserMedia.hidden=NO;
}
-(void)DisplayUSerMedia{

    NSLog(@"My count:%d",[DataHolder DataHolderSharedInstance].MediaObjectsArray.count);
    [self SegmentChanged:nil];
    self.view.userInteractionEnabled=YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        return 120;
    }
    return 79;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int count=DataArray.count/4;
    if (DataArray.count%4!=0) {
        count++;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MyImageCell";
    CustomCell *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (CustomCell *)currentObject;
                break;
            }
        }
    }
    cell.delegate=self;
    cell.callback=@selector(GoForLikes:);
    // Here we use the new provided setImageWithURL: method to load the web image
    if(4*indexPath.row+0<[DataArray count]){
        
        if (segment.selectedSegmentIndex==0) {
            MediaObject *Obj=[DataArray objectAtIndex:4*indexPath.row+0];
            cell.unv1.text=[NSString stringWithFormat:@"%@",Obj.likesCount];
            [cell.v1 setImageWithURL:[NSURL URLWithString:Obj.thumbnail]];
            cell.v1.clipsToBounds = YES;
            cell.b1.tag=4*indexPath.row+1;
        }
        else{
            
            PFObject *Obj=[DataArray objectAtIndex:4*indexPath.row+0];
            NSArray *arr=[Obj objectForKey:@"liked"];
            cell.unv1.text=[NSString stringWithFormat:@"%d/%@",arr.count,[Obj objectForKey:@"likesDue"]];
            [cell.v1 setImageWithURL:[NSURL URLWithString:[Obj objectForKey:@"url"]]];
            cell.v1.clipsToBounds = YES;
            cell.b1.hidden=YES;
            
        }
        
        
    }
    else{
        cell.v1.image=nil;
        cell.v1.hidden=YES;
        cell.b1.tag=0;
        cell.b1.hidden=YES;
        cell.unv1.hidden=YES;
        cell.h1.hidden=YES;
    }
    if(4*indexPath.row+1<[DataArray count]){
        if (segment.selectedSegmentIndex==0) {
            MediaObject *Obj=[DataArray objectAtIndex:4*indexPath.row+1];
            cell.unv2.text=[NSString stringWithFormat:@"%@",Obj.likesCount];
            [cell.v2 setImageWithURL:[NSURL URLWithString:Obj.thumbnail]];
            cell.v2.clipsToBounds = YES;
            cell.b2.tag=4*indexPath.row+2;
        }
        else{
            
            PFObject *Obj=[DataArray objectAtIndex:4*indexPath.row+1];
            NSArray *arr=[Obj objectForKey:@"liked"];
            cell.unv2.text=[NSString stringWithFormat:@"%d/%@",arr.count,[Obj objectForKey:@"likesDue"]];
            [cell.v2 setImageWithURL:[NSURL URLWithString:[Obj objectForKey:@"url"]]];
            cell.v2.clipsToBounds = YES;
            cell.b2.hidden=YES;
            
        }
        
    }
    else{
        cell.v2.image=nil;
        cell.v2.hidden=YES;
        cell.b2.tag=0;
        cell.b2.hidden=YES;
        cell.unv2.hidden=YES;
        cell.h2.hidden=YES;
    }
    if(4*indexPath.row+2<[DataArray count])
    {
        if (segment.selectedSegmentIndex==0) {
            MediaObject *Obj=[DataArray objectAtIndex:4*indexPath.row+2];
            cell.unv3.text=[NSString stringWithFormat:@"%@",Obj.likesCount];
            [cell.v3 setImageWithURL:[NSURL URLWithString:Obj.thumbnail]];
            cell.v3.clipsToBounds = YES;
            cell.b3.tag=4*indexPath.row+3;
        }
        else{
            
            PFObject *Obj=[DataArray objectAtIndex:4*indexPath.row+2];
            NSArray *arr=[Obj objectForKey:@"liked"];
            cell.unv3.text=[NSString stringWithFormat:@"%d/%@",arr.count,[Obj objectForKey:@"likesDue"]];
            [cell.v3 setImageWithURL:[NSURL URLWithString:[Obj objectForKey:@"url"]]];
            cell.v3.clipsToBounds = YES;
            cell.b3.hidden=YES;
            
        }
    }
    else{
        cell.v3.image=nil;
        cell.v3.hidden=YES;
        cell.b3.tag=0;
        cell.b3.hidden=YES;
        cell.unv3.hidden=YES;
        cell.h3.hidden=YES;
    }
    if(4*indexPath.row+3<[DataArray count]){
        if (segment.selectedSegmentIndex==0) {
            MediaObject *Obj=[DataArray objectAtIndex:4*indexPath.row+3];
            cell.unv4.text=[NSString stringWithFormat:@"%@",Obj.likesCount];
            [cell.v4 setImageWithURL:[NSURL URLWithString:Obj.thumbnail]];
            cell.v4.clipsToBounds = YES;
            cell.b4.tag=4*indexPath.row+4;
        }
        else{
            
            PFObject *Obj=[DataArray objectAtIndex:4*indexPath.row+3];
            NSArray *arr=[Obj objectForKey:@"liked"];
            cell.unv4.text=[NSString stringWithFormat:@"%d/%@",arr.count,[Obj objectForKey:@"likesDue"]];
            [cell.v4 setImageWithURL:[NSURL URLWithString:[Obj objectForKey:@"url"]]];
            cell.v4.clipsToBounds = YES;
            cell.b4.hidden=YES;
            
        }
        
    }else{
        cell.v4.image=nil;
        cell.v4.hidden=YES;
        cell.b4.tag=0;
        cell.b4.hidden=YES;
        cell.unv4.hidden=YES;
        cell.h4.hidden=YES;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)GoForLikes:(id)sender{
    GetLikesViewController *Obj=[[GetLikesViewController alloc] initWithNibName:@"GetLikesViewController" bundle:nil];
    Obj.index=[sender tag]-1;
    [self.navigationController pushViewController:Obj animated:YES];
}
-(IBAction)SegmentChanged:(id)sender{
    
    if (segment.selectedSegmentIndex==0) {
        DataArray=[DataHolder DataHolderSharedInstance].MediaObjectsArray;
        [table reloadData];
    }
    else{
        
        DataArray=[DataHolder DataHolderSharedInstance].MyObjectsTobeLiked;
        [table reloadData];
        
    }
    
}
-(IBAction)Logout:(id)sender{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Loagout" message:@"Are you sure want to logout?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            
            //if([[cookie domain] isEqualToString:@"https://instagram.com"]) {
            
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            //}
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(IBAction)InApp:(id)sender{
    
    
    InAppPurchaseViewController *obj=[[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
    [self presentModalViewController:obj animated:YES];
    
}


@end
