//
//  CoesterJSONParser.m
//  CoesterApp
//
//  Created by Syed Imran on 15/07/2013.
//  Copyright (c) 2013 l3-nexgen. All rights reserved.
//

#import "JSONParser.h"
#import "DataHolder.h"
#import "AppManager.h"
#import "MediaObject.h"
#import "UserProfile.h"



@implementation JSONParser

@synthesize delegate;
@synthesize callback;
@synthesize errorCallback;

static JSONParser *JSONParserSharedInstance;

- (id) init
{
	if (self = [super init])
	{
		
        //UID= [[UIDevice currentDevice] uniqueIdentifier];
	}
	return self;
}
+ (JSONParser *) JSONParserSharedInstance
{
	@synchronized ([JSONParser class])
	{
		if (!JSONParserSharedInstance )
		{
			JSONParserSharedInstance = [[JSONParser alloc] init];
            
		}
		return JSONParserSharedInstance;
	}
	return nil;
}
-(BOOL)ParseMediaObjects:(NSData*)data{
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    NSLog(@"Dic:%@",results);
    NSArray *dataArray=[results objectForKey:@"data"];
    NSDictionary *pagination=[results objectForKey:@"pagination"];
    [DataHolder DataHolderSharedInstance].NextMaxId=[pagination objectForKey:@"next_max_id"];
    if ([DataHolder DataHolderSharedInstance].NextMaxId.length<5) {
        [DataHolder DataHolderSharedInstance].NextMaxId=@"";
    }
    if (dataArray.count!=0) {
        for (NSDictionary *Dic in dataArray) {
            MediaObject *Obj=[[MediaObject alloc] initWithDic:Dic];
            [[DataHolder DataHolderSharedInstance].MediaObjectsArray addObject:Obj];
        }
        return YES;
    }
    return NO;
    
    
    
    
}

-(BOOL)ParseUsersObjects:(NSData*)data{
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    NSLog(@"Dic:%@",results);
    NSArray *dataArray=[results objectForKey:@"data"];
    NSDictionary *pagination=[results objectForKey:@"pagination"];
    [DataHolder DataHolderSharedInstance].NextMaxId=[pagination objectForKey:@"next_cursor"];
    if ([DataHolder DataHolderSharedInstance].NextMaxId.length<5) {
        [DataHolder DataHolderSharedInstance].NextMaxId=@"";
    }
    if (dataArray.count!=0) {
        for (NSDictionary *Dic in dataArray) {
            NSString *userId=[Dic objectForKey:@"id"];
            [[DataHolder DataHolderSharedInstance].follows addObject:userId];
        }
        return YES;
    }
    return NO;
    
    
    
    
}
-(MediaObject*)ParseMediaObject:(NSData*)data{
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    NSLog(@"Dic:%@",results);
    NSDictionary *dic=[results objectForKey:@"data"];
    MediaObject *Obj=[[MediaObject alloc] initWithDic:dic];
    return Obj;
    
    
    
}

-(BOOL)ParseRelationObject:(NSData*)data{
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    
    if (![[results objectForKey:@"data"] isKindOfClass:[NSNull class]]){
        NSString *Dic=[[results objectForKey:@"data"] objectForKey:@"outgoing_status"];
        NSLog(@"lolololo:::%@",Dic);
        if ([Dic isEqualToString:@"none"]) {
            return YES;
        }
        else
            return NO;
    }
    else{
        
        return NO;
    }
    
    
}

-(BOOL)ParseFollowResponseObject:(NSData*)data{
   
    NSNumber* noFbEnd = [DataHolder DataHolderSharedInstance].UserObject[@"noFollowBackEnd"];
    
    NSNumber* current = [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]];
    
    NSLog(@"%ld",([noFbEnd longValue]-[current longValue]));
          
    if([noFbEnd longLongValue]>[current longLongValue])
    {
        return YES;
    }
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    
    if (![[results objectForKey:@"meta"] isKindOfClass:[NSNull class]]){
        NSString *Dic=[NSString stringWithFormat:@"%@",[[results objectForKey:@"meta"] objectForKey:@"code"]];
        NSLog(@"lolololo:::%@",Dic);
        if ([Dic isEqualToString:@"200"]) {
            return YES;
        }
        else
            return NO;
    }
    else{
        
        return NO;
    }
    
    
}
-(UserProfile*)ParseUserProfileObjects:(NSData*)data{
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    
    if ([[[results objectForKey:@"meta"] objectForKey:@"code"] integerValue]==400) {
        UserProfile *Obj=[[UserProfile alloc] initPrivate];
        return Obj;
    }
    
    
    if (![[results objectForKey:@"data"] isKindOfClass:[NSNull class]]){
        NSDictionary *Dic=[results objectForKey:@"data"];
        UserProfile *Obj=[[UserProfile alloc] initWithDic:Dic];
        return Obj;
    }
    else{
    
        return nil;
    }
    
    
}
-(void)ParseUpdateUserProfileObjects:(NSData*)data{
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    
    if (![[results objectForKey:@"data"] isKindOfClass:[NSNull class]]){
        NSDictionary *dic=[[results objectForKey:@"data"] objectForKey:@"counts"];
        [DataHolder DataHolderSharedInstance].UserProfile.media=[NSString stringWithFormat:@"%@",[dic objectForKey:@"media"]];
        if (![[dic  objectForKey:@"followed_by"] isKindOfClass:[NSNull class]])
            [DataHolder DataHolderSharedInstance].UserProfile.followed_by=[NSString stringWithFormat:@"%@",[dic objectForKey:@"followed_by"]];
        if (![[dic  objectForKey:@"follows"] isKindOfClass:[NSNull class]])
            [DataHolder DataHolderSharedInstance].UserProfile.follows=[NSString stringWithFormat:@"%@",[dic objectForKey:@"follows"]];
    }
    else{
        
        return;
    }
    
    
}
-(UserProfile*)ParseUserLoginObject:(NSData*)data{
    
    NSString *a = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@" rentData: %@", a);
    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data //1
                                                            options:kNilOptions
                                                              error:nil];
    
    if (results!=Nil){
        UserProfile *Obj=[[UserProfile alloc] initWithLoginDic:results];
        return Obj;
    }
    else{
        
        return nil;
    }
    
    
}
@end
