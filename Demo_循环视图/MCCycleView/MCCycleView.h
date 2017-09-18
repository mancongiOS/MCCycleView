//
//  MCCycleView.h
//  Demo_循环视图
//
//  Created by goulela on 2017/9/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MCCycleDelegate <NSObject>

- (void)MCCycleItemViewDidSelectedWith:(NSInteger)index;

@end

@interface MCCycleView : UIView

@property (nonatomic, weak) id<MCCycleDelegate> customDelegate;

- (void)setDataSource:(NSArray *)dataArray centerItemSize:(CGSize)size;

@end
