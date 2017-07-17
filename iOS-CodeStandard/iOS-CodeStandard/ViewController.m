//
//  ViewController.m
//  iOS-CodeStandard
//
//  Created by zhangfuwei on 2017/7/17.
//  Copyright © 2017年 BIZ. All rights reserved.
//

#import "ViewController.h"
#import "BIZConsultModel.h"

#import "UIColor+Extension.h"


// 关于宏的使用要注意下,不建议过多的使用

// 比如下面这种一定要注意加个括号
//#define kDOUBLE_SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds) * 2
#define kDOUBLE_SCREEN_WIDTH (CGRectGetWidth([UIScreen mainScreen].bounds) * 2)

// 这样其实可以使用内联函数替代,因为内联函数更容易检测到错误
static inline CGFloat doubleScreenWidth() {
    return CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
}


/** 如果只是的全局变量声明替换，推荐使用常量定义 */
#define METHOD(a) [NSString stringWithFormat:@"%@", a] // 内部宏定义，除非是只能用宏来完成，否则推荐使用常量定义，例如cellID,通知名
static NSString * const kCellId = @"cell"; // 常量定义,私有常量用首字母k标注

// 对应extern的声明的变量进行定义
NSString * const BIZAnotherNotificationName = @"aNotification"; // 外部公用常量：类名 + 常量名，并且在头文件中 extern 声明


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  在消息发送的时候增加的开销是微不足道的。更多关于性能问题的介绍你可以看 Should I Use a Property or an Instance Variable?(http://blog.bignerdranch.com/4005-should-i-use-a-property-or-an-instance-variable/) 所以，在属性和变量之间，尽可能的使用属性吧，除非有特别的需要
 */

@property (nonatomic, copy, readwrite) NSString *uuid;// 使用 readwrite 重写属性保持内部可写可读
@property (nonatomic, assign, readwrite) BIZViewControllerTypeFrom typeFrom;


// 内部.m方法注释用“//”简洁易懂
@property (nonatomic, strong) UITableView *tableView; // tableView

@property (nonatomic, strong) NSMutableArray *dataSource; // 数据源
@property (nonatomic, strong) UIButton *settingButton; // 属性应该尽可能描述性地命名，避免缩写，并且是小写字母开头的驼峰命名，不推荐setBtn 缩写命名

@end

@implementation ViewController {
    // 实例变量名之前Google的代码规范建议是带一个"_"以便于和属性区分开
    
    // 自定义的界面
    UIView *_customView;
    
    // 自定义按钮
    UIButton *_customButton;
}

#pragma mark - delloc & init

// 方法的调用注意空格的使用
// -/+ 和 (返回值) 之间应该有一个空格.

/* delloc 和 init 写在最前面，保持醒目，另外方法括号位置不推荐使用
 - (void)dealloc
 {
 
 }
 推荐使用下面的写法
 */
- (void)dealloc {
}

- (instancetype)initWithUuid:(NSString *)uuid state:(BIZViewControllerTypeFrom)typeFrom {
    if (!(self = [super init])) {
        // 尽量在不满足条件时及时return
        return nil;
    }
    _uuid = uuid;
    _typeFrom = typeFrom;
    _dataSource = [NSMutableArray array];
    return self;
}

#pragma mark -- lifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layoutUI];
    
    _dataSource = @[@"A",@"B",@"C",@"D"].mutableCopy;
    
    NSDictionary *titles = @{@"A":@"andy",@"B":@"brain",@"C":@"candy"};
    NSNumber *shouldUseLiterals = @YES;
    NSNumber *buildingZIPCode = @10018; // @(10018)
     #pragma unused (titles,shouldUseLiterals,buildingZIPCode) // 忽略没有用的警告
    
    NSError *error = nil;
    // ...
    if (!error) { // 推荐使用括号划定作用范围，使用!判断条件，不推荐 if(error == nil) return;
        // ...
        return;
    }
    
    // 多参数方法调用规范,让“:”保持对其
    [UIView animateWithDuration:1.0
                          delay:1.0
                        options:UIViewAnimationOptionRepeat
                     animations:^{
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    // 不推荐
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionRepeat animations:^{
        
    } completion:^(BOOL finished) {
        
    }];

    
    // 变量名也要有意义
    UIColor *color = [UIColor whiteColor];
    // 减少没有意思的变量名
    // UIColor *c = [UIColor whiteColor];
    // 或者过于简短的缩写
    // UIColor *col = [UIColor whiteColor];
    
    // 使用美式英语为主, 避免使用英式英语, 比如colour是英式英语, 不建议使用如下变量名
    // UIColor *colour = [UIColor whiteColor];
    
    // 对于调用相同方法名的类别方法, 行为是不确认的
    // 这也是类别方法加一个前缀的原因, 和别的模块区分开
    [color biz_colorDescription];
    
    // CGFloat的变量统一使用CGFloat,
    CGFloat width = kDOUBLE_SCREEN_WIDTH;
    // 避免使用float
    // float fWidth = kDOUBLE_SCREEN_WIDTH;
    
    // 定义的变量要使用, 不然会有警告. 不要忽视这样警告.
    // 如果定义的变量已经不再使用, 那么注释掉或者删掉, 留着时间长了会造成误解
    NSLog(@"%f", width);
    
    
    // 有些返回值应该需要使用临时的中间变量存储一下,使得逻辑更加的清晰
    // 比如如下的使用,就能使得代码更加清晰
    BOOL viewIsAppearing = ([self isBeingPresented] || [self isMovingToParentViewController]);
    BOOL viewIsDisappearing = ([self isBeingDismissed] || [self isMovingFromParentViewController]);
    // 转场动画正在进行的时候, 不要做任何操作
    if (viewIsAppearing || viewIsDisappearing) {
        // ...
    }
    
    // 关于大括号, 代码块的使用, 大括号内的对象是有生命周期的, 出了大括号的话, 里面的对象就被释放掉了
    // 巧妙的使用大括号, 可以使得代码更清晰整洁
    {
        // 这里的width的作用域仅限于大阔内, 不建议这么使用, 这里仅作例子
        CGFloat width = doubleScreenWidth();
    }
    
    // 三个叹号可以着重标记, 可以快速查找
    // !!!: 宏的使用
    NSLog(@"macro : double screen width : %f", kDOUBLE_SCREEN_WIDTH);
    NSLog(@"inline: double screen width : %f", doubleScreenWidth());
    
    // MARK也可以进行着重标记
    // MARK: block的使用
    // 如果代码较多, 就应该考虑抽象出一个方法出来
    [self showHowToUseBlocks];
    
    // 三个问号可以着重标记, 可以快速查找
    // ???: 方法的调用
    [self showHowToCallMethods];
    
    // 条件语句的使用
    [self showHowToUseControlFlow];
    
    // 快速枚举的使用
    [self showHowToFastEnumerator];
    
    // 运算也需要注意空格, 可以多添加一些括号帮助理解
    NSInteger sum = 1 + 2 + 3;
    sum = sum * 3;
    sum += 2;
    ++sum;
    
    sum = 1 + 2 + 3 * 4;
    sum = 1 + 2 + 3*4;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response
// 事件响应
#pragma mark - ControllerDataSource
// 苹果SDK提供数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    cell.textLabel.text = _dataSource[indexPath.row];
    //    [cell setModel:self.dataSource[indexPath.row]]; // 设置模型
    return cell;
}
#pragma mark - ControllerDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
// 苹果SDK提供的代理
#pragma mark - CustomDelegate
// 自定义的代理
#pragma mark - public methods
- (void)doSomeThingWithArray:(NSArray *)array {
    _dataSource = [_dataSource arrayByAddingObjectsFromArray:array].mutableCopy;
    [_tableView reloadData];
}

#pragma mark - private methods
// 当前控制器使用的私有文件
- (void)layoutUI {
    // UI布局主要为add添加相关，具体配置在get方法中实现
    [self.view addSubview:self.tableView];
}

// 展示block的规范
- (void)showHowToUseBlocks
{
    // 简单同步block
    void (^syncBlock)() = ^{
        NSLog(@"sync block");
    };
    syncBlock();
    
    // 简单异步block, 这种下一个runloop就调用的block就不需要weak下self了
    void (^asyncBlock)() = ^{
        NSLog(@"async block");
    };
    dispatch_async(dispatch_get_main_queue(), asyncBlock);
    
    // 较长延时的block, 主要是网络的异步, 需要weak下self
    // 主要避免循环引用
    __weak typeof(self) weakSelf = self;
    void (^delayAsyncBlock)() = ^{
        // 将weakSelf强引用一下, 这样保证了在这个block块执行期间,strongSelf一直有效,不会被释放掉
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        NSLog(@"strong self : %@", strongSelf);
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), delayAsyncBlock);
    
    // 直接当参数使用的block
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%s", __func__);
    });
    
    // 代码行数较多的block块
    // 建议将block单独定义成变量
    void (^largeBlock)() = ^{
        // balabala....
        NSLog(@"step 1");
        // 此处省略N行代码
        
        // balabala....
        NSLog(@"step 2");
        // 此处省略N行代码
        
        // balabala....
        NSLog(@"step 3");
        // 此处省略N行代码
        
        // balabala....
        NSLog(@"step 4");
        // 此处省略N行代码
    };
    // 调用largeBlock变量
    dispatch_async(dispatch_get_main_queue(), largeBlock);
    
    
    // 多个block参数的使用
    // 第一种
    [UIView animateWithDuration:0.3 animations:^{
        // ...
    } completion:^(BOOL finished) {
        // ...
    }];
    
    // 第二种
    [UIView animateWithDuration:0.3
                     animations:^{
                         // ...
                     } completion:^(BOOL finished) {
                         // ...
                     }];
    
    
}

