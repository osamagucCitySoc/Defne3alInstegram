@interface ParseStarterProjectViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    NSURLConnection* getAdsConnection;
    NSURLConnection* getInstagramSourceConnection;
    NSURLConnection* getAccountsLimitConnection;
    IBOutlet UIImageView *bg;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busyIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end
