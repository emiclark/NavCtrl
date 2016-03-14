//
//  Company.m
//  NavCtrl
//  ASSIGNMENT 5
//  Use Yahoo finance API to get stock prices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (id) initWithName:(NSString*)name andStockSymbol:(NSString *)stockSymbol andLogo:(NSString*)logo{
    self=[super init];
    if (self) {
        self.name = name;
        self.stockSymbol = stockSymbol;
        self.logo = logo;
        self.productArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSString*)description {
    
    return [NSString stringWithFormat:@"%@, %@", self.name, self.logo];
}
@end

