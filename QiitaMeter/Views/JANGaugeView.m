//
//  JANGaugeView.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANGaugeView.h"

@implementation JANGaugeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor2 = [UIColor colorWithRed:125.0/255 green:187.0/255 blue:45.0/255 alpha:1.0];
    self.backgroundColor = [UIColor whiteColor];
    
    CGContextRef context;
    CGColorSpaceRef colorspace;
    CGGradientRef gradient;
    
    CGPoint startPoint;
    CGPoint endPoint;
    
    // グラデーションの色を指定する地点を、ここでは 2 つ用意します。
    CGFloat locations[2] = {0.0, 1.0};
    
    // 描画するキャンバスの情報を取得します。
    context = UIGraphicsGetCurrentContext();
    colorspace = CGColorSpaceCreateDeviceRGB();
    
    // グラデーションの色（今回は 2 地点分）を CGColorRef を格納した CFArrayRef 配列で用意します。
    CGColorRef colors[2];
    CFArrayRef colors_buffer;
    
    colors[0] = self.backgroundColor.CGColor;
    colors[1] = self.backgroundColor2.CGColor;
    
    colors_buffer = CFArrayCreate(kCFAllocatorDefault, (const void**)colors, 2, &kCFTypeArrayCallBacks);
    
    // グラデーションの描画に必要な情報を揃えます。
    // 描画の開始地点と終了地点は、ここではそれぞれ、UIView の左上と右下（斜めのグラデーション）に指定しています。
    gradient = CGGradientCreateWithColors(colorspace, colors_buffer, locations);
    
    startPoint = rect.origin;

    endPoint = CGPointMake(rect.origin.x + rect.size.width * _persentValue, 0);
    
    // グラデーションをキャンバスに描画します。
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    // 使い終わった CF オブジェクトを解放します。
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    CFRelease(colors_buffer);

}


@end
