//
//  DAO.m
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "SQLMethods.h"


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
    [self.companyList addObject:currentCompany];
    [SQLMethods addCompanyToSQL:currentCompany];
}

- (void) addProduct:(Product *)currentProduct {
    [self.currentCompany.productArray addObject:currentProduct];
    NSLog(@"%ld",self.currentCompany.companyID);
    [SQLMethods addProductToSQL:currentProduct forCompany: self.currentCompany];
}

- (void) updateCompany:(Company *)currentCompany AtIndex:(NSInteger)index{
    NSLog(@"updateCompany:%@",currentCompany);
    [SQLMethods updateCompanyToSQL:currentCompany];
}

- (void) updateProduct:(Product *)currentProduct AtIndex:(NSInteger)index {
    NSLog(@"updateProduct:%@, %ld",currentProduct, self.currentProductIndex);
    [SQLMethods updateProductToSQL:currentProduct];
}



#pragma mark Singleton Methods
- (void)initializeDAOsetupSQL {
    //check documents directory to see if dao.db exists,
    //if so, populate arrays,
    //if not, copy dao.db from resource folder in main bundle and ,
    //finally, populate arrays
   
    Company *currentCompany = [[Company alloc]init];
    self.nextCompanyRowNumber = 0;
    [SQLMethods createOrOpenDB];
    
    //populate all the products for each company from SQL
    self.companyList = [SQLMethods populateCompanyFromSQL];

    //populate all the products for each company
    for (int i=0; i<self.companyList.count; i++) {
        currentCompany = self.companyList[i];
        self.currentCompany.row = i;
        self.currentCompanyIndex = i;
        self.currentCompany.productArray= [[NSMutableArray alloc]init];

        [[DAO sharedManager] populateProducts: currentCompany];
    }
}

- (void) populateProducts:(Company  *)currentCompany {
    //populate DAO with Products from SQL
    DAO *dao = [[DAO alloc]init];
    NSMutableArray *resultProductArray = [[NSMutableArray alloc]init];
    resultProductArray = [SQLMethods populateProductsFromSQL:currentCompany];
    
    //add productArray to companyList
    [dao.companyList objectAtIndex: dao.currentCompanyIndex].productArray = resultProductArray;
    [dao.companyList objectAtIndex:dao.currentCompanyIndex].productArray = currentCompany.productArray;
    
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