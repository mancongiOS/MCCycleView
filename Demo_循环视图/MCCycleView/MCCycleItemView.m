//
//  MCCycleItemView.m
//  Demo_循环视图
//
//  Created by goulela on 2017/9/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCCycleItemView.h"


@interface MCCycleItemView ()

@property (nonatomic, strong) UIView * shadowView;


@end

@implementation MCCycleItemView

#define kWidth self.bounds.size.width
#define kHeigth self.bounds.size.height


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubivews];
    } return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.shadowView.frame = CGRectMake(0, 0, kWidth, kHeigth);
    self.bgImageView.frame = CGRectMake(0, 0, kWidth, kHeigth);
    self.nameLabel.frame = CGRectMake(0, kHeigth-40, kWidth, 40);
    self.distanceButton.frame = CGRectMake(kWidth - 60, kHeigth-40, 60, 40);
}

- (void)addSubivews {
    [self addSubview:self.shadowView];
    [self.shadowView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.nameLabel];
    [self.bgImageView addSubview:self.distanceButton];
}





- (UIView *)shadowView {
    if (_shadowView == nil) {
        self.shadowView = [[UIView alloc] init];
        self.shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
        self.shadowView.layer.shadowOpacity = 0.8; // 透明度
        self.shadowView.layer.shadowOffset = CGSizeMake(0, 5);
        self.shadowView.layer.shadowRadius = 5.0;
        self.shadowView.clipsToBounds = NO;
    } return _shadowView;
}

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.backgroundColor = [UIColor redColor];
        self.bgImageView.layer.cornerRadius = 5;
        self.bgImageView.layer.masksToBounds = YES;
    } return _bgImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.nameLabel.textColor = [UIColor whiteColor];
    } return _nameLabel;
}

- (UIButton *)distanceButton {
    if (_distanceButton == nil) {
        self.distanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.distanceButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.distanceButton setImage:[UIImage imageNamed:@"Reuse_location"] forState:UIControlStateNormal];
        [self.distanceButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } return _distanceButton;
}


@end
