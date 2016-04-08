//
//  coreDataMethods.h
//  NavCtrl
//
//  Created by Aditya Narayan on 4/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#import <CoreData/CoreData.h>


@interface coreDataMethods : NSObject

@property (nonatomic, retain) NSString *archivePath;


+(void) initModelContext;
+(void) addCompany:(Company *)currentCompany;
+(void) addProduct:(Product *)currentProduct;

+(void) saveChanges;
+(void)loadAllCompanies;

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
