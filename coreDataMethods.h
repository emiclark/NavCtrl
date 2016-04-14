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

// setup methods
+(void) initModelContext;
+(void) loadOrCreateCoreData;
+(void) loadCoreData:(NSArray *)MOresultArray;
+(void) getNewCompanyIDandProductID;
+(NSArray *) fetchProductsForCompany;
+(void) addCompanyAndProductsToCoreData;

// Company CRUD functions
+(void) addCompany:(Company *)currentCompany;
+(void) updateCompany:(Company *)currentCompany;
+(void) deleteCompany:(Company *)currentCompany;

// Product CRUD functions
+(void) addProduct:(Product *)currentProduct toCompany:(Company *)currentCompany;
+(void) updateProduct:(Product *)currentProduct;
+(void) deleteProduct:(Product *)currentProduct;

#pragma mark utility functions
+(void) saveChanges;
+(void) setUndoManager:(NSManagedObjectContext *)contextMgr;
//

//
//
//+(int) GetNoOfProductsCount;
//



@end
