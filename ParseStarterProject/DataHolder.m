//
//  DataHolder.m
//  CoesterApp
//
//  Created by Syed Imran on 15/07/2013.
//  Copyright (c) 2013 l3-nexgen. All rights reserved.
//

#import "DataHolder.h"
#import "MediaObject.h"

@implementation DataHolder

@synthesize AccessToken,MediaObjectsArray,UserID,UserProfile,tagsCategoryArray,userSelectedTags,MinLikes,MaxLikes,StartTime,EndTime,SessionComments,SessionFollows,SessionLikes    ,UserObjectID,OBjectsTobeLiked,NextMaxId,MyObjectsTobeLiked,follows,UserObject,userTypes,userSelectedType,usersArray;

static DataHolder *DataHolderSharedInstance;

- (id) init
{
	if (self = [super init])
	{
        usersArray=[[NSMutableArray alloc] init];
        follows=[[NSMutableArray alloc] init];
        OBjectsTobeLiked=[[NSMutableArray alloc] init];
        MyObjectsTobeLiked=[[NSMutableArray alloc] init];
        userTypes=[[NSArray alloc] initWithObjects:@"Abstract",@"Advertising",@"Architecture",@"Art",@"Cars",@"Cities",@"Entertainment",@"Fashion",@"Food",@"Health & Fittness",@"Nature",@"Personal Life",@"Sports",@"Travel", nil];
        
        
        NextMaxId=@"";
        MinLikes=0;
        MaxLikes=0;
        MediaObjectsArray=[[NSMutableArray alloc] init];
        tagsCategoryArray=[[NSMutableArray alloc] init];
        userSelectedTags=[[NSMutableArray alloc] init];
    }
	return self;
}
+ (DataHolder *) DataHolderSharedInstance
{
	@synchronized ([DataHolder class])
	{
		if (!DataHolderSharedInstance )
		{
			DataHolderSharedInstance = [[DataHolder alloc] init];
            
		}
		return DataHolderSharedInstance;
	}
	return nil;
}
-(void)AddselectedTagsFromCatagory:(NSString*)name{

    NSArray *arr=[self getTagsFromCatagory:name];
    for (NSString *str in arr) {
        if ([userSelectedTags indexOfObject:str]== NSNotFound) {
            [userSelectedTags addObject:str];
        }
    }
    
}
-(void)AddselectedTagsFromArray:(NSArray*)arr{
    
    for (NSString *str in arr) {
        if ([userSelectedTags indexOfObject:str]== NSNotFound) {
            [userSelectedTags addObject:str];
        }
    }
    
}

-(NSMutableArray*)MediaArrayWithMinimumLikes{

    MinLikes=[self.UserProfile.minlikes integerValue];
    MaxLikes=[self.UserProfile.maxlikes integerValue];
    NSMutableArray *Array=[[NSMutableArray alloc] init];
    for (MediaObject *Obj in MediaObjectsArray) {
        NSLog(@"my Likes Are:    #######   %d",Obj.Likes.count);
        if ((Obj.Likes.count>=MinLikes && Obj.Likes.count<=MaxLikes) || (Obj.Likes.count>=MinLikes && MaxLikes==0)) {
            [Array addObject:Obj];
        }
    }
    return Array;
}
-(int)GetTime{

    NSLog(@"%d",[DataHolder DataHolderSharedInstance].UserProfile.Time);
    return [DataHolder DataHolderSharedInstance].UserProfile.Time;
    //return [[NSUserDefaults standardUserDefaults] integerForKey:@"time"];
}
-(int)SubtractTime:(int)Seconds{

    int currentTime=[DataHolder DataHolderSharedInstance].UserProfile.Time;
    int newTime=currentTime-Seconds;
    [DataHolder DataHolderSharedInstance].UserProfile.Time=newTime;
    return newTime;
    
//    int currentTime=[[NSUserDefaults standardUserDefaults] integerForKey:@"time"];
//    int newTime=currentTime-Seconds;
//    [[NSUserDefaults standardUserDefaults] setInteger:newTime forKey:@"time"];
//    return newTime;
}



@end


