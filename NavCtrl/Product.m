//
//  Product.m
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
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
        
    }
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@, %@, %@", self.name, self.url, self.logo];
}
@end
