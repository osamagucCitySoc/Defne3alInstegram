#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "AppManager.h"



@interface WebManager : NSObject
{
	NSMutableURLRequest	*theRequest;
	NSURLConnection		*theConnection;
	NSMutableString			*requestBody;
    NSString            *RequestParameters;
    NSString *accessToken;
}

@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, retain) NSString *accessToken;
@property(nonatomic, assign) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					errorCallback;

- (id)init;
+ (WebManager *)WebManagerSharedInstance;
-(void)FetchMediaObjectsWithTag:(NSString*)tag Delegate:(id)requestDelegate
                   WithSelector:(SEL)requestSelector
              WithErrorSelector:(SEL)requestErrorSelector;
-(void)LikeMediaObjectWithID:(NSString*)ID Delegate:(id)requestDelegate
                WithSelector:(SEL)requestSelector
           WithErrorSelector:(SEL)requestErrorSelector;
-(void)FollowUserWithID:(NSString*)ID Delegate:(id)requestDelegate
           WithSelector:(SEL)requestSelector
      WithErrorSelector:(SEL)requestErrorSelector;
-(void)FetchUserObjectsWithUserID:(NSString*)ID Delegate:(id)requestDelegate
                     WithSelector:(SEL)requestSelector
                WithErrorSelector:(SEL)requestErrorSelector;
-(void)ValidateTagWithTagName:(NSString*)name Delegate:(id)requestDelegate
                 WithSelector:(SEL)requestSelector
            WithErrorSelector:(SEL)requestErrorSelector;
-(void)SignUpUserWithDelegate:(id)requestDelegate
                 WithSelector:(SEL)requestSelector
            WithErrorSelector:(SEL)requestErrorSelector;
-(void)LogInUserWithDelegate:(id)requestDelegate
                WithSelector:(SEL)requestSelector
           WithErrorSelector:(SEL)requestErrorSelector;
-(void)GetCategoriesWithDelegate:(id)requestDelegate
                    WithSelector:(SEL)requestSelector
               WithErrorSelector:(SEL)requestErrorSelector;
-(void)UserTimeStampWithDelegate:(id)requestDelegate
                    WithSelector:(SEL)requestSelector
               WithErrorSelector:(SEL)requestErrorSelector;
-(void)UpdateTagsWithDelegate:(id)requestDelegate
                 WithSelector:(SEL)requestSelector
            WithErrorSelector:(SEL)requestErrorSelector;
-(void)LogoutUserWithDelegate:(id)requestDelegate
                 WithSelector:(SEL)requestSelector
            WithErrorSelector:(SEL)requestErrorSelector;
-(void)FetchMediaObjectsWithMediaId:(NSString*)mediaId Delegate:(id)requestDelegate
                       WithSelector:(SEL)requestSelector
                  WithErrorSelector:(SEL)requestErrorSelector;
-(void)FetchMediaObjectsWithUSerId:(NSString*)USerId Delegate:(id)requestDelegate
                      WithSelector:(SEL)requestSelector
                 WithErrorSelector:(SEL)requestErrorSelector;



-(void)FetchSelfFollowerObjectsWithDelegate:(id)requestDelegate
                               WithSelector:(SEL)requestSelector
                          WithErrorSelector:(SEL)requestErrorSelector;
-(void)GetRelationWithUserWithID:(NSString*)ID Delegate:(id)requestDelegate
                    WithSelector:(SEL)requestSelector
               WithErrorSelector:(SEL)requestErrorSelector;

@end


