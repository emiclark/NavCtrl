//
//  SQLMethods.m
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 3/26/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "SQLMethods.h"
#import "DAO.h"
#import "Product.h"


@implementation SQLMethods

static sqlite3 *sqliteDB;
static NSString *dbPath;


+(void) deleteCompanyFromSQL:(NSInteger)companyID{
    NSString *query = [NSString stringWithFormat: @"DELETE FROM company WHERE companyID=%ld",(long)companyID];
    [self execute_SQLwithQuery:query];
}

+(void) deleteProductFromSQL:(NSInteger)productID {
    NSString *query = [NSString stringWithFormat: @"DELETE FROM product WHERE productID=%ld",(long)productID];
    [self execute_SQLwithQuery:query];
}

- (id)init {
    if ((self = [super init])) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dao" ofType:@"db"];
        if (sqlite3_open([path UTF8String], &sqliteDB) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

+ (NSString *)getDBPath {
    //find documents directory for app
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //document path found in index:0
    NSString *dirPathStr =  [dirPath objectAtIndex:0];
    
    //add filename to end of path
    dbPath = [dirPathStr stringByAppendingPathComponent:@"sqliteDB.db"];

    return dbPath;
}

+ (void) createOrOpenDB{
    //get dbPath for document directory
    dbPath = [self getDBPath];
    
    //instantiate nsfilemanager object
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //check if dao.db exists in document directory
    BOOL success = [filemgr fileExistsAtPath:dbPath];
    NSError *error;
    
    if (success) {
        //sqliteDB.db exists
        NSLog(@"sqliteDB.db exists in documents directory");
        
    }else {
        //sqliteDB.db does not exist - copy dao.db from main bundle to documents directory
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dao" ofType:@"db"];
        
        success = [filemgr copyItemAtPath:path toPath:dbPath error:&error];
        NSLog(@"\nsqliteDB.db copied to documents directory");
    }
    NSLog (@"dbPath: %@",dbPath);
}


+(NSMutableArray*) populateCompanyFromSQL {
    
    NSMutableArray *companies = [[NSMutableArray alloc] init];
    // populate company arrays with information from the sql database
    sqlite3_stmt *statement = NULL ;
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM company"];
        if (sqlite3_prepare(sqliteDB,  [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
            while (sqlite3_step(statement)== SQLITE_ROW) {
                //initialize
                Company *company = [[Company alloc]init];
                
                //get company fields from sql
                int sqlite3_column_int(sqlite3_stmt*, int iCol);
                company.companyID = sqlite3_column_int(statement, 0);
                company.row = sqlite3_column_int(statement, 1);
                company.name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                company.stockSymbol = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                company.logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                
                // add company to companyList
                [companies addObject: company];
            }
        }
        
        sqlite3_close(sqliteDB);
    }
    return companies;
}



+(NSMutableArray *) populateProductsFromSQL:(Company *)currentCompany {
    
    NSMutableArray *tempProductArray = [[NSMutableArray alloc]init];
    
    // populate product arrays with information from the sql database
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK) {
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM product  where companyID=%ld", currentCompany.companyID];
        
        const char *query_sql = [querySQL UTF8String];
        if (sqlite3_prepare(sqliteDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
            {
            //for each product do..
            while (sqlite3_step(statement)== SQLITE_ROW)  {
                Product *product = [[Product alloc]init];
                product.productID = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] integerValue];
                product.companyID = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] integerValue];
                product.name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                product.url = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                product.logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                
                //add products to the productsArray
                [tempProductArray addObject: product];
            }
        }
    }
    sqlite3_close(sqliteDB);
    return (tempProductArray);
}


+(void) addCompanyToSQL:(Company *)currentCompany{

    char *error;
    if(sqlite3_open([dbPath UTF8String], &sqliteDB) == SQLITE_OK) {

        NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO company (row, companyID, name, stockSymbol,logo) VALUES ('%i', '%i','%@','%@''%@')",(int)currentCompany.row, (int)currentCompany.companyID , currentCompany.name, currentCompany.stockSymbol, currentCompany.logo];

        if (sqlite3_exec(sqliteDB, [querySQL UTF8String], NULL, NULL, &error) == SQLITE_OK)
            {

            }
        sqlite3_close(sqliteDB);
    }
}

+(void) addProductToSQL:(Product *)currentProduct {
    
    char *error;
    if(sqlite3_open([dbPath UTF8String], &sqliteDB) == SQLITE_OK) {
        
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO product (productID, companyID, name, url,logo) VALUES ('%i', '%i','%@','%@''%@')",(int) currentProduct.productID, (int) currentProduct.companyID, currentProduct.name, currentProduct.url, currentProduct.logo];
        
        if (sqlite3_exec(sqliteDB, [insertStmt UTF8String], NULL, NULL, &error) == SQLITE_OK)
            {
            
            }
        sqlite3_close(sqliteDB);
    }
}


+ (void)execute_SQLwithQuery:(NSString *)query {

    dbPath = [self getDBPath];
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK) {
        char *errMsg;
        if (sqlite3_exec(sqliteDB, [query UTF8String], NULL, NULL, &errMsg) != SQLITE_OK) {
            NSLog(@"sqlite3_exec failed with query = %@",query);
        }
        sqlite3_close(sqliteDB);
    }
    else {
        NSLog(@"Failed to open database");
    }
}


- (void)dealloc {
    sqlite3_close(sqliteDB);
    [super dealloc];
}


@end
