//
//  Company.m
//  NavCtrl
//  ASSIGNMENT4
//  DAO refactored: Add/Edit Company+Product, + reorder+delete rows
//
//  Created by Emiko Clark on 2/26/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (id) initWithName:(NSString*)name andLogo:(NSString*)logo{
    self=[super init];
    if (self) {
        self.name = name;
        self.logo = logo;
        self.productArray = [[NSMutableArray alloc]init];
//        NSLog(@"_init:%@",self);
    }
    return self;
}

-(NSString*)description {

    return [NSString stringWithFormat:@"%@, %@", self.name, self.logo];
}
@end
