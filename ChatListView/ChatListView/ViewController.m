//
//  ViewController.m
//  ChatListView
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "ViewController.h"
#import "FriendGroup.h"
#import "Friend.h"
#import "HeadView.h"
#import "ChatViewController.h"

@interface ViewController ()<HeadViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"好友列表";
    [self.view addSubview:self.ptableView];
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadData{
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"friends.plist"  withExtension:nil];
    NSArray *array=[NSArray arrayWithContentsOfURL:url];
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArray addObject:[FriendGroup friendGroupWithDict:obj]];
    }];
    
}

#pragma mark UITableViewDelegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FriendGroup *group=self.dataArray[section];
    return group.opened?group.friends.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* indetitier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indetitier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetitier];
    }
    FriendGroup *friendGroup = self.dataArray[indexPath.section];
    Friend *friend = friendGroup.friends[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:friend.icon];
    cell.textLabel.textColor = friend.isVip ? [UIColor redColor] : [UIColor blackColor];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.intro;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *view=[HeadView headViewWithTableView:tableView];
    view.friendGroup=self.dataArray[section];
    view.delegate=self;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *viewController = [[ChatViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)clickHeadView
{
    [self.ptableView reloadData];
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

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
