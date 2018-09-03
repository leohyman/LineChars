//
//  AEWLineChartModel.m
//  AEWallet
//
//  Created by 吕召 on 2018/7/18.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "AEWLineChartModel.h"

@implementation AEWLineChartModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yMarkLabWidth = LZGet(45.f);
        self.yMarkLabHeight =  LZGet(18.f);
        
        
        self.xMarkLabWidth = LZGet(30.f);
        self.xMarkLabHeight =  LZGet(9.f);
        
        //看设计图
        self.startPoint = CGPointMake(LZGet(55),LZGet(192) - LZGet(27));
        self.lineRect = CGRectMake(LZGet(52), LZGet(35), K_SCREENWIDTH - LZGet(55) - LZGet(17), LZGet(130));

    }
    return self;
}


- (void)setYMarkTitles:(NSArray *)yMarkTitles{
    
    _yMarkTitles = yMarkTitles;
    self.yMarkLabInterval = LZGet(144)/(yMarkTitles.count);

}

- (void)setXMarkTitles:(NSArray *)xMarkTitles{
    
    _xMarkTitles = xMarkTitles;
    CGFloat fristLabelX = LZGet(41);
    CGFloat lastLabelRight= LZGet(13);

    self.xMarkLabInterval = (K_SCREENWIDTH -fristLabelX - lastLabelRight - self.xMarkLabWidth * xMarkTitles.count)/(xMarkTitles.count -1);

}



//屏幕是适配
+ (CGFloat)autoValue:(CGFloat)value{
    
    CGFloat tempW = 0;
    CGFloat denominator =.0f;
    tempW         = 375.f;
    denominator   = MIN(K_SCREENWIDTH, K_SCREENHEIGHT);
    return ceil((value/tempW) * denominator);
    
}
@end
