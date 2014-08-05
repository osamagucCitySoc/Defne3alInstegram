//
//  UserProfile.m
//  Instagram
//
//  Created by Syed Imran on 23/01/2014.
//  Copyright (c) 2014 l3-nexgen. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile
@synthesize username,bio,website,profile_picture,media,followed_by,follows,ID,full_name,gender,Time,user_tags,app_followers,app_likes,app_comments,minlikes,maxlikes,categoryID;
@synthesize InstawhoreLike;
@synthesize InstawhoreFllow;
@synthesize InstawhoreComment;
@synthesize NewbyLike;
@synthesize NewbyFllow;
@synthesize NewbyComment;
@synthesize InstafamousLike;
@synthesize InstafamousFllow;
@synthesize InstafamousComment;
@synthesize ProLike;
@synthesize ProFllow;
@synthesize ProComment;
@synthesize LegendaryLike;
@synthesize LegendaryFllow;
@synthesize LegendaryComment;

-(id)initPrivate{

    username=@"Private";
    bio=@"Private";
    website=@"";
    profile_picture=@"Private";
    media=@"Private";
    followed_by=@"Private";
    follows=@"Private";
    ID=@"Private";
    profile_picture=@"http://images.ak.instagram.com/profiles/anonymousUser.jpg";
    return self;
}

-(id)initWithDic:(NSDictionary*)dic{
    username=@"";
    bio=@"";
    website=@"";
    profile_picture=@"";
    media=@"";
    followed_by=@"";
    follows=@"";
    ID=@"";
        
    
    if (![[dic objectForKey:@"username"] isKindOfClass:[NSNull class]])
        username=[NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]];
    if (![[dic objectForKey:@"bio"] isKindOfClass:[NSNull class]])
        bio=[NSString stringWithFormat:@"%@",[dic objectForKey:@"bio"]];
    if (![[dic objectForKey:@"website"] isKindOfClass:[NSNull class]])
        website=[NSString stringWithFormat:@"%@",[dic objectForKey:@"website"]];
    if (![[dic objectForKey:@"profile_picture"] isKindOfClass:[NSNull class]])
        profile_picture=[NSString stringWithFormat:@"%@",[dic objectForKey:@"profile_picture"]];
    if (![[[dic objectForKey:@"counts"] objectForKey:@"media"] isKindOfClass:[NSNull class]])
        media=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"counts"] objectForKey:@"media"]];
    if (![[[dic objectForKey:@"counts"] objectForKey:@"followed_by"] isKindOfClass:[NSNull class]])
        followed_by=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"counts"]  objectForKey:@"followed_by"]];
    if (![[[dic objectForKey:@"counts"] objectForKey:@"follows"] isKindOfClass:[NSNull class]])
        follows=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"counts"] objectForKey:@"follows"]];
    if (![[dic objectForKey:@"ID"] isKindOfClass:[NSNull class]])
        ID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ID"]];
    if (![[dic objectForKey:@"full_name"] isKindOfClass:[NSNull class]])
        full_name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"full_name"]];
    if (![[dic objectForKey:@"total_hourse_purchase"] isKindOfClass:[NSNull class]])
        Time=[[NSString stringWithFormat:@"%@",[dic objectForKey:@"total_hourse_purchase"]] integerValue];
    
    return self;
}


