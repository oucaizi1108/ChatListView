//
//  EmojiInputView.h
//  Emoji_master
//
//  Created by oucaizi on 15/9/21.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmojiView;

extern  const CGFloat Emoji_DefaultH;/// self默认高度
extern  const CGFloat Emoji_MaxH; ///self最大高度
extern  const CGFloat Emoji_TextH;/// textView默认高度
extern  const CGFloat Emoji_LButtonW;/// 左边按钮默认宽度
extern  const CGFloat Emoji_RButtonW;/// 右边按钮默认宽度
extern  const CGFloat Emoji_ButtonH; /// 左右按钮默认高度


typedef void(^SendBlock)(NSString* text);

@interface EmojiInputView : UIView<UITextViewDelegate>


@property(nonatomic,strong) UITextView *inputTextView;///文本输入框
@property(nonatomic,strong) UIButton   *switchKeyboard;///切换键盘按钮
@property(nonatomic,strong) UIButton   *sendButton;///发送按钮
@property(nonatomic,strong) EmojiView  *emojiView;///表情视图
@property(nonatomic,copy)   SendBlock  sendBlockText;///发送文本


-(void)resetConfig;/// 还原默认配置
@end
