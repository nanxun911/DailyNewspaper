//
//  StarTableViewCell.m
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import "StarTableViewCell.h"

@implementation StarTableViewCell

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
    if ([reuseIdentifier isEqualToString:@"star"]) {
        self.label = [[UILabel alloc] init];
        self.rightView = [[UIImageView alloc] init];
        self.label.font = [UIFont boldSystemFontOfSize:18];
        self.label.numberOfLines = 2;
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.rightView];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@280);
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10);
            make.height.equalTo(@80);
        }];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@70);
            make.height.equalTo(@70);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(5);
        }];
    }
    return self;
}
-(void)layoutSubviews {
    
}
@end
