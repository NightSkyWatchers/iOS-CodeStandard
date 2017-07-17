//
//  ViewController.h
//  iOS-CodeStandard
//
//  Created by zhangfuwei on 2017/7/17.
//  Copyright © 2017年 BIZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BIZConsultModel; // 使用@class 来使用一个类, 实现文件.m中再使用#import 导入,减少交叉编译

/** 枚举遵循苹果官方命名规则：类名 + enum类型名 */
typedef NS_ENUM(NSUInteger,BIZViewControllerTypeFrom) {
    BIZViewControllerTypeNone,
    BIZViewControllerTypeFromHome,
    BIZViewControllerTypeFromOffline,
    BIZViewControllerTypeFromMyInfo,
};


// 像这种的定义NSString类型的宏
#define BIZOneNoticicationName @"BIZOneNotificationName"
// 可以使用extern声明替代
extern NSString * const BIZAnotherNotificationName;



@interface ViewController : UIViewController
/** 外部变量可用块注释,符合doc规范，属性变量都采取驼峰命名方法 */

/** uuid */
@property (nonatomic, copy, readonly) NSString *uuid; // 对暴漏的属性如果非必要，尽量readonly，保证可控

/** 跳转来源控制器 */
@property (nonatomic, assign, readonly) BIZViewControllerTypeFrom typeFrom;

/** model */
@property (nonatomic, strong) BIZConsultModel *consultModel;


/**
 初始化方法
 
 @param uuid 全局标识符
 @param typeFrom 跳转来源
 @return 本类实体对象
 */
- (instancetype)initWithUuid:(NSString *)uuid state:(BIZViewControllerTypeFrom)typeFrom ;// 方法名之间尽量少用 and

/**
 

 @param array 传字符串作为参数
 */
- (void)doSomeThingWithArray:(NSArray*) array;

@end

