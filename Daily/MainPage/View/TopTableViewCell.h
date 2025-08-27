//
//  TopTableViewCell.h
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "TopContentView.h"
#import "SDWebImage.h"
#import "TopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopTableViewCell : UITableViewCell
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIPageControl* page;
@property (nonatomic, strong) NSMutableArray<TopContentView*> *ary;
- (void)setImageUrls:(NSArray<TopModel*>*) topModels;
@end

NS_ASSUME_NONNULL_END
