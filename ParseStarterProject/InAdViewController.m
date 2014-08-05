//
//  InAdViewController.m
//  InstaLikePlus
//
//  Created by OsamaMac on 8/4/14.
//
//

#import "InAdViewController.h"

@interface InAdViewController ()

@end

@implementation InAdViewController

@synthesize adDict;

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
    NSURL* url = [[NSURL alloc] initWithString:[adDict objectForKey:@"pic"]];
	[self.asyncImageView loadImageFromURL:url];
    [self.view bringSubviewToFront:self.backButton];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highlightLetter:)];
    [self.asyncImageView addGestureRecognizer:tapRecognizer];

}


-(void)highlightLetter:(UITapGestureRecognizer*)sender
{
    if([adDict objectForKey:@"link"] && [[adDict objectForKey:@"link"] length]>0)
    {
        NSURL *url = [NSURL URLWithString:[adDict objectForKey:@"link"]];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissMeClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
