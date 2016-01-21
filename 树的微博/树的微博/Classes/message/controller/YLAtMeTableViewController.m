//
//  YLAtMeTableViewController.m
//  树的微博
//
//  Created by WYL on 16/1/20.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLAtMeTableViewController.h"
#import "YLHomeTitleView.h"

@interface YLAtMeTableViewController ()

@property (nonatomic, strong) NSMutableArray <YLStatusFrame *> *statusFrames;

@property (nonatomic, weak) YLHomeTitleView *titleView;

@end

@implementation YLAtMeTableViewController

- (NSMutableArray <YLStatusFrame *> *)statusFrames
{
    if(_statusFrames == nil)
    {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBar];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getMetion_statuses];
}
#pragma mark 设置导航栏
- (void)setNavBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem.tintColor = GrayColor;
    
    // 标题
    YLHomeTitleView *titleView = [[YLHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    titleView.title = @"所有微博";
    self.navigationItem.titleView = titleView;
    self.titleView = titleView;
    titleView.titleClickBlock = ^(BOOL arrowDown){
        
        YLLog(@"bool : %d", arrowDown);
    };
}
#pragma mark
- (void)setting
{
    
}

#pragma mark 下拉刷新
- (void)pullDownRefresh
{
    [self getMetion_statuses];
}
#pragma mark - 获取@我的微博
- (void)getMetion_statuses
{
    /*
     source             false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token       false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     since_id           false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
     max_id             false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     count              false	int	单页返回的记录条数，最大不超过200，默认为20。
     page               false	int	返回结果的页码，默认为1。
     filter_by_author	false	int	作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
     filter_by_source	false	int	来源筛选类型，0：全部、1：来自微博、2：来自微群，默认为0。
     filter_by_type     false	int	原创筛选类型，0：全部微博、1：原创的微博，默认为0。
     */
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    params[@"access_token"] = Account.access_token;
    if(self.unreadCount.intValue)
    {
        params[@"count"] = self.unreadCount;
    }
    if(self.statusFrames.count)
    {
        YLStatusFrame *statusFrame = self.statusFrames.firstObject;
        params[@"since_id"] = statusFrame.status.idstr;
    }
    
    [[YLNetworkTool shareNetworkTool] getWithURL:GetStatusesMentionMeAPI params:params success:^(id json) {
        
        NSArray *statuses = json[@"statuses"];
        [statuses enumerateObjectsUsingBlock:^(NSDictionary *statusDict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YLStatus *status = [YLStatus statusWithDict:statusDict];
            YLStatusFrame *frame = [YLStatusFrame frameWithStauts:status];
            [self.statusFrames insertObject:frame atIndex:idx];
        }];
        [self.tableView reloadData];
        if(self.tableView.mj_header.isRefreshing)
        {
            [self.tableView.mj_header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        
        if(self.tableView.mj_header.isRefreshing)
        {
            [self.tableView.mj_header endRefreshing];
        }
        [MBProgressHUD showError:@"网络错误"];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLStatusTableViewCell *cell = [YLStatusTableViewCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.statusFrames[indexPath.row].cellHeight;
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
