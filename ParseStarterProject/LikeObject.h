//
//  LikeObjec.h
//  Instagram
//
//  Created by Syed Imran on 23/01/2014.
//  Copyright (c) 2014 l3-nexgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LikeObject : NSObject
{
    
    NSString *username;
    NSString *profile_picture;
    NSString *Id;
    NSString *full_name;
    
    
}

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *profile_picture;
@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *full_name;


-(id)initWithDic:(NSDictionary*)dic;
@end
