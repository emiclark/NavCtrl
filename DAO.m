//
//  DAO.m
//  NavCtrl
// Assignment8
// CoreData
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "coreDataMethods.h"


static DAO *sharedMyManager = nil;

@implementation DAO




- (void) deleteCompany:(Company *)currentCompany atRow:(NSInteger)row {
    [self.companyList removeObjectAtIndex:row];
    NSLog(@"%@\n",self.currentCompany);
    [SQLMethods deleteCompanyFromSQL: currentCompany];
}

- (void) deleteProduct:(Product *)currentProduct atRow:(NSInteger)row {
    // Delete the row from the data source
    [self.currentCompany.productArray removeObjectAtIndex:row];
    NSLog(@"co:%@, \nprod:%@",self.currentCompany, currentProduct);
    [SQLMethods deleteProductFromSQL: currentProduct];
}

- (void) addCompany:(Company *)currentCompany{
    NSLog(@"DAO:save:currentCompany%@",currentCompany);

    [self.companyList addObject:currentCompany];
    [coreDataMethods addCompany:currentCompany];
}

- (void) addProduct:(Product *)currentProduct {
    [self.currentCompany.productArray addObject:currentProduct];
    NSLog(@"%d",self.currentCompany.companyID);
    [SQLMethods addProductToSQL:currentProduct forCompany: self.currentCompany];
}

- (void) updateCompany:(Company *)currentCompany AtIndex:(NSInteger)index{
    NSLog(@"updateCompany:%@",currentCompany);
    [SQLMethods updateCompanyToSQL:currentCompany];
}

- (void) updateProduct:(Product *)currentProduct AtIndex:(NSInteger)index {
    //    NSLog(@"updateProduct:%@, %ld",currentProduct, self.currentProductIndex);
    [SQLMethods updateProductToSQL:currentProduct];
}

#pragma mark Singleton Methods
//- (void)initializeDAO {
//   self.companyList = [[NSMutableArray alloc]init];
//}

- (NSMutableArray *) populateProducts:(Company  *)currentCompany {
    //populate DAO with Products from SQL
    self.currentCompany.productArray = [SQLMethods populateProductsFromSQL:currentCompany];
    return self.currentCompany.productArray;
}



+ (id)sharedManager {
    //ensures object is created only once
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
        }
    return sharedMyManager;
}



- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}


- (id)retain {
    return self;
}

- (oneway void)release {
    // never release
}

- (id)autorelease {
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
    
}

@end