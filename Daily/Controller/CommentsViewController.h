//
//  CommentsViewController.h
//  Daily
//
//  Created by nanxun on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import "CommentsView.h"
#import "CommentsModel.h"
#import "CommentsTableViewCell.h"
#import "Manger.h"
#import "SDWebImage.h"
#import "NSDate+JudgeDay.h"
#import "UITextView+JudgeHeight.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (nonatomic, strong) CommentsView* iView;
//@property (nonatomic, strong) NSMutableArray<CommentsModel*>* LongCommentsAry;
//@property (nonatomic, strong) NSMutableArray<CommentsModel*>* shortCommentsAry;
@property (nonatomic, strong) CommentsModel* LongCommentsModel;
@property (nonatomic, strong) CommentsModel* shortCommentsModel;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary*>* heightAry;
@end

NS_ASSUME_NONNULL_END
