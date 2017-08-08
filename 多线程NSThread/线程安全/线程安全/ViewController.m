//
//  ViewController.m
//  线程安全
//
//  Created by ChangRJey on 2017/8/7.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** 售票员A */
@property (nonatomic, strong) NSThread * threadA;
/** 售票员B */
@property (nonatomic, strong) NSThread * threadB;
/** 售票员C */
@property (nonatomic, strong) NSThread * threadC;
/** 总票数 */
@property (nonatomic, assign) NSInteger totalCount;
@end

@implementation ViewController

/**
 * 互斥锁优缺点
 
   优点：能有效防止因多线程抢夺资源造成的数据安全问题
   缺点：需要消耗大量的CPU资源
 
   使用互斥锁的前提：多线程抢夺同一块资源
 
   相关专业术语：线程同步
   线程同步：多条线程在同一条线上执行（按顺序的执行任务）
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 设置总票数
    self.totalCount = 100;
    
    // 创建线程
    self.threadA = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadB = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.threadC = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
    
    self.threadA.name = @"售票员A";
    self.threadB.name = @"售票员B";
    self.threadC.name = @"售票员C";
    
    // 执行线程
    [self.threadA start];
    [self.threadB start];
    [self.threadC start];
}

- (void) saleTicket{
    
    while (1) {
        // 锁：必须是全局唯一的 一般使用 self
        // 1.注意加锁位置
        // 2.注意加锁的前提条件，多线程共享一块资源
        // 3.注意加锁是需要代价的，需要耗费性能和时间
        // 4.加锁的结果：线程同步  当线程A执行的时候进行加锁 线程B在外等着线程A结束 锁开了执行线程B
        @synchronized (self) {
            NSInteger count = self.totalCount;
            
            if(count > 0){
                // 耗时操作 
                for(NSInteger i = 0; i<100000; i++){
                    
                }
                self.totalCount = count - 1;
                
                NSLog(@"%@卖出一张票，还剩%zd张票",[NSThread currentThread].name,self.totalCount);
            }else{
                NSLog(@"票已经卖完");
                break;
            }
        }
    }
    
}

@end
