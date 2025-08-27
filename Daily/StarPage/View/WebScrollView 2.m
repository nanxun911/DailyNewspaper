//
//  WebScrollView.m
//  Daily
//
//  Created by nanxun on 2024/10/29.
//

#import "WebScrollView.h"

@implementation WebScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        //[self.scrollView addSubview:_webView];
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, 0);
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:_webContentView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.webContentView = [[WebContentView alloc] initWithFrame:self.bounds];
        [self.scrollView addSubview:self.webContentView];
        
        _bar = [[UIView alloc] init];
        _bar.backgroundColor = [UIColor colorWithRed:246.0 / 256.0 green:246.0 / 256.0 blue:246.0 / 256.0 alpha:1];
        [self addSubview:_bar];
        [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-30);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@50);
        }];
        
        //设置工具栏
    //    UIImageView* backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fanhui-3.png"]];
    //    UIImageView* commentsView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pinglun.png"]];
    //    UIImageView* loveView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dianzan.png"]];
    //    UIImageView* uploadView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shangchuan-4.png"]];
    //    UIImageView* starView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoucang-3.png"]];
        
        UIButton* back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setImage:[UIImage imageNamed:@"fanhui-3.png"] forState:UIControlStateNormal];
        [_bar addSubview:back];
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@30);
            make.top.equalTo(_bar).offset(10);
            make.height.equalTo(@30);
        }];
        UIButton* comment = [UIButton buttonWithType:UIButtonTypeCustom];
        [comment setImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
        [comment setTitle:@"123" forState:UIControlStateNormal];
        [comment setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_bar addSubview:comment];
        
        comment.titleLabel.font = [UIFont systemFontOfSize:12];
        [comment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        comment.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, -10); // 图片稍微向左下角偏移
        comment.titleEdgeInsets = UIEdgeInsetsMake(-30, 20, 0, 0);
        
        [comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back.mas_right).offset(30);
            make.width.equalTo(@70);
            make.top.equalTo(_bar).offset(10);
            make.height.equalTo(@40);
        }];
        
        
        UIButton* love = [UIButton buttonWithType:UIButtonTypeCustom];
        [love setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
        [love setImage:[UIImage imageNamed:@"dianzan-3.png"] forState:UIControlStateSelected];
        [_bar addSubview:love];
        
        love.titleLabel.font = [UIFont systemFontOfSize:12];
        [love setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        love.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, -10); // 图片稍微向左下角偏移
        love.titleEdgeInsets = UIEdgeInsetsMake(-30, 20, 0, 0);
        
        [love mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(comment.mas_right);
            make.width.equalTo(@70);
            make.top.equalTo(_bar).offset(10);
            make.height.equalTo(@40);
        }];
        UIButton* upload = [UIButton buttonWithType:UIButtonTypeCustom];
        //[upload addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
        [upload setImage:[UIImage imageNamed:@"shangchuan-4.png"] forState:UIControlStateNormal];
        [_bar addSubview:upload];
        [upload mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(love.mas_right).offset(30);
            make.width.equalTo(@30);
            make.top.equalTo(_bar).offset(10);
            make.height.equalTo(@30);
        }];
        UIButton* star = [UIButton buttonWithType:UIButtonTypeCustom];
        [star setImage:[UIImage imageNamed:@"shoucang-3.png"] forState:UIControlStateNormal];
        [star setImage:[UIImage imageNamed:@"shoucang-4.png"] forState:UIControlStateSelected];
        [_bar addSubview:star];
        [star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(upload.mas_right).offset(50);
            make.width.equalTo(@30);
            make.top.equalTo(_bar).offset(10);
            make.height.equalTo(@30);
        }];
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:246.0 / 256.0 green:246.0 / 256.0 blue:246.0 / 256.0 alpha:1];
        [_bar addSubview:view];
        //[self.navigationController.toolbar addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bar.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@40);
        }];
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(58, 10, 1, 34)];
        lineView.backgroundColor = UIColor.blackColor;
        [_bar addSubview:lineView];
    }
    return self;
}
-(void)setWebPoint:(NSUInteger)section {
    self.webContentView.frame = CGRectMake(self.bounds.size.width * section, 0, self.bounds.size.width, self.bounds.size.height);
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * section, 0)];
}
-(void)setScrollContent:(NSUInteger)count {
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * count, 0);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
