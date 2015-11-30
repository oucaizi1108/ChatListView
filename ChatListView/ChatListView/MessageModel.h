//
//  MessageModel.h
//  ChatListView
//
//  Created by oucaizi on 15/11/30.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,MessageType) {
    MessageTypeOther,
    MessageTypeMe
    
};

@interface MessageModel : NSObject

@property(nonatomic,assign)   MessageType type;
@property (nonatomic, copy)   NSString *text;
@property (nonatomic, copy)   NSString *time;
@property (nonatomic, assign) BOOL showTime;

+ (id)messageModelWithDict:(NSDictionary *)dict;

@end
