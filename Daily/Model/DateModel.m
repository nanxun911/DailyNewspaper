//
//  DateModel.m
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import "DateModel.h"

@implementation DateModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nowDate = [NSDate date];
    }
    return self;
}
- (void)judgeTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    self.string = [dateFormatter stringFromDate:self.nowDate];
    if ([self.string intValue] > 0 && [self.string intValue] < 6) {
        self.string = @"  早点休息";
    } else if ([self.string intValue] > 6 && [self.string intValue] < 12) {
        self.string = @"  早上好";
    } else if ([self.string intValue] > 12 && [self.string intValue] < 18) {
        self.string = @"  中午好";
    } else {
        self.string = @"  晚上好";
    }
}
- (void)judgeDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString* str0 = [dateFormatter stringFromDate:self.nowDate];
    NSString* str = [str0 substringWithRange: NSMakeRange(0, 2)];
    NSDictionary* monthDicty = @{@"01":@"正月",@"02":@"杏月",@"03":@"桃月",@"04":@"槐月",@"05":@"榴月",@"06":@"荷月",@"07":@"霜月",@"08":@"桂月",@"09":@"玄月",@"10":@"阳月",@"11":@"冬月",@"12":@"腊月"};
    //    NSDictionary* dataDicty = @{@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六",@"7":@"七",@"8":@"八",@"9":@"九"};
    NSString* str2 = [str0 substringWithRange: NSMakeRange(3, 1)];
    NSString* str3 = [str0 substringWithRange:NSMakeRange(4, 1)];
    self.monthString = [monthDicty[str] copy];
    self.dateString = [NSString stringWithFormat:@"%@%@", str2, str3];
    self.date = [NSString stringWithFormat:@"%@%@", str2, str3];
    self.month = [str copy];
    self.headString = [NSString stringWithFormat:@"2024%@%@%@", str, str2, str3];
}
- (NSMutableArray*)yesterDay:(NSInteger) section {
    NSInteger dateNum = [self.date intValue];
    NSInteger monthNum = [self.month intValue];
    if (dateNum - section <= 0) {
        
    }
    NSString* dateStr = [NSString stringWithFormat:@"%ld", dateNum - section];
    NSString* monthStr = [NSString stringWithFormat:@"%ld", monthNum];
    return [NSMutableArray arrayWithArray:@[dateStr, monthStr]];
}
- (NSString*)computingTime:(NSString*)nowString andDay:(NSInteger)date {
    NSInteger day = [nowString integerValue] % 100;
    NSInteger month = [nowString integerValue] / 100 % 100;
    NSInteger year = [nowString integerValue] / 10000;
    NSDictionary* timeDictionary = @{@1:@31, @2:@28, @3:@31, @4:@30, @5:@31, @6:@30, @7:@31, @8:@31, @9:@30, @10:@31, @11:@30, @12:@31};
    //NSLog(@"%ld", year);
    while (day - date <= 0 && month > 1) {
        month -= 1;
        day = [timeDictionary[[NSNumber numberWithInteger:month]] integerValue] + (day - date);
        date -= [timeDictionary[[NSNumber numberWithInteger:month + 1]] integerValue];
    }
    while (month <= 1 && day - date <= 0) {
        year -= 1;
        month = 12;
        date = date - day;
        day = 31;
        while (day - date <= 0 && month > 1) {
            NSLog(@"1222");
            month -= 1;
            date = date - day;
            if (date < 0) {
                day -= date;
            } else {
                day = [timeDictionary[[NSNumber numberWithInteger:month]] integerValue];
            }
        }
    }
    if (day > date && date > 0) {
        day -= date;
    }
    NSString* string = [NSString stringWithFormat:@"%ld%02ld%02ld", year, month, day];
    return string;
}
@end
