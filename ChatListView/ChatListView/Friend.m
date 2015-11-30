//
//  Friend.m
//  ChatListView
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "Friend.h"

@implementation Friend

@synthesize icon;
@synthesize name;
@synthesize intro;
@synthesize vip;

+(instancetype)friendWithDic:(NSDictionary*)dict{
   return  [[self alloc] friendWithDic:dict];
}

-(instancetype)friendWithDic:(NSDictionary*)dict{
    if (self==[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
