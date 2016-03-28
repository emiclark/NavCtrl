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

//-(instancetype)init {
//    
//    self = [super init];
//    if (self) {
//        // do initializing work here
//    }
//    return self;
//}


#pragma mark Singleton Methods
- (void)initializeDAOsetupSQL {
    //check documents directory to see if dao.db exists,
    //if so, populate arrays,
    //if not, copy dao.db from resource folder in main bundle and ,
    //finally, populate arrays
   
    DAO *dao = [DAO sharedManager];
    Company *currentCompany = [[Company alloc]init];
    
    [SQLMethods createOrOpenDB];

    //populate all the products for each company
    dao.companyList = [[NSMutableArray alloc ]init];
    [SQLMethods populateCompanyFromSQL];

    //populate all the products for each company


    
    for (int i=0; i<dao.companyList.count; i++) {
        currentCompany = dao.companyList[i];
        dao.currentCompany.row = i;
        dao.currentCompanyIndex = i;
        dao.currentCompany.productArray= [[NSMutableArray alloc]init];

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

- (void) saveCompany:(Company *)currentCompany{
    //assign new companyID and set companyIndex
    self.currentCompanyIndex = self.companyList.count;
    self.currentCompany.companyID = self.companyList.count+1;
    
    [self.companyList addObject:currentCompany];
    [SQLMethods saveCompanyToSQL:currentCompany];
}

//
//- (void) updateCompany:(Company *)currentCompany{
//    
//}
//
//
- (void) saveProduct:(Product *)currentProduct {
    [SQLMethods saveProductToSQL:currentProduct];
}
//
//- (void) updateProduct:(Product *)currentProduct{
//    
//}


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
//    sqlite3_close(self.sqliteDB);
    [super dealloc];

}

@end