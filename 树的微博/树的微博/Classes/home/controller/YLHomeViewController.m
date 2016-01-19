//
//  YLHomeViewController.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLHomeViewController.h"
#import "YLHomeTitleView.h"
#import "YLStatusTableViewCell.h"

@interface YLHomeViewController ()

@property (nonatomic, weak) YLHomeTitleView *titleView;

/**
 *  存放微博的 frame 以及微博信息
 */
@property (nonatomic, strong) NSMutableArray <YLStatusFrame *> *statusFrames;

@property (nonatomic, strong) UILabel *statusesCountMessageView;

@end

YLUser *User = nil;

@implementation YLHomeViewController
#pragma mark -

- (NSMutableArray<YLStatusFrame *> *)statusFrames
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpRefresh)];
    
    // 设置导航栏
    [self setNavBar];
    
    // 获取微博信息
    [self getNewStatuses];
}
#pragma mark 下拉刷新
- (void)pullDownRefresh
{
    [self getNewStatuses];
}
#pragma mark 上拉刷新
- (void)pullUpRefresh
{
    [self getMoreStatuses];
}

#pragma mark - 设置导航栏
- (void)setNavBar
{
    // 左侧按钮
    UIButton *friendAttention = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [friendAttention setImage:[UIImage imageNamed:@"navigationbar_friendattention"] forState:UIControlStateNormal];
    [friendAttention setImage:[UIImage imageNamed:@"navigationbar_friendattention_highlighted"] forState:UIControlStateHighlighted];
    [friendAttention addTarget:self action:@selector(friendAttentionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendAttention];
    
    // 右侧按钮
    UIButton *radar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [radar setImage:[UIImage imageNamed:@"navigationbar_icon_radar"] forState:UIControlStateNormal];
    [radar setImage:[UIImage imageNamed:@"navigationbar_icon_radar_highlighted"] forState:UIControlStateHighlighted];
    [radar addTarget:self action:@selector(radarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:radar];
    
    // 标题
    YLHomeTitleView *titleView = [[YLHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    self.navigationItem.titleView = titleView;
    self.titleView = titleView;
    titleView.titleClickBlock = ^(BOOL arrowDown){
    
        YLLog(@"bool : %d", arrowDown);
    };
    
    // 获取新微博的提示信息
    UILabel *statusesCountMessageView = [[UILabel alloc] init];
    statusesCountMessageView.backgroundColor = OrangeColor;
    statusesCountMessageView.textAlignment = NSTextAlignmentCenter;
    statusesCountMessageView.font = SystemFont(12);
    statusesCountMessageView.textColor = WhiteColor;
    self.statusesCountMessageView = statusesCountMessageView;
    
    // 获取个人信息
    [self getCurrentUserInfo];
    
}
#pragma mark 点击了朋友关注
- (void)friendAttentionButtonClick
{
    YLLog(@"friendAttentionButtonClick");
}
#pragma mark 点击了雷达
- (void)radarButtonClick
{
    YLLog(@"radarButtonClick");
}
#pragma mark 获取用户信息
- (void)getCurrentUserInfo
{
    /*
     source         false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid            false	int64	需要查询的用户ID。
     screen_name	false	string	需要查询的用户昵称。
     */
    NSDictionary *params = @{@"access_token" : Account.access_token, @"uid" : Account.uid};
    __weak typeof(self) weakSelf = self;
    [[YLNetworkTool shareNetworkTool]getWithURL:GetUserInfoAPI params:params success:^(id json) {
        
        User = [YLUser userWithDict:json];
        weakSelf.titleView.title = User.name;
        json = nil;
        
    } failure:^(NSError *error) {
        
        weakSelf.titleView.title = @"未知用户";
        [MBProgressHUD showError:@"获取昵称失败"];
        
    }];
}

#pragma mark 获取新微博
- (void)getNewStatuses
{
    // 先读取本地数据
    YLStatusesParam *statusesParam = [[YLStatusesParam alloc] init];
    statusesParam.count = @10;
    if(self.statusFrames.count)
    {
        statusesParam.since_id = @(self.statusFrames.firstObject.status.idstr.longLongValue);
    }
    NSArray *localStatusesArr = [[YLUserCacheTool shareUserCacheTool] getStatusesWithParam:statusesParam];
    if(localStatusesArr.count)
    {
        // 本地有数据，加载
        [localStatusesArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YLStatus *status = [YLStatus statusWithDict:dict];
            YLStatusFrame *frame = [YLStatusFrame frameWithStauts:status];
            [self.statusFrames insertObject:frame atIndex:idx];
        }];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }
    else
    {
        // 本地没有数据，网络请求
        /*
         source         false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
         access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
         since_id       false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
         max_id         false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
         count          false	int     单页返回的记录条数，最大不超过100，默认为20。
         page           false	int     返回结果的页码，默认为1。
         base_app       false	int     是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
         feature        false	int     过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
         trim_user      false	int     返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
         */
        
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        params[@"access_token"] = Account.access_token;
        params[@"count"] = @10;
        if(self.statusFrames.count)
        {
            YLStatusFrame *statusFrame = self.statusFrames.firstObject;
            params[@"since_id"] = statusFrame.status.idstr;
        }
        [[YLNetworkTool shareNetworkTool] getWithURL:GetUserStatusesAPI params:params success:^(id json) {
            
            NSArray *statuses = json[@"statuses"];
            [[YLUserCacheTool shareUserCacheTool] saveStatusesToLocal:statuses];    // 存入本地
            [statuses enumerateObjectsUsingBlock:^(NSDictionary *statusDict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YLStatus *status = [YLStatus statusWithDict:statusDict];
                YLStatusFrame *frame = [YLStatusFrame frameWithStauts:status];
                [self.statusFrames insertObject:frame atIndex:idx];
            }];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if(statuses.count)
            {
                [self showMessageWithNewStatusesCount:(unsigned)statuses.count];
            }
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"刷新失败"];
            [self.tableView.mj_header endRefreshing];
        }];
    }
}

#pragma mark 获取更多的微博
- (void)getMoreStatuses
{
    // 先获取本地数据
    YLStatusesParam *statusesParam = [[YLStatusesParam alloc] init];
    statusesParam.count = @10;
    if(self.statusFrames.count)
    {
        statusesParam.max_id = @(self.statusFrames.lastObject.status.idstr.longLongValue - 1);
    }
    NSArray *localStatusesArr = [[YLUserCacheTool shareUserCacheTool] getStatusesWithParam:statusesParam];
    if(localStatusesArr.count)
    {
        // 本地有数据，加载
        [localStatusesArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YLStatus *status = [YLStatus statusWithDict:dict];
            YLStatusFrame *frame = [YLStatusFrame frameWithStauts:status];
            [self.statusFrames addObject:frame];
        }];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }
    else
    {
        // 本地没有，网络获取
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        params[@"access_token"] = Account.access_token;
        params[@"count"] = @10;
        if(self.statusFrames.count)
        {
            YLStatusFrame *statusFrame = self.statusFrames.lastObject;
            params[@"max_id"] = @(statusFrame.status.idstr.longLongValue - 1);
        }
        [[YLNetworkTool shareNetworkTool] getWithURL:GetUserStatusesAPI params:params success:^(id json) {
            
            NSArray *statuses = json[@"statuses"];
            [[YLUserCacheTool shareUserCacheTool] saveStatusesToLocal:statuses];    // 存入本地
            [statuses enumerateObjectsUsingBlock:^(NSDictionary *statusDict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YLStatus *status = [YLStatus statusWithDict:statusDict];
                YLStatusFrame *frame = [YLStatusFrame frameWithStauts:status];
                [self.statusFrames addObject:frame];
            }];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"获取失败"];
            [self.tableView.mj_footer endRefreshing];
        }];
    }
}
#pragma mark 显示获取到多少条新微博
- (void)showMessageWithNewStatusesCount:(unsigned int)count
{
    self.statusesCountMessageView.text = [NSString stringWithFormat:@"%d 条新微博", count];
    CGFloat height = 30;
    CGFloat y = 64 - height;
    self.statusesCountMessageView.frame = CGRectMake(0, y, kScreenWidth, height);
    [self.navigationController.view addSubview:self.statusesCountMessageView];
    [self.navigationController.view insertSubview:self.statusesCountMessageView belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1.0 animations:^{
        
        self.statusesCountMessageView.y = 64;
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:1.0 animations:^{
                
                self.statusesCountMessageView.y = y;
                
            }completion:^(BOOL finished) {
                
                [self.statusesCountMessageView removeFromSuperview];
            }];
        });
    }];
}

#pragma mark - Table view data source
#pragma mark 分组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell 的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}
#pragma mark cell
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


@end
