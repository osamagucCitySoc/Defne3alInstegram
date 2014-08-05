//
//  LikeObjec.m
//  Instagram
//
//  Created by Syed Imran on 23/01/2014.
//  Copyright (c) 2014 l3-nexgen. All rights reserved.
//

#import "LikeObject.h"

@implementation LikeObject
@synthesize username,Id,profile_picture,full_name;

-(id)initWithDic:(NSDictionary*)dic{
    
    Id=@"";
    username=@"";
    profile_picture=@"";
    full_name=@"";
    
    
    if (![[dic objectForKey:@"id"] isKindOfClass:[NSNull class]])
        Id=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    if (![[dic objectForKey:@"username"] isKindOfClass:[NSNull class]])
        username=[NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]];
    if (![[dic objectForKey:@"profile_picture"] isKindOfClass:[NSNull class]])
        profile_picture=[NSString stringWithFormat:@"%@",[dic objectForKey:@"profile_picture"]];
    if (![[dic objectForKey:@"full_name"] isKindOfClass:[NSNull class]])
        full_name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"full_name"]];
    
    return self;
}

@end
