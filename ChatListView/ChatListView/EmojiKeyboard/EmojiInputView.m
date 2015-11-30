//
//  EmojiInputView.m
//  Emoji_master
//
//  Created by oucaizi on 15/9/21.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "EmojiInputView.h"
#import "EmojiView.h"
#import "Header.h"

const CGFloat Emoji_DefaultH=44;/// self默认高度
const CGFloat Emoji_MaxH=80; ///self最大高度
const CGFloat Emoji_TextH=30;/// textView默认高度
const CGFloat Emoji_LButtonW=45;/// 左边按钮默认宽度
const CGFloat Emoji_RButtonW=55;/// 右边按钮默认宽度
const CGFloat Emoji_ButtonH=30; /// 左右按钮默认高度


@implementation EmojiInputView
@synthesize inputTextView=_inputTextView;
@synthesize switchKeyboard=_switchKeyboard;
@synthesize sendButton=_sendButton;
@synthesize emojiView=_emojiView;
@synthesize sendBlockText=_sendBlockText;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShows:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        [self setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
        [self addSubview:self.inputTextView];
        [self addSubview:self.switchKeyboard];
        [self addSubview:self.sendButton];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    CGFloat textView_width= CGRectGetWidth(self.frame)-Emoji_LButtonW-Emoji_RButtonW-(10+5)*2;
    CGSize textSize = [self.inputTextView sizeThatFits:CGSizeMake(textView_width, MAXFLOAT)];
    CGFloat height=MAX(Emoji_ButtonH, MIN(textSize.height, Emoji_MaxH));
    
    /// 重置self的frame
    CGFloat offset = 10;
    CGRect addBarFrame = self.frame;
    CGFloat maxY = CGRectGetMaxY(addBarFrame);
    addBarFrame.size.height = height+offset;
    addBarFrame.origin.y = maxY-addBarFrame.size.height;
    self.frame = addBarFrame;

    
    /// 左键盘切换按钮
    [self.switchKeyboard setFrame:CGRectMake(5,0 , Emoji_LButtonW, Emoji_ButtonH)];
    self.switchKeyboard.center =CGPointMake(self.switchKeyboard.center.x, CGRectGetHeight(self.bounds)/2);
    
    /// 文本输入框
    [self.inputTextView setFrame:CGRectMake(CGRectGetMaxX(self.switchKeyboard.frame)+10,0, textView_width,height)];
    self.inputTextView.center=CGPointMake(self.inputTextView.center.x,  CGRectGetHeight(self.bounds)/2);
    self.inputTextView.scrollEnabled = (textSize.height > height-offset);
    
    /// 发送按钮
    [self.sendButton setFrame:CGRectMake(CGRectGetMaxX(self.inputTextView.frame)+10, 0, Emoji_RButtonW, Emoji_ButtonH)];
    [self.sendButton setCenter:CGPointMake(self.sendButton.center.x, CGRectGetHeight(self.bounds)/2)];
    
   
}

#pragma mark event

-(void)switchKeyboardPressed:(UIButton*)sender{
    if (sender.tag==1) {
        [self.inputTextView setInputView:nil];
    }else{
        [self.inputTextView setInputView:self.emojiView];
        [self.emojiView.TcollectionView setContentOffset:CGPointZero];
    }
    [self.inputTextView reloadInputViews];
    sender.tag = (sender.tag+1)%2;
    [sender setImage:[UIImage imageNamed:!sender.tag?@"btn_expression":@"btn_keyboard"] forState:UIControlStateNormal];
    [self.inputTextView becomeFirstResponder];
    
}

-(void)sendButtonPressed:(UIButton*)sender{
    if (self.sendBlockText) {
        self.sendBlockText(self.inputTextView.text);
    }
    [self resetConfig];
}

-(void)resetConfig{
    self.inputTextView.text=@"";
    [self.switchKeyboard setImage:[UIImage imageNamed:@"btn_expression"] forState:UIControlStateNormal];
    [self.switchKeyboard setTag:0];
    [self.sendButton setEnabled:NO];
    [self setNeedsLayout];
    [self.inputTextView resignFirstResponder];
    [self.inputTextView setInputView:nil];
}

#pragma mark notify

-(void)keyboardWillShows:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         CGRect newInputBarFrame = kbRect;
                         newInputBarFrame.origin.y-=(CGRectGetHeight(self.bounds)+NAVGATIONBAR_HEIGHT);
                         newInputBarFrame.size.height=CGRectGetHeight(self.bounds);
                         self.frame = newInputBarFrame;
                     }
                     completion:nil];
}

-(void)keyboardWillHidden:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGFloat heights = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.center = CGPointMake(self.bounds.size.width/2.0f, heights-CGRectGetHeight(self.frame)/2.0-NAVGATIONBAR_HEIGHT);
                         
                     }
                     completion:nil];
}


#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView{
    self.sendButton.enabled=![@"" isEqualToString:textView.text];
    
    [self setNeedsLayout];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([textView.text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark --setter/getter

-(UITextView*)inputTextView{
    if (!_inputTextView) {
        _inputTextView=[[UITextView alloc] init];
        [_inputTextView setDelegate:self];
        [_inputTextView setShowsHorizontalScrollIndicator:NO];
        [_inputTextView setShowsVerticalScrollIndicator:NO];
        [_inputTextView setScrollEnabled:NO];
    }
    return _inputTextView;
}

-(UIButton*)sendButton{
    if (!_sendButton) {
        _sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:[UIColor orangeColor]];
        [_sendButton setEnabled:NO];
        [_sendButton.layer setShouldRasterize:YES];
        [_sendButton.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
        [_sendButton.layer setMasksToBounds:YES];
        [_sendButton.layer setCornerRadius:4];
        [_sendButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.3] forState:UIControlStateDisabled];
        [_sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(UIButton*)switchKeyboard{
    if (!_switchKeyboard) {
        _switchKeyboard=[UIButton buttonWithType:UIButtonTypeCustom];
        [_switchKeyboard setTag:0];
        [_switchKeyboard setImage:[UIImage imageNamed:@"btn_expression"] forState:UIControlStateNormal];
        [_switchKeyboard addTarget:self action:@selector(switchKeyboardPressed:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _switchKeyboard;
}

-(EmojiView*)emojiView{
    if (!_emojiView) {
        _emojiView=[[EmojiView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 216+30)];
        __weak typeof(self) weakSelf=self;
        _emojiView.updateText=^(NSString*text){
            NSMutableString *mut_string=[NSMutableString stringWithString:weakSelf.inputTextView.text];
            [mut_string appendString:text];
            weakSelf.inputTextView.text=mut_string;
            weakSelf.sendButton.enabled=![@"" isEqualToString: weakSelf.inputTextView.text];
            [weakSelf setNeedsLayout];
            
        };
        _emojiView.delegateBlock=^{
            [weakSelf.inputTextView deleteBackward];
        };
    }
    return _emojiView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
