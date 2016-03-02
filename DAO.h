//
//  DAO.h
//  NavCtrl
//  ASSIGNMENT4
//  DAO ADD Company + Product
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray <Company *>  *companyList;

+ (id)sharedManager;
@end
