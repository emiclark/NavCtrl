//
//  coreDataMethods.h
//  NavCtrl
//
//  Created by Aditya Narayan on 4/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Company.h"
#import "Product.h"
#import "DAO.h"


@interface coreDataMethods : NSObject

@property (nonatomic, retain) NSString *archivePath;
@property (nonatomic, retain) NSUndoManager *undoManager;

// setup methods
+(void) initModelContext;
+(void) checkToLoadOrCreateCoreData;
+(void) addCompanyAndProductsToCoreData;
+(void) loadCoreData:(NSArray *)MOresultArray;
+(NSArray *) fetchProductsForCompany;


// Company CRUD functions
+(void) addCompany:(Company *)currentCompany;
+(void) updateCompany:(Company *)currentCompany;
+(void) deleteCompany:(Company *)currentCompany;
+(void) undoCompany;

// Product CRUD functions
+(void) addProduct:(Product *)currentProduct toCompany:(Company *)currentCompany;
+(void) updateProduct:(Product *)currentProduct;
+(void) deleteProduct:(Product *)currentProduct;
+(void) undoProduct;
//+(void) undoProductForCompany:(Company *)currentCompany;

#pragma mark utility functions
+(void) saveChanges;
+(float) getNewCompanyRowNumber;
+(float) getNewProductRowNumber;
+(void) getNewCompanyIDandProductID;
+(void) reloadCompaniesFromContext;
//+(void) reloadProductsFromContextForCompany;
+(void) reloadProductsFromContextForCompany:(Company *) currentCompany;


@end
