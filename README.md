# iOS-CodeStandard
iOS代码规范
基于所在的两家公司的代码开发需求编写的一部分代码规范


/** 如果只是的全局变量声明替换，推荐使用常量定义 */
#define METHOD(a) [NSString stringWithFormat:@"%@", a] // 内部宏定义，除非是只能用宏来完成，否则推荐使用常量定义，例如cellID,通知名
/** 通知名 */
extern NSString * const BIZViewControllerNotificationName;
static NSString * const kCellId = @"cell"; // 常量定义,私有常量用首字母k标注
/**
 *  在消息发送的时候增加的开销是微不足道的。更多关于性能问题的介绍你可以看
 Should I Use a Property or an Instance Variable?(http://blog.bignerdranch.com/4005-should-i-use-a-property-or-an-instance-variable/)
 所以，在属性和变量之间，尽可能的使用属性吧，除非有特别的需要
 */
