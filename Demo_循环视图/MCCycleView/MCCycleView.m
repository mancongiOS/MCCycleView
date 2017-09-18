//
//  MCCycleView.m
//  Demo_循环视图
//
//  Created by goulela on 2017/9/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCCycleView.h"

#import "MCCycleItemView.h"

#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height


@interface MCCycleView ()<UIScrollViewDelegate>
{
    CGFloat _imageWidth;
    CGFloat _imageHeight;
}

/** 背景图片 */
@property (nonatomic, strong) UIImageView * bgImageView;
/** scrollView */
@property (nonatomic, strong) UIScrollView * scrollView;
/** 处理过后的数据源 */
@property (nonatomic, strong) NSArray * dataArray;
/** 中间变量控件数组 */
@property (nonatomic, strong) NSMutableArray * tempArray;
/** 指示点 */
@property (nonatomic, strong) UIPageControl * pageControl;



@end
@implementation MCCycleView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self addSubviews];
        
        
    } return self;
}



- (void)setDataSource:(NSArray *)dataArray centerItemSize:(CGSize)size {
    
    CGFloat width = ceil(size.width);
    CGFloat height = ceil(size.height);
    _imageWidth = width;
    _imageHeight = height;
    
    if (dataArray.count == 0) {
        return;
    }
    
    
    self.pageControl.numberOfPages = dataArray.count;
    
    
    NSArray * processedArray = [self processOriginalData:dataArray];
    
    self.dataArray = processedArray;
    
    for (int i = 0; i < processedArray.count; i ++) {
        
        MCCycleItemView * view = [[MCCycleItemView alloc] init];
        
        // 赋值操作
        NSDictionary * dict = processedArray[i];
        view.bgImageView.image = [UIImage imageNamed:dict[@"image"]];
        view.nameLabel.text = [NSString stringWithFormat:@"    %@",dict[@"name"]];
        [view.distanceButton setTitle:dict[@"distance"] forState:UIControlStateNormal];
        
        
        
        
        view.tag = i + 1000;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClikced:)];
        [view addGestureRecognizer:tap];
        
        view.frame = CGRectMake(i*width, 0, width, height);
        if (i != 1) {
            CGRect tempFrame = view.frame;
            tempFrame.size.height = height*0.8;
            tempFrame.size.width  = width*0.8;
            view.frame = tempFrame;
        }
        view.center = CGPointMake(width/2  + i*width, height/2);
        [self.scrollView addSubview:view];
        [self.tempArray addObject:view];
    }
    self.bgImageView.frame = CGRectMake(0, 0, kSelfWidth, kSelfHeight);
    self.scrollView.bounds = CGRectMake(0, 0, width, height);
    self.scrollView.center = CGPointMake(kSelfWidth/2, kSelfHeight/2);
    self.scrollView.contentSize = CGSizeMake(width*processedArray.count, height);
    [self.scrollView setContentOffset:CGPointMake(width, 0)];
    
    CGFloat maxHeight = CGRectGetMaxY(self.scrollView.frame);
    self.pageControl.frame = CGRectMake(0, maxHeight+10, kSelfWidth, 10);
}




// 处理循环滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    
    
    if (offsetX >= (_imageWidth * (self.dataArray.count-1))) { // 滑动到最后一张
        scrollView.contentOffset = CGPointMake(_imageWidth, 0);
    } else if (offsetX == 0) {
        scrollView.contentOffset = CGPointMake(_imageWidth * (self.dataArray.count-2), 0);
    }
    CGFloat changedOffsetX = scrollView.contentOffset.x;
    
    
    // 改变pageControl的当前页
    self.pageControl.currentPage = changedOffsetX/_imageWidth-1;
}