-(id)initWithLoginDic:(NSDictionary*)dic{
    username=@"";
    bio=@"";
    website=@"";
    profile_picture=@"";
    media=@"";
    followed_by=@"";
    follows=@"";
    ID=@"";
    
    
    if (![[dic objectForKey:@"username"] isKindOfClass:[NSNull class]])
        username=[NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]];
    if (![[dic objectForKey:@"bio_description"] isKindOfClass:[NSNull class]])
        bio=[NSString stringWithFormat:@"%@",[dic objectForKey:@"bio_description"]];
    if (![[dic objectForKey:@"website"] isKindOfClass:[NSNull class]])
        website=[NSString stringWithFormat:@"%@",[dic objectForKey:@"website"]];
    if (![[dic objectForKey:@"profile_picture"] isKindOfClass:[NSNull class]])
        profile_picture=[NSString stringWithFormat:@"%@",[dic objectForKey:@"profile_picture"]];
    if (![[dic objectForKey:@"media"] isKindOfClass:[NSNull class]])
        media=[NSString stringWithFormat:@"%@",[dic objectForKey:@"media"]];
    if (![[dic  objectForKey:@"followed_by"] isKindOfClass:[NSNull class]])
        followed_by=[NSString stringWithFormat:@"%@",[dic objectForKey:@"followed_by"]];
    if (![[dic  objectForKey:@"follows"] isKindOfClass:[NSNull class]])
        follows=[NSString stringWithFormat:@"%@",[dic objectForKey:@"follows"]];
    if (![[dic objectForKey:@"id"] isKindOfClass:[NSNull class]])
        ID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ID"]];
    if (![[dic objectForKey:@"full_name"] isKindOfClass:[NSNull class]])
        full_name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"full_name"]];
    if (![[dic objectForKey:@"gender"] isKindOfClass:[NSNull class]])
        gender=[NSString stringWithFormat:@"%@",[dic objectForKey:@"gender"]];
    if (![[dic objectForKey:@"total_hourse_purchase"] isKindOfClass:[NSNull class]])
        Time=[[NSString stringWithFormat:@"%@",[dic objectForKey:@"total_hourse_purchase"]] integerValue];
    if (![[dic objectForKey:@"user_tags"] isKindOfClass:[NSNull class]])
        user_tags=[NSArray arrayWithArray:[dic objectForKey:@"user_tags"]];
    if (![[dic objectForKey:@"category_id"] isKindOfClass:[NSNull class]])
        categoryID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"category_id"]];
    if (![[dic objectForKey:@"app_followers"] isKindOfClass:[NSNull class]])
        app_followers=[NSString stringWithFormat:@"%@",[dic objectForKey:@"app_followers"]];
    if (![[dic objectForKey:@"app_likes"] isKindOfClass:[NSNull class]])
        app_likes=[NSString stringWithFormat:@"%@",[dic objectForKey:@"app_likes"]];
    if (![[dic objectForKey:@"app_comments"] isKindOfClass:[NSNull class]])
        app_comments=[NSString stringWithFormat:@"%@",[dic objectForKey:@"app_comments"]];
    if (![[[dic objectForKey:@"Globel_min_max"] objectForKey:@"minumum"] isKindOfClass:[NSNull class]])
        app_comments=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"Globel_min_max"] objectForKey:@"minumum"]];
    if (![[[dic objectForKey:@"Globel_min_max"] objectForKey:@"maximum"] isKindOfClass:[NSNull class]])
        app_comments=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"Globel_min_max"] objectForKey:@"maximum"]];
    
    
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Newby"] objectForKey:@"likes"] isKindOfClass:[NSNull class]])
        NewbyLike=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Newby"] objectForKey:@"likes"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Newby"] objectForKey:@"comments"] isKindOfClass:[NSNull class]])
        NewbyComment=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Newby"] objectForKey:@"comments"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Newby"] objectForKey:@"followers"] isKindOfClass:[NSNull class]])
        NewbyFllow=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Newby"] objectForKey:@"followers"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Pro"] objectForKey:@"likes"] isKindOfClass:[NSNull class]])
        ProLike=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Pro"] objectForKey:@"likes"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Pro"] objectForKey:@"comments"] isKindOfClass:[NSNull class]])
        ProComment=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Pro"] objectForKey:@"comments"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Pro"] objectForKey:@"followers"] isKindOfClass:[NSNull class]])
        ProFllow=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Pro"] objectForKey:@"followers"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instawhore"] objectForKey:@"likes"] isKindOfClass:[NSNull class]])
        InstawhoreLike=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instawhore"] objectForKey:@"likes"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instawhore"] objectForKey:@"comments"] isKindOfClass:[NSNull class]])
        InstawhoreComment=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instawhore"] objectForKey:@"comments"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instawhore"] objectForKey:@"followers"] isKindOfClass:[NSNull class]])
        InstawhoreFllow=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instawhore"] objectForKey:@"followers"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Legendary"] objectForKey:@"likes"] isKindOfClass:[NSNull class]])
        LegendaryLike=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Legendary"] objectForKey:@"likes"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Legendary"] objectForKey:@"comments"] isKindOfClass:[NSNull class]])
        LegendaryComment=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Legendary"] objectForKey:@"comments"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Legendary"] objectForKey:@"followers"] isKindOfClass:[NSNull class]])
        LegendaryFllow=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Legendary"] objectForKey:@"followers"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instafamous"] objectForKey:@"likes"] isKindOfClass:[NSNull class]])
        InstafamousLike=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instafamous"] objectForKey:@"likes"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instafamous"] objectForKey:@"comments"] isKindOfClass:[NSNull class]])
        InstafamousComment=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instafamous"] objectForKey:@"comments"]];
    if (![[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instafamous"] objectForKey:@"followers"] isKindOfClass:[NSNull class]])
        InstafamousFllow=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"Globel_mileston"] objectForKey:@"Instafamous"] objectForKey:@"followers"]];
    
    
    return self;
}

@end
