//
//  AEWLineChartsView.m
//  AEWallet
//
//  Created by 吕召 on 2018/7/18.
//  Copyright © 2018年 铭创信科. All rights reserved.
//

#import "AEWLineChartsView.h"
#import "AEWLineChartModel.h"

@interface AEWLineChartsView()

//记录点的坐标
@property (nonatomic,strong)NSMutableArray *pointArray;

//显示数量
@property (nonatomic,strong)UILabel *countLabel;

//lineLayer
@property (nonatomic,strong)CAShapeLayer *lineLayer;

//coverBtns
@property (nonatomic,strong)NSMutableArray *coverBtns;
@end


@implementation AEWLineChartsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pointArray = [[NSMutableArray alloc]init];
        self.coverBtns = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setupView{
    
    
    //画Y轴
    [self drawYAxsiLine];
    
    //画X轴
    [self drawXAxsiLine];
    
    //与X轴平行的线
    [self drawXGridline];
    
    //与Y轴平行的线
    [self drawYGridline];
    
    //画折现
    [self drawChartLine];
    
    //画圆环
    [self setupCircleViews];
    
    //画渐变阴影
    [self drawGradient];
    
    //覆盖一层点击图层
    [self setupCoverViews];
}

#pragma mark  Y轴
- (void)drawYAxsiLine {
    
    UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
    [yAxisPath moveToPoint:CGPointMake(2, 0)];
    [yAxisPath addLineToPoint:CGPointMake(2, self.height)];
    
    CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
    yAxisLayer.lineWidth = 1;
    yAxisLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
    yAxisLayer.path = yAxisPath.CGPath;
    [self.layer addSublayer:yAxisLayer];
}

#pragma mark  X轴
- (void)drawXAxsiLine {
    UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
    [xAxisPath moveToPoint:CGPointMake(0, self.height-2)];
    [xAxisPath addLineToPoint:CGPointMake(self.width, self.height-2)];
    
    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
    xAxisLayer.lineWidth = 0.5;
    xAxisLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4].CGColor;
    xAxisLayer.path = xAxisPath.CGPath;
    [self.layer addSublayer:xAxisLayer];
}


