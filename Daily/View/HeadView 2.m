//
//  HeadView.m
//  Daily
//
//  Created by nanxun on 2024/10/23.
//

#import "HeadView.h"

@implementation HeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor colorWithRed:180 / 256.0 green:180 / 256.0 blue:180 / 256.0 alpha:1];
        self.label.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:self.lineView];
        [self addSubview:self.label];
        //NSLog(@"%ld", self.subviews.count);
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.width.equalTo(@90);
            make.left.equalTo(self).offset(20);
            make.height.equalTo(@30);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label.mas_centerY);
            make.right.equalTo(self).offset(-10);
            make.left.equalTo(self.label.mas_right);
            make.height.equalTo(@1);
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
