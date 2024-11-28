//
//  WebContentView.m
//  Daily
//
//  Created by nanxun on 2024/10/26.
//

#import "WebContentView.h"

@implementation WebContentView
-(void)setUI {
    self.backgroundColor = UIColor.whiteColor;
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 140)];
    [self addSubview:_webView];
    
//    _bar = [[UIView alloc] init];
//    _bar.backgroundColor = [UIColor colorWithRed:246.0 / 256.0 green:246.0 / 256.0 blue:246.0 / 256.0 alpha:1];
//    [self addSubview:_bar];
//    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self).offset(-90);
//        make.left.equalTo(self);
//        make.right.equalTo(self);
//        make.height.equalTo(@50);
//    }];
//    
//    //设置工具栏
////    UIImageView* backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fanhui-3.png"]];
////    UIImageView* commentsView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pinglun.png"]];
////    UIImageView* loveView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dianzan.png"]];
////    UIImageView* uploadView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shangchuan-4.png"]];
////    UIImageView* starView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoucang-3.png"]];
//    
//    UIButton* back = [UIButton buttonWithType:UIButtonTypeCustom];
//    [back setImage:[UIImage imageNamed:@"fanhui-3.png"] forState:UIControlStateNormal];
//    [_bar addSubview:back];
//    [back mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(10);
//        make.width.equalTo(@30);
//        make.top.equalTo(_bar).offset(10);
//        make.height.equalTo(@30);
//    }];
//    UIButton* comment = [UIButton buttonWithType:UIButtonTypeCustom];
//    [comment setImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
//    [comment setTitle:@"123" forState:UIControlStateNormal];
//    [comment setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    [_bar addSubview:comment];
//    
//    comment.titleLabel.font = [UIFont systemFontOfSize:12];
//    [comment setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    comment.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, -10); // 图片稍微向左下角偏移
//    comment.titleEdgeInsets = UIEdgeInsetsMake(-20, 10, 0, 0);
//    
//    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(back.mas_right).offset(30);
//        make.width.equalTo(@70);
//        make.top.equalTo(_bar).offset(10);
//        make.height.equalTo(@40);
//    }];
//    
//    
//    UIButton* love = [UIButton buttonWithType:UIButtonTypeCustom];
//    [love setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
//    [_bar addSubview:love];
//    
//    love.titleLabel.font = [UIFont systemFontOfSize:12];
//    [love setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    love.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, -10); // 图片稍微向左下角偏移
//    love.titleEdgeInsets = UIEdgeInsetsMake(-20, 10, 0, 0);
//    
//    [love mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(comment.mas_right);
//        make.width.equalTo(@70);
//        make.top.equalTo(_bar).offset(10);
//        make.height.equalTo(@40);
//    }];
//    UIButton* upload = [UIButton buttonWithType:UIButtonTypeCustom];
//    //[upload addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
//    [upload setImage:[UIImage imageNamed:@"shangchuan-4.png"] forState:UIControlStateNormal];
//    [_bar addSubview:upload];
//    [upload mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(love.mas_right).offset(30);
//        make.width.equalTo(@30);
//        make.top.equalTo(_bar).offset(10);
//        make.height.equalTo(@30);
//    }];
//    UIButton* star = [UIButton buttonWithType:UIButtonTypeCustom];
//    [star setImage:[UIImage imageNamed:@"shoucang-3.png"] forState:UIControlStateNormal];
//    [_bar addSubview:star];
//    [star mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(upload.mas_right).offset(50);
//        make.width.equalTo(@30);
//        make.top.equalTo(_bar).offset(10);
//        make.height.equalTo(@30);
//    }];
//    UIView* view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithRed:246.0 / 256.0 green:246.0 / 256.0 blue:246.0 / 256.0 alpha:1];
//    [_bar addSubview:view];
//    //[self.navigationController.toolbar addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_bar.mas_bottom);
//        make.left.equalTo(self);
//        make.right.equalTo(self);
//        make.height.equalTo(@40);
//    }];
//    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(58, 10, 1, 34)];
//    lineView.backgroundColor = UIColor.blackColor;
//    [_bar addSubview:lineView];
    
    //[self.navigationController.toolbar addSubview:lineView];
//    UIImageView* lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vertical_line.png"]];
//    [backView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(backView);
//        make.top.equalTo(backView).offset(5);
//        make.bottom.equalTo(backView).offset(-5);
//        make.width.equalTo(@3);
//    }];
    
    
    
}
//-(void)press {
//    NSLog(@"12312312312312");
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setWebPoint:(NSUInteger)section {
    self.webView.frame = CGRectMake(self.bounds.size.width * section, 0, self.bounds.size.width, self.bounds.size.height - 140);
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
