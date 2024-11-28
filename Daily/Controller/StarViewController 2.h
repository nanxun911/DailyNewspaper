//
//  StarViewController.h
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "StarTableViewCell.h"
#import "StarModel.h"
#import "SDWebImage.h"
#import "TopWebContentViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface StarViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) StarView* iView;
@property (nonatomic, strong) NSMutableArray<StarModel*>* iModel;
@end

NS_ASSUME_NONNULL_END
