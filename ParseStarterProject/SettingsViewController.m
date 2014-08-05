//
//  SettingsViewController.m
//  InstaLikePlus
//
//  Created by Kanwal on 27/06/2014.
//
//

#import "SettingsViewController.h"
#import "ParseStarterProjectAppDelegate.h"
#import "InAppPurchaseViewController.h"
#import "GoProViewController.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{

    ParseStarterProjectAppDelegate *controller = (ParseStarterProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	for(UIView *view in controller.tabbar.tabBar.subviews)
	{
		if([view isKindOfClass:[UIImageView class]])
		{
			[view removeFromSuperview];
		}
	}
	[controller.tabbar.tabBar insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar2.png"]] atIndex:0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        return 2;
    }
    else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] init];
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"شراء نقاط";
        }
        else{
        
            cell.textLabel.text=@"إزالة الإعلانات";
        }
        
    }
    else {
        cell.textLabel.text=@"تسجيل الخروج";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section==0){
    
        if (indexPath.row==0) {
            InAppPurchaseViewController *obj=[[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController" bundle:nil];
            [self presentViewController:obj animated:YES completion:^{
                
            }];
        }
        else{
        
            GoProViewController *obj=[[GoProViewController alloc] initWithNibName:@"GoProViewController" bundle:nil];
            [self presentViewController:obj animated:YES completion:^{
                
            }];

        }
    }
    else{
    
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"logout"
         object:self];

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section < 1)return nil;
    
    UILabel *rightsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    rightsLabel.backgroundColor = [UIColor clearColor];
    
    rightsLabel.textColor = [UIColor colorWithRed:37.0/255 green:37.0/255 blue:37.0/255 alpha:1.0];
    
    [rightsLabel setAlpha:0.5];
    
    [rightsLabel setTextAlignment:1];
    
    [rightsLabel setNumberOfLines:2];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    
    rightsLabel.text = [@"الإصدار: " stringByAppendingFormat:@"%.1f\n%@ %@",[[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] floatValue],@"جميع الحقوق محفوظة للمطورين العرب ",[dateFormatter stringFromDate:[NSDate date]]];
    
    rightsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    
    return rightsLabel;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)return 50;
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if(section==0){
    
        return @"شراء";
    }
    else{
    
        return @"تسجيل الخروج من حسابك";
    }
}
- (IBAction)followTabClicked:(id)sender {
    ParseStarterProjectAppDelegate *controller = (ParseStarterProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
    [controller.tabbar setSelectedIndex:0];
}
@end
