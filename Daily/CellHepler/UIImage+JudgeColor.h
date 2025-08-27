//
//  UIImage+JudgeColor.h
//  Daily
//
//  Created by nanxun on 2024/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JudgeColor)
-(void)getSubjectColor:(void(^)(UIColor*))callBack;
@end

NS_ASSUME_NONNULL_END
