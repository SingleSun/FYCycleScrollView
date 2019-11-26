//
//  FYScrollView.m
//  FYCycleScrollviewExample
//
//  Created by 樊杨 on 2019/11/25.
//  Copyright © 2019 樊杨. All rights reserved.
//

#import "FYScrollView.h"
#import "UIImageView+WebCache.h"

#define FYImageName(name)  [UIImage imageNamed:[NSString stringWithFormat:@"%@",name]]

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@interface FYScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * bgScrollView;
@property(nonatomic,strong)UIImageView * leftImageView;
@property(nonatomic,strong)UIImageView * middleImageView;
@property(nonatomic,strong)UIImageView * rightImageView;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)NSTimer * timer;
/**当前展示图片的下标*/
@property(nonatomic,assign)NSInteger currentIndex;

/**图片数量*/
@property(nonatomic,assign)NSInteger imagesCount;

@end

@implementation FYScrollView


-(instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.bgScrollView.frame = CGRectMake(0, 0, kWidth, kHeight);
    [self addSubview:_bgScrollView];

    self.leftImageView.frame = CGRectMake(kWidth*0, 0, kWidth, kHeight);
    self.middleImageView.frame = CGRectMake(kWidth*1, 0, kWidth, kHeight);
    self.rightImageView.frame = CGRectMake(kWidth*2, 0, kWidth, kHeight);
    [self.bgScrollView addSubview:self.leftImageView];
    [self.bgScrollView addSubview:self.middleImageView];
    [self.bgScrollView addSubview:self.rightImageView];
    
    //添加小圆点
    self.pageControl.frame = CGRectMake(0, kHeight-30, kWidth, 30);
    [self addSubview:self.pageControl];
    
    self.bgScrollView.contentSize = CGSizeMake(kWidth * 3, kHeight);
    //设置scrollView的初始位置
    self.bgScrollView.contentOffset = CGPointMake(kWidth, 0);
    
}

//始终展示中间图片
-(void)setScollViewCenterPosition{
    _bgScrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
}

-(void)setLocalImages:(NSArray *)localImages{
 
    _localImages = localImages;
    if (_localImages && _localImages.count == 0) {
        [self.leftImageView removeFromSuperview];
        [self.rightImageView removeFromSuperview];
        [self.middleImageView removeFromSuperview];
        self.bgScrollView.contentSize = CGSizeMake(kWidth, kHeight);
        return;
    }else if (_localImages.count == 1){
        [self.leftImageView removeFromSuperview];
        [self.rightImageView removeFromSuperview];
        self.bgScrollView.contentSize = CGSizeMake(kWidth, kHeight);
    }
    self.pageControl.numberOfPages = _localImages.count;
    self.currentIndex = 0;
    self.imagesCount = self.localImages.count;
    //启动定时器
    [self addScrollTimer];
}


/// 网络图片
/// @param imagesUrl 网络图片数组
-(void)setImagesUrl:(NSArray *)imagesUrl{
    _imagesUrl = imagesUrl;
    if (_imagesUrl && _imagesUrl.count == 0) {
        [self.leftImageView removeFromSuperview];
        [self.rightImageView removeFromSuperview];
        [self.middleImageView removeFromSuperview];
        self.bgScrollView.contentSize = CGSizeMake(kWidth, kHeight);
        return;
    }else if (_imagesUrl.count == 1){
        [self.leftImageView removeFromSuperview];
        [self.rightImageView removeFromSuperview];
        self.bgScrollView.contentSize = CGSizeMake(kWidth, kHeight);
    }
    self.pageControl.numberOfPages = _imagesUrl.count;
    self.imagesCount = _imagesUrl.count;
    self.currentIndex = 0;
    //启动定时器
    [self addScrollTimer];
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    
    _currentIndex = currentIndex;
    if (self.imagesUrl.count>0) {
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imagesUrl[(self.currentIndex - 1 + self.imagesCount) % self.imagesCount]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:self.imagesUrl[self.currentIndex]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.imagesUrl[(self.currentIndex + 1) % self.imagesCount]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    }else if (self.localImages.count > 0){
        self.leftImageView.image = [UIImage imageNamed:self.localImages[(self.currentIndex - 1 + self.localImages.count) % self.localImages.count]];
        self.middleImageView.image = [UIImage imageNamed:self.localImages[self.currentIndex]];
        self.rightImageView.image = [UIImage imageNamed:self.localImages[(self.currentIndex + 1) % self.localImages.count]];
    }
    
    [self setScollViewCenterPosition];
    self.pageControl.currentPage = self.currentIndex;
}

#pragma mark UIScrollViewDeleget

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //停止定时器
    [self.timer invalidate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"拖动结束 ==== %f",scrollView.contentOffset.x);
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //计算中间图片展示的index
    CGFloat offsetDistance = offsetX - self.bounds.size.width;
    if (offsetDistance > 0) {
        //向左滑动，更换下一张图片
        self.currentIndex = (self.currentIndex + 1) % self.imagesCount;
    }else if(offsetDistance < 0){
        //向右滑动
        self.currentIndex = (self.currentIndex -1 + self.imagesCount) % self.imagesCount;
    }
    [self addScrollTimer];
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"定时器运作 ====== %f",scrollView.contentOffset.x);
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //计算中间图片展示的index
    CGFloat offsetDistance = offsetX - self.bounds.size.width;
    if (offsetDistance > 0) {
        //向左滑动，更换下一张图片
        self.currentIndex = (self.currentIndex + 1) % self.imagesCount;
    }
}

-(void)addScrollTimer{
    //ios 10
    _timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(timerCycleScrollView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark 点击
-(void)imageScrollClick{
    if (self.cycleScrollViewClick) {
        self.cycleScrollViewClick(self.currentIndex);
    }
}

-(void)timerCycleScrollView{
    
    [_bgScrollView setContentOffset:CGPointMake(kWidth*2, 0) animated:YES];

}

-(UIScrollView *)bgScrollView{
 
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc]init];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.delegate = self;
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.bounces = YES;
    }
    return _bgScrollView;
}

-(UIImageView *)leftImageView{
 
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc]init];
    }
    return _leftImageView;
}

-(UIImageView *)middleImageView{
 
    if (_middleImageView == nil) {
        _middleImageView = [[UIImageView alloc]init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageScrollClick)];
        _middleImageView.userInteractionEnabled = YES;
        [_middleImageView addGestureRecognizer:tap];
    }
    return _middleImageView;
}

-(UIImageView *)rightImageView{
 
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc]init];
    }
    return _rightImageView;
}

-(UIPageControl *)pageControl{
 
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

-(void)dealloc{
 
    [self.timer invalidate];
    self.timer = nil;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
