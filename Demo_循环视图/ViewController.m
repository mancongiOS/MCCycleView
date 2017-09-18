//
//  ViewController.m
//  Demo_循环视图
//
//  Created by goulela on 2017/9/14.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "ViewController.h"
#import "MCCycleView.h"

@interface ViewController ()
<MCCycleDelegate>

@end

@implementation ViewController

#define kSelfWidth self.view.frame.size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 高度说明 
    
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    
    MCCycleView * view = [[MCCycleView alloc] init];
   
    view.customDelegate = self;
    view.frame = CGRectMake(0, 100, kSelfWidth, 300);
    [self.view addSubview:view];
    
    NSArray * array = @[
                        @{@"image" :@"HomePage_0",@"name":@"第一个",@"distance": @"1.0km"},
                        @{@"image" :@"HomePage_1",@"name":@"第二个",@"distance": @"2.0km"},
                        @{@"image" :@"HomePage_2",@"name":@"第三个",@"distance": @"3.0km"},
                        @{@"image" :@"HomePage_3",@"name":@"第四个",@"distance": @"4.0km"}
                        ];
    
    [view setDataSource:array centerItemSize:CGSizeMake(kSelfWidth*0.8, kSelfWidth*0.4)];
}


- (void)MCCycleItemViewDidSelectedWith:(NSInteger)index {

    NSLog(@"点击了第%ld个",(long)index);
}



@end
