//
//  NSDate+JudgeDay.m
//  Daily
//
//  Created by nanxun on 2024/11/3.
//

#import "NSDate+JudgeDay.h"

@implementation NSDate (JudgeDay)
- (BOOL)isDateToday:(NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    return (components1.year == components2.year && components1.month == components2.month && components1.day == components2.day);
}
@end
