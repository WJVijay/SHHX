//
//  WJTableViewController.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJTableViewController.h"
//#import "WJDefineHeader.h"
//#import "UITableView+WJCategory.h"
//#import <MJRefresh.h>

//屏幕宽高
#define kSCREENWIDTH_WJTableViewController [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT_WJTableViewController [UIScreen mainScreen].bounds.size.height

@interface WJTableViewController ()

@property(strong,nonatomic)NSMutableArray                *rCellIdentifers;

@end

static NSString *defaultCellIndentifier = @"UITableViewCell";

@implementation WJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageStr = @"0";
  
}

- (void)startData{
    
    [self.tableView.mj_footer resetNoMoreData];
    self.listArray = @[];
}

- (void)loadMoreData{
    
    WJLog(@"------super-loadMoreData------");
    if (self.listArray.count%10==0) {
        self.pageStr= [NSString stringWithFormat:@"%ld",self.listArray.count/10];
    }else{
        self.pageStr=[NSString stringWithFormat:@"%ld",self.listArray.count/10+1];
    }
}

- (void)setLoadMoreArray:(NSArray *)loadMoreArray{
    
    _loadMoreArray = loadMoreArray;
    if (_loadMoreArray.count != 0) {
        NSMutableArray *mulArray = [NSMutableArray arrayWithArray:self.listArray];
        [_loadMoreArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mulArray addObject:obj];
        }];
        self.listArray = mulArray;
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}


- (void)reloadEmptyDate{
    [self.tableView reloadEmptyDataSet];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSIndexPath *path =  [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];

}

#pragma mark -tableViewDelegate&&dataSource-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIndentifier];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellIndentifier];
    }
    
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGFLOAT_MIN;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [self.tableView scrollsToTop];
//}

#pragma mark - DZNEmptyDataSetSource Methods

/**
 空状态标题的属性字符串：

 @param scrollView scrollView description
 @return return value description
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    text = @"暂无数据！";//";
    font = [UIFont boldSystemFontOfSize:17.0];
    textColor = [UIColor lightGrayColor];//[UIColor blueColor];
    //    switch (self.type) {
    //        case Home:
    //        {
    //            text = @"No Photos";
    //            font = [UIFont boldSystemFontOfSize:17.0];
    //            textColor = [UIColor colorWithHexString:@"#545454"];
    //            break;
    //        }
    //            break;
    //
    //        default:
    //            return nil;
    //    }
    if (!text) {
        return nil;
    }
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


/**
 空状态描述的属性字符串：

 @param scrollView scrollView description
 @return return value description
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
//    switch (self.type) {
//        case Home:
//        {
//            text = @"";//@"Get started by uploading a photo.";
//            font = [UIFont boldSystemFontOfSize:15.0];
//            textColor = [UIColor colorWithHexString:@"#545454"];
//            break;
//        }
//        default:
//            return nil;
//    }
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedString;
}


/**
 返回要在空状态下显示的内容，并利用NSAttributedString功能自定义文本外观。
 
 空状态的图像：

 @param scrollView scrollView description
 @return return value description
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        return [UIImage imageNamed:@"nodata"];
    }else{
        return [UIImage imageNamed:@"nodata"];
    }
}


///**
// 图像视图动画
//
// @param scrollView scrollView description
// @return return value description
// */
//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
//{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
//    animation.duration = 0.25;
//    animation.cumulative = YES;
//    animation.repeatCount = MAXFLOAT;
//    
//    return animation;
//}


/**
 用于指定按钮状态的属性字符串：

 @param scrollView scrollView description
 @param state state description
 @return return value description
 */
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSString *text = nil;
//    UIFont *font = nil;
//    UIColor *textColor = nil;
//    switch (1) {
//        case 1:
//        {
//            text = @"";//@"Start Browsing";
//            font = [UIFont boldSystemFontOfSize:16.0];
//            textColor = [UIColor colorWithHexString:(state == UIControlStateNormal) ? @"05adff" : @"6bceff"];
//            break;
//        }
//        default:
//            return nil;
//    }
//    if (!text) {
//        return nil;
//    }
//
//    NSMutableDictionary *attributes = [NSMutableDictionary new];
//    if (font) [attributes setObject:font forKey:NSFontAttributeName];
//    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}


