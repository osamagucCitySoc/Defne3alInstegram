//
//  CoesterJSONParser.h
//  CoesterApp
//
//  Created by Syed Imran on 15/07/2013.
//  Copyright (c) 2013 l3-nexgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"
#import "MediaObject.h"
@interface JSONParser : NSObject
{

}
@property(nonatomic, retain) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					errorCallback;


+ (JSONParser *) JSONParserSharedInstance;
-(BOOL)ParseMediaObjects:(NSData*)data;
-(UserProfile*)ParseUserProfileObjects:(NSData*)data;
-(void)ParseTagsCatagories:(NSData*)data;
-(UserProfile*)ParseUserLoginObject:(NSData*)data;
-(MediaObject*)ParseMediaObject:(NSData*)data;
-(void)ParseUpdateUserProfileObjects:(NSData*)data;



-(BOOL)ParseFollowResponseObject:(NSData*)data;
-(BOOL)ParseUsersObjects:(NSData*)data;
-(BOOL)ParseRelationObject:(NSData*)data;

@end
