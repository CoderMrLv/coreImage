//
//  ViewController.m
//  coreImage
//
//  Created by apple on 16/2/24.
//  Copyright © 2016年 qingxun. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+ImageEffects.h"
@interface ViewController ()

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"002"];
   /*  *****************CoreImage**************** */
    
    //CIImage
    CIImage * ciImage = [[CIImage alloc] initWithImage:image];
    
    //CIFilter
    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    //将图片输入到滤镜中
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    
    //设置的模糊程度 0 - 100
    [blurFilter setValue:@(10) forKey:@"inputRadius"];
    
    //将处理好的图片输出
    CIImage *outCiImage = [blurFilter valueForKey:kCIOutputImageKey];
    
    //操作上下文  默认CPU渲染
    CIContext * context = [CIContext contextWithOptions:nil];
    
    //操作句柄
    CGImageRef  outCGImage = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
    
    //获取最终的图片
    UIImage * blurImage = [UIImage imageWithCGImage:outCGImage];
    
    //释放句柄
    CGImageRelease(outCGImage);
    /*  *********************************** */
   
   //原始图片

    
    //初始化ImageView
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*1184/2540.f)];
    
    imageView.image = blurImage;
    [self.view addSubview:imageView];
}

//通过类别实现图片的模糊
- (void)imageCategory{
    
    //原始图片
    UIImage * sourceImage = [UIImage imageNamed:@"002"];
    //对图片进行模糊   模糊程度
    UIImage *blurImage = [sourceImage blurImageWithRadius:20];
    
    //模糊的范围
    
    UIImage * blurImage2 = [sourceImage blurImageAtFrame:CGRectMake(0, 100, sourceImage.size.width/2.f, sourceImage.size.height/2.f)];
    
    
    //加载图片
    UIImageView * imageView = [[UIImageView alloc]initWithImage:blurImage];
    imageView.frame = CGRectMake(0, 300, 300, 150);
    [self.view addSubview:imageView];
    

}

//UIVisualEffectView iOS8以上
- (void)imageBlur{

    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"002"]];
    self.scrollView.contentSize = imageView.image.size;
    self.scrollView.bounces = NO;
    [self.scrollView addSubview:imageView];
    [self.view addSubview:self.scrollView];

    /* *******模糊效果********* */
    //1、创建模糊view
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    //2、设定尺寸
    effectView.frame = CGRectMake(0,100, 320,200);
    //3、添加到view上
    [self.view addSubview:effectView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:effectView.bounds];
    label.text = @"简单的测试";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    
    //1、创建出子模糊视图
    UIVisualEffectView * subEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)effectView.effect]];
    //2、设定尺寸
    subEffectView.frame = effectView.bounds;
    
    //3、将子模糊View添加到effectView的ContentView才能生效
    [effectView.contentView addSubview:subEffectView];
    
    //4、添加要显示的view达到特殊的效果
    [subEffectView.contentView addSubview:label];
    
    
}

@end
