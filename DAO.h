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
#import "sqlite3.h"
#import "SQLMethods.h"

@interface DAO : NSObject


@property (nonatomic) NSInteger currentCompanyIndex;
@property (nonatomic) NSInteger currentProductIndex;

@property (nonatomic,strong) Company *currentCompany;
@property (nonatomic,strong) Product *currentProduct;


@property (nonatomic, retain) NSMutableArray <Company *>  *companyList;

+ (id)sharedManager;

- (void) initializeDAOsetupSQL;
- (void) populateCompany;
- (void) populateProducts:(Company  *)currentCompany ;

- (void) saveCompany:(Company *)currentCompany;
- (void) saveProduct:(Product *)currentProduct;

//- (void) updateCompany:(Company *)currentCompany;
//- (void) updateProduct:(Product *)currentProduct;

//- (void) deleteCompany:(Company *)currentCompany;
//- (void) deleteProduct:(Product *)currentProduct;
//
//- (void) moveCompany:(Company *)currentCompany;
//- (void) moveProduct:(Product *)currentProduct;

@end


