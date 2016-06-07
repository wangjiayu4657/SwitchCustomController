//
//  NSObject+Extension.m
//  SwitchController
//
//  Created by fangjs on 16/6/6.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (id) performSelector:(SEL)selector withObjects:(NSArray *)objects {
   
    //方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
         [NSException raise:@"方法错误" format:@"%@方法找不到",NSStringFromSelector(selector)];
    }
    
    // NSInvocation:利用一个 NSInvocation 对象包装一次方法调用(方法调用者 方法名 方法参数 方法返回值)
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    // 除self、_cmd以外的参数个数
    NSInteger paramsCount = signature.numberOfArguments - 2;
    paramsCount = MIN(paramsCount, objects.count);
    //设置参数
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    
    // 调用方法
    [invocation invoke];
    
    //获取返回值
    id returnVale = nil;
    if (signature.methodReturnLength) {
        //有返回值类型,才去获得返回值
        [invocation getReturnValue:&returnVale];
    }
    return returnVale;
}

@end

