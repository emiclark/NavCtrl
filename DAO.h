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
@property (nonatomic) NSInteger currentCompanyID;
@property (nonatomic) NSInteger currentProductID;
@property (nonatomic) int newCompanyID;

@property (nonatomic,strong) Company *currentCompany;
@property (nonatomic,strong) Product *currentProduct;


@property (nonatomic, retain) NSMutableArray <Company *>  *companyList;

+ (id)sharedManager;

- (void) initializeDAOsetupSQL;
- (void) populateProducts:(Company  *)currentCompany ;

- (void) deleteCompany:(Company *)currentCompany atRow:(NSInteger)row;
- (void) deleteProduct:(Product *)currentProduct atRow:(NSInteger)row;

- (void) updateCompany:(Company *)currentCompany AtIndex:(NSInteger)index;
- (void) updateProduct:(Product *)currentProduct AtIndex:(NSInteger)index;

- (void) addCompany:(Company *)currentCompany;
- (void) addProduct:(Product *)currentProduct;

//- (void) moveCompany:(Company *)currentCompany fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)index;
////- (void) moveProduct:(Product *)currentProduct;

@end


