//
//  ViewController.m
//  FYCycleScrollviewExample
//
//  Created by 樊杨 on 2019/11/20.
//  Copyright © 2019 樊杨. All rights reserved.
//

#import "ViewController.h"
#import "FYScrollView.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试";
    
    [self initUI];
}

-(void)initUI{
    
    FYScrollView * imageCycleView = [[FYScrollView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 200)];
//    imageCycleView.localImages = @[@"01.jpeg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg"];
    
    imageCycleView.imagesUrl = @[@"https://goss2.cfp.cn/creative/vcg/800/version23/VCG21gic13888179.jpg?x-oss-process=image/format,jpg/interlace,1",@"https://goss4.cfp.cn/creative/vcg/800/new/VCG211142686948.jpg?x-oss-process=image/format,jpg/interlace,1",@"https://goss1.cfp.cn/creative/vcg/800/new/VCG211135596837.jpg?x-oss-process=image/format,jpg/interlace,1",@"https://goss2.cfp.cn/creative/vcg/800/version23/VCG41544338423.jpg?x-oss-process=image/format,jpg/interlace,1",@"https://goss2.cfp.cn/creative/vcg/nowater800/new/eed5c4cb6919431785ee19bcea18af5b.jpg?x-oss-process=image/format,webp"];
    imageCycleView.cycleScrollViewClick = ^(NSInteger index) {
        SecondViewController * second = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:second animated:YES];
    };
    [self.view addSubview:imageCycleView];
    
}

@end