// 更改中间视图放大缩小
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGFloat offsetWidth = _imageWidth;
    CGFloat imageHeight = _imageHeight;
    CGFloat minWidth = offsetWidth * 0.85;
    CGFloat minHeight = imageHeight * 0.85;
    CGPoint offset = scrollView.contentOffset;
    NSInteger pageCount = offset.x / offsetWidth;
    CGFloat progress = 1 - (fabs(offset.x)  - offsetWidth * pageCount)/offsetWidth;
    
    float offsetScale = 0.15;
    
    if (pageCount == 0) {
        MCCycleItemView * imageView1 = self.tempArray[pageCount + 1];
        CGRect frame1 = imageView1.bounds;
        frame1.size.width = offsetWidth - offsetWidth * progress * offsetScale;
        frame1.size.height = imageHeight - imageHeight * progress * offsetScale;
        imageView1.bounds = frame1;
        
        MCCycleItemView * imageView2 = self.tempArray[pageCount];
        CGRect frame2 = imageView2.bounds;
        frame2.size.width = minWidth + offsetWidth * progress * offsetScale;
        frame2.size.height = minHeight + imageHeight * progress * offsetScale;
        imageView2.bounds = frame2;
    }else if (pageCount == self.tempArray.count - 1) {
        MCCycleItemView * imageView1 = self.tempArray[pageCount - 1];
        CGRect frame1 = imageView1.bounds;
        frame1.size.width = offsetWidth - offsetWidth * progress * offsetScale;
        frame1.size.height = imageHeight - imageHeight * progress * offsetScale;
        imageView1.bounds = frame1;
        
        MCCycleItemView * imageView2 = self.tempArray[pageCount];
        CGRect frame2 = imageView2.bounds;
        frame2.size.width = minWidth + offsetWidth * progress * offsetScale;
        frame2.size.height = minHeight + imageHeight * progress * offsetScale;
        imageView2.bounds = frame2;
    }else{
        //        NSLog(@"%zd",pageCount);
        MCCycleItemView * imageView1 = self.tempArray[pageCount + 1];
        CGRect frame1 = imageView1.bounds;
        frame1.size.width = offsetWidth - offsetWidth * progress * offsetScale;
        frame1.size.height = imageHeight - imageHeight * progress * offsetScale;
        imageView1.bounds = frame1;
        
        MCCycleItemView * imageView2 = self.tempArray[pageCount];
        CGRect frame2 = imageView2.bounds;
        frame2.size.width = minWidth + offsetWidth * progress * offsetScale;
        frame2.size.height = minHeight + imageHeight * progress * offsetScale;
        imageView2.bounds = frame2;
        
        MCCycleItemView * imageView3 = self.tempArray[pageCount - 1];
        CGRect frame3 = imageView3.bounds;
        frame3.size.width = offsetWidth - offsetWidth * progress * offsetScale;
        frame3.size.height = imageHeight - imageHeight * progress * offsetScale;
        imageView3.bounds = frame3;
        
        
        if (self.tempArray.count - pageCount > 2) {
            MCCycleItemView * imageView4 = self.tempArray[pageCount + 2];
            CGRect frame4 = imageView4.bounds;
            frame4.size.width = minWidth;
            frame4.size.height = minHeight;
            imageView4.bounds = frame4;
        }
    }
}

- (void)itemClikced:(UITapGestureRecognizer *)sender {
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    
    NSInteger index = [singleTap.view tag] -1000;
    
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(MCCycleItemViewDidSelectedWith:)]) {
        [self.customDelegate MCCycleItemViewDidSelectedWith:index];
    }
}

- (void)pageControlClicked:(UIPageControl *)sender {
    NSInteger index = sender.currentPage;
    self.scrollView.contentOffset = CGPointMake(_imageWidth*(index+1), 0);
}



- (void)addSubviews {
    [self addSubview:self.bgImageView];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}


-(NSMutableArray *)processOriginalData:(NSArray <NSString *>*)array {
    
    NSMutableArray * arr = [NSMutableArray arrayWithArray:array];
    NSString * firstImage = array[array.count - 1];
    NSString * lastOneImage = array[0];
    [arr insertObject:firstImage atIndex:0];
    [arr addObject:lastOneImage];
    return arr;
}


#pragma mark - setter & getter
- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor whiteColor];
    } return _bgImageView;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.alwaysBounceVertical = NO;
        
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor greenColor];
    } return _scrollView;
}

- (NSMutableArray *)tempArray {
    if (_tempArray == nil) {
        _tempArray = [NSMutableArray arrayWithCapacity:0];
    } return _tempArray;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.currentPage = 1;
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self.pageControl addTarget:self action:@selector(pageControlClicked:) forControlEvents:UIControlEventValueChanged];
    } return _pageControl;
}

@end
