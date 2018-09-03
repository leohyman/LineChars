//
//  AEWLineChartModel.h
//  AEWallet
//
//  Created by 吕召 on 2018/7/18.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIView+LZSize.h"
#import "Masonry.h"


///屏幕的宽
#define K_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
///屏幕的高
#define K_SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

#define LZGet(A)  [AEWLineChartModel autoValue:A]

@interface AEWLineChartModel : NSObject


/**
 Convert Y轴刻度
 */
@property (nonatomic,strong)NSArray *yMarkTitles;

/**
 Convert Y刻度的宽度
 */
@property (nonatomic,assign)CGFloat yMarkLabWidth;


/**
 Convert Y刻度的高度
 */
@property (nonatomic,assign)CGFloat yMarkLabHeight;

/**
 Convert Y刻度的均分的高度,这里应该是可变的,根据高度/yMarkTitles.count 等于的值是的高度, 是Y轴的高度);
 */
@property (nonatomic,assign)CGFloat yMarkLabInterval;




/**
Convert x轴刻度
*/
@property (nonatomic,strong)NSArray *xMarkTitles;

/**
 Convert /X刻度的宽度
 */
@property (nonatomic,assign)CGFloat xMarkLabWidth;

/**
 Convert X刻度的高度
 */

@property (nonatomic,assign)CGFloat xMarkLabHeight;

/**
 Convert X刻度的均分的宽度的间隔,这里应该是可变的,根据宽度/yMarkTitles.count,(这里的宽度, 是总的宽度 -  第一个刻度的X - 最有一个的max(x) 除以 xMarkTitles.count - 1);
 */
@property (nonatomic,assign)CGFloat xMarkLabInterval;

/**
 Convert 线的坐标
 */
@property (nonatomic,assign)CGRect lineRect;


/**
 Convert 数据源
 valueArray 参数@[@(0),@(60),@(130),@(10),@(70)];
 */
@property (nonatomic, strong) NSArray *valueArray;

//最大值
@property (nonatomic, assign) NSInteger maxCount;

/**
 Convert 开始点,(左下角) 注意左下角的开始线, 是交叉点, 为开始线
 */
@property (nonatomic, assign) CGPoint startPoint;



//适配
+ (CGFloat)autoValue:(CGFloat)value;



@end
