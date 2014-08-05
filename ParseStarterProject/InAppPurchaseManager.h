#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "Reachability.h"

#define Coins_500   @"arabdevs.defneadefak.instagram.1"
#define Coins_1000  @"arabdevs.defneadefak.instagram.2"
#define Coins_3000  @"arabdevs.defneadefak.instagram.3"
#define Coins_8000  @"arabdevs.defneadefak.instagram.4"
#define Coins_25000 @"arabdevs.defneadefak.instagram.5"
#define remove_ads  @"arabdevs.defneadefak.instagram.6"
#define no_follow_back  @"arabdevs.defneadefak.instagram.7"


@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
	NSSet               *_ProductIdentifiers;
	NSMutableArray      *_Products;
	SKProductsRequest   *_Request;
    
    SKProduct           *_Product ;
    NSString            *_ProductNumber;
    id                   _Delegate;
    SEL                  _Selector;
    SEL                  _ErrorSelector;
    NSMutableArray      *PurchasedProductsList;
}

@property(strong,nonatomic) NSSet               *ProductIdentifiers;
@property(strong,nonatomic) NSMutableArray      *Products;
@property(strong,nonatomic) SKProduct           *Product ;
@property(strong,nonatomic) SKProductsRequest   *Request;
@property(strong,nonatomic) NSString            *ProductNumber;
@property(nonatomic, retain) id                 Delegate;
@property(nonatomic) SEL                        Selector;
@property(nonatomic) SEL                        ErrorSelector;

- (id)init;
+ (InAppPurchaseManager *)InAppPurchaseManagerSharedInstance;


- (void)PurchaseProductWithNumber:(int )Number
        Delegate:(id)del 
        WithSelector:(SEL)callBack
        WithErrorSelector:(SEL)errorCallBack;

- (void)Start_Purchasing;
- (BOOL)Is_Need_To_Purchase_Product;
- (BOOL)Is_Product_Already_Purchased;
- (void)Unlock_Functionality_For:(NSString *)ProductIdentifier;
- (void)Transaction_Completed:(SKPaymentTransaction *)Transaction;
- (void)Transaction_Restored:(SKPaymentTransaction *)Transaction;
- (void)Transaction_Failed:(SKPaymentTransaction *)Transaction;

- (BOOL)Is_Network_Reachable;
- (void)Return_Back_Successfully;
- (void)Return_Back_Error;
- (void)Restore_ProductsWithDelegate:(id)del
                        WithSelector:(SEL)callBack
                   WithErrorSelector:(SEL)errorCallBack;
@end
