//
//  coreDataMethods.m
//  NavCtrl
//
//  Created by Aditya Narayan on 4/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "coreDataMethods.h"
#import <CoreData/CoreData.h>
#import "CompanyMO.h"
#import "ProductMO.h"
#import "DAO.h"

@implementation coreDataMethods

static NSManagedObjectContext *context;
static NSManagedObjectModel *model;
static NSString *path;


+(void) initModelContext {
    
    //get path and filename to store
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
    path =  [documentsDirectory stringByAppendingPathComponent:@"store.data"];

    // 1. Creating ObjectModel which describes the schema.
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 2. Creating Context.
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    
    if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    NSLog(@"%@\n",storeURL);
    
    context = [[NSManagedObjectContext alloc] init];
    
    //Add an undo manager
    context.undoManager = [[NSUndoManager alloc] init];
    
    //3. Now the context points to the SQLite store
    [context setPersistentStoreCoordinator:psc];
    //[[self context] setUndoManager:nil];
    
}

+(void) addCompany:(Company *)currentCompany{

    // Generating primary key using timestamp.
    NSNumber *pk = [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
    
    //Add this object to the context. Nothing happens till it is saved
    CompanyMO *company = [NSEntityDescription insertNewObjectForEntityForName: @"CompanyMO" inManagedObjectContext: context];
    
    [company setCompanyID:pk ];
    [company setName:currentCompany.name];
    [company setStockSymbol:currentCompany.stockSymbol];
    [company setLogo:currentCompany.logo];
    
    [coreDataMethods saveChanges];
}

// On calling this, actual saving is done in the Core Data table
+(void) saveChanges
{
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if(!successful)
    {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    NSLog(@"Data Saved");
}


+(void)loadAllCompanies {
    DAO *dao = [DAO sharedManager];
    // Loads all companies from Core Data Company table into tableview datasource.
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //A predicate template can also be used
    NSPredicate *p = [NSPredicate predicateWithFormat:@"companyID >0 "];
    [request setPredicate:p];
    
//    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByPk = [[NSSortDescriptor alloc]
                                    initWithKey:@"companyID" ascending:NO];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByPk]];
    
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CompanyMO"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    dao.companyList = [[NSMutableArray alloc]initWithArray:result];
    
}



+(void) addProduct:(Product *)currentProduct{
    
    // Generating primary key using timestamp.
    NSNumber *pk = [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];

    //Add this object to the contex. Nothing happens till it is saved
    ProductMO *product = [NSEntityDescription insertNewObjectForEntityForName: @"Product" inManagedObjectContext: context];
    
    [product setProductID: pk ];
    [product setName: currentProduct.name];
    [product setUrl:currentProduct.url];
    [product setLogo:currentProduct.logo];
   // [product setCompanyID:companyMO]
    
    
    
    [coreDataMethods saveChanges];
    
  //  [dao.productArray addObject:product];
    
}




//
//+(void) deleteCompany:(Company *)currentCompany{
//    
//}


//+(void) deleteProduct:(Product *)currentProduct {
//    
//}
//
//+(void) updateCompany:(Company *)currentCompany {
//    
//}
//
//
//+(void) updateProduct:(Product *)currentProduct {
//    
//}
//
//
//+(void) MoveCompany:(Company *)currentCompany {
//    
//}
//
//
//+(void) MoveProduct:(Product *)currentProduct toIndex:(float)newIndex{
//    
//}
//
//
//+(int) GetNoOfProductsCount {
//    int i=0;
//    return i;
//}
//
//



@end
