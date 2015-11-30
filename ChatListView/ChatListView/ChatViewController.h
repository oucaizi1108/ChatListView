//
//  ChatViewController.h
//  ChatListView
//
//  Created by oucaizi on 15/11/30.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ChatViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *ptableView;


@end
