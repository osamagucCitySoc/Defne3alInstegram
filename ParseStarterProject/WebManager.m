
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#import "WebManager.h"
#import "DataHolder.h"
@implementation WebManager

@synthesize receivedData;
@synthesize delegate;
@synthesize callback;
@synthesize errorCallback,accessToken;

 WebManager *WebManagerSharedInstance;

- (id) init
{
	if (self = [super init])
	{
		receivedData	= nil;
		delegate		= nil;
		callback		= nil;
		errorCallback	= nil;
        //UID= [[UIDevice currentDevice] uniqueIdentifier];
	}
	return self;
}
+ (WebManager *) WebManagerSharedInstance
{
	@synchronized ([WebManager class])
	{
		//if (!WebManagerSharedInstance)
		//{
			WebManagerSharedInstance = [[WebManager alloc] init];
            
		//}
		return WebManagerSharedInstance;
	}
	return nil;
}

-(void)FetchUserObjectsWithUserID:(NSString*)ID Delegate:(id)requestDelegate
                   WithSelector:(SEL)requestSelector
              WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    // requestBody=[NSMutableString stringWithFormat:@""];
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@?access_token=%@",ID, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    [self Check_Network_Status_And_Move_On];
    
}

-(void)FetchMediaObjectsWithTag:(NSString*)tag Delegate:(id)requestDelegate
                     WithSelector:(SEL)requestSelector
                WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
   // requestBody=[NSMutableString stringWithFormat:@""];
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=%@",tag, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    [self Check_Network_Status_And_Move_On];
    
}

-(void)FetchMediaObjectsWithUSerId:(NSString*)USerId Delegate:(id)requestDelegate
                   WithSelector:(SEL)requestSelector
              WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    // requestBody=[NSMutableString stringWithFormat:@""];
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent?max_id=%@&access_token=%@",USerId,[DataHolder DataHolderSharedInstance].NextMaxId, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    [self Check_Network_Status_And_Move_On];
    
}
-(void)FetchSelfFollowerObjectsWithDelegate:(id)requestDelegate
                      WithSelector:(SEL)requestSelector
                 WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    // requestBody=[NSMutableString stringWithFormat:@""];
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/follows?cursor=%@&access_token=%@",[DataHolder DataHolderSharedInstance].NextMaxId, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    [self Check_Network_Status_And_Move_On];
    
}


-(void)FetchMediaObjectsWithMediaId:(NSString*)mediaId Delegate:(id)requestDelegate
WithSelector:(SEL)requestSelector
WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    // requestBody=[NSMutableString stringWithFormat:@""];
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/media/%@?access_token=%@",mediaId, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    [self Check_Network_Status_And_Move_On];
    
}



-(void)LikeMediaObjectWithID:(NSString*)ID Delegate:(id)requestDelegate
                   WithSelector:(SEL)requestSelector
              WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@",ID, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    [theRequest setHTTPMethod:@"POST"];
    [self Check_Network_Status_And_Move_On];
    
}
-(void)GetRelationWithUserWithID:(NSString*)ID Delegate:(id)requestDelegate
           WithSelector:(SEL)requestSelector
      WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/relationship?access_token=%@",ID, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    //NSString *Param=@"action=follow";
   // [theRequest setHTTPBody:[Param dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setHTTPMethod:@"GET"];
    [self Check_Network_Status_And_Move_On];
    
}

