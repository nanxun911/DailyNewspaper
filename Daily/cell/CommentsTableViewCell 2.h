//
//  CommentsViewTableViewCell.h
//  Daily
//
//  Created by nanxun on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsTableViewCell : UITableViewCell
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIImageView* image;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UITextView* commentText;
@property (nonatomic, strong) UIButton* likeButton;
@property (nonatomic, strong) UIButton* commentButton;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UILabel* headLabel;
//@property (nonatomic, assign) BOOL isOpen;
@end

NS_ASSUME_NONNULL_END
