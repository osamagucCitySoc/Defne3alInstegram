#import <Parse/Parse.h>
#import "ParseStarterProjectAppDelegate.h"
#import "ParseStarterProjectViewController.h"
#import "FollowViewController.h"
#import "LikeViewController.h"
#import "SettingsViewController.h"
#import "Appirater.h"

@implementation ParseStarterProjectAppDelegate


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[RevMobAds startSessionWithAppID:REVMOB_ID];
    [Appirater setAppId:iTunesAppID];
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:5];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:NO];
    [Appirater userDidSignificantEvent:YES];
    
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Login)
                                                 name:@"login"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Logout)
                                                 name:@"logout"
                                               object:nil];
    
    
    // ****************************************************************************
    // Uncomment and fill in with your Parse credentials:
    // [Parse setApplicationId:@"your_application_id" clientKey:@"your_client_key"];
    //
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
    // [PFFacebookUtils initializeFacebook];
    // ****************************************************************************

    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    [Parse setApplicationId:PARSE_APP_ID
                  clientKey:PARSE_CLIENT_ID];
    FollowViewController *follow=[[FollowViewController alloc] initWithNibName:@"FollowViewController" bundle:nil];
    LikeViewController *like=[[LikeViewController alloc] initWithNibName:@"LikeViewController" bundle:nil];
    SettingsViewController *settings=[[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:settings];
    UINavigationController *navigation1=[[UINavigationController alloc] initWithRootViewController:follow];
     UINavigationController *navigation2=[[UINavigationController alloc] initWithRootViewController:like];
    // Override point for customization after application launch.
    //like.title=@"ss";
    like.title=@"";
    follow.title=@"";
    settings.title=@"";
    _tabbar=[[UITabBarController alloc] init];
    
    _tabbar.viewControllers=[NSArray arrayWithObjects:navigation1,navigation2,navigation,nil];
        
    _nav=[[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    [[self.viewController busyIndicator]setAlpha:1.0];
    [[self.viewController loginBtn]setAlpha:0.0];
    self.window.rootViewController = _nav;
    [self.window makeKeyAndVisible];

    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced
        // in iOS 7). In that case, we skip tracking here to avoid double
        // counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
                                                    UIRemoteNotificationTypeAlert|
                                                    UIRemoteNotificationTypeSound];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    return YES;
}


-(void)Login{

    [[AppManager AppManagerSharedInstance] Hide_Waiting_Alert];
    //[[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"Instagram Login" message:@"You are successfully logged in"];
    self.window.rootViewController = _tabbar;
    [self.window makeKeyAndVisible];
    _tabbar.selectedIndex=0;
}
-(void)Logout{

    self.window.rootViewController = _nav;
    [_nav popToRootViewControllerAnimated:NO];
    [self.window makeKeyAndVisible];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}
/*
 
///////////////////////////////////////////////////////////
// Uncomment this method if you are using Facebook
///////////////////////////////////////////////////////////
 
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
} 
 
*/

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];

    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
     application.applicationIconBadgeNumber = 0;
    
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"removeads"]){
        //Chartboost *cb = [Chartboost sharedChartboost];
        //cb.appId = ChartBoost_APPID;
        //cb.appSignature = ChartBoost_Secret;
        
        // Required for use of delegate methods.
        //cb.delegate = self;
        
        // Begin a user session. Must not be dependent on user actions or any prior network requests.
        // Must be called every time your app becomes active.
        //[cb startSession];
       // [cb showInterstitial];
        //[[RevMobAds session] showFullscreen];
    }
    //[[RevMobAds session] showBanner];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (BOOL)shouldRequestInterstitial:(NSString *)location
{
    return YES;
}
- (BOOL)shouldDisplayInterstitial:(NSString *)location
{
    return YES;
}
#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
    }
}





@end
