//
//  Product.m
//  NavCtrl
//  ASSIGNMENT4
//  DAO refactored: Add/Edit Company+Product, + reorder+delete rows
//
//  Created by Emiko Clark on 2/26/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id) initWithName:(NSString*)name andUrl:(NSString*)url andLogo:(NSString*)logo{
    self=[super init];
    if (self) {
        self.name = name;
        self.url  = url;
        self.logo = logo;
//        NSLog(@"_init:%@",self);
        
    }
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@, %@, %@", self.name, self.url, self.logo];
}
@end
