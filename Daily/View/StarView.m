//
//  StarView.m
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import "StarView.h"

@implementation StarView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void) setUI {
    self.backgroundColor = UIColor.whiteColor;
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(self);
        make.top.equalTo(self).offset(103);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
