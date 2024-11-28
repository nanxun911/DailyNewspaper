//
//  ContentTableViewCell.h
//  Daily
//
//  Created by nanxun on 2024/10/21.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ContentTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContentTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView* storyView;
@property (nonatomic, strong) UILabel* mainLabel;
@property (nonatomic, strong) UILabel* authorLabel;

@end

NS_ASSUME_NONNULL_END
