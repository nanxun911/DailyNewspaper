//
//  WebContentView.h
//  Daily
//
//  Created by nanxun on 2024/10/26.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "NewsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WebContentView : UIView
@property (nonatomic, strong) WKWebView* webView;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, copy) NSArray* ary;
@property (nonatomic, strong) UIView* bar;
-(void)setWebPoint:(NSUInteger)section;
-(void)setScrollContent:(NSUInteger)count;
@end

NS_ASSUME_NONNULL_END
