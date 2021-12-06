//
//  TJDataSourceController+Thread.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/6.
//

#import "TJDataSourceController+Thread.h"

@implementation TJDataSourceController (Thread)
// 创建线程
- (void)_creatPthread{
    /*
     第一个参数： 目标对象
     第二个参数： 方法选择器
     第三个参数： 前面调用方法需要传递的参数 可以为nil
     */
    
    //第一种
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(addSubThread:) object:@"123"];
    [thread start];
    thread.threadPriority = 1.0;
    //第二种 版本太高不建议使用
    if (@available(iOS 10.0, *)) {
        NSThread * thread2 = [[NSThread alloc] initWithBlock:^{
            NSLog(@"____%@",[NSThread currentThread]);
        }];
        thread2.name = @"我是子线程";
        [thread2 start];
    } else {
        // Fallback on earlier versions
    }
    //第三种
    [NSThread detachNewThreadSelector:@selector(addSubThread:) toTarget:self withObject:@"分离子线程"];
    //第四种创建线程
    [self performSelectorInBackground:@selector(addSubThread:) withObject:@"开启一条后台线程"];
}

-(void)addSubThread:(NSString *)str{
    NSLog(@"%@_____%@",str,[NSThread currentThread]);
}
// GCD sync同步函数+串行队列，不会会开启多条线程 ，队列中的任务是串行执行的
// 创建队列
-(void)_syncConcureent{
    /**
     第一个参数C语言的字符串，标签
     第二个参数队列的类型DISPATCH_QUEUE_CONCURRENT（并发)DISPATCH_QUEUE_SERIAL(串行)
     */
    
    dispatch_queue_t queue =  dispatch_queue_create("com.creatDown", DISPATCH_QUEUE_SERIAL);
    /*
     第一个参数队列
     第二个任务方法
     */
    dispatch_sync(queue, ^{
        NSLog(@"down%@",[NSThread currentThread]);
    });
}
//  异步函数，主队列：不会开辟线程
-(void)_asyncMain{
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        NSLog(@"down%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"down1%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"down2%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"down3%@",[NSThread currentThread]);
    });
    
}
// GCD 控制并发数量
- (void)_gcdControlConcurrency{
    dispatch_queue_t workConcurrentQueue = dispatch_queue_create("create_dispatch_queue_t_tongji",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue= dispatch_queue_create("create_dispatch_serialQueue",DISPATCH_QUEUE_SERIAL);
    // 并发三个线程
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
    for (NSInteger i = 0; i < 100; i++) {
        dispatch_async(serialQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(workConcurrentQueue, ^{
                sleep(1);
                NSLog(@"thread-info:%@结束执行任务%d",[NSThread
                                                 currentThread],(int)i);
                dispatch_semaphore_signal(semaphore);});
            
        });}
    
    NSLog(@"主线程...!");
}
// GCD 组内异步操作
- (void)_gcdGroupOperation{
    dispatch_queue_t queue = dispatch_queue_create("chunjie.ren", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < 100; i ++) {
        dispatch_group_async(group, queue, ^{
            dispatch_group_enter(group);//通知group，下面的任务马上要放到group中执行了
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                    NSLog(@"我等待了3秒_%@",[NSThread currentThread]);
                    dispatch_group_leave(group); //通知group，任务完成了，该任务要从group中移除了。
                });
            });
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"你们终于跑完了_%@",[NSThread currentThread]);
    });
}
// 栅栏函数
- (void)_barrierFunction{
    //获取全局并发队列
    //栅栏函数不能使用全局并发队列
    //       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); //全局并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.shanwen", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue1, ^{
        sleep(1);
        NSLog(@"down1===%@",[NSThread currentThread]);
    });
    dispatch_barrier_sync(queue1, ^{
        NSLog(@"栅栏函数");
    });
    dispatch_async(queue1, ^{
        NSLog(@"down2===%@",[NSThread currentThread]);
    });
    dispatch_barrier_sync(queue1, ^{
        sleep(3);
        NSLog(@"栅栏函数");
    });
    dispatch_async(queue1, ^{
        NSLog(@"down3===%@",[NSThread currentThread]);
    });
}
// 快速迭代
-(void)_rapidIteration{
    CGFloat star =  CFAbsoluteTimeGetCurrent();
    /**
     @param iterations#> 遍历的次数 100 description#>
     @param queue#> 队列(并发队列) description#>
     @param size_t 索引 index
     */
    NSLog(@"start");
    // index 无序
    dispatch_apply(1000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        NSLog(@"%zu___%@",index,[NSThread currentThread]);
    });
    NSLog(@"end");
    CGFloat stop =  CFAbsoluteTimeGetCurrent();
    NSLog(@"time = %f",stop -star);
    
}
// NSOperationBlock
-(void)_blockOperation{
    // 没有执行顺序
    NSBlockOperation * block = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"我是blockOperationWithBlock = %@",[NSThread currentThread]);
    }];
    // 不一定 blockOperationWithBlock 回调得快 还是 追加任务的快
    for (int i = 0 ; i < 10000; i ++) {
        //追加任务的时候是子线程中追加的
        [block addExecutionBlock:^{
            NSLog(@"追加任务%d个%@",i,[NSThread currentThread]);
        }];
    }
    [block start];
}
// NSOperation队列 使用
-(void)_blockOperationWithQueue{
    NSMutableArray * mArr = [NSMutableArray arrayWithCapacity:10000];
    for (int i = 0; i < 10000; i ++) {
        NSBlockOperation * block1 = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"%@",[NSThread currentThread]);
        }];
        [mArr addObject:block1];
    }
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [mArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [queue addOperation:obj];
        if (idx == 2000) {
            // 暂停
            queue.suspended = YES;
            NSLog(@"我暂停了");
            sleep(3);
        }
        
        if (idx == 3000) {
            // 开始
            NSLog(@"我暂停了");
            queue.suspended = NO;
            sleep(3);
        }
        if (idx == 9000) {
            // 取消所有方法 取消之后就没有任何反应了
            [queue cancelAllOperations];
            NSLog(@"我取消了");
        }
    }];
    
    //简单方法
    [queue addOperationWithBlock:^{
        NSLog(@"7---%@",[NSThread currentThread]);
    }];
}

