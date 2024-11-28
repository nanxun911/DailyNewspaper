//
//  MainPageViewController.h
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import <UIKit/UIKit.h>
#import "MainPageView.h"
#import "MainPageModel.h"
#import "Manger.h"
#import "DateModel.h"
#import "TopTableViewCell.h"
#import "Masonry.h"
#import "SDWebImage.h"
#import "HeadView.h"
#import "ContentTableViewCell.h"
#import "WebContentViewController.h"
#import "TopWebContentViewController.h"
#import "PersonViewController.h"
#import "StarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainPageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) MainPageView* iView;
@property (nonatomic, strong) NSMutableArray<MainPageModel*> *iModel;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) DateModel* dateModel;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) NSInteger nowPage;
@property (nonatomic, strong) WebContentViewController* webViewController;
@end

NS_ASSUME_NONNULL_END