-(void)FollowUserWithID:(NSString*)ID Delegate:(id)requestDelegate
                WithSelector:(SEL)requestSelector
           WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    
    NSNumber* noFbEnd = [DataHolder DataHolderSharedInstance].UserObject[@"noFollowBackEnd"];
    
    NSNumber* current = [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]];
    
    NSLog(@"%ld",([noFbEnd longValue]-[current longValue]));
    
    if([noFbEnd longLongValue]>[current longLongValue])
    {
        if([delegate respondsToSelector:callback])
        {
            [delegate performSelector:callback withObject:[[NSData alloc] init]];
        }
        return;
    }else
    {
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/relationship?access_token=%@",ID, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    NSString *Param=@"action=follow";
    
    [theRequest setHTTPBody:[Param dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setHTTPMethod:@"POST"];
    [self Check_Network_Status_And_Move_On];
    }
    
}
-(void)ValidateTagWithTagName:(NSString*)name Delegate:(id)requestDelegate
           WithSelector:(SEL)requestSelector
      WithErrorSelector:(SEL)requestErrorSelector{
    delegate    = requestDelegate;
	callback    = requestSelector;
	errorCallback=requestErrorSelector;
    
    NSString *urlString=[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@?access_token=%@",name, [DataHolder DataHolderSharedInstance].AccessToken];
    NSLog(@"Request: %@", urlString);
    NSURL* url = [NSURL URLWithString:urlString];
   	theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];
    [theRequest setHTTPMethod:@"GET"];
    [self Check_Network_Status_And_Move_On];
    
}
- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void) connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        return;
    }
}

-(void)Check_Network_Status_And_Move_On
{
    if ([self Is_Network_Reachable] == YES)
    {
        [self CreateConnectionAndStartDownloading];
    }
    else
    {
        [[AppManager AppManagerSharedInstance] Hide_Network_Indicator];
        [[AppManager AppManagerSharedInstance] Hide_Waiting_Alert];
        
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"No Connection" message:@"The internet connection appears to be offline.\n or slow connectivity signals." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        Alert.tag = 0;
        [Alert show];
        if(errorCallback)
            [delegate performSelector:errorCallback withObject:nil];
    }
}
-(void)CreateConnectionAndStartDownloading;
{
    // NSLog(@"%@",requestBody);
   
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (requestBody) {
        requestBody=nil;
    }
    if (theConnection)
		receivedData = [NSMutableData data];
	else
		NSLog(@"Connection Failed");
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
   // NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedData setLength:0];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(delegate && callback){
		if([delegate respondsToSelector:callback])
        {
			[delegate performSelector:callback withObject:receivedData];
		}
        else
        {
			NSLog(@"No response from delegate");
            if(errorCallback)
                [delegate performSelector:errorCallback withObject:nil];
        }
    }
}
- (void)connection:(NSURLConnection *)connection  didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
	
	receivedData=nil;
	theConnection=nil;
	if(errorCallback)
		[delegate performSelector:errorCallback withObject:error];
}
-(BOOL)Is_Network_Reachable
{
	Reachability * reach1 = [Reachability reachabilityForInternetConnection];
	Reachability * reach2 = [Reachability reachabilityForLocalWiFi];
	NetworkStatus netstatus1 = [reach1 currentReachabilityStatus];
	NetworkStatus netstatus2 = [reach2 currentReachabilityStatus];
	if((netstatus1 == NotReachable) && (netstatus2 == NotReachable))
		return NO;
	return YES;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1111) // NETWORK SLOW -> PENDING SOAP REQUEST : LOGIN
    {
        if (buttonIndex == 0)
        {
            [[AppManager AppManagerSharedInstance] Show_Network_Indicator];
            [[AppManager AppManagerSharedInstance] Show_Waiting_Alert];
            [self Check_Network_Status_And_Move_On];
        }
    }
}
-(void)Reset
{
	delegate    = nil;
	callback    = nil;
	errorCallback = nil;
}
-(void) dealloc
{
	
	receivedData=nil;
	theConnection=nil;
}



@end

