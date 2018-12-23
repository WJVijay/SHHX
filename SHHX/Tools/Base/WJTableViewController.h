//
//  WJTableViewController.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJBaseViewController.h"
#import "UIScrollView+EmptyDataSet.h"

//设置空白页的样式类型
typedef NS_ENUM(NSInteger, EmptyDataStyle) {
    
    EmptyDataTypeImageTitleContentV,  //图片标题内容
};


//设置空白页的图片类型
typedef NS_ENUM(NSInteger, EmptyDataImageType) {
    
    EmptyDataImageTypeOne,
};

@interface WJTableViewController : WJBaseViewController <UITableViewDelegate,UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

//空白页状态(常态和加载中)
@property (nonatomic, getter=isLoading) BOOL                    loading;
//网络类型
@property (assign,nonatomic) NSInteger                          networkingType;
//空白页w样式
@property (assign,nonatomic) EmptyDataStyle                     emptyDataStyle;
//是否有上拉加载更多
@property (assign,nonatomic,getter=isMJLoadMore) BOOL           isMJLoadMore;

@property ( strong, nonatomic) UITableView                      *tableView;
//数据源
@property ( strong, nonatomic) NSArray                          *listArray;
//下拉加载获得的数据源
@property (strong,nonatomic) NSArray                            *loadMoreArray;

@property (copy  ,nonatomic)NSString                            *pageStr;

//系统cell标识
@property ( copy, nonatomic) NSString                           *defaultCellIndentifier;
//注册单个cell的标识
@property(copy,nonatomic)NSString                               *cellIdentifier;
//注册多个cell的标识
@property(strong,nonatomic)NSArray                              *cellIdentifiers;

- (void)startData __attribute__((objc_requires_super));
- (void)loadMoreData __attribute__((objc_requires_super));

////数据小于10条隐藏 tap or pull to load more
//- (void)hideMJFooter;

// 网络请求回调后调用刷新空白页
- (void)reloadEmptyDate;

/**
 赋值注册cell
 
 @param cellName cell
 @param selfClass 控制器
 */
- (void)registCellWithCellName:(NSString *)cellName WithSelf:(Class)selfClass;

/**
 注册多个cell
 
 @param cellName cell数组
 @param selfClass 控制器
 */
- (void)registCellWithcellNameArr:(NSArray <NSString *>*)cellName WithSelf:(Class)selfClass;

@end
