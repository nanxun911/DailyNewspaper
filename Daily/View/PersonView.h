//
//  PersonView.h
//  Daily
//
//  Created by nanxun on 2024/11/12.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonView : UIView
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIButton* setButton;
@property (nonatomic, strong) UIButton* nightButton;
@end

NS_ASSUME_NONNULL_END
