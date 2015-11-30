//
//  FriendGroup.h
//  ChatListView
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendGroup : NSObject

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, assign) BOOL opened;

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
