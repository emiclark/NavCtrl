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


+(void) initModelContext;
+(void)loadOrCreateCoreData;
+(void)addCompanyAndProductsToCoreData;

+(void) addCompany:(Company *)currentCompany;
+(void) addProduct:(Product *)currentProduct toCompany:(Company *)currentCompany;

+(void) saveChanges;

//+(void) deleteCompany:(Company *)currentCompany;
//+(void) deleteProduct:(Product *)currentProduct;
//
//+(void) updateCompany:(Company *)currentCompany;
//+(void) updateProduct:(Product *)currentProduct;
//
//+(void) MoveCompany:(Company *)currentCompany;
//+(void) MoveProduct:(Product *)currentProduct toIndex:(float)newIndex;
//
//+(int) GetNoOfProductsCount;
//



@end
