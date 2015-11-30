//
//  CellModel.h
//  ChatListView
//
//  Created by oucaizi on 15/11/30.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@class MessageModel;

#define textPadding 15

@interface CellModel : NSObject

@property (nonatomic, strong) MessageModel *message;
@property (nonatomic, assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect textFrame;
@property (nonatomic, assign, readonly) CGFloat cellHeght;
@end
