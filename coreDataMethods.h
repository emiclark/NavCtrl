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

#pragma mark Setup Methods
+(void) initModelContext;
+(void) checkToLoadOrCreateCoreData;
+(void) addCompanyAndProductsToCoreData;
+(void) loadCoreData:(NSArray *)MOresultArray;
+(NSArray *) fetchProductsForCompany;

#pragma mark Company CRUD Methods
+(void) addCompany:(Company *)currentCompany;
+(void) updateCompany:(Company *)currentCompany;
+(void) deleteCompany:(Company *)currentCompany;
+(void) moveCompany:(Company *)currentCompany;
+(void) undoCompany;

#pragma mark Product CRUD Methods
+(void) addProduct:(Product *)currentProduct toCompany:(Company *)currentCompany;
+(void) updateProduct:(Product *)currentProduct;
+(void) deleteProduct:(Product *)currentProduct;
+(void) moveProduct:(Product *)currentProduct;
+(void) undoProduct;

#pragma mark Utility Methods
+(void) saveChanges;
+(float) getNewCompanyRowNumber;
+(float) getNewProductRowNumber;
+(void) getNewCompanyIDandProductID;
+(void) reloadCompaniesFromContext;
+(NSMutableArray *) reloadProductsFromContextForCompany: (Company *)currentCompany forProductArray:(NSMutableArray *)productArray;
+(void) releaseCompanyAndProducts:(Company *)currentCompany;

@end
