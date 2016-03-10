//
//  DAO.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO refactored: Add/Edit Company+Product, + reorder+delete rows
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray <Company *>  *companyList;
@property (nonatomic) NSUInteger companyNo;

+ (id)sharedManager;
@end