- (void)showHowToCallMethods {
    
    // 换行显示(推荐使用)
    [self performSelector:@selector(description)
               withObject:nil
               afterDelay:1.0];
    
    // 一行显示(不推荐使用)
    [self performSelector:@selector(description) withObject:nil afterDelay:1.0];
    
    
}

- (void)showHowToUseControlFlow {
    BOOL flag = YES;
    if (flag) {
        // ...
    } else {
        // ...
    }
    
    // 注释1
    if (flag) {
        
    }
    // 注释2
    else {
        
    }
    
    // 不建议如下使用if/else
    if (flag)
        NSLog(@"if 没有大括号...");
    else
        NSLog(@"else 没有大括号...");
    
    
    NSInteger num = 2;
    switch (num) {
        case 1: {
            // switch里面代码较多的话需要加上大括号
        }
            break;
            
            // 关于条件的注释
        case 2: {
            // 大括号也可以加在break后面
            break;
        }
            
        case 3:
            // 简单的几行代码, 可以不适用大括号
            break;
            
        default:
            break;
    }
}

- (void)showHowToFastEnumerator {
    // 建议使用Modern Objective-C 语法
    NSArray *nums = @[@1, @2, @3, @4, @5, @6];
    
    // 推荐使用
    [nums enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger idx, BOOL *stop) {
        //
    }];
    
    // 一般使用
    for (NSNumber *num in nums) {
        NSLog(@"%@", num);
    }
    
    // 不建议使用, 不够现代化
    NSUInteger count = nums.count;
    // for循环的使用注意空格
    for (NSUInteger index = 0; index < count; ++index) {
        // 建议使用Modern Objective-C 语法
        NSNumber *num = nums[index];
        NSLog(@"%@", num);
    }
    
    // 也不建议这么使用, 不够现代化
    NSNumber *num = nil;
    NSEnumerator *enumerator = [nums objectEnumerator];
    while ((num = enumerator.nextObject) != nil) {
        NSLog(@"%@", num);
    }
    
    // 字典的使用
    NSDictionary *dictionary = @{@1 : @"1",
                                 @2 : @"2",
                                 @3 : @"3",
                                 @4 : @"4"};
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //
    }];
}

#pragma mark - getter and setter 懒加载
/** 视情况而定，不一定在这里初始化 */
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 注册cell
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
        

    }
    return _tableView;
}

- (void)setConsultModel:(BIZConsultModel *)consultModel {
    _consultModel = consultModel;
    // 根据模型去 做其他后续操作
}

@end
