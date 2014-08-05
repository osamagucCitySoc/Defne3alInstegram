//
//  UserProfile.h
//  Instagram
//
//  Created by Syed Imran on 23/01/2014.
//  Copyright (c) 2014 l3-nexgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject
{
    
    NSString *username;
    NSString *bio;
    NSString *website;
    NSString *profile_picture;
    NSString *media;
    NSString *followed_by;
    NSString *follows;
    NSString *ID;
    NSString *full_name;
    NSString *gender;
    NSArray *user_tags;
    NSString *app_followers;
    NSString *app_likes;
    NSString *app_comments;
    NSString *minlikes;
    NSString *maxlikes;
    
    
    NSString *InstawhoreLike;
    NSString *InstawhoreFllow;
    NSString *InstawhoreComment;
    
    NSString *NewbyLike;
    NSString *NewbyFllow;
    NSString *NewbyComment;
    
    NSString *InstafamousLike;
    NSString *InstafamousFllow;
    NSString *InstafamousComment;
    
    NSString *ProLike;
    NSString *ProFllow;
    NSString *ProComment;
    
    NSString *LegendaryLike;
    NSString *LegendaryFllow;
    NSString *LegendaryComment;
    
    NSString *categoryID;
    int Time;
    
}

@property(nonatomic,assign)int Time;
@property(nonatomic,strong)NSArray *user_tags;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *bio;
@property(nonatomic,strong)NSString *website;
@property(nonatomic,strong)NSString *profile_picture;
@property(nonatomic,strong)NSString *gender;

@property(nonatomic,strong)NSString *media;
@property(nonatomic,strong)NSString *followed_by;
@property(nonatomic,strong)NSString *follows;
@property(nonatomic,strong)NSString *ID;

@property(nonatomic,strong)NSString *app_followers;
@property(nonatomic,strong)NSString *app_likes;
@property(nonatomic,strong)NSString *app_comments;

@property(nonatomic,strong)NSString *full_name;

@property(nonatomic,strong)NSString *minlikes;
@property(nonatomic,strong)NSString *maxlikes;


@property(nonatomic,strong)NSString *InstawhoreLike;
@property(nonatomic,strong)NSString *InstawhoreFllow;
@property(nonatomic,strong)NSString *InstawhoreComment;

@property(nonatomic,strong)NSString *NewbyLike;
@property(nonatomic,strong)NSString *NewbyFllow;
@property(nonatomic,strong)NSString *NewbyComment;

@property(nonatomic,strong)NSString *InstafamousLike;
@property(nonatomic,strong)NSString *InstafamousFllow;
@property(nonatomic,strong)NSString *InstafamousComment;

@property(nonatomic,strong)NSString *ProLike;
@property(nonatomic,strong)NSString *ProFllow;
@property(nonatomic,strong)NSString *ProComment;

@property(nonatomic,strong)NSString *LegendaryLike;
@property(nonatomic,strong)NSString *LegendaryFllow;
@property(nonatomic,strong)NSString *LegendaryComment;
@property(nonatomic,strong)NSString *categoryID;


-(id)initWithDic:(NSDictionary*)dic;
-(id)initWithLoginDic:(NSDictionary*)dic;
-(id)initPrivate;
@end
