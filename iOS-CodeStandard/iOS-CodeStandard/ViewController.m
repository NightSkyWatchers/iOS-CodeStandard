//
//  ViewController.m
//  iOS-CodeStandard
//
//  Created by zhangfuwei on 2017/7/17.
//  Copyright © 2017年 BIZ. All rights reserved.
//

#import "ViewController.h"
#import "BIZConsultModel.h"

/** 如果只是的全局变量声明替换，推荐使用常量定义 */
#define METHOD(a) [NSString stringWithFormat:@"%@", a] // 内部宏定义，除非是只能用宏来完成，否则推荐使用常量定义，例如cellID,通知名
static NSString * const kCellId = @"cell"; // 常量定义,私有常量用首字母k标注
NSString * const YCViewControllerNotificationName = @"aNotification"; // 外部公用常量：类名 + 常量名，并且在头文件中 extern 声明


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

@implementation ViewController

#pragma mark - delloc & init
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
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
}

#pragma mark - getter and setter 懒加载
/** 视情况而定，不一定在这里初始化 */
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)setConsultModel:(BIZConsultModel *)consultModel {
    _consultModel = consultModel;
    // 根据模型去 做其他后续操作
}

@end
