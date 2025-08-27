//
//  UITextView+JudgeHeight.m
//  Daily
//
//  Created by nanxun on 2024/11/5.
//

#import "UITextView+JudgeHeight.h"

@implementation UITextView (JudgeHeight)
- (NSString*)stringOfLine:(NSInteger)line {
    NSString *text = self.text;
    NSLayoutManager *layoutManager = self.layoutManager;
    NSTextContainer *textContainer = self.textContainer;
    NSRange lineRange = NSMakeRange(0, 0);
    NSUInteger index = 0;
    NSUInteger numberOfLines = 0;
    // 遍历所有行
    while (index < layoutManager.numberOfGlyphs) {
        [layoutManager lineFragmentRectForGlyphAtIndex:index
                                        effectiveRange:&lineRange];
        if (numberOfLines == line) {
            // 获取指定行的文本
            return [text substringWithRange:lineRange];
        }
        index = NSMaxRange(lineRange);
        numberOfLines++;
    }
    return nil;
}
- (BOOL)isLineFullyFilled:(NSString*) lineText {
    NSTextContainer *textContainer = self.textContainer;
    //CGFloat availableWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2;
    
    NSDictionary *attributes = @{
        NSFontAttributeName: self.font
    };
    
    CGFloat availableWidth = [lineText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attributes
                                                context:nil].size.width;
    
    // 添加一个小的容差值，避免浮点数比较的精度问题
    CGFloat tolerance = 1.0;
    NSLog(@"%lf %lf", self.contentSize.width, availableWidth);
    return self.contentSize.width >= (availableWidth - tolerance);
}
- (BOOL)judgeHeight {
    NSUInteger nums = 2;  // 限制的最大行数
    NSString *string = @"计算行高";  // 用于计算单行高度的样本字符串

    CGFloat width = self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - self.textContainer.lineFragmentPadding * 2;

    if (self.text.length == 0) {
        return NO;
    }

    // 实际内容高度
    CGFloat titleActualHeight = [self.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName: self.font}
                                                        context:nil].size.height;

    // 单行高度
    CGFloat singleLineHeight = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName: self.font}
                                                    context:nil].size.height;

    // 最大允许的高度
    CGFloat titleMaxHeight = singleLineHeight * nums;


    return titleActualHeight > titleMaxHeight;
}
- (int)getLinesWithLabelWidth:(CGFloat)width {
    return (int)[self getLinesArrayOfStringWidth:(self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - self.textContainer.lineFragmentPadding * 2)].count;
}
- (NSArray *)getLinesArrayOfStringWidth:(CGFloat)width {
    NSString *text = [self text];
    UIFont *font = [self font];
    if (text == nil) {
        return nil;
    }
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:(NSString *)kCTFontAttributeName
                   value:(__bridge  id)myFont
                   range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}


- (NSString *)stringByTruncatingString:(NSString *)str suffixStr:(NSString *)suffixStr font:(UIFont *)font forLength:(CGFloat)length {
    if (!str || ![str isKindOfClass:[NSString class]] || !suffixStr || !font) {
        return nil;
    }

    // 获取原字符串宽度
    CGSize originalSize = [str sizeWithAttributes:@{NSFontAttributeName: font}];
    if (originalSize.width <= length) {
        return str;
    }

    // 后缀宽度
    CGSize suffixSize = [suffixStr sizeWithAttributes:@{NSFontAttributeName: font}];
    CGFloat maxTextWidth = length - suffixSize.width;

    // 从最长开始缩短
    for (NSInteger i = str.length; i > 0; i -= (int)[suffixStr length]) {
        if (i > str.length) {  // 防止越界
            continue;
        }

        NSString *tempStr = [str substringToIndex:i];
        CGSize tempSize = [tempStr sizeWithAttributes:@{NSFontAttributeName: font}];

        if (tempSize.width <= maxTextWidth) {
            return [NSString stringWithFormat:@"%@%@", tempStr, suffixStr];
        }
    }

    // 如果长度过短，返回仅后缀
    return suffixStr;
}
-(void)addSuffixString:(NSString*)suffixStr isOpne:(BOOL)isOpen {
    // 获取原字符串宽度
    NSString* string = [self.text copy];
    if (isOpen) {
        string = [self.text copy];
    } else {
        NSArray* ary = [self getLinesArrayOfStringWidth:self.contentSize.width];
        string = [NSString stringWithString:[(NSString*)ary[0] stringByAppendingString:(NSString*)ary[1]]];
    }
    CGSize originalSize = [string sizeWithAttributes:@{NSFontAttributeName:self.font}];

    CGSize suffixSize = [suffixStr sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGFloat maxTextWidth = originalSize.width - suffixSize.width;

    // 从最长开始缩短
    for (NSInteger i = string.length; i > 0; i -= (int)[suffixStr length]) {
        if (i > string.length) {  // 防止越界
            continue;
        }

        NSString *tempStr = [string substringToIndex:i];
        CGSize tempSize = [tempStr sizeWithAttributes:@{NSFontAttributeName:self.font}];

        if (tempSize.width <= maxTextWidth) {
            self.text = [NSString stringWithFormat:@"%@%@", tempStr, suffixStr];
        }
    }
}
- (NSString *)getTitle:(NSString *)content flagStr:(NSString *)flagStr {
    NSArray *contentArr = [self getLinesArrayOfStringWidth:(self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - self.textContainer.lineFragmentPadding * 2)];
    NSLog(@"%@", contentArr);
         //将第一行和第二行的字符串重组
    NSString *theFirstTwoLinesStr = [NSString stringWithFormat:@"%@%@…",contentArr[0],contentArr[1]];
    NSLog(@"%@ %@", contentArr[0], contentArr[1]);
    int theFirstTwoLinesCount = (int)theFirstTwoLinesStr.length;
    NSString* string = @"…展开";
    for (int i = 0; i < theFirstTwoLinesCount; i++) {
        //慢慢一步步截取之前我们由第一行和第二行组成的字符串的前theFirstTwoLinesCount-i-3)个字符串.3表示我们自己添加的“ …”的长度
        NSString *tempStr = [theFirstTwoLinesStr substringWithRange:NSMakeRange(0, theFirstTwoLinesCount - i - [string length])];
        
        NSString *str = [NSString stringWithFormat:@"%@…展开",tempStr];
        str = [NSString stringWithFormat:@"%@", str];
        self.text = str;
        NSLog(@"每一步骤的：%@", str);
        NSArray *tempArr = [self getLinesArrayOfStringWidth:self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - self.textContainer.lineFragmentPadding * 2];
            //直到我们截取到字符串和固定文字的组合刚刚好是2行就大功告成
        if (tempArr.count <= 2) {
            //i = theFirstTwoLinesCount+1;
            NSLog(@"最后的：%@", str);
            return str;
        }
    }
    return content;
}
- (NSString*) addTitle {
    NSArray* contentArr = [self getLinesArrayOfStringWidth:(self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - self.textContainer.lineFragmentPadding * 2)];
    NSString* theTwoLine = [NSString stringWithFormat:@"%@%@...展开", contentArr[0], contentArr[1]];
    self.text = [theTwoLine copy];
    return theTwoLine;
}
@end