-(void)_invocationOperationWithQueue{
    CGFloat start = CFAbsoluteTimeGetCurrent();
    NSMutableArray * mArray = [NSMutableArray arrayWithCapacity:1000];
    for(int i = 0;i < 10000;i ++){
        NSInvocationOperation * tion1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(_invocationOperation:) object:[NSString stringWithFormat:@"tion%d",i]];
        [mArray addObject:tion1];
    }
    /*
     GCD:
     串行类型:Create&主队列
     并行类型:Create&全局并发队列
     NSOperation:
     主队列:  [NSOperationQueue mainQueue] 和GCD主队列一样
     非主队列:[[NSOperationQueue alloc] init] 非常特殊具有（并行和串行的功能）
     //默认情况下非主队列是并行队列
     
     */
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [queue addOperation:obj];
    }];
    CGFloat end = CFAbsoluteTimeGetCurrent();
    NSLog(@"start - end %f",end-start);
}

- (void)_invocationOperation:(NSString *)text{
    NSLog(@"%@_%@",text,NSThread.currentThread);
}

-(void)_creatImage{
    __weak __block typeof(self) wself = self;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 300, 300)];
    //1创建队列
    __block UIImage * image1;
    __block UIImage * image2;
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    //2 封装操作，下载图片1
    NSBlockOperation * download = [NSBlockOperation blockOperationWithBlock:^{
        NSURL * url = [NSURL URLWithString:@"http://img.netbian.com/file/2017/0605/23c80014b9bc7748f631752a3c766a27.jpg"];
        
        NSData * data = [NSData dataWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
    }];
    //3 封装操作，下载图片2
    NSBlockOperation * download2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL * url = [NSURL URLWithString:@"http://img.netbian.com/file/2017/0605/2f62d25996dddc9e5622c03381fce662.jpg"];
        
        NSData * data = [NSData dataWithContentsOfURL:url];
        image2 = [UIImage imageWithData:data];
    }];
    
    //4 合成图片
    NSBlockOperation * mergeImage = [NSBlockOperation blockOperationWithBlock:^{
        //4.1 开上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        //4.2 画图1
        [image1 drawInRect:CGRectMake(0, 0, 200, 200)];
        //4.3 画图2
        [image2 drawInRect:CGRectMake(100, 100, 100, 100)];
        //4.4 根据上下文得到图片
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        //4.5 关上下文
        UIGraphicsEndImageContext();
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            imageView.image = image;
            __strong typeof(wself) sself = wself;
            [sself.view addSubview:imageView];
            [sself moveSubViews];
        }];
    }];
    
    
    //5 设置依赖关系
    [mergeImage addDependency:download];
    [mergeImage addDependency:download2];
    //6.添加操作到队列中去
    [queue addOperation:download];
    [queue addOperation:download2];
    [queue addOperation:mergeImage];
    
}
// GCD 定时器
- (void)_timingTask{
    //创建timer 不能多次创建
    NSLog(@"添加了定时器");
    __weak __block typeof(self) wself = self;
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:maskView];
    dispatch_source_t source_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    //设置timer
    dispatch_source_set_timer(source_t, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    //设置回调
    dispatch_source_set_event_handler(source_t, ^{
        NSLog(@"123");
    });
    //启动timer
    dispatch_resume(source_t);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"移除了定时器");
        //暂停对象不能为空 不能为局部变量
        //dispatch_suspend(source_t);
        dispatch_source_cancel(source_t);
        __strong typeof(wself) sself = wself;
        [sself moveSubViews];
    });
    
}
// 线程保活
- (void)_threadToKeepAlive{
    if (@available(iOS 10.0, *)) {
        NSThread * thred = [[NSThread alloc] initWithBlock:^{
            NSLog(@"创建一个子线程");
            // 往RunLoop的 Mode 中添加一个source1任务
            [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        }];
        [thred start];
    }
}

@end
