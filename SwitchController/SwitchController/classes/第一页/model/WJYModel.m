//
//  WJYModel.m
//  SwitchController
//
//  Created by fangjs on 16/5/27.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYModel.h"

@implementation WJYModel


+(instancetype)wjyModelInitWithDictionary:(NSDictionary *)dictionary {
    WJYModel *model = [[WJYModel alloc] init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}


@end
