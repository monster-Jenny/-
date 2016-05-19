//
//  ChineseString.m
//  通讯录过滤加排序
//
//  Created by 王蓉蓉 on 16/5/19.
//  Copyright © 2016年 Monster. All rights reserved.
//

#import "ChineseString.h"

@implementation ChineseString
@synthesize model;
@synthesize pinyin;

+ (NSMutableArray *)indexArrayFilterWithOriginalArray:(NSMutableArray *)originalArray
{
    NSMutableArray * tempArray = [self returnSortedArrayWithArray:originalArray];
    NSMutableArray *A_Result = [NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((ChineseString*)object).pinyin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            // NSLog(@"IndexArray----->%@",pinyin);
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;
}

+ (NSMutableArray *)sortArrayFilterWithOriginalArray:(NSMutableArray *)originalArray
{
    NSMutableArray * tempArray = [self returnSortedArrayWithArray:originalArray];
    NSMutableArray *LetterResult = [NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    //拼音分组
    for (ChineseString * object in tempArray) {
        
        NSString *tpinyin = [object.pinyin substringToIndex:1];
        PersonModel *person = object.model;
        //不同
        if(![tempString isEqualToString:tpinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:person];
            [LetterResult addObject:item];
            //遍历
            tempString = tpinyin;
        }
        else//相同
        {
            [item  addObject:person];
        }
    }
    return LetterResult;
}

+ (NSMutableArray *)returnSortedArrayWithArray:(NSMutableArray *)originalArray
{
    //获取字符串中文字的拼音首字母并与模型共同存放
    NSMutableArray * chineseStringArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < originalArray.count; i ++) {
        ChineseString * chineseStr = [[ChineseString alloc] init];
        chineseStr.model = originalArray[i];
        
        //先过滤掉姓名中的一些特殊字符，空格，等等
        //过滤掉两边的空格和回车
        chineseStr.model.name = [chineseStr.model.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //过滤掉中间的特殊字符
        chineseStr.model.name = [self removeSpecialCharacter:chineseStr.model.name];
        
        //开始将姓名的首字母提取出来
        //判断首字符是否为字母（即可能是英文名）
        NSString * RegEx = @"[A-Za-z]+";//正则表达式
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",RegEx];
        NSString *initialStr = [chineseStr.model.name length]?[chineseStr.model.name substringToIndex:1]:@"";
        if ([predicate evaluateWithObject:initialStr]) {
            chineseStr.pinyin = [chineseStr.model.name capitalizedString];
        }
        else
        {
            if (![chineseStr.model.name isEqualToString:@""]) {
                NSString *PinYin = [[NSString alloc] init];
                for (int j = 0; j < chineseStr.model.name.length; j ++) {
                    PinYin = [PinYin stringByAppendingString:[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseStr.model.name characterAtIndex:j])] uppercaseString]];
                }
                chineseStr.pinyin = PinYin;
            }
            else
            {
                chineseStr.pinyin = @"";
            }
        }
        [chineseStringArray addObject:chineseStr];
    }
    
    //对chineseStringArray按照拼音进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    [chineseStringArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringArray;
}

+ (NSString *)removeSpecialCharacter:(NSString *)string
{
    NSRange range = [string rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (range.location != NSNotFound) {
        return [self removeSpecialCharacter:[string stringByReplacingCharactersInRange:range withString:@""]];
    }
    return string;
}

@end
