//
//  DAO.h
//  NavCtrl
// Assignment8
// CoreData
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

@property (nonatomic,strong) Company *currentCompany;
@property (nonatomic,strong) Product *currentProduct;

@property (nonatomic) int newCompanyID;
@property (nonatomic) int newProductID;

@property ( nonatomic) float newCompanyRow;
@property ( nonatomic) float newProductRow;

@property (nonatomic, retain) NSMutableArray *companyList;

+ (id)sharedManager;
//- (instancetype) init;
+ (void) initializeDAO;

- (NSMutableArray *) populateProducts:(Company  *)currentCompany ;

- (void) addCompany:(Company *)currentCompany;
- (void) addProduct:(Product *)currentProduct;

- (void) updateCompany:(Company *)currentCompany;
+ (void) updateProduct:(Product *)currentProduct;
//- (void) updateCompany:(Company *)currentCompany AtIndex:(NSInteger)index;
//- (void) updateProduct:(Product *)currentProduct AtIndex:(NSInteger)index;

- (void) deleteCompany:(Company *)currentCompany atRow:(NSInteger)row;
- (void) deleteProduct:(Product *)currentProduct atRow:(NSInteger)row;






@end




