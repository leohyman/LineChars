//
//  ViewController.m
//  LZLineCharts
//
//  Created by 吕召 on 2018/9/3.
//  Copyright © 2018年 链动科技. All rights reserved.
//

#import "ViewController.h"
#import "AEWLineChartModel.h"
#import "AEWTradeHistoryChartsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    //K图    self.yMarkTitles =
    AEWLineChartModel *lineChartModel = [[AEWLineChartModel alloc]init];
    lineChartModel.yMarkTitles = @[@(0),@(40),@(80),@(120),@(160),@(200)]; 
    lineChartModel.xMarkTitles = @[@"6-15",@"6-19",@"6-22",@"6-25",@"6-29"];
    lineChartModel.maxCount = 200;
    lineChartModel.valueArray = @[@(150),@(60),@(130),@(100),@(170),
                                  @(100),@(120),@(100),@(180),@(70),
                                  @(120),@(40),@(190),@(10),@(110)];
    
    AEWTradeHistoryChartsView *chartsView = [[AEWTradeHistoryChartsView alloc]initWithFrame:CGRectMake(0, LZGet(55), K_SCREENWIDTH, LZGet(192))];
    chartsView.lineChartModel = lineChartModel;
    [self.view addSubview:chartsView];
}


@end
