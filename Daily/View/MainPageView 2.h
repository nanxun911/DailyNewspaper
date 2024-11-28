//
//  MainPageView.h
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import <UIKit/UIKit.h>
#import "DataView.h"
#import "TopContentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainPageView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel* titleView;
@property (nonatomic, strong) DataView* dataView;
@property (nonatomic, strong) UIView* containView;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIPageControl* page;
@property (nonatomic, strong) UINavigationBarAppearance* apperance;
@property (nonatomic, strong) UIActivityIndicatorView* activity;
@property (nonatomic, strong) UIView* footerView;
@property (nonatomic, strong) UIView* headerView;
@property (nonatomic, strong) UIActivityIndicatorView* headActivity;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UIButton* rightButton;
//@property (nonatomic, strong) UIImageView* leftImageView;
//@property (nonatomic, strong) NSMutableArray<TopContentView*> *ContentViewArray;
-(void)setUI;
@end

NS_ASSUME_NONNULL_END
