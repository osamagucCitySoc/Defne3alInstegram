//
//  DataHolder.h
//  CoesterApp
//
//  Created by Syed Imran on 15/07/2013.
//  Copyright (c) 2013 l3-nexgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"


@interface DataHolder : NSObject
{
    
    NSMutableArray *usersArray;
    NSMutableArray *follows;
    NSArray *userTypes;
    NSString *userSelectedType;
    
    NSString *UserObjectID;
    PFObject *UserObject;
    NSMutableArray *OBjectsTobeLiked;
    NSMutableArray *MyObjectsTobeLiked;
    NSString *NextMaxId;
    
    
   
    NSString *AccessToken;
    NSString *UserID;
    NSMutableArray *MediaObjectsArray;
    UserProfile *UserProfile;
    NSMutableArray *tagsCategoryArray;
    NSMutableArray *userSelectedTags;
    NSString *StartTime;
    NSString *EndTime;
    int SessionLikes;
    int SessionFollows;
    int SessionComments;
    int MinLikes;
    int MaxLikes;
    
}

@property(nonatomic,readonly)NSMutableArray *usersArray;
@property(nonatomic,readonly)NSMutableArray *follows;
@property(nonatomic,strong)NSArray *userTypes;
@property(nonatomic,strong)NSString *userSelectedType;


@property(nonatomic,strong)PFObject *UserObject;
@property(nonatomic,strong)NSString *UserObjectID;
@property(nonatomic,strong)NSString *NextMaxId;
@property(nonatomic,strong)NSMutableArray *OBjectsTobeLiked;
@property(nonatomic,strong)NSMutableArray *MyObjectsTobeLiked;


@property(nonatomic,assign)int SessionLikes;
@property(nonatomic,assign)int SessionFollows;
@property(nonatomic,assign)int SessionComments;
@property(nonatomic,assign)int MinLikes;
@property(nonatomic,assign)int MaxLikes;
@property(nonatomic,strong)NSString *StartTime;
@property(nonatomic,strong)NSString *EndTime;


@property(nonatomic,strong)NSString *AccessToken;
@property(nonatomic,strong)NSString *UserID;
@property(nonatomic,strong)NSMutableArray *MediaObjectsArray;
@property(nonatomic,strong)UserProfile *UserProfile;
@property(nonatomic,strong)NSMutableArray *tagsCategoryArray;
@property(nonatomic,strong)NSMutableArray *userSelectedTags;

+ (DataHolder *) DataHolderSharedInstance;
-(void)LoadTags;
-(NSMutableArray*)MediaArrayWithMinimumLikes;
-(NSArray*) getTagsFromCatagory:(NSString*)name;
-(void)AddselectedTagsFromCatagory:(NSString*)name;
-(void)AddselectedTagsFromArray:(NSArray*)arr;
-(int)GetTime;
-(int)SubtractTime:(int)Seconds;
@end
