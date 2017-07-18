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
/**
代码规范：
1、用的舒服、看着舒服、养成习惯
2、多用空格，多用回车（这个类里面的东西都是用了大量的空格和回车，大家仔细看看）
3、命名规范，简单的用英文，复杂的用中文，长度要控制好，别太长了
4、多用已经定义好的公共方法
5、尽量消灭警告，如果是第三方代码，就要小心的
6、注意内存管理
7、XCODE使用通用的第三方控件，如何自动显示注释、自动对齐
8、XCODE显示一行的字符，100字符
9、少用消息机制，多用block、代理
10、版本的API要考虑到兼容到iOS7，如果API有变动要增加版本控制，特别是电商
11、如果建立文件夹要先建立物理文件夹，然后拖入到工程里面，禁止在工程里面建立逻辑文件夹
12、此项目中所有代码都是手写的，禁止使用xid等自动生成代码工具
13、项目的图片资源，要定期清理一下将不用的图片删除掉
15、做界面时，一定考虑适配界面，参考适配文档；
16、基本类型，首先考虑使用NS框架的类型，不要用C类型
17、创建Button时，注意button的点击有效区域，要尽量大一些；
18、注意数据类型在可变和不可变之间的赋值，尽量避免直接赋值，会引起异常；
*/
 @end