/**
 在空状态下按钮对于状态的背景颜色

 @param scrollView scrollView description
 @param state state description
 @return return value description
 */
//- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSString *imageName = @"123";
//    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
//
//    switch (1) {
//        case 1:
//            capInsets = UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0);
//            rectInsets = UIEdgeInsetsMake(0.0, 10, 0.0, 10);
//            break;
//        default:
//            break;
//    }
//    return [[[UIImage imageNamed:imageName] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
//}


/**
 空状态的背景颜色：

 @param scrollView scrollView description
 @return return value description
 */
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    switch (1) {
        case 1:
            return [UIColor whiteColor];//[UIColor colorWithHexString:@"34465c"];
            
        default:
            return nil;
    }
}


/**
 调整内容视图的垂直对齐方式（即：当tableHeaderView可见时非常有用）：

 @param scrollView scrollView description
 @return return value description
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    if (/* DISABLES CODE */ (1)) {
        CGFloat offset = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        offset += CGRectGetHeight(self.navigationController.navigationBar.frame);
        return -offset;
    }
    if (0) {
        return -roundf(self.tableView.frame.size.height/2.5);
    }
    return 0.0;
}

/**
 将组件彼此分开（默认分隔为11分）

 @param scrollView scrollView description
 @return return value description
 */
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 15;
}


- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    
    _loading = loading;
    
    [self.tableView reloadEmptyDataSet];
}


#pragma mark - DZNEmptyDataSetDelegate Methods
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}

//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
//{
//    self.loading = YES;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//        [self startData];
//    });
//
//}

//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
//{
//    self.loading = YES;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//        [self startData];
//    });
//}


#pragma mark -customMthod-
- (void)registCellWithcellNameArr:(NSArray <NSString *>*)cellName WithSelf:(Class)selfClass{
    
    if (cellName.count != 0 && selfClass) {
        
        for (int i = 0; i < cellName.count; i ++) {
            
            NSString *identifier = NSStringFromClass(selfClass);
            NSString *identifierStr = [NSString stringWithFormat:@"%@%d",identifier,0x10+i];
            [self.rCellIdentifers addObject:identifierStr];
            NSString *className = cellName[i];
            Class class = NSClassFromString(className);
            if (class) {
                [self.tableView registerClass:class forCellReuseIdentifier:identifierStr];
            }
        }
        
        self.cellIdentifiers = self.rCellIdentifers.copy;
    }
}

- (void)registCellWithCellName:(NSString *)cellName WithSelf:(Class)selfClass{
    
    if (cellName.length != 0 && selfClass) {
        
        NSString *identifierStr = NSStringFromClass(selfClass);
        self.cellIdentifier = identifierStr;
        Class class = NSClassFromString(cellName);
        if (class) {
            [self.tableView registerClass:class forCellReuseIdentifier:identifierStr];
        }
    }
}

- (NSString *)defaultCellIndentifier{
    
    return defaultCellIndentifier;
}

- (NSMutableArray *)rCellIdentifers{
    
    if (_rCellIdentifers == nil) {
        _rCellIdentifers = [NSMutableArray array];
    }
    return _rCellIdentifers;
}

- (NSArray *)listArray
{
    if (!_listArray) {
        self.listArray = [NSArray array];
    }
    return _listArray;
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        CGFloat marigin = 5;
        if (kIs_iPhoneX) {
            marigin = 48;
        }
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.navigationController.navigationBar.frame)-marigin) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startData)];
        MJRefreshAutoGifFooter *mj_footer = [MJRefreshAutoGifFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [mj_footer setTitle:@"全部加载完毕" forState:MJRefreshStateNoMoreData];
        _tableView.mj_footer = mj_footer;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGFLOAT_MIN)];;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, CGFLOAT_MIN)];
    }
    return _tableView;
}


@end
