//
//  ChineseString.h
//  通讯录过滤加排序
//
//  Created by 王蓉蓉 on 16/5/19.
//  Copyright © 2016年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"
#import "PersonModel.h"

@interface ChineseString : NSObject

@property (nonatomic, strong) PersonModel * model;

@property (nonatomic, strong) NSString *pinyin;

+ (NSMutableArray *)indexArrayFilterWithOriginalArray:(NSMutableArray *)originalArray;

+ (NSMutableArray *)sortArrayFilterWithOriginalArray:(NSMutableArray *)originalArray;

@end
