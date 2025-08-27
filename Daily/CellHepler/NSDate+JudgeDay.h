//
//  NSDate+JudgeDay.h
//  Daily
//
//  Created by nanxun on 2024/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JudgeDay)
- (BOOL)isDateToday:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
