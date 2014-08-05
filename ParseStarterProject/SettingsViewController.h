//
//  SettingsViewController.h
//  InstaLikePlus
//
//  Created by Kanwal on 27/06/2014.
//
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

- (IBAction)followTabClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
