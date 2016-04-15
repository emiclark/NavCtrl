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


// Singleton Methods
+(id)sharedManager;
+(void) initializeDAO;

// Company CRUD Methods
+(void) addCompany:(Company *)currentCompany;
+(void) updateCompany:(Company *)currentCompany;
-(void) deleteCompany:(Company *)currentCompany atRow:(NSInteger)row;
+(void) undoCompany;
+(void) save;

// Product CRUD Methods
-(void) addProduct:(Product *)currentProduct;
+(void) updateProduct:(Product *)currentProduct;
-(void) deleteProduct:(Product *)currentProduct atRow:(NSInteger)row;
+(void) undoProduct;

//- (void) undoProductforCompany:(Company*)currentCompany;

// Utility Methods
+(float) getNewCompanyRowNumber;
+(float) getNewProductRowNumber;

@end




