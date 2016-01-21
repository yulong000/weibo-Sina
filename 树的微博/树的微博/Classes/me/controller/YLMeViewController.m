//
//  YLMeViewController.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLMeViewController.h"
#import "YLMeTableViewCell.h"
#import "YLDiscoverTableViewCellModel.h"
#import "YLHeadViewCell.h"
#import "YLUserInfoCell.h"

@interface YLMeViewController ()

@property (nonatomic, strong) NSMutableArray <NSMutableArray *> *dataSource;

@end

@implementation YLMeViewController

- (NSMutableArray <NSMutableArray *> *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MeTableViewCell" ofType:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        for(int i = 0; i < arr.count; i++)
        {
            NSMutableArray *subArr = arr[i];
            NSMutableArray *tmpArr = [NSMutableArray array];
            [subArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YLDiscoverTableViewCellModel *model = [YLDiscoverTableViewCellModel modelWithDict:dict];
                [tmpArr addObject:model];
            }];
            [_dataSource addObject:tmpArr];
        }
    }
    return _dataSource;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBA(240, 240, 240, 1);
    
    [self setNavBar];
}
#pragma mark 设置导航栏
- (void)setNavBar
{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    leftBtn.titleLabel.font = SystemFont(16);
    [leftBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [leftBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    [leftBtn setTitleColor:OrangeColor forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(addFriends) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    rightBtn.titleLabel.font = SystemFont(16);
    [rightBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightBtn setTitleColor:OrangeColor forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationController.navigationBar.tintColor = GrayColor;
}
#pragma mark 添加好友
- (void)addFriends
{
    
}
#pragma mark 设置
- (void)setting
{
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 2;
    }
    else
    {
        return self.dataSource[section - 1].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            YLHeadViewCell *cell = [YLHeadViewCell cellWithTableView:tableView];
            cell.user = User;
            cell.iconClickedBlock = ^{
            
                YLLog(@"点击了头像");
            };
            return cell;
        }
        else
        {
            YLUserInfoCell *cell = [YLUserInfoCell cellWithTableView:tableView];
            cell.user = User;
            cell.buttonClickedBlock = ^(NSInteger index, NSUInteger count){
            
                YLLog(@"点击了按钮, %ld, count : %lu", index, count);
            };
            return cell;
        }
    }
    else
    {
        YLMeTableViewCell *cell = [YLMeTableViewCell cellWithTableView:tableView];
        cell.model = self.dataSource[indexPath.section - 1][indexPath.row];
        cell.showArrow = YES;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            return 80;
        }
        else
        {
            return 60;
        }
    }
    else
    {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
