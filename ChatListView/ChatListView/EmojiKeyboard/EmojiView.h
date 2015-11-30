//
//  EmojiView.h
//  Emoji_master
//
//  Created by oucaizi on 15/9/21.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateText)(NSString*text);
typedef void(^DelegateEmoji)(void);

@interface EmojiView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/// 分类选择使用collectionView
@property(nonatomic,strong) UICollectionView *TcollectionView;

/// 表情数组
@property(nonatomic,strong) NSArray          *emojiArray;

/// 更新textView输入框
@property(nonatomic,copy)   UpdateText       updateText;

/**
 *   删除表情按钮
 */
@property(nonatomic,strong) UIButton         *delegateEmoji;


/**
 *  删除表情block回调
 */
@property(nonatomic,copy) DelegateEmoji   delegateBlock;

@end
