//
//  TopContentView.h
//  Daily
//
//  Created by nanxun on 2024/10/22.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIImage+JudgeColor.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopContentView : UIView
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* authorLabel;
@property (nonatomic, strong) UIVisualEffectView* effectView;
@property (nonatomic, strong) UIView* backView;
// 在.h文件中添加属性
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
-(void)setImageColor;
@end

NS_ASSUME_NONNULL_END
