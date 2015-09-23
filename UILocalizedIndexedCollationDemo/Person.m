//
//  Person.m
//  UILocalizedIndexedCollationDemo
//
//  Created by 吴珂 on 15/9/22.
//  Copyright © 2015年 MyCompany. All rights reserved.
//

#import "Person.h"

@implementation Person


- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]) {
        self.name = name;
    }
    
    return self;
}
@end
