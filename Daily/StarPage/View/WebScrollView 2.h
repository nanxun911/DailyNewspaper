//
//  WebScrollView.h
//  Daily
//
//  Created by nanxun on 2024/10/29.
//

#import <UIKit/UIKit.h>
#import "WebContentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WebScrollView : UIView
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) WebContentView* webContentView;
@property (nonatomic, strong) UIView* bar;
-(void)setWebPoint:(NSUInteger)section;
-(void)setScrollContent:(NSUInteger)count;
@end

NS_ASSUME_NONNULL_END
