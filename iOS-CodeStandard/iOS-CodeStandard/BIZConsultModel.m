//
//  BIZConsultModel.m
//  iOS-CodeStandard
//
//  Created by zhangfuwei on 2017/7/17.
//  Copyright © 2017年 BIZ. All rights reserved.
//

#import "BIZConsultModel.h"


@implementation BIZConsultDataModel

@end

@implementation BIZConsultModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"data":BIZConsultDataModel.class};
}

@end
