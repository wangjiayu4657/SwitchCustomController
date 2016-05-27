//
//  WJYModel.h
//  SwitchController
//
//  Created by fangjs on 16/5/27.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJYModel : NSObject


/**name*/
@property (strong , nonatomic) NSString *name;

/**icon*/
@property (strong , nonatomic) NSString *icon;

/**highlighted_icon*/
@property (strong , nonatomic) NSString *highlighted_icon;

/**NSArray*/
@property (strong , nonatomic) NSArray *subcategories;

+(instancetype) wjyModelInitWithDictionary:(NSDictionary *) dictionary;

@end
