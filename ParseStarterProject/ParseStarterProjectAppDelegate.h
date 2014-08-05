@class ParseStarterProjectViewController;


#define REVMOB_ID @"53ca553deee830d806f5da9b"
#define ChartBoost_APPID @"53ca57cc89b0bb41583af870"
#define ChartBoost_Secret @"703f9dc7647925bbc3553213bbaa92183ef97e1c"
#define iTunesAppID @"900905385"
#define PARSE_APP_ID @"5PurCXIwYMLyYNs2gzKLr2TAg3GNwMrNCCtfStSs"
#define PARSE_CLIENT_ID @"a0uhlf12Qg3ohMEeK4PXf5oLvpzefp02LS3XGPXZ"
@interface ParseStarterProjectAppDelegate : NSObject <UIApplicationDelegate> {
}
@property (nonatomic, strong) IBOutlet UITabBarController *tabbar;
@property (nonatomic, strong) IBOutlet UINavigationController *nav;
@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet ParseStarterProjectViewController *viewController;

@end
