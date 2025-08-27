//
//  UITextView+JudgeHeight.h
//  Daily
//
//  Created by nanxun on 2024/11/5.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
NS_ASSUME_NONNULL_BEGIN

@interface UITextView (JudgeHeight)
//- (CGFloat)judgeHeight:(CGFloat)width;
- (NSString*)stringOfLine:(NSInteger)line;
- (BOOL)isLineFullyFilled:(NSString *)lineText;
-(BOOL)judgeHeight;
- (NSString*)stringByTruncatingString:(NSString *)str suffixStr:(NSString *)suffixStr font:(UIFont *)font forLength:(CGFloat)length;
- (BOOL)isLineFullyFilledWithPrecision:(NSString *)lineText;
- (NSString *)getLineStringAtLine:(NSUInteger)line;
- (int)getLinesWithLabelWidth:(CGFloat)width;
-(void)addSuffixString:(NSString*)suffixStr isOpne:(BOOL)isOpen;
- (NSString *)getTitle:(NSString *)content flagStr:(NSString *)flagStr;
- (NSString*) addTitle;
@end

NS_ASSUME_NONNULL_END
