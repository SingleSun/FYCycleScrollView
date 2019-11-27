//
//  FYCustomPageControl.m
//  FYCycleScrollviewExample
//
//  Created by 樊杨 on 2019/11/27.
//  Copyright © 2019 樊杨. All rights reserved.
//

#import "FYCustomPageControl.h"

@implementation FYCustomPageControl

-(instancetype)init{
 
    if (self = [super init]) {
        self.pageMode = FYPageControlModeDefault;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        self.pageMode = FYPageControlModeDefault;
    }
    return self;
}

-(void)setCurrentPage:(NSInteger)currentPage{
 
    [super setCurrentPage:currentPage];
    if (self.pageMode == FYPageControlModeDefault) {
        [self setNeedsLayout];
    }else{
        for (NSUInteger i = 0; i < [self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        CGSize size;
        size.height = 20;
        size.width = 20;
        [dot setFrame:CGRectMake(dot.frame.origin.x,dot.frame.origin.y,  size.width,size.height)];
        }
    }
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat maxWidth = 0.0;
    for (NSUInteger i = 0; i < [self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        CGSize size;
        size.height = 5;
        size.width = 15;
        [dot setFrame:CGRectMake(maxWidth,dot.frame.origin.y,  size.width,size.height)];
        maxWidth = CGRectGetMaxX(dot.frame) + margin;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,maxWidth, self.bounds.size.height);
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
}

-(void)setPageMode:(FYPageControlMode)pageMode{
    _pageMode = pageMode;
    [self setNeedsLayout];
}

-(void)setPageImg:(UIImage *)pageImg{
    
    _pageImg = pageImg;
    [self setValue:pageImg forKeyPath:@"_pageImage"];
    
}

-(void)setCurrentPageImg:(UIImage *)currentPageImg{
    
    _currentPageImg = currentPageImg;
    [self setValue:currentPageImg forKeyPath:@"_currentPageImage"];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
