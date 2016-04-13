//
//  SQLMethods.m
//  NavCtrl
// Assignment8
// CoreData
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


+(void) deleteCompanyFromSQL:(Company *)currentCompany {
    NSString *query = [NSString stringWithFormat: @"DELETE FROM company WHERE companyID=%i",(int)currentCompany.companyID];
    [self execute_SQLwithQuery:query];
}

+(void) deleteProductFromSQL:(Product *)currentProduct {
    NSString *query = [NSString stringWithFormat: @"DELETE FROM product WHERE productID=%i",(int)currentProduct.productID];
    [self execute_SQLwithQuery:query];
}

+(void) updateCompanyToSQL:(Company *)currentCompany {
    NSString *querySQL = [NSString stringWithFormat:@"UPDATE company Set companyID=%i, row=%f, name='%@', stockSymbol='%@',logo='%@' WHERE  companyID=%i", (int)currentCompany.companyID , (float)currentCompany.row, currentCompany.name, currentCompany.stockSymbol, currentCompany.logo,(int)currentCompany.companyID];
    [SQLMethods execute_SQLwithQuery:querySQL];
}

+(void) updateProductToSQL:(Product *)currentProduct {
    NSString *querySQL = [NSString stringWithFormat:@"UPDATE product Set  companyID='%i', row='%f', name='%@', url='%@',logo='%@' WHERE  productID=%i",  (int)currentProduct.companyID, (float)currentProduct.row, currentProduct.name, currentProduct.url, currentProduct.logo,(int)currentProduct.productID];
    [SQLMethods execute_SQLwithQuery:querySQL];
}

+(void) addCompanyToSQL:(Company *)currentCompany andRow:(float)row {
    NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO company (row, name, stockSymbol,logo) VALUES ('%f','%@','%@','%@')", (float)currentCompany.row, currentCompany.name, currentCompany.stockSymbol, currentCompany.logo];
    [SQLMethods execute_SQLwithQuery:querySQL];
}

+(void) addCompanyToSQL:(Company *)currentCompany{
    NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO company (row, name, stockSymbol,logo) VALUES ('%f','%@','%@','%@')", (float)currentCompany.row, currentCompany.name, currentCompany.stockSymbol, currentCompany.logo];
    [SQLMethods execute_SQLwithQuery:querySQL];
}

+(void) addProductToSQL:(Product *)currentProduct forCompany:(Company *)currentCompany {
    NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO product (companyID, row, name, url,logo) VALUES ('%i', '%f','%@','%@','%@')", (int)currentCompany.companyID, currentProduct.row, currentProduct.name, currentProduct.url, currentProduct.logo];
    [SQLMethods execute_SQLwithQuery:querySQL];
}

+(void) MoveCompany:(Company *)currentCompany {
    //    NSLog(@"company: %@", currentCompany);
    NSString *querySQL = [NSString stringWithFormat:@"UPDATE company Set row='%f' WHERE  companyID=%i",(float)currentCompany.row,(int)currentCompany.companyID];
    NSString *string = [NSString stringWithString:querySQL];
    [SQLMethods execute_SQLwithQuery:string];
}

+(void) MoveProduct:(Product *)currentProduct  toIndex:(float)newIndex  {
    NSString *querySQL = [NSString stringWithFormat:@"UPDATE product Set row='%f' WHERE  productID=%i",(float) currentProduct.row,(int)currentProduct.productID];
    [SQLMethods execute_SQLwithQuery:querySQL];
}

+(void)execute_SQLwithQuery:(NSString *)query {
    
    dbPath = [self getDBPath];
    int sqlStatus = sqlite3_open([dbPath UTF8String], &sqliteDB);
    if (sqlStatus == SQLITE_OK) {
        char *errMsg;
        if (sqlite3_exec(sqliteDB, [query UTF8String], NULL, NULL, &errMsg) == SQLITE_OK) {
            NSLog(@"sqlite3_exec success = %@",query);
        }
        sqlite3_close(sqliteDB);
    }
    else {
        NSLog(@"Failed to open database");
    }
    sqlite3_close(sqliteDB);
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
        
        [filemgr copyItemAtPath:path toPath:dbPath error:&error];
        NSLog(@"\nsqliteDB.db copied to documents directory");
    }
    NSLog (@"dbPath: %@",dbPath);
}


+(NSMutableArray*) populateCompanyFromSQL {
    
    NSMutableArray *companies = [[[NSMutableArray alloc] init]autorelease];
    // populate company arrays with information from the sql database
    sqlite3_stmt *statement = NULL ;
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK)
        {
        //--> SELECT rowName FROM tableName order by rowName
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM company order by row"];
        if (sqlite3_prepare(sqliteDB,  [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
            while (sqlite3_step(statement)== SQLITE_ROW) {
                //initialize
                Company *company = [[[Company alloc]init] autorelease];
                
                //get company fields from sql
                int sqlite3_column_int(sqlite3_stmt*, int iCol);
                company.companyID = sqlite3_column_int(statement, 0);
                company.row = sqlite3_column_int(statement, 1);
                company.name = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]autorelease];
                company.stockSymbol = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)]autorelease];
                company.logo = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)]autorelease];
                
                // add company to companyList
                [companies addObject: company];
            }
            }
        sqlite3_close(sqliteDB);
        }
    return companies;
}

+(NSMutableArray *) populateProductsFromSQL:(Company *)currentCompany {
    
    NSMutableArray *tempProductArray = [[[NSMutableArray alloc]init] autorelease];
    
    // populate product arrays with information from the sql database
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK) {
        
        NSString *querySQL = [[NSString stringWithFormat:@"SELECT * FROM product  where companyID=%ld order by row", (long)currentCompany.companyID] autorelease];
        
        if (sqlite3_prepare(sqliteDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
            //for each product do..
            while (sqlite3_step(statement)== SQLITE_ROW)  {
                Product *product = [[[Product alloc]init] autorelease];
                product.productID = (int)[[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] integerValue];
                product.companyID = (int)[[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] integerValue];
                product.name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                product.url = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)]autorelease];
                product.logo = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] autorelease];
                product.row = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] floatValue];
                
                //add products to the productsArray
                [tempProductArray addObject: product];
            }
            }
    }
    sqlite3_close(sqliteDB);
    return (tempProductArray);
}


+(int) GetNoOfProductsCount
{
    //count the number of total products in products array and set value to newProductID
    int count = 0;
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPath UTF8String], &sqliteDB)==SQLITE_OK) {
        
        NSString *querySQL = [[NSString stringWithFormat:@"select count(*) from product"] autorelease];
        
        if (sqlite3_prepare(sqliteDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
            //Loop through all the returned rows (should be just one)
            while( sqlite3_step(statement) == SQLITE_ROW )
                {
                count = sqlite3_column_int(statement, 0);
                }
            }
        else
            {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(sqliteDB) );
            }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(sqliteDB);
    }
    return count;
}

- (void)dealloc {
    [super dealloc];
}


@end
