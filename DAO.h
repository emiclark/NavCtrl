//
//  DAO.h
//  NavCtrl
// Assignment7-MMM
// Manual Memory Management
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

@property (nonatomic, retain) NSMutableArray *companyList;

+ (id)sharedManager;

- (void) initializeDAOsetupSQL;
- (NSMutableArray *) populateProducts:(Company  *)currentCompany ;

- (void) deleteCompany:(Company *)currentCompany atRow:(NSInteger)row;
- (void) deleteProduct:(Product *)currentProduct atRow:(NSInteger)row;

- (void) updateCompany:(Company *)currentCompany AtIndex:(NSInteger)index;
- (void) updateProduct:(Product *)currentProduct AtIndex:(NSInteger)index;

- (void) addCompany:(Company *)currentCompany;
- (void) addProduct:(Product *)currentProduct;


@end




