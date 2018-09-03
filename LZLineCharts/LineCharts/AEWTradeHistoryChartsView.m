//
//  AEWTradeHistoryChartsView.m
//  AEWallet
//
//  Created by 吕召 on 2018/7/17.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "AEWTradeHistoryChartsView.h"
#import "AEWLineChartsView.h"
#import "AEWLineChartModel.h"

/**
 *  Y轴刻度标签 与 Y轴 之间 空隙
 */
#define HORIZON_YMARKLAB_YAXISLINE LZGet(8.f)

/**
 *  Y轴刻度标签  宽度
 */
#define YMARKLAB_WIDTH LZGet(45.f)

/**
 *  Y轴刻度标签  高度
 */
#define YMARKLAB_HEIGHT LZGet(18.f)


/**
 *  Y轴点之之间的间隔
 */
#define YMARKLAB_INTERVAL LZGet(24.f)

/**
 *  最上边的Y轴刻度标签距离顶部的 距离
 */
#define YMARKLAB_TO_TOP 12.f


@interface AEWTradeHistoryChartsView ()

/**
 *  网格线的起始点
 */
@property (nonatomic, assign) CGPoint startPoint;
@end


@implementation AEWTradeHistoryChartsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        self.startPoint = CGPointMake(LZGet(55),self.height - LZGet(27));

        [self setupView];
        
        
    }
    return self;
}

#pragma mark - setupView
- (void)setupView{
    
    //交易笔数
    UILabel *tradeCountLabel = [[UILabel alloc]init];
    tradeCountLabel.text = @"交易笔数";
    tradeCountLabel.font = [UIFont systemFontOfSize:LZGet(8)];
    tradeCountLabel.textColor = [UIColor whiteColor];
    tradeCountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:tradeCountLabel];
    [tradeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(LZGet(20));
        make.width.mas_equalTo(LZGet(52));
        make.height.mas_equalTo(LZGet(8));
    }];
    
    
    //最近交易历史 title
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"最近15天交易历史";
    titleLabel.font = [UIFont systemFontOfSize:LZGet(13)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tradeCountLabel.mas_right);
        make.top.mas_equalTo(LZGet(15));
        make.right.mas_equalTo(-LZGet(20));
        make.height.mas_equalTo(LZGet(13));
    }];

}




#pragma mark  Y轴上的刻度标签
- (void)setupYMarkLabs {

    for (int i = 0; i < self.lineChartModel.yMarkTitles.count; i ++) {
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.startPoint.y -  self.lineChartModel.yMarkLabHeight/2. - i * self.lineChartModel.yMarkLabInterval, self.lineChartModel.yMarkLabWidth, self.lineChartModel.yMarkLabHeight)];
        markLab.textAlignment = NSTextAlignmentRight;
        markLab.font = [UIFont systemFontOfSize:10.0];
        markLab.textColor = [UIColor.whiteColor colorWithAlphaComponent:0.5];
        //字体倾斜
        markLab.transform = CGAffineTransformMakeRotation(-M_PI_4/2);
        markLab.text = [NSString stringWithFormat:@"%@", self.lineChartModel.yMarkTitles[i]];
        [self addSubview:markLab];
    }
}


#pragma mark  X轴上的刻度标签
- (void)setupXMarkLabs {
    
    
    for (int i = 0; i < self.lineChartModel.xMarkTitles.count; i ++) {
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(LZGet(41) + (self.lineChartModel.xMarkLabWidth + self.lineChartModel.xMarkLabInterval) * i, self.startPoint.y + LZGet(8), self.lineChartModel.xMarkLabWidth, self.lineChartModel.xMarkLabHeight)];
        if(i == self.lineChartModel.xMarkTitles.count - 1){
            markLab.textAlignment = NSTextAlignmentRight;
        } else {
            markLab.textAlignment = NSTextAlignmentCenter;
        }
        markLab.textColor = UIColor.whiteColor;

        markLab.font = [UIFont systemFontOfSize:10.0];
        markLab.text = [NSString stringWithFormat:@"%@", self.lineChartModel.xMarkTitles[i]];
        [self addSubview:markLab];
    }
}

#pragma mark - actions

#pragma mark - custool

#pragma mark - get && set
- (void)setLineChartModel:(AEWLineChartModel *)lineChartModel{
    _lineChartModel  = lineChartModel;
    //画X轴title
    [self setupXMarkLabs];
    [self setupYMarkLabs];
    
    //折线部分
    AEWLineChartsView *lineChartsView = [[AEWLineChartsView alloc]initWithFrame:lineChartModel.lineRect];
    [self addSubview:lineChartsView];
    lineChartsView.lineChartModel = lineChartModel;
    
}

@end
