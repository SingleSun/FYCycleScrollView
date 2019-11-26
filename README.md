# FYCycleScrollView

简单的无限循环轮播图，使用三个imageView实现。

导入方式：

1、直接下载zip压缩包文件
2、使用Cocopods管理
   ```
   pod 'FYCycleScrollView', ~>'1.0.0'
   ```

使用：
```
FYScrollView * imageCycleView = [[FYScrollView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 200)];
    //加载本地图片
imageCycleView.localImages = @[@"01.jpeg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg"];
imageCycleView.cycleScrollViewClick = ^(NSInteger index) {
        SecondViewController * second = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:second animated:YES];
    };
```
