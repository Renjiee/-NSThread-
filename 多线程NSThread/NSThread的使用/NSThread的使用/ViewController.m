//
//  ViewController.m
//  NSThread的使用
//
//  Created by ChangRJey on 2017/8/7.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// NSThread的生命周期 ： 当线程执行完成之后被释放

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取主线程
    NSThread * mainThread = [NSThread mainThread];
    NSLog(@"主线程---%zd",mainThread);
    
    // 获取当前线程
    NSThread * currentThread = [NSThread currentThread];
    NSLog(@"子线程---%zd",currentThread);
    
}

- (IBAction)btnClick:(UIButton *)sender {
    [self createOneThread_1];
}

// alloc init  创建线程，需要手动启动线程
- (void) createOneThread_1{
    
    // 1.创建线程
    NSThread * threadA = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    
    // 设置名称
    threadA.name = @"子线程A";
    // 设置线程优先级  取值范围 0.0 ~ 1.0 之间 最高1.0  默认优先级是0.5
    threadA.threadPriority = 0.1;
    
    // 2.执行线程
    [threadA start];
    
    // 1.创建线程
    NSThread * threadB = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    
    // 设置名称
    threadB.name = @"子线程B";
    // 设置线程优先级
//    threadB.threadPriority = 0.0;
    
    // 2/执行线程
    [threadB start];
    
    // 1.创建线程
    NSThread * threadC = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    
    // 设置名称
    threadC.name = @"子线程C";
    // 设置线程优先级
    threadC.threadPriority = 1.0;
    
    // 2.执行线程
    [threadC start];
}

// 分离子线程 自动启动线程
- (void) createOneThread_2{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"分离子线程"];
}

// 开启后台线程
- (void) createOneThread_3{
    [self performSelectorInBackground:@selector(run:) withObject:@"开启后台线程"];
}

- (void) run: (NSString *) param{
    
    NSLog(@"--------run---------%@---------%@",[NSThread currentThread],param);
    
    // 阻塞线程 阻塞时间完成后才会释放线程
    // 方法1.
//    [NSThread sleepForTimeInterval:2.0];
    // 方法2.
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
    
    NSLog(@"end-----");
    
}

- (void) task{
    for(NSInteger i = 0; i<100; i++){
        NSLog(@"%zd--------%@",i,[NSThread currentThread]);
        
        if(i == 20){
            // 强制退出线程
            [NSThread exit];
            break;
        }
    }
}

@end
