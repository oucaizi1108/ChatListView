//
//  EmojiView.m
//  Emoji_master
//
//  Created by oucaizi on 15/9/21.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "EmojiView.h"
#import "EmojiCollectionViewCell.h"
#import "Emoji.h"
#import "Header.h"

static NSString *const idetify=@"EmojiCollectionViewCell";

@implementation EmojiView
@synthesize TcollectionView=_TcollectionView;
@synthesize emojiArray=_emojiArray;
@synthesize updateText=_updateText;
@synthesize delegateEmoji=_delegateEmoji;
@synthesize delegateBlock=_delegateBlock;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:COLOR_GRAY_LINE];
        
        _emojiArray=[Emoji allEmoji];
        frame.size.height-=30;
        [self.TcollectionView setFrame:frame];
        [self addSubview:self.TcollectionView];
        
        [self.delegateEmoji setFrame:CGRectMake(CGRectGetWidth(frame)-50, CGRectGetMaxY(self.TcollectionView.frame)+5, 30, 20)];
        [self addSubview:self.delegateEmoji];
    }
    return self;
}

#pragma mark event
-(void)delegateEmojiPressed{
    if (self.delegateBlock) {
        self.delegateBlock();
    }
}

#pragma mark collectionView delegate datesource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_emojiArray count];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    EmojiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idetify forIndexPath:indexPath];
    cell.emojiLable.text=_emojiArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EmojiCollectionViewCell *cell=(EmojiCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.updateText) {
        self.updateText(cell.emojiLable.text);
    }
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    return CGSizeMake(40, 40);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    CGFloat padding=(CGRectGetWidth(self.frame)-20-40*6)/5;
    return padding;
}

#pragma mark --setter/getter

-(UICollectionView*)TcollectionView{
    if (!_TcollectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _TcollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_TcollectionView setDelegate:self];
        [_TcollectionView setDataSource:self];
        [_TcollectionView setBackgroundColor:[UIColor whiteColor]];
        [_TcollectionView setShowsHorizontalScrollIndicator:NO];
        [_TcollectionView setCanCancelContentTouches:YES];
        [_TcollectionView setDelaysContentTouches:NO];
        [_TcollectionView setAlwaysBounceVertical:NO];
        [_TcollectionView registerClass:[EmojiCollectionViewCell class] forCellWithReuseIdentifier:idetify];
    }
    return _TcollectionView;
}

-(UIButton*)delegateEmoji{
    if (!_delegateEmoji) {
        _delegateEmoji=[UIButton buttonWithType:UIButtonTypeCustom];
        [_delegateEmoji setBackgroundImage:[UIImage imageNamed:@"keyboard_btn_delete"] forState:UIControlStateNormal];
        [_delegateEmoji addTarget:self action:@selector(delegateEmojiPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delegateEmoji;
}


@end
