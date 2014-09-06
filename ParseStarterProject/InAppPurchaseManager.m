#import "InAppPurchaseManager.h"
#import "AppManager.h"
@implementation InAppPurchaseManager

@synthesize ProductIdentifiers  = _ProductIdentifiers;
@synthesize Products            = _Products;
@synthesize Product             = _Product;
@synthesize Request             = _Request;
@synthesize ProductNumber       = _ProductNumber;
@synthesize Delegate            = _Delegate;
@synthesize Selector            = _Selector;
@synthesize ErrorSelector       = _ErrorSelector;

static InAppPurchaseManager *InAppPurchaseManagerSharedInstance;

+ (id ) alloc
{
	@synchronized([InAppPurchaseManager class])
	{
		NSAssert(InAppPurchaseManagerSharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		InAppPurchaseManagerSharedInstance = [super alloc];
		return InAppPurchaseManagerSharedInstance;
	}
	return nil;
}
+ (InAppPurchaseManager *) InAppPurchaseManagerSharedInstance
{
	@synchronized ([InAppPurchaseManager class])
	{
		if (!InAppPurchaseManagerSharedInstance)
		{
			InAppPurchaseManagerSharedInstance = [[InAppPurchaseManager alloc] init];
		}
		return InAppPurchaseManagerSharedInstance;
	}
	return nil;
}

- (id)init
{
    if ((self = [super init])) 
    {
        self.Products       = nil;
        self.Product        = nil;
        self.Request        = nil;
        self.ProductNumber  = nil;
        self.Delegate       = nil;
        self.Selector       = nil;
        self.ErrorSelector  = nil;
        PurchasedProductsList = [[NSMutableArray alloc] init];
        self.ProductIdentifiers = [NSSet setWithObjects:
                        Coins_500,
                        Coins_1000,
                        Coins_3000,
                        Coins_8000,
                        Coins_25000,
                        remove_ads,
                        no_follow_back,nil];
    }
    return self;
}
-(void)PurchaseProductWithNumber:(int )Number
        Delegate:(id)del 
        WithSelector:(SEL)callBack
        WithErrorSelector:(SEL)errorCallBack
{    
    self.Selector           = callBack;
    self.Delegate           = del;
    self.ErrorSelector      = errorCallBack;
    self.ProductNumber      = nil;
    self.Product            = nil;
    if (Number == 1)
    {
        self.ProductNumber = Coins_500;
    }
    else if (Number == 2)
    {
        self.ProductNumber = Coins_1000;
    }
    else if (Number == 3)
    {
        self.ProductNumber = Coins_3000;
    }
    else if (Number == 4)
    {
        self.ProductNumber = Coins_8000;
    }
    else if (Number == 5)
    {
        self.ProductNumber = Coins_25000;
    }
    else if(Number == 6)
    {
         self.ProductNumber = remove_ads;
    }
    else if(Number == 7)
    {
        self.ProductNumber = no_follow_back;
    }
    if ([self Is_Need_To_Purchase_Product] == YES)
    {
        if ([self Is_Network_Reachable] == YES)
        {
            if (self.Products == nil || [self.Products count] <= 0)
            {
                self.Request = [[SKProductsRequest alloc] initWithProductIdentifiers:self.ProductIdentifiers];
                self.Request.delegate = self;
                [self.Request start];
            }
            else 
            {
                [self Start_Purchasing];
            }
        }
        else
        {
            [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"خطأ" message:@"الرجاء التأكد من اتصال جهازك بالإنترنت"];
            [self Return_Back_Error];
        }
    }
    else
    {
        [self Return_Back_Successfully];
    }
}
-(BOOL)Is_Need_To_Purchase_Product
{
    BOOL Is_Consumeable = YES; // Check Here Selected Product Is Consumeable Or Not
    
    if (Is_Consumeable == YES) // Consumeable
    {
        return YES;
    }
    else // Non Consumeable
    {
        if ([self Is_Product_Already_Purchased] == NO)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}
-(BOOL)Is_Product_Already_Purchased
{
    // Check Is Product Already Purchased
    
    return NO;
    
   // [self Unlock_Functionality_For:@"NILL"];
    return YES;
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    self.Request.delegate = nil;
    self.Request = nil;

    if ([response.products count] <= 0)
    {
        [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"خطأ" message:@"تعذر الإتصال بالايتيونز"];
        [self Return_Back_Error];
    }
    else
    {
        self.Products = [[NSMutableArray alloc] initWithArray:response.products];
        [self Start_Purchasing];
    }
}
- (void) request:(SKRequest *) request didFailWithError:(NSError *) error
{    
    [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"خطأ" message:@"تعذر الإتصال بالايتيونز"];
    [self Return_Back_Error];
}
- (void)Start_Purchasing
{
    int Count = [self.Products count];
    if (self.ProductNumber!= nil)
    {
        for (int i = 0; i < Count; i++)
        {
            SKProduct *P = [self.Products objectAtIndex:i];
            if ([P.productIdentifier isEqualToString:self.ProductNumber])
            {
                self.Product = [self.Products objectAtIndex:i];
                SKPayment *Payment = [SKPayment paymentWithProduct:self.Product];
                [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                [[SKPaymentQueue defaultQueue] addPayment:Payment];
                return;
            }
        }
    }
    else
    {
        //[[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"Error !!!" message:@"Selected Product Is Not Available In Store, Try Later"];
        [[AppManager AppManagerSharedInstance] Show_Alert_With_Title:@"خطأ" message:@"الميزة التي تحاول شراءها غير متاحة في الوقت الحالي"];
    }
    [self Return_Back_Error];
}
- (void)Restore_ProductsWithDelegate:(id)del
                        WithSelector:(SEL)callBack
                       WithErrorSelector:(SEL)errorCallBack
{
    self.Selector           = callBack;
    self.Delegate           = del;
    self.ErrorSelector      = errorCallBack;

    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                {
                    [self Transaction_Completed:transaction];
                    break;
                }
            case SKPaymentTransactionStateRestored:
                {
                    [self Transaction_Restored:transaction];
                    break;
                }
            case SKPaymentTransactionStateFailed:
                {
                    [self Transaction_Failed:transaction];
                    break;
                }
            case SKPaymentTransactionStatePurchasing:
                {
                    break;
                }
            default:
                {
                    break;
                }
        }
    }
    [self Unlock_Functionality];
}
-(void)Unlock_Functionality
{
    if([PurchasedProductsList count] > 0)
    {
        while ([PurchasedProductsList count] > 0)
        {
            NSString *ProductIdentifier = [PurchasedProductsList objectAtIndex:0];
            [self Unlock_Functionality_For:ProductIdentifier];
            [PurchasedProductsList removeObjectAtIndex:0];
        }
        [self Return_Back_Successfully];
    }
    else
    {
        [self Return_Back_Error];
    }
}
-(void)Unlock_Functionality_For:(NSString *)ProductIdentifier
{
    if([ProductIdentifier isEqualToString:Coins_500])
    {
        //[_Delegate performSelector:_Selector withObject:[NSNumber numberWithInt:1]];
    }
    else if([ProductIdentifier isEqualToString:Coins_1000])
    {
        //[_Delegate performSelector:_Selector withObject:[NSNumber numberWithInt:2]];
    }
    else if([ProductIdentifier isEqualToString:Coins_3000])
    {
    //    [_Delegate performSelector:_Selector withObject:[NSNumber numberWithInt:3]];
    }
    else if([ProductIdentifier isEqualToString:Coins_8000])
    {
      //  [_Delegate performSelector:_Selector withObject:[NSNumber numberWithInt:4]];
    }
    else if([ProductIdentifier isEqualToString:Coins_25000])
    {
        //[_Delegate performSelector:_Selector withObject:[NSNumber numberWithInt:5]];
    }
    else if([ProductIdentifier isEqualToString:remove_ads])
    {
        //[_Delegate performSelector:_Selector withObject:[NSNumber numberWithInt:6]];
    }
}
- (void)Transaction_Completed:(SKPaymentTransaction *)Transaction
{
    if([self verifyReceipt:Transaction])
    {
        NSString *ProductIdentifier = Transaction.payment.productIdentifier;
        [PurchasedProductsList addObject:ProductIdentifier];
        [[SKPaymentQueue defaultQueue] finishTransaction: Transaction];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"شكرا لك" message:@"تم الشراء بنجاح" delegate:nil cancelButtonTitle:@"تم" otherButtonTitles:nil];
        [alert show];

    }else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"لم يتم الشراء" message:@"إما إنك تخترقنا فأنصحك أن تنسى، أو هناك خطأ راسلنا" delegate:nil cancelButtonTitle:@"تم" otherButtonTitles:nil];
        [alert show];
        [[SKPaymentQueue defaultQueue] finishTransaction:Transaction];
    }
}
- (BOOL)verifyReceipt:(SKPaymentTransaction *)transaction {
    NSString* string = [[NSString alloc]initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",string);
    NSString *post = [NSString stringWithFormat:@"purchase=%@",string];
    
    //NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    //NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];

    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSURL *url = [NSURL URLWithString:@"http://osamalogician.com/validateMe2.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:postData];
    
    NSURLResponse* response;
    NSError* error = nil;
    
    //Capturing server response
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    return [[[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding]isEqual:@"OK"];
    /*NSString *jsonObjectString = [self encode:(uint8_t *)transaction.transactionReceipt.bytes length:transaction.transactionReceipt.length];
     NSLog(@"%@",jsonObjectString);
     NSString *completeString = [NSString stringWithFormat:@"http://osamalogician.com/validateMe2.php?receipt=%@", jsonObjectString];
     NSURL *urlForValidation = [NSURL URLWithString:completeString];
     NSMutableURLRequest *validationRequest = [[NSMutableURLRequest alloc] initWithURL:urlForValidation];
     [validationRequest setHTTPMethod:@"GET"];
     NSData *responseData = [NSURLConnection sendSynchronousRequest:validationRequest returningResponse:nil error:nil];
     NSString *responseString = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
     NSInteger response = [responseString integerValue];
     return (response == 0);*/
}

- (NSString *)encode:(const uint8_t *)input length:(NSInteger)length {
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (void)Transaction_Restored:(SKPaymentTransaction *)Transaction
{
 
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"شكرا لك" message:@" تم الإسترجاع. الأن لن ترى  بار الإعلانات في كل صفحات التطبيق." delegate:nil cancelButtonTitle:@"تم" otherButtonTitles:nil];
    [alert show];

    NSString *ProductIdentifier = Transaction.originalTransaction.payment.productIdentifier;
    [PurchasedProductsList addObject:ProductIdentifier];

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"removeads"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [[SKPaymentQueue defaultQueue] finishTransaction: Transaction];
}
- (void)Transaction_Failed:(SKPaymentTransaction *)Transaction 
{
    if (Transaction.error.code != SKErrorPaymentCancelled)
        NSLog(@"Transaction error: %@", Transaction.error.localizedDescription);
    [[SKPaymentQueue defaultQueue] finishTransaction: Transaction];
    [self Return_Back_Error];
}
-(BOOL)Is_Network_Reachable
{
    Reachability * reach1 = [Reachability reachabilityForInternetConnection];
    Reachability * reach2 = [Reachability reachabilityForLocalWiFi];
    NetworkStatus netstatus1 = [reach1 currentReachabilityStatus];
    NetworkStatus netstatus2 = [reach2 currentReachabilityStatus];
    if((netstatus1 == NotReachable) && (netstatus2 == NotReachable))
    {
//        [[[UIAlertView alloc] initWithTitle:@"Network Connectivity Problem" message:@"Please Check Your Internet Connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    return YES;
}
- (void)Return_Back_Successfully
{
	if(self.Delegate && self.Selector)
    {
        if([self.Delegate respondsToSelector:self.Selector])
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
			[self.Delegate performSelector:self.Selector withObject:self.ProductNumber];
            #pragma clang diagnostic pop
        }
        else
        {
            NSLog(@"No responce");
        }
    }
}
- (void)Return_Back_Error
{
    if(self.Delegate && self.ErrorSelector)
    {
        if([self.Delegate respondsToSelector:self.ErrorSelector])
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.Delegate performSelector:self.ErrorSelector withObject:nil];
            #pragma clang diagnostic pop
        }
        else
        {
            NSLog(@"No responce");
        }
    }
}
-(void)dealloc
{
    self.Delegate = nil;
    self.Selector   = nil;
    self.ErrorSelector = nil;
}

@end