//
//  SQLMethods.h
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 3/26/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Product.h"
#import "Company.h"

@interface SQLMethods : NSObject

+(void) createOrOpenDB;
+(void) populateCompanyFromSQL;
+(NSMutableArray *) populateProductsFromSQL:(Company *)currentCompany;

+(void) saveCompanyToSQL:(Company *)currentCompany;
+(void) saveProductToSQL:(Product *)currentProduct;

@end