#pragma mark  与 X轴 平行的网格线
- (void)drawXGridline {
    CGFloat lineIntervalWidth = (self.height - 2) / (self.lineChartModel.yMarkTitles.count - 1);
    for (int i = 0; i < self.lineChartModel.yMarkTitles.count; i ++) {
        
        UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
        [xAxisPath moveToPoint:CGPointMake(0, lineIntervalWidth * i)];
        [xAxisPath addLineToPoint:CGPointMake(self.width, lineIntervalWidth * i)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
        xAxisLayer.path = xAxisPath.CGPath;
        [self.layer addSublayer:xAxisLayer];
    }
}

#pragma mark  与 Y轴 平行的网格线
- (void)drawYGridline {
    
    CGFloat lineIntervalWidth = (self.width - 2) / (self.lineChartModel.valueArray.count - 1);

    for (int i = 0; i < self.lineChartModel.valueArray.count; i ++) {
        
        UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
        [yAxisPath moveToPoint:CGPointMake(2 + lineIntervalWidth *i, self.height-2)];
        [yAxisPath addLineToPoint:CGPointMake(2 + lineIntervalWidth *i, self.height)];
        
        CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
        yAxisLayer.lineWidth = 0.5;
        yAxisLayer.strokeColor = [UIColor whiteColor].CGColor;
        yAxisLayer.path = yAxisPath.CGPath;
        [self.layer addSublayer:yAxisLayer];
    }
}

#pragma mark 画折线图
- (void)drawChartLine
{
    NSInteger maxValue = self.lineChartModel.maxCount;
    CGFloat lineIntervalWidth = (self.width - 2) / (self.lineChartModel.valueArray.count - 1);

    NSArray *valueArray = self.lineChartModel.valueArray;
    
    UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
    
    for (int i = 0; i < valueArray.count; i ++) {
        
        CGFloat point_X = lineIntervalWidth * i + 2;
        
        CGFloat value = [valueArray[i] floatValue];
        CGFloat percent = value / maxValue;
        CGFloat point_Y = self.height * (1 - percent);
        CGPoint point = CGPointMake(point_X, point_Y);
        
        // 记录各点的坐标方便后边添加渐变阴影 和 点击层视图 等
        [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
        
        if (i == 0) {
            [pAxisPath moveToPoint:point];
        }
        else {
            [pAxisPath addLineToPoint:point];
        }
    }
    
    CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
    pAxisLayer.lineWidth = 1;
    pAxisLayer.strokeColor = UIColor.whiteColor.CGColor;
    pAxisLayer.fillColor = [UIColor clearColor].CGColor;
    pAxisLayer.path = pAxisPath.CGPath;

    //增加动画, 这里还在学习中
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 10;
//    pathAnimation.repeatCount = 1;
//    pathAnimation.removedOnCompletion = YES;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
//    [pAxisLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    [self.layer addSublayer:pAxisLayer];
    
}

#pragma mark 折线上的圆环
- (void)setupCircleViews {
    
    for (int i = 0; i < self.pointArray.count; i ++) {
        UIView * graphColorView = [UIView new];
        graphColorView.clipsToBounds = YES;
        graphColorView.layer.cornerRadius = 2;
        graphColorView.center = [self.pointArray[i] CGPointValue];
        graphColorView.bounds = CGRectMake(0, 0, 4, 4);
        graphColorView.backgroundColor = [UIColor yellowColor];
        [self addSubview:graphColorView];
    }
}

#pragma mark 渐变阴影
- (void)drawGradient {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 2);
    //    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:170/255.0 blue:10/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor];
    
    gradientLayer.colors = @[(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:1].CGColor,
                             (__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0].CGColor];
    
    gradientLayer.locations=@[@0.2,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(0.0,1);
    
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    [gradientPath moveToPoint:CGPointMake(0, self.height)];
    
    for (int i = 0; i < self.pointArray.count; i ++) {
        [gradientPath addLineToPoint:[self.pointArray[i] CGPointValue]];
    }
    
    CGPoint endPoint = [[self.pointArray lastObject] CGPointValue];
    endPoint = CGPointMake(endPoint.x + 2, self.height + self.height - 2);
    [gradientPath addLineToPoint:endPoint];
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.fillColor = [UIColor whiteColor].CGColor;
    arc.path = gradientPath.CGPath;
    
    gradientLayer.mask = arc;
    
    [self.layer addSublayer:gradientLayer];
    
}

#pragma mark 覆盖一层点击图层
- (void)setupCoverViews {
    
    for (int i = 0; i < self.pointArray.count; i ++) {
        
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.tag = 100 + i;
        coverBtn.center = [self.pointArray[i] CGPointValue];
        coverBtn.bounds = CGRectMake(0, 0, 20, 20);
        [self addSubview:coverBtn];
        [coverBtn addTarget:self action:@selector(coverAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.coverBtns addObject:coverBtn];
    }
    
}

#pragma mark - action
- (void)coverAction:(UIButton *)btn{
    self.countLabel.hidden = NO;
    self.countLabel.frame = CGRectMake(btn.frame.origin.x - 10, btn.frame.origin.y - LZGet(8), LZGet(40), LZGet(10));
    self.countLabel.text = [NSString stringWithFormat:@"%@",self.lineChartModel.valueArray[btn.tag - 100]];
    
    [self createLineLayer:btn];
}

//点击点到x轴的线
- (void)createLineLayer:(UIButton *)btn{
    
    [self.lineLayer removeFromSuperlayer];
    
    CGFloat lineIntervalWidth = (self.width - 2) / 14;

    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:btn.center];
    [linePath addLineToPoint:CGPointMake(2 + lineIntervalWidth * (btn.tag - 100), self.height - 2)];
    
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.lineWidth = 0.5;
    self.lineLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
    self.lineLayer.path = linePath.CGPath;
    [self.layer addSublayer:self.lineLayer];
}

#pragma mark - cusTool
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        UIButton * fristBtn = self.coverBtns.firstObject;
        UIButton * lastBtn = self.coverBtns.lastObject;
        CGPoint temFrisBtnPoint = [fristBtn convertPoint:point fromView:self];
        CGPoint temLastBtnPoint = [lastBtn convertPoint:point fromView:self];

        if (CGRectContainsPoint(fristBtn.bounds, temFrisBtnPoint))
        {
            view = fristBtn;
        } else if (CGRectContainsPoint(lastBtn.bounds, temLastBtnPoint)) {
        
            view = lastBtn;
        }
        
    }
    return view;
}

#pragma mark - get && set
- (void)setLineChartModel:(AEWLineChartModel *)lineChartModel{
    _lineChartModel  = lineChartModel;
 
    [self setupView];
}
- (UILabel *)countLabel{
    if(!_countLabel){
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = UIColor.whiteColor;
        _countLabel.font = [UIFont systemFontOfSize:LZGet(13)];
        _countLabel.hidden = YES;
        [self addSubview:_countLabel];

    }
    return _countLabel;
}
@end
