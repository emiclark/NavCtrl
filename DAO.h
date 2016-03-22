//
//  DAO.h
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray <Company *>  *companyList;
@property (nonatomic) NSInteger companyNo;

+ (id)sharedManager;

- (void) createOrOpenDB;
- (void) populateCompany;
- (void) populateProductsForCompany:(NSInteger)companyID;
@end
