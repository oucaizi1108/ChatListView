//
//  EmojiCollectionViewCell.m
//  Emoji_master
//
//  Created by oucaizi on 15/9/21.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "EmojiCollectionViewCell.h"

@implementation EmojiCollectionViewCell
@synthesize emojiLable=_emojiLable;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.emojiLable setFrame:self.bounds];
        [self addSubview:self.emojiLable];
    }
    return self;
}

#pragma mark --setter/getter

-(UILabel *)emojiLable{
    if (!_emojiLable) {
        _emojiLable=[[UILabel alloc] init];
        [_emojiLable setTextAlignment:NSTextAlignmentCenter];
    }
    return _emojiLable;
}

@end
