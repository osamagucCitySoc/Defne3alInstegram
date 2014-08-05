//
//  AttachemntObject.m
//  CoesterVMS
//
//  Created by Syed Imran on 23/08/2013.
//   
//

#import "MediaObject.h"
#import "LikeObject.h"

@implementation MediaObject
@synthesize Id,userID,Likes,low_resolution,thumbnail,likesCount;


-(id)initWithDic:(NSDictionary*)dic{
    
    Id=@"";
    userID=@"";
    Likes=[[NSMutableArray alloc] init];
 
    NSLog(@"Dic...:%@",dic);
    
    if (![[dic objectForKey:@"id"] isKindOfClass:[NSNull class]])
        Id=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
    if (![[[dic objectForKey:@"user"] objectForKey:@"id"] isKindOfClass:[NSNull class]])
        userID=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"user"] objectForKey:@"id"]];

    if (![[[dic objectForKey:@"images"] objectForKey:@"low_resolution"] isKindOfClass:[NSNull class]])
        low_resolution=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"]];
    if (![[[dic objectForKey:@"images"] objectForKey:@"thumbnail"] isKindOfClass:[NSNull class]])
        thumbnail=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"]];

    if (![[[dic objectForKey:@"likes"] objectForKey:@"data"] isKindOfClass:[NSNull class]]){
        NSArray *LikesArray=[[dic objectForKey:@"likes"] objectForKey:@"data"];
        likesCount=[[dic objectForKey:@"likes"] objectForKey:@"count"];
        for (NSDictionary *Dic in LikesArray) {
            LikeObject *like=[[LikeObject alloc] initWithDic:Dic];
            [Likes addObject:like];
        }
    }
    return self;
}

@end
