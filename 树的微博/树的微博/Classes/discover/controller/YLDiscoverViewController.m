//
//  YLDiscoverViewController.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLDiscoverViewController.h"
#import "YLSearchBar.h"
#import "YLLoopScrollView.h"
#import "YLHotTopicView.h"
#import "YLDiscoverTableViewCell.h"
#import "YLDiscoverTableViewCellModel.h"

@interface YLDiscoverViewController ()

@property (nonatomic, strong) NSMutableArray <NSMutableArray *> *dataSource;

@end

@implementation YLDiscoverViewController

- (NSMutableArray <NSMutableArray *> *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DiscoverTableViewCell" ofType:@"plist"];
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
    
    YLSearchBar *searchBar = [[YLSearchBar alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    [self.navigationController.navigationBar addSubview:searchBar];
    
    [self setupHeaderView];
}
#pragma mark 设置 tableview 的头视图
- (void)setupHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    CGFloat margin = 10;
    CGFloat loopScrollViewH = 100;
    CGFloat hotTopicViewH = 80;
    
    NSArray *adUrls = @[@"http://ww3.sinaimg.cn/large/8ffeeb91jw1f06442gzn2j20hs05k3z8.jpg",
                        @"http://pica.nipic.com/2008-06-13/2008613185412196_2.jpg",
                        @"http://www.shanlink.com/uploadfile/wangyi/20140411/6597268778261229182.jpg"];
    YLLoopScrollView *loopScrollView = [[YLLoopScrollView alloc] initWithImageUrlsSource:adUrls placeholderImage:[UIImage imageNamed:@"weibo_helper_group_feed_picture"]];
    loopScrollView.frame = CGRectMake(0, margin, self.view.width, loopScrollViewH);
    loopScrollView.pageControlCurrentPageColor = OrangeColor;
    [loopScrollView startTimer];
    [headerView addSubview:loopScrollView];
    
    YLHotTopicView *hotTopicView = [[YLHotTopicView alloc] init];
    hotTopicView.frame = CGRectMake(0, CGRectGetMaxY(loopScrollView.frame) + margin, self.view.width, hotTopicViewH);
    hotTopicView.titles = @[@"#车内自拍#", @"#朕不许你#", @"#太子妃升职记#", @"热门话题"];
    [headerView addSubview:hotTopicView];
    
    headerView.frame = CGRectMake(0, 0, self.view.width, CGRectGetMaxY(hotTopicView.frame));
    headerView.backgroundColor = RGBA(240, 240, 240, 1);
    self.tableView.tableHeaderView = headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLDiscoverTableViewCell *cell = [YLDiscoverTableViewCell cellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.section][indexPath.row];
    return cell;
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
