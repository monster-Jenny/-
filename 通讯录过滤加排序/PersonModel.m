//
//  PersonModel.m
//  通讯录过滤加排序
//
//  Created by 王蓉蓉 on 16/5/19.
//  Copyright © 2016年 Monster. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
    }
    return self;
}

- (void)dealloc
{
    self.name = nil;
}

@end
