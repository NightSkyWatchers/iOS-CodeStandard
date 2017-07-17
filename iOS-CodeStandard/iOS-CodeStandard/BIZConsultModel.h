//
//  BIZConsultModel.h
//  iOS-CodeStandard
//
//  Created by zhangfuwei on 2017/7/17.
//  Copyright © 2017年 BIZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIZConsultDataModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 年龄 */
@property (nonatomic, assign) NSInteger age;

@end

/**
 code	String	必选	状态代码。
 1：获取数据成功
 0：获取数据失败
 des	String	必选	描述
 */
@interface BIZConsultModel : NSObject
/** 返回值 */
@property (nonatomic, copy) NSString *code;
/** 描述 */
@property (nonatomic, copy) NSString *des;

/** 数据 */
@property (nonatomic, strong) NSArray <BIZConsultDataModel *>*data;

@end
