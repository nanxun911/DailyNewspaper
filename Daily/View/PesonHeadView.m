//
//  PesonHeadView.m
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import "PesonHeadView.h"

@implementation PesonHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"WechatIMG17.jpg"];
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 50;
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont boldSystemFontOfSize:18];
        self.label.text = @"12314";
        [self addSubview:self.label];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(@100);
            make.width.equalTo(@100);
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(10);
            make.left.equalTo(self.imageView).offset(25);
            make.height.equalTo(@40);
            make.width.equalTo(@120);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
