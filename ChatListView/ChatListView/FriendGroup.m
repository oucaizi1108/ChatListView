//
//  FriendGroup.m
//  ChatListView
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "FriendGroup.h"
#import "Friend.h"

@implementation FriendGroup

@synthesize friends;
@synthesize name;
@synthesize online;
@synthesize opened;

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self==[super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *tempArray=[NSMutableArray array];
        [self.friends enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Friend *friend=[Friend friendWithDic:obj];
            [tempArray addObject:friend];
        }];
        self.friends=tempArray;
    }
    return self;
}

@end
