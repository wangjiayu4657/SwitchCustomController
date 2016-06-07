//
//  NSObject+Extension.h
//  SwitchController
//
//  Created by fangjs on 16/6/6.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
- (id) performSelector:(SEL)selector withObjects:(NSArray *)objects;
@end
