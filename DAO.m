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
#import "sqlite3.h"

static DAO *sharedMyManager = nil;

@implementation DAO
{
     NSMutableString *query;
     NSURL *dataURL;
     NSString *dbPath;
     sqlite3 *sqliteDB;
}
#pragma mark Singleton Methods
- (id)init {
    if (self = [super init]) {
        [self createOrOpenDB];
        [self populateCompany];
        //[self populateProductsForCompany:self.companyNo];
    }
    return self;
}

+ (id)sharedManager {
    //ensures object is created only once
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}


- (void) createOrOpenDB{
    //find documents directory for app
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //document path found in index:0
    NSString *dirPathStr =  [dirPath objectAtIndex:0];
    
    //add filename to end of path
    dbPath = [dirPathStr stringByAppendingPathComponent:@"sqliteDB.db"];
    
    //convert full pathname to dao.db to url
    //NSURL *dbURL = [NSURL URLWithString:@"dbPath"];
    
    //instantiate nsfilemanager object
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //check if dao.db exists in document directory
    BOOL success = [filemgr fileExistsAtPath:dbPath];
    NSError *error;
    
    if (success) {
        //dao.db exists
        NSLog(@"sqliteDB.db exists in documents directory: %@",dbPath);
        
    }else {
        //dao.db does not exist - copy dao.db from main bundle to documents directory
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sqliteDB" ofType:@"db"];
        success = [filemgr copyItemAtPath:path toPath:dbPath error:&error];
        NSLog(@"sqliteDB.db copied to documents directory: %@",dbPath);
    }
    
}

- (void) populateCompany{
    // populate company arrays with information from the sql database
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK)
    {
        [self.companyList removeAllObjects];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM COMPANY"];
        
        const char *query_sql = [querySQL UTF8String];
        if (sqlite3_prepare(sqliteDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                //initialize arrays
                //for each company do..
                Company *company = [[Company alloc]init];
                
                //get company fields from sql
                int companyNo = (int)[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *coName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *coStockSymbol = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *coLogo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                
                //add companies
                self.companyNo = companyNo;
                company.name = coName;
                company.stockSymbol = coStockSymbol;
                company.logo = coLogo;
                
                //populate all the products for the company
                [self populateProductsForCompany:self.companyNo];
                
                // add company to companyList
                [self.companyList addObject: company];

                
            }
        }
    }
}

- (void) populateProductsForCompany:(NSUInteger)companyID {
    // populate product arrays with information from the sql database
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK)
    {
        //   [productArray removeAllObjects];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM product WHERE company.id=product.company_id"];
        
        const char *query_sql = [querySQL UTF8String];
        if (sqlite3_prepare(sqliteDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            //for each product do..
            while (sqlite3_step(statement)== SQLITE_ROW)  {
                
                //initialize arrays
                Product *product = [[Product alloc]init];
                
                //get product fields from sql
                int companyID = (int)[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *prodName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *prodURL = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *prodLogo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                
                //add products
                self.companyNo = companyID;
                product.name = prodName;
                product.url = prodURL;
                product.logo = prodLogo;
                
                //add products to the productsArray
                [[self.companyList objectAtIndex: self.companyNo].productArray  addObject: product];
            }
        }
    }
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