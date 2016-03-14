//
//  Company.h
//  NavCtrl
//  ASSIGNMENT 5
//  Use Yahoo finance API to get stock prices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *stockSymbol;
@property (nonatomic, strong) NSString *stockPrice;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSMutableArray <Product*>  *productArray;



- (id) initWithName:(NSString*)name andStockSymbol:(NSString *)stockSymbol andLogo:(NSString*)logo;
@end