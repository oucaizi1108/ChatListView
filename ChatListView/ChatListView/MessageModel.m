//
//  MessageModel.m
//  ChatListView
//
//  Created by oucaizi on 15/11/30.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

@synthesize text;
@synthesize time;
@synthesize type;
@synthesize showTime;

+ (id)messageModelWithDict:(NSDictionary *)dict
{
    MessageModel *message = [[self alloc] init];
    message.text = dict[@"text"];
    message.time = dict[@"time"];
    message.type = [dict[@"type"] intValue];
    
    return message;
}

@end
