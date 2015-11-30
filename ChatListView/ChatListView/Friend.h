//
//  Friend.h
//  ChatListView
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;
@property (nonatomic,assign ,getter=isVip) BOOL vip;

+(instancetype)friendWithDic:(NSDictionary*)dict;

-(instancetype)friendWithDic:(NSDictionary*)dict;

@end
