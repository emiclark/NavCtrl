//
//  DAO.h
//  NavCtrl
// Assignment10
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "AFNetworking.h"
#import "CompanyCollectionViewController.h"
@class CompanyCollectionViewController;

@interface DAO : NSObject

@property (nonatomic,strong) Company *currentCompany;
@property (nonatomic,strong) Product *currentProduct;

@property (nonatomic) int newCompanyID;
@property (nonatomic) int newProductID;

@property ( nonatomic) float newCompanyRow;
@property ( nonatomic) float newProductRow;

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableString *stockSymbol;
@property (nonatomic, retain) CompanyCollectionViewController *ccvc;

    
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

    
#pragma mark Get Yahoo Stock Prices
-(void)updateStockPrices;
    
#pragma mark Misc Methods
+(float) getNewCompanyRowNumber;
+(float) getNewProductRowNumber;

@end




