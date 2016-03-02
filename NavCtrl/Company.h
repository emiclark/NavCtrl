//
//  Company.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//  Created by Emiko Clark on 2/26/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSMutableArray <Product*>  *productArray;


- (id) initWithName:(NSString*)name andLogo:(NSString*)logo;
@end
