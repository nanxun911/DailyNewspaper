//
//  PersonViewController.h
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import <UIKit/UIKit.h>
#import "PersonView.h"
#import "StarViewController.h"
#import "PesonHeadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PersonView* iView;
@end

NS_ASSUME_NONNULL_END
