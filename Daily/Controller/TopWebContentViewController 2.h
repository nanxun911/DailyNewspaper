//
//  TopWebContentViewController.h
//  Daily
//
//  Created by nanxun on 2024/10/28.
//

#import <UIKit/UIKit.h>
#import "WebContentView.h"
#import "WebScrollView.h"
#import "Manger.h"
#import "NewsModel.h"
#import "CommentsViewController.h"
#import "DataBaseManger.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopWebContentViewController : UIViewController<UIScrollViewDelegate, WKNavigationDelegate>
@property (nonatomic, assign) NSInteger webId;
@property (nonatomic, strong) WebScrollView* iView;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) NSMutableArray<NSNumber*> *ary;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSMutableSet* webSet;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, strong) NSMutableString* dateString;
@property (nonatomic, strong) UIView* toolView;
@property (nonatomic, strong) NSMutableDictionary *newsModel;
@end

NS_ASSUME_NONNULL_END
