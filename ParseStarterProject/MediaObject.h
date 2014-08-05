//
//  AttachemntObject.h
//  CoesterVMS
//
//  Created by Syed Imran on 23/08/2013.
//   
//

#import <Foundation/Foundation.h>

@interface MediaObject : NSObject
{
    
    NSString *Id;
    NSString *userID;
    NSString *low_resolution;
    NSString *thumbnail;
    NSMutableArray *Likes;
    NSString *likesCount;


}

@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *likesCount;
@property(nonatomic,strong)NSString *thumbnail;
@property(nonatomic,strong)NSString *low_resolution;
@property(nonatomic,strong)NSString *userID;
@property(nonatomic,strong)NSMutableArray *Likes;

-(id)initWithDic:(NSDictionary*)dic;
@end