//
//["479713355","205140116","19864247","17823099","797398595","30559640","938768310","1090074173","178579011","856305878","1166826037","1319431480","435658198","905133140","671829156","226077737","7528839","1351594540","1050388887","502931975","450310841","1085785667","282114026","226302288","429707654","562947399","1351677086","45919496","1351692305","1351638684","308684488","1234887148","309211585","317689476","192736408","205969209","6040998","649618827","488326701","516818263","1189243212","32574498","1003750263","1184726255","1057075972","1331784270","1229104845","308989379","353171033","352538909","1336388419","1336966339","693098540","325786147","1340271315","19725040","35090940","438399449","1267720346","188946468","443983612","1339387326","293733889","231519139","1124686074","1281260337","485419228","999010531","1326100525","1281521567","562500146","262705614","311389174","1283521569","178096800","1017195127","680795666","14658726","25609377","1068965465","1063241688","1116717019","1004059155","8823625","477442109","289128694","397580603","25882189","626014616","435474375","609415321","472964222","16577288","296337254","939518961","1316103532","1327569237","37142520","536490414","146042760","1317262507","263552068","1264269325","1162075575","438226701","862973983","468212722","636761705","55617740","402023260","242336239","318666835","336333638","442766367","559570889","309995620","514668468","244763914","344125061","1292995928","325420178","758549547","405443137","397992817","269495928","258927487","453544066","455589237","1315864711","287593060","541454736","274116006","48178048","1325871783","243256489","1144364016","875043924","1326399331","1301657660","548297918","409480153","606967165","1324787384","191419361","4880083","281604500","493749357","264479183","1307405929","146084963","899583490","1253563406","32624811","246422557","636391564","355189021","1075740334","1130354601","215592592","370151064","389660492","945016254","286599571","305797217","222566136","593605499","441289270","36995277","453860198","1298424357","1005421956","317555516","1261034919","1191040873","696295845","20292840","347642947","1313465779","305560412","298643660","192604343","1259695532","1265814806","1324370400","45714926","198399124","826987954","193123413","1297664857","290722639","23968623","696330664","640085513","41382786","180717174","328116988","293111444","266251871","1211021705","392234953","605408898","32922237","985601137","800813249","656203681","868596416","1326084000","1139570375","1041661585","314829761","582106021","37348144","289652139","217954985","458311175","1299314510","352046850","1211124211","296458667","973447750","506714321","363528989","188341698","20263260","389499393","13559968","528635753","369528905","1292162739","1292196864","1292994985","264895074","1292993656","246406389","254271285","184686815","517952227","1194066391","1100056440","803068296","1067424380","183716064","247822393","808269193","12088064","55496210","22686004","13036911","410792262","508940810","525622875","231324946","494265557","271267003","416899463","47658353","1151975939","10741382","308106818","318217147","483421287","445832427","27134976","241115885","530330766","1029639636","178645293","1161735274","1201433000","195171830","1032967403","54016961","10295074","340013175","290687640","1121959942","268284143","48259368","21387310","696505299","231054988","274127651","1193601994","252623553","1098485810","523474109","495392837","1209717580","1025273700","1049980284","224609214","262363335","308366216","427278405","485030794","578216512","7764107","707848068","350460173","225371440","326177012","503945323","23632020","1767841","18724070","12847332","241998717","272751564","293586426","27977055","48886258","202226739","491506253","393322233","20846813","276925560","273405807","16103128","1180089492","51480379","1190911127","242232426","265270675","210744550","37487623","215314395","850670968","178674471","200937971","276452948","315544906","1172582052","501584107","5134315","203139011","910588894","43227845","604717946","1139355826","42011455","286007386","21946882","508580407","28011380","47340181","21581068","25887429","944344580","289797034","16360800","12491745","30082738","770891662","1118499096","1118641121","1100952704","2021102","9730520","204623787","617911156","250095611","348588748","1137379527","6860189","184692323","14971455","37881271","28202407","318394742","862228749","715196094","300538887","482951715","569778168","280947117","490166853","186877879","492883252","351498008","286728291","442532891","230438304","861039188","301560772","320526802","38189880","233025898","26670887","499558864","214593733","1068819574","450032668","47948672","366765875","217385151","1077770613","556898091","282321946","192088949","329301555","939886491","428784745","928962821","282342805","778668410","990679017","707510651","702062782","223746079","421393908","195208374","627133742","1020649976","1028303555","402456351","396346301","419841332","383961428","399557948","243957957","493366672","568011294","467011789","483184796","217332615","240509437","274156804","978755455","971250056","984703270","203065321","579540073","272105837","29835662","936277045","331097502","907462907","943522904","231697830","1106396186","50805275","231398775","627518480","854781808","560563461","11611896","1106249015","268857194","331900766","236339819","26386512","356865302","244523397","228371467","1106133634","578026833","1101848222","951823007","43598130","522619239","685472965","1016877604","175002599","660828405","491473196","337944374","218609928","415963890","48750157","19331409","3244161","297140984","386144267","325652038","517535396","971312918","236480472","646046184","292677853","571363602","563967108","476709725","331881189","335383740","1025532151","380976223","595861951","35088219","717855726","183624757","264694572","268369963","457383705","461899329","21128480","299794916","233781352","307187456","1071769631","194856496","510239637","896288186","28361461","1004273363","294775350","225168025","239945600","185480850","330732597","431387351","971630527","365268039","345719859","492008898","759834514","893628808","324032025","1054667362","374477788","796175306","527136367","194760632","421465223","478103046","1021170436","403998206","311822936","583884026","38341301","979804942","185071598","758711088","40614384","229708395","757317366","262236047","312081184","794140964","352186560","583719954","53641811","870593663","1010463866","773573125","50404428","607248989","923400052","1006288909","194782733","6435049","1010534311","553723722","802590497","585743437","711945533","412267497","1016970425","308343066","194091544","205953583","575115211","190089130","907760083","282542875","311957021","6523481","20871417","16338759","53855793","330189124","143848051","9234734","264241955","353451892","15299888","241388381","15245628","228843047","308189514","363429777","717482373","212339152","10208189","1032472682","255988121","442512648","682074","282784990","144864376","48170790","220087625","185483013","651812","613476924","5331959","299818310","646298608","513606441","1003060473","234551514","7319889","1039644519","298519470","272480436","23254785","1027937951","273553057","299664666","12693164","201553518","370889214","2697366","318145135","28017098","249714554","1032336502","211597253","269824468","719172777","20972","961909159","284390124","1038900775","9632656","217843359","233500634","537727699","15051089","273218738","197089576","275657363","1026540567","626338281","357940365","335430974","381266457","351381544","659222828","1021944892","328820840","327409590","419572561","289573222","3869625","6941446","34357188","52056952","529162407","26106961","271708289","45579046","34887364","222724093","178906122","32688077","1002301475","3256514","298667413","43610254","247185751","472803407","240219013","244206190","17647614","204136036","292436866","31017776","815330082","311241962","5392107","40365009","191089175","215450711","228304543","1036147693","226519568","144638527","851050252","623383415","286222317","967887583","22583325","617366798","1035482133","196900129","52419957","45263743","306018328","189009960","214460116","969257911","218015948","794917343","235065137","348256828","276089017","1013290662","459846710","230974668","212648302","316765918","803047214","8945581","312404982","224682266","494292201","469033560","26900639","10640373","653591031","1028228344","1678037","338571277","843693288","274781193","240227886","230918665","995466041","469065197","14077962","265033923","276494468","213421198","24217390","204937034","288391528","393271534","404425776","29540484","225130577","335294650","183198154","1016258277","255582169","145707678","394059352","399459506","280145757","335547151","308059706","16882197","288543125","6134629","8951330","656966315","51786142","243782920","6367167","279912511","306648227","584174922","11110389","676203908","291744059","30684972","400995798","339972173","18209078","393985869","287265400","243047326","200486607","410314508","196546645","11262520","21284255","204202030","297456397","933791322","38981342","246886975","887003840","834277712","370423476","21879708","287041953","410392664","36623690","298356714","569308373","15803345","291861418","290526615","713791457","575841958","38281190","994629533","194492348","708998212","289563431","247492712","651055082","55245570","30568015","291733486","9439526","53019910","389418361","350419489","187682728","946512665","1000016166","207372869","989513315","217320642","279122911","448957724","190697584","947295518","36088456","963885825","314636480","181637772","643227155","988036324","990364670","33956285","871179074","640688939","250198546","211433031","223327978","235783352","25916181","260732811","861795701","738699510","23080100","232961760","321862691","181387503","985141721","447631947","43708586","281095886","24408958","417150227","268501245","555620947","211289244","177209533","617376288","330318952","602976946","699473355","50778912","712990199","559014508","263522606","52810309","1004621026","22946447","844783680","651824981","37416722","184382516","265928388","996461130","26568983","732389983","999065659","204647979","611603356","289092988","648289597","345472186","213571807","432999031","846223275","26578770","1006074581","261755207","36162127","298749693","679629430","26578690","10396405","303289174","567136101","519616228","313345837","44778166","189708635","187267997","314748000","274697301","641113202","645221","716241410","189479681","211236524","305716450","419732863","20852439","233957167","294455196","6009704","630702975","19815084","683514313","213015671","233531014","766593525","214553774","206167347","341782562","431210838","31320279","36992393","483655071","52518827","22845425","302259123","861126553","294294699","6134041","622526313","187937643","393395495","34179734","246369986","3809440","205779540","222866745","41344051","239252165","16232945","335600856","39068987","51626131","421863426","1803292","228713199","367797596","391918123","38998340","8279438","398134822","230026013","654874538","240478709","1007346336","9669392","647822386","586592344","20434168","45354078","931640561","202120342","177173163","24630650","8096682","227038906","586128383","464045997","217856811","1007767042","291073078","24806852","4991926","14438870","568288920","989177641","190850204","272714981","34133264","273561067","298817422","360162722","179273135","307340090","258630294","439835967","5440865","221617926","555161833","26878568","401289747","352567859","301352658","24772113","992983470","34159194","207126760","194705536","9969239","176573397","545069617","418524635","417862183","50569932","275281266","286934737","240582875","354210075","269303009","430188394","3652793","189841641","943304834","444166761","199966455","36123142","182724998","51731206","339595883","859975067","326790068","43483483","818045820","41800480","22367750","314829517","493184748","1007546903","708718791","702085992","419294592","984326168","677252473","307516030","239031099","48152902","39080800","653190543","277587938","528830661","41637932","546198390","330629083","262942516","191223861","235400219","261084520","31159744","421262691","536777420","206772934","185451564","32808457","303328056","29881425","185834289","21226894","186382808","11047601","21191652","28185383","30719764","7560206","210705533","42638346","220645273","177550917","17928197","569720700","514132966","44205518","10435849","313354888","321766259","4894200","219799828","145362033","316401821","15556030","425854658","222040366","7189602","22866746","193061464","446419026","317951772","694033279","309354583","577889198","3400013","371018698","717483177","40959715","248431519","43710028","557342243","173805212","14819178","587328419","222907599","306606614","51972489","198787059","620422327","44419804","32709450","264397144","356249412","35182512","307081736","22339710","18897598","460854465","774641071","446998588","42924402","233070689","295769346","263985093","981847052","231243547","1006882016","312500609","13898829","293690365","240752594","42433273","694843504","390982884","663874032","994919798","327667890","184380254","342404740","442200062","514576484","21871489","45828006","325625285","931369176","8947833","310412513","54781761","212684406","624036753","261080535","296503384","15981215","175944121","288236101","20959774","406601850","313003567","173958048","184540345","198699398","524884422","53936372","328694417","1007342086","10736542","28120480","178004368","996887664","821249691","208451015","269454295","493562998","399935067","227162381","238046443","967493441","214720291","1002178530","19748008","25512430","5882045","232251105","242619313","12115802","693851878","371361237","253106757","181724044","727848280","230943432","14835489","275120061","1689423","356290461","230072159","502674502","254788122","945808481","348042362","726493911","410698620","312281304","344350325","411539615","304724576","872194697","469423738","288660061","53804818","574052812","190452979","180909720","181360417","33776527","4399244","302339797","236705466","300336611","192187648","329624341","303165547","574778184","201661935","17504112","514160024","20275695","293502151","39306581","13858624","349","123395","25025320"]
