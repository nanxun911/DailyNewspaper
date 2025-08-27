//
//  ContentTableViewCell.m
//  Daily
//
//  Created by nanxun on 2024/10/21.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([reuseIdentifier isEqualToString:@"content"]) {
        self.mainLabel = [[UILabel alloc] init];
        self.mainLabel.numberOfLines = 2;
        self.mainLabel.font = [UIFont boldSystemFontOfSize:18];
        self.storyView = [[UIImageView alloc] init];
        self.storyView.layer.masksToBounds = YES;
        self.authorLabel = [[UILabel alloc] init];
        self.authorLabel.numberOfLines = 1;
        self.authorLabel.textColor = [UIColor colorWithRed:180 / 256.0 green:180 / 256.0 blue:180 / 256.0 alpha:1];
        self.authorLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_authorLabel];
        [self.contentView addSubview:_mainLabel];
        [self.contentView addSubview:_storyView];
    }
    return self;
}
- (void)layoutSubviews {
    [self.storyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.top.equalTo(self).offset(10);
    }];
    self.storyView.layer.cornerRadius = self.storyView.frame.size.width / 8;
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.storyView.mas_left).offset(-10);
        make.height.equalTo(@50);
        make.top.equalTo(self).offset(10);
    }];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.mainLabel.mas_bottom);
        make.bottom.equalTo(self).offset(-20);
        make.right.equalTo(self.storyView.mas_left).offset(-10);
    }];
}
@end
