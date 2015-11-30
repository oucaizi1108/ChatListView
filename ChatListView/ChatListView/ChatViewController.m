//
//  ChatViewController.m
//  ChatListView
//
//  Created by oucaizi on 15/11/30.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageModel.h"
#import "CellModel.h"
#import "MessageCell.h"
#import "EmojiInputView.h"

#define kToolBarH 44
#define kTextFieldH 30

@interface ChatViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *cellFrameDatas;
    UITableView *chatView;
  
}
@property(nonatomic,strong) UITableView *chatView;

@property(nonatomic,strong) NSMutableArray *cellFrameDatas;

@property(nonatomic,strong) NSMutableArray *dataArray;

/// 底部输入框
@property(nonatomic,strong) EmojiInputView *inputBar;

@end


@implementation ChatViewController

@synthesize cellFrameDatas=_cellFrameDatas;
@synthesize chatView=_chatView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"好友列表";
    [self.view addSubview:self.ptableView];
    
    [self loadData];
    [self addChatView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


/**
 *  记载数据
 */
- (void)loadData
{
    _cellFrameDatas =[NSMutableArray array];
    NSURL *dataUrl = [[NSBundle mainBundle] URLForResource:@"messages.plist" withExtension:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfURL:dataUrl];
    for (NSDictionary *dict in dataArray) {
        MessageModel *message = [MessageModel messageModelWithDict:dict];
        CellModel *lastFrame = [_cellFrameDatas lastObject];
        CellModel *cellFrame = [[CellModel alloc] init];
        message.showTime = ![message.time isEqualToString:lastFrame.message.time];
        cellFrame.message = message;
        [_cellFrameDatas addObject:cellFrame];
    }
}
/**
 *  添加TableView
 */
- (void)addChatView
{
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    _chatView  = [[UITableView alloc] init];
    _chatView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kToolBarH-60);
    _chatView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    _chatView.delegate = self;
    _chatView.dataSource = self;
    _chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatView.allowsSelection = NO;
    [_chatView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    
    // 底部评论
    self.inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, self.view.frame.size.height - kToolBarH/2-64);
    
    [self.view addSubview:_chatView];
    [self.view addSubview:self.inputBar];
    
    __weak  typeof(self) weakSelf=self;
    self.inputBar.sendBlockText=^(NSString*text){
        //1.获得时间
        NSDate *senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:mm"];
        NSString *locationString=[dateformatter stringFromDate:senddate];
        
        //2.创建一个MessageModel类
        MessageModel *message = [[MessageModel alloc] init];
        message.text = text;
        message.time = locationString;
        message.type = 0;
        
        //3.创建一个CellFrameModel类
        CellModel *cellFrame = [[CellModel alloc] init];
        CellModel *lastCellFrame = [weakSelf.cellFrameDatas lastObject];
        message.showTime = ![lastCellFrame.message.time isEqualToString:message.time];
        cellFrame.message = message;
        
        //4.添加进去，并且刷新数据
        [weakSelf.cellFrameDatas addObject:cellFrame];
        [weakSelf.chatView reloadData];
        
        //5.自动滚到最后一行
        NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_cellFrameDatas.count - 1 inSection:0];
        [weakSelf.chatView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    };

    
}

- (void)endEdit
{
    [self.view endEditing:YES];
}

#pragma mark UITableViewDelegate/DataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return _cellFrameDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.cellFrame = _cellFrameDatas[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellModel *cellFrame = _cellFrameDatas[indexPath.row];
    return cellFrame.cellHeght;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



#pragma mark setter/getter

-(UITableView*)ptableView{
    if (!_ptableView) {
        _ptableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_ptableView setDelegate:self];
        [_ptableView setDataSource:self];
        [_ptableView setTableFooterView:[UIView new]];
    }
    return _ptableView;
}

-(EmojiInputView*)inputBar{
    if (!_inputBar) {
        _inputBar=[[EmojiInputView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), Emoji_DefaultH)];
        
    }
    return _inputBar;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

@end
