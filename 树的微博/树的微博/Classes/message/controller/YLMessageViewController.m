//
//  YLMessageViewController.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLMessageViewController.h"
#import "YLMessageTableViewCellModel.h"
#import "YLMessageTableViewCell.h"
#import "YLAtMeTableViewController.h"

@interface YLMessageViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YLMessageViewController

- (NSMutableArray *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MessageTableViewCell" ofType:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YLMessageTableViewCellModel *model = [YLMessageTableViewCellModel modelWithDict:dict];
            [_dataSource addObject:model];
        }];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    
    self.tableView.rowHeight = 65;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedUnreadMessageCountNotification:) name:kGetUnreadMessageCountNotification object:nil];
    
}
#pragma mark 设置导航栏
- (void)setNavBar
{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    leftBtn.titleLabel.font = SystemFont(16);
    [leftBtn setTitle:@"发现群" forState:UIControlStateNormal];
    [leftBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [leftBtn setTitleColor:OrangeColor forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(discoverGroup) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_icon_newchat"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_icon_newchat_highlight"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(newChat) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationController.navigationBar.tintColor = GrayColor;
}
#pragma mark 发现群
- (void)discoverGroup
{
    
}
#pragma mark 开启新的聊天
- (void)newChat
{
    
}

#pragma mark 接收到未读消息的通知
- (void)receivedUnreadMessageCountNotification:(NSNotification *)noti
{
    YLUnreadMessageCountModel *model = noti.userInfo[kGetUnreadMessageCountNotification];
    // @我的
    YLMessageTableViewCellModel *atMeModel = self.dataSource.firstObject;
    atMeModel.unreadCount = @(model.mention_status);
    
    // 新评论数
    YLMessageTableViewCellModel *cmtModel = self.dataSource[1];
    cmtModel.unreadCount = @(model.cmt);
    
    // 新私信数
    YLMessageTableViewCellModel *dmModel = self.dataSource[4];
    dmModel.unreadCount = @(model.dm);
    
    if(model.messageCount)
    {
        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLMessageTableViewCell *cell = [YLMessageTableViewCell cellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        // @我的
        YLAtMeTableViewController *atMeVc = [[YLAtMeTableViewController alloc] init];
        atMeVc.view.backgroundColor = WhiteColor;
        YLMessageTableViewCellModel *model = self.dataSource[indexPath.row];
        atMeVc.unreadCount = model.unreadCount;
        [self.navigationController pushViewController:atMeVc animated:YES];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
