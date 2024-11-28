//
//  DateModel.h
//  Zhihu Daily
//
//  Created by nanxun on 2024/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateModel : NSObject
@property (nonatomic, strong) NSDate* nowDate;
@property (nonatomic, copy) NSString* dateString;
@property (nonatomic, copy) NSString* monthString;
@property (nonatomic, copy) NSString* string;
@property (nonatomic, copy) NSString* headString;
@property (nonatomic, copy) NSString* month;
@property (nonatomic, copy) NSString* date;
- (void)judgeDate;
- (void)judgeTime;
- (NSMutableArray*)yesterDay:(NSInteger) section;
- (NSString*)computingTime:(NSString*)nowString andDay:(NSInteger)date;
@end

NS_ASSUME_NONNULL_END
