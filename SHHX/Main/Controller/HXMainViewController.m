
//
//  HXMainViewController.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/12.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "HXMainViewController.h"
#define DefultUser @"User20170330000001"
#import "HXModel.h"
#import "HXTableViewCell.h"

@interface HXMainViewController ()

@property (strong,nonatomic)NSString                         *hostApi;

@property (assign,nonatomic)BOOL                             isAuto;

@end

@implementation HXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
//    btn.selected = [[NSUserDefaults getUserDefaultObjectWithKey:@"isAutoLogin"] integerValue];
//    [btn setTitle:@"不自动" forState:UIControlStateNormal];
//    [btn setTitle:@"自动" forState:UIControlStateSelected];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//    [btn setImage:[UIImage imageNamed:@"ic_landing_microblog"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"ic_landing_microblog"] forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(clickSave:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem* rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//
//    self.navigationItem.rightBarButtonItem=rightButtonItem;
    
 
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = 110;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
//
//    self.hostApi = @"http://203.156.255.126:8101//api/CMS/PostInfo";
    [self startData];
    
    [self.tableView registerClass:[HXTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self startData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
    if (indexPath.row < self.listArray.count) {
        HXModel *model = self.listArray[indexPath.row];
        cell.imgStr = model.InfoCover;
        cell.sting = model.OwnerShow_rowNum;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (void)startData{

    [super startData];
    WJLog(@"------first------");
    WeakSelf;
    WJNetConfig *config = [WJNetConfig new];
    config.urlString = @"http://203.156.255.126:8101//api/CMS/PostInfo";
    config.params = @{@"PageCount":@"10",@"PageIndex":self.pageStr,@"UserID":DefultUser};
    config.isFirstCache = YES;
    [[WJNetworking new] getDataWithNetConfig:config success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            weakSelf.listArray = [HXModel modelWithDictionary:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

}

- (void)loadMoreData{

    [super loadMoreData];
    WJLog(@"------loadMoreData------");
    WeakSelf;
    [MBProgressHUD showOnlyLoadToView:[UIApplication sharedApplication].keyWindow];
    NSDictionary *dict = @{@"PageCount":@"10",@"PageIndex":self.pageStr,@"UserID":DefultUser,@"Type":@"1"};
    WJNetConfig *config = [WJNetConfig new];
    config.urlString = @"http://203.156.255.126:8101//api/CMS/PostInfo";
    config.params = dict;
    [[WJNetworking new] getDataWithNetConfig:config success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            weakSelf.loadMoreArray = [HXModel modelWithDictionary:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                WJLog(@"--------%ld",self.listArray.count);
                [weakSelf.tableView reloadData];
            });
        });

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
}

//- (void)Sucess:(id)response
//{
//    WJWeakSelf;
//    WJLog(@"%@",response);
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        self.listArray = [HXModel dictoryToModel:response];
//        dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//        });
//    });
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXModel *model = (HXModel *)obj;
        WJLog(@"%@",model.InfoTitle);
    }];
}

- (void)Failed:(NSString *)error tag:(NSString *)tag{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
    WJLog(@"error");
}

@end
