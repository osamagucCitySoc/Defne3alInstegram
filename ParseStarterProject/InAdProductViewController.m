//
//  InAdProductViewController.m
//  InstaLikePlus
//
//  Created by OsamaMac on 8/5/14.
//
//

#import "InAdProductViewController.h"

@interface InAdProductViewController ()

@end

@implementation InAdProductViewController

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
    if(self.tag == 888)
        
    {
        [self.imageView setImage:[UIImage imageNamed:@"autoFollowAd.png"]];
    }else if(self.tag == 999)
    {
        [self.imageView setImage:[UIImage imageNamed:@"noFbAd.png"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
