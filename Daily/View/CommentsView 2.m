//
//  CommentsView.m
//  Daily
//
//  Created by nanxun on 2024/10/31.
//

#import "CommentsView.h"

@implementation CommentsView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void) setUI {
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor = UIColor.whiteColor;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    label.text = @"已显示全部评论";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.lightGrayColor;
    self.tableView.tableFooterView = label;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
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
