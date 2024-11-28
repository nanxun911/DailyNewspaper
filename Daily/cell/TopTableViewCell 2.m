//
//  TopTableViewCell.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "TopTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation TopTableViewCell

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
    if ([reuseIdentifier isEqualToString:@"scrollView"]) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH - 20)];
        self.scrollView.contentSize = CGSizeMake(WIDTH * 7, WIDTH - 20);
        [self.scrollView setContentOffset:CGPointMake(WIDTH, 0)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.tag = 100;
        self.ary = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            TopContentView* iView = [[TopContentView alloc] initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, WIDTH)];
            [self.ary addObject:iView];
            [self.scrollView addSubview:iView];
        }
//        self.page = [[UIPageControl alloc] init];
//        self.page.numberOfPages = 7;
//        self.page.currentPage = 0;
//        self.page.tintColor = UIColor.grayColor;
//        self.page.currentPageIndicatorTintColor = UIColor.whiteColor;
        [self.contentView addSubview:self.scrollView];
        [self.contentView addSubview:self.page];
    }
    return self;
}
- (void)setImageUrls:(NSMutableArray<TopModel*>*) topModels {
    for (int i = 0; i < self.ary.count; i++) {
        TopContentView* iView = self.ary[i];
        if (i == 0) {
            TopModel* topModel = topModels[topModels.count - 1];
            //NSLog(@"%@", topModel.title);
            //NSLog(@"%@", scrollViewCell.scrollView.subviews[i + 2]);
            //TopContentView* iView = scrollViewCell.scrollView.subviews[i + 2];
            [iView.imageView sd_setImageWithURL:[NSURL URLWithString:topModel.image]placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [iView setImageColor];
            }];
            //UIColor* color = [iView averageColorFromImage:iView.imageView.image];
            //[iView applyCustomBlurEffectWithColorOverlayToImage:iView.imageView.image inView:iView];
            iView.titleLabel.text = [topModel.title copy];
            iView.authorLabel.text = [topModel.hint copy];
        } else if (i == self.ary.count - 2) {
            TopModel* topModel = topModels[i - 1];
            //NSLog(@"%@", topModel.title);
            //NSLog(@"%@", scrollViewCell.scrollView.subviews[i + 2]);
            //TopContentView* iView = scrollViewCell.scrollView.subviews[i + 2];
            [iView.imageView sd_setImageWithURL:[NSURL URLWithString:topModel.image]placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [iView setImageColor];
            }];

            //UIColor* color = [iView averageColorFromImage:iView.imageView.image];
            //[iView applyCustomBlurEffectWithColorOverlayToImage:iView.imageView.image inView:iView];
            iView.titleLabel.text = [topModel.title copy];
            iView.authorLabel.text = [topModel.hint copy];
        } else {
            TopModel* topModel = topModels[i % 5 - 1];
            //NSLog(@"%@", topModel.title);
            //NSLog(@"%@", scrollViewCell.scrollView.subviews[i + 2]);
            //TopContentView* iView = scrollViewCell.scrollView.subviews[i + 2];
            [iView.imageView sd_setImageWithURL:[NSURL URLWithString:topModel.image]placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [iView setImageColor];
            }];
            //UIColor* color = [iView averageColorFromImage:iView.imageView.image];
            //[iView applyCustomBlurEffectWithColorOverlayToImage:iView.imageView.image inView:iView];
            iView.titleLabel.text = [topModel.title copy];
            iView.authorLabel.text = [topModel.hint copy];
        }
    }
}
- (void)layoutSubviews {
//    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@100);
//        make.bottom.equalTo(self).offset(-20);
//        make.right.equalTo(self).offset(-40);
//        make.height.equalTo(@20);
//    }];
}
@end
