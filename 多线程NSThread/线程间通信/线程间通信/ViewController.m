//
//  ViewController.m
//  线程间通信
//
//  Created by ChangRJey on 2017/8/7.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(download) object:nil];
    
    [thread start];
}

- (void) download{
    
    // 1.获取图片rul
    NSURL * url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502704595&di=77a802f956215c509727a13dc7176b7a&imgtype=jpg&er=1&src=http%3A%2F%2Fatt.bbs.duowan.com%2Fforum%2F201306%2F08%2F220236m63ppvbxbevgrbrg.jpg"];
    
    // 2.根据url下载图片二进制数据到本地
    NSData * imageData = [NSData dataWithContentsOfURL:url];
    
    // 3.转换图片格式
    UIImage * image = [UIImage imageWithData:imageData];
    
    NSLog(@"download---%@",[NSThread currentThread]);
    
    // 4.回到主线程显示UI
    
    /**
     * 参数1. 调用方法
       参数2. 方法传递值
       参数3. 是否完成该方法后执行下一步
     */
    
    // 方法1.
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
    // 方法2.
    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    // 方法3.
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
    NSLog(@"----end----");
}

- (void) showImage: (UIImage *) image{
    self.imageView.image = image;
    NSLog(@"showImage---%@",[NSThread currentThread]);
}

@end
