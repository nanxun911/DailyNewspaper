//
//  dataView.m
//  Daily
//
//  Created by nanxun on 2024/10/21.
//

#import "DataView.h"

@implementation DataView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mothLabel = [[UILabel alloc] init];
        self.dayLabel = [[UILabel alloc] init];
        self.mothLabel.font = [UIFont systemFontOfSize:14];
        self.dayLabel.font = [UIFont boldSystemFontOfSize:23];
        self.mothLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.mothLabel];
        [self.mothLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.and.right.equalTo(self);
            make.height.equalTo(@20);
        }];
        [self addSubview:self.dayLabel];
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.and.right.equalTo(self);
            make.bottom.equalTo(self.mothLabel.mas_top);
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
