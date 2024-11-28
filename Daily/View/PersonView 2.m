//
//  PersonView.m
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import "PersonView.h"

@implementation PersonView
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
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = UIColor.whiteColor;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@400);
        make.top.equalTo(self).offset(103);
    }];
    self.setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.setButton setTitle:@"设置" forState:UIControlStateNormal];
    [self.nightButton setTitle:@"夜间模式" forState:UIControlStateNormal];
    [self.setButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.nightButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
   
    [self addSubview:_setButton];
    [self addSubview:_nightButton];
    [self.setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.bottom.equalTo(self).offset(-40);
    }];
    [self.nightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(200);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.bottom.equalTo(self).offset(-40);
    }];
    [self.nightButton setImage:[UIImage imageNamed:@"yueliang.png"] forState:UIControlStateNormal];
    [self.setButton setImage:[UIImage imageNamed:@"shezhi-2.png"] forState:UIControlStateNormal];
    _setButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_setButton.imageView.frame.size.width, -_setButton.imageView.frame.size.height, 0);
    _setButton.imageEdgeInsets = UIEdgeInsetsMake(-_setButton.titleLabel.intrinsicContentSize.height, 0, 0, -_setButton.titleLabel.intrinsicContentSize.width);
    _nightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_nightButton.imageView.frame.size.width, -_nightButton.imageView.frame.size.height, 0);
    _nightButton.imageEdgeInsets = UIEdgeInsetsMake(-_nightButton.titleLabel.intrinsicContentSize.height, 0, 0, -_nightButton.titleLabel.intrinsicContentSize.width);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
