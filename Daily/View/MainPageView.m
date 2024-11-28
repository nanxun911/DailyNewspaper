//
//  MainPageView.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "MainPageView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation MainPageView
- (void)setUI {
    self.backgroundColor = UIColor.whiteColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //self.tableView.bounces = NO;
    self.tableView.tag = 101;
    [self addSubview:self.tableView];
    //UIRefreshControl* refersh = [[UIRefreshControl alloc] init];
//    self.tableView.refreshControl = refersh;
    self.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 60)];
    //[self.tableView addSubview:refersh];
    
    self.headActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    [self.headerView addSubview:self.headActivity];
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    [self.footerView addSubview:self.activity];
    
    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.footerView);
    }];
    [self.headActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headerView);
    }];
    
    self.titleView.backgroundColor = UIColor.whiteColor;
    self.titleView.font = [UIFont boldSystemFontOfSize:24];
    UIImageView* iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vertical_line.png"]];
    iView.frame = CGRectMake(0, 0, 10, 40);
    [self.titleView addSubview:iView];
    //self.titleView.font = [UIFont boldSystemFontOfSize:20];
    //[self addSubview:self.titleView];
    self.titleView.textColor = UIColor.blackColor;
    //self.titleView.font = [UIFont systemFontOfSize:18];
    self.titleView.textAlignment = NSTextAlignmentLeft;
    self.dataView = [[DataView alloc] initWithFrame:CGRectMake(0, 0, 48, 60)];
    self.page = [[UIPageControl alloc] init];
    self.page.numberOfPages = 5;
    self.page.tintColor = UIColor.grayColor;
    self.page.currentPageIndicatorTintColor = UIColor.whiteColor;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG17.jpg"]];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = CGRectMake(0, 0, 40, 40);
    self.imageView.layer.cornerRadius = self.bounds.size.width / 2;
    self.imageView.clipsToBounds = YES;
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:[UIImage imageNamed:@"WechatIMG17.jpg"] forState:UIControlStateNormal];
        
        // 设置按钮的内容模式
    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.rightButton.clipsToBounds = YES; // 确保按钮的内容不超出边界
    self.rightButton.layer.masksToBounds = YES;
        // 使用 Auto Layout 设置按钮大小
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightButton.widthAnchor constraintEqualToConstant:40].active = YES; // 设置宽度
    [self.rightButton.heightAnchor constraintEqualToConstant:40].active = YES; // 设置高度
    self.rightButton.layer.cornerRadius = 20;
        
        // 添加点击事件
    //[avatarButton addTarget:self action:@selector(avatarButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(self);
    }];
    //设置导航栏
    self.apperance = [[UINavigationBarAppearance alloc] init];
    _apperance.backgroundColor = UIColor.whiteColor;
    _apperance.shadowColor = nil;
    _apperance.shadowImage = [[UIImage alloc] init];
    //self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //[self.containView addSubview:_containView];
    self.backgroundColor = UIColor.whiteColor;
    [self.tableView addSubview:self.page];
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@360);
        make.right.equalTo(self.mas_right).offset(-5);
        make.width.equalTo(@180);
        make.height.equalTo(@40);
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void) setMyScrollView {
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
