//
//  CVTipView.m
//  Countdown
//
//  Created by Coulton Vento on 12/29/14.
//  Copyright (c) 2014 Coulton Vento. All rights reserved.
//

#import "CVTipView.h"

const CGFloat kCVTipBoxInternalPadding = 20.0f;

@interface CVTipView ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) CVTip *tip;
@property (nonatomic, strong) UIFont *font;
@end

@implementation CVTipView

- (id)initWithTip:(CVTip*)tip
         andWidth:(CGFloat)width
{
    self = [super init];
    if (self) {
        
        self.tip = tip;
        self.frame = CGRectMake(0, 0, width, [CVTipView calculateBoxHeightWithTip:tip andBoxWidth:width]);
        self.backgroundColor = [UIColor whiteColor];
        
        if (tip.title) {
            const CGRect labelFrame = ^{
                
                CGRect f = self.frame;
                f.origin.x = kCVTipBoxInternalPadding;
                f.size.width -= 2 * kCVTipBoxInternalPadding;
                f.origin.y = kCVTipBoxInternalPadding;
                
                if (tip.hasIcon) {
                    f.origin.y += tip.icon.size.height + kCVTipBoxInternalPadding;
                }
                
                f.size.height -= kCVTipBoxInternalPadding + f.origin.y;
                
                return f;
            }();
            
            self.label = [[UILabel alloc] initWithFrame:labelFrame];
            self.label.textAlignment = NSTextAlignmentCenter;
            self.label.numberOfLines = 0;
            self.label.font = tip.font;
            self.label.text = tip.title;
            [self addSubview:self.label];
        }
        
        if (tip.hasIcon) {
            const CGRect iconFrame = ^{
                
                CGRect f = CGRectZero;
                f.origin.x = (self.frame.size.width - tip.icon.size.width) * 0.5;
                f.origin.y = kCVTipBoxInternalPadding;
                f.size = tip.icon.size;
                
                return f;
            }();
            
            self.icon = [[UIImageView alloc] initWithFrame:iconFrame];
            self.icon.image = tip.icon;
            [self addSubview:self.icon];
        }
    }
    return self;
}

- (void)setTintColor:(UIColor *)tintColor
{
    self.icon.tintColor = tintColor;
    self.label.tintColor = tintColor;
}

+ (CGFloat)calculateBoxHeightWithTip:(CVTip*)tip
                         andBoxWidth:(CGFloat)boxWidth
{
    CGFloat labelWidth = boxWidth - (2 * kCVTipBoxInternalPadding);
    CGRect rect = [tip.title boundingRectWithSize:CGSizeMake(labelWidth, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName : tip.font
                                                    }
                                          context:nil];
    
    // Padding
    rect.size.height += kCVTipBoxInternalPadding * 2;
    
    if (tip.hasIcon) {
        rect.size.height += tip.icon.size.height + kCVTipBoxInternalPadding;
    }
    
    return rect.size.height;
}

@end
