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
//#import "sqlite3.h"
//#import "SQLMethods.h"

@interface DAO : NSObject

@property (nonatomic,strong) Company *currentCompany;
@property (nonatomic,strong) Product *currentProduct;

@property (nonatomic) int newCompanyID;
@property (nonatomic) int newProductID;

@property ( nonatomic) float newCompanyRow;
@property ( nonatomic) float newProductRow;

@property (nonatomic, retain) NSMutableArray *companyList;

#pragma mark Singleton Methods
+(id)sharedManager;
+(void) initializeDAO;

#pragma mark Company CRUD Methods
+(void) addCompany:(Company *)currentCompany;
+(void) updateCompany:(Company *)currentCompany;
-(void) deleteCompany:(Company *)currentCompany atRow:(NSInteger)row;
+(void) moveCompany:(Company *)currentCompany;
+(void) undoCompany;
+(void) save;

#pragma mark Product CRUD Methods
-(void) addProduct:(Product *)currentProduct;
+(void) updateProduct:(Product *)currentProduct;
-(void) deleteProduct:(Product *)currentProduct atRow:(NSInteger)row;
+(void) moveProduct:(Product *)currentProduct;
+(void) undoProduct;

#pragma mark Misc Methods
+(float) getNewCompanyRowNumber;
+(float) getNewProductRowNumber;

@end




