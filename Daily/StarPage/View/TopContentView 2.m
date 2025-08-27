//
//  TopContentView.m
//  Daily
//
//  Created by nanxun on 2024/10/22.
//

#import "TopContentView.h"

@implementation TopContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.authorLabel = [[UILabel alloc] init];
        self.imageView = [[UIImageView alloc] init];
        self.authorLabel.textColor = [UIColor colorWithRed:198/255.0 green:203/255.0 blue:208/255.0 alpha:1];
        self.titleLabel.textColor = UIColor.whiteColor;
        self.authorLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:23];
        [self addSubview:self.imageView];
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.effectView.frame = CGRectMake(0, 200, 393, 200);
        
        UIView *colorView = [[UIView alloc] init];
        colorView.frame = CGRectMake(0, 200, self.bounds.size.width, 200);

        
        self.gradientLayer = [CAGradientLayer layer];
        //设置开始和结束位置(设置渐变的方向)
        self.gradientLayer.startPoint = CGPointMake(0, 0.5);
        self.gradientLayer.endPoint = CGPointMake(0, 0);
        
        self.gradientLayer.frame = CGRectMake(0, 0, 393, 200);
        [colorView.layer insertSublayer:self.gradientLayer atIndex:0];

        [self addSubview:colorView];
        
        
        [self addSubview:_titleLabel];
        [self addSubview:_authorLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-50);
            make.height.equalTo(@80);
        }];
        [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.left.right.equalTo(self.titleLabel);
            make.bottom.equalTo(self).offset(-30);
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self);
        }];
        [self setImageColor];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touch" object:nil userInfo:nil];
}
#pragma mark CoreImage
-(void)setImageColor {
    [self.imageView.image getSubjectColor:^(UIColor * _Nonnull subjectColor){ 
        self.gradientLayer.colors = @[(id)[subjectColor colorWithAlphaComponent:1.0].CGColor,
                                 (id)[subjectColor colorWithAlphaComponent:0.0].CGColor];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
