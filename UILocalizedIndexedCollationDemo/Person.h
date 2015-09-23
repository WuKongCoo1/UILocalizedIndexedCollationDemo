//
//  Person.h
//  UILocalizedIndexedCollationDemo
//
//  Created by 吴珂 on 15/9/22.
//  Copyright © 2015年 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (instancetype) initWithName:(NSString *)name;

@property (nonatomic, copy) NSString *name;

@end
