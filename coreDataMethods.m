//
//  coreDataMethods.m
//  NavCtrl
//
//  Created by Aditya Narayan on 4/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "coreDataMethods.h"
#import "CompanyMO.h"
#import "ProductMO.h"



@implementation coreDataMethods

static NSManagedObjectContext *context;
static NSManagedObjectModel *model;
static NSString *path;

#pragma mark setup functions

+(void) initModelContext {
    if(!context){
        
        //get path and filename to store
        NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
        path =  [documentsDirectory stringByAppendingPathComponent:@"model.data"];
        
        // 1. Creating ObjectModel which describes the schema.
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // 2. Creating Context.
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
        }
        //print url of model.data store
        NSLog(@"%@\n\n",storeURL);
        
        context = [[NSManagedObjectContext alloc] init];
        
        //3. Add an undo manager
        context.undoManager = [[NSUndoManager alloc] init];
        [context setUndoManager:context.undoManager ];
        
        
        //4. Now the context points to the SQLite store
        [context setPersistentStoreCoordinator:psc];
    }
}


+(void)checkToLoadOrCreateCoreData {
    
    // Loads all companies from Core Data Company table into tableview datasource.
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByPk = [[NSSortDescriptor alloc]
                                  initWithKey:@"row" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByPk]];
    
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CompanyMO"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if(!result){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }else if (result.count > 0) {
        [coreDataMethods loadCoreData:result ];
        
    }else if (result.count == 0) {
        //add companies and products to store if model.data (data) is nonexistant
        [coreDataMethods addCompanyAndProductsToCoreData];
        
        //initialize newcompanyID and newproductID for new company and products
        [coreDataMethods getNewCompanyIDandProductID];
    }
}

+(void)addCompanyAndProductsToCoreData{
    DAO *dao = [DAO sharedManager];
    dao.newCompanyRow = 1.0;
    dao.newProductRow = 1.0;
    dao.newCompanyID  = 1.0;
    dao.newProductID  = 1.0;
    dao.companyList = [[NSMutableArray alloc]init];
    
    //initialize companies and products
    
    Company *apple = [[Company alloc] initWithName:@"Apple" andStockSymbol:@"AAPL" andLogo:@"apple.png" andRow:dao.newCompanyRow andCompanyID:dao.newCompanyID];
    dao.currentCompany = apple;
    [dao.companyList addObject:apple];
    [coreDataMethods addCompany:apple];
    
    Product *iPad  = [[Product alloc] initWithName: @"iPad" andUrl:@"http://www.apple.com/ipad/" andLogo:@"apple.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [apple.productArray addObject: iPad ];
    [coreDataMethods addProduct:iPad toCompany:apple];
    
    Product *iPod = [[Product alloc] initWithName:@"iPod Touch" andUrl:@"http://www.apple.com/ipod-touch/" andLogo: @"apple.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [apple.productArray addObject: iPod ];
    [coreDataMethods addProduct:iPod toCompany:apple];
    
    Product *iPhone = [[Product alloc] initWithName:@"iPhone" andUrl:@"http://www.apple.com/iphone/" andLogo: @"apple.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [apple.productArray addObject: iPhone ];
    [coreDataMethods addProduct:iPhone toCompany:apple];
    
    //samsung
    Company *samsung = [[Company alloc] initWithName:@"Samsung" andStockSymbol:@"SSNLF" andLogo:@"samsung.png" andRow:dao.newCompanyRow andCompanyID:dao.newCompanyID];
    dao.currentCompany = samsung;
    [dao.companyList addObject:samsung];
    [coreDataMethods addCompany:samsung];
    
    Product *S4 = [[Product alloc] initWithName:@"Galaxy S4" andUrl:@"http://www.samsung.com/global/microsite/galaxys4/" andLogo: @"samsung.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [samsung.productArray addObject: S4 ];
    [coreDataMethods addProduct:S4 toCompany:samsung];
    
    Product *Note = [[Product alloc] initWithName:@"Galaxy Note" andUrl:@"http://www.samsung.com/us/mobile/galaxy-note/" andLogo: @"samsung.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [samsung.productArray addObject: Note ];
    [coreDataMethods addProduct:Note toCompany:samsung];
    dao.newProductRow++;
    
    Product *Tab = [[Product alloc] initWithName:@"Galaxy Tab" andUrl:@"http://www.samsung.com/us/mobile/galaxy-tab/" andLogo: @"samsung.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [samsung.productArray addObject: Tab ];
    [coreDataMethods addProduct:Tab toCompany:samsung];
    
    //google
    Company *google = [[Company alloc] initWithName:@"Google" andStockSymbol:@"GOOG" andLogo:@"google.png" andRow:dao.newCompanyRow andCompanyID:dao.newCompanyID];
    dao.currentCompany = google;
    [dao.companyList addObject:google];
    [coreDataMethods addCompany:google];
    
    Product *pixelC = [[Product alloc] initWithName:@"Pixel C" andUrl:@"https://pixel.google.com/pixel-c/" andLogo: @"google.png"andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [google.productArray addObject: pixelC ];
    [coreDataMethods addProduct:pixelC toCompany:google];
    
    Product *chromebook = [[Product alloc] initWithName:@"Chromebook" andUrl:@"https://www.google.com/chromebook/" andLogo:@"google.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [google.productArray addObject: chromebook ];
    [coreDataMethods addProduct:chromebook toCompany:google];
    
    Product *Nexus6P = [[Product alloc] initWithName:@"Nexus 6P" andUrl:@"https://www.google.com/nexus/6p/" andLogo: @"google.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [google.productArray addObject: Nexus6P ];
    [coreDataMethods addProduct:Nexus6P toCompany:google];
    
    //microsoft
    Company *microsoft =  [[Company alloc] initWithName:@"Microsoft" andStockSymbol:@"MSFT" andLogo:@"microsoft.png" andRow:dao.newCompanyRow andCompanyID:dao.newCompanyID];
    dao.currentCompany = microsoft;
    [dao.companyList addObject:microsoft];
    [coreDataMethods addCompany:microsoft];
    
    Product *Lumina = [[Product alloc] initWithName:@"Lumia 950 XL" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/" andLogo:@"microsoft.png" andCompanyID: dao.currentCompany.companyID andRow: dao.newProductRow andProductID: dao.newProductID ];
    [microsoft.productArray addObject: Lumina ];
    [coreDataMethods addProduct:Lumina toCompany:microsoft];
    
    Product *Lenovo = [[Product alloc] initWithName:@"Lenovo ideapad MIIX 700" andUrl:@"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/" andLogo: @"microsoft.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [microsoft.productArray addObject: Lenovo ];
    [coreDataMethods addProduct:Lenovo toCompany:microsoft];
    
    Product *Surface = [[Product alloc] initWithName:@"Surface Pro 4" andUrl:@"http://www.microsoft.com/surface/en-us/devices/surface-pro-4" andLogo: @"microsoft.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [microsoft.productArray addObject: Surface ];
    [coreDataMethods addProduct:Surface toCompany:microsoft];
    
    [coreDataMethods saveChanges];
}


+ (void) loadCoreData: (NSArray *)MOresultArray {
    
    DAO *dao = [DAO sharedManager];
    
    //initialize newcompanyID
    dao.newCompanyID = (int)MOresultArray.count;
    
    //load all MO objects from coreData and initialize DAO
    dao.companyList = [[NSMutableArray alloc]init];
    
    //convert companyMO to company
    for (CompanyMO *companyMO in MOresultArray) {
        Company *company = [[Company alloc]init];
        
        long companyID = [companyMO.companyID integerValue];
        float row = [companyMO.row floatValue ];
        
        company.companyID = (int) companyID;
        company.row  = row;
        company.name = companyMO.name;
        company.stockSymbol = companyMO.stockSymbol;
        company.logo = companyMO.logo;
        
        //initialize productArray for each company
        company.productArray = [[NSMutableArray alloc]init];
        
        NSArray *allProductsArray = [coreDataMethods fetchProductsForCompany];
        if (allProductsArray.count > 0) {
            
            //initialize/convert product array for each company
            for (ProductMO *productMO in allProductsArray) {
                if (companyMO.companyID == productMO.companyID) {
                    Product *product = [[Product alloc ]init];
                    product.productID = (int)[productMO.productID integerValue];
                    product.name   = productMO.name;
                    product.row = [productMO.row floatValue];
                    product.companyID = (int)[productMO.companyID integerValue];
                    product.url = productMO.url;
                    product.logo = productMO.logo;
                    
                    [company.productArray addObject:product];
                }
            }
            [dao.companyList addObject:company];
        }
    }
}


+(NSArray *) fetchProductsForCompany {
    
    // fetch all products from Core Data
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   initWithKey:@"row" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"ProductMO"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if(!result){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    return result;
    
}



#pragma mark Company CRUD functions

+(void) addCompany:(Company *)currentCompany {
    
    //add currentCompany and save
    DAO *dao = [DAO sharedManager];
    NSNumber *tempCompanyID = [[NSNumber alloc]initWithInteger:currentCompany.companyID];
    NSNumber *tempRow = [[NSNumber alloc]initWithFloat:currentCompany.row];
    
    //Add this object to the context. Nothing happens till it is saved
    CompanyMO *companyMO = [NSEntityDescription insertNewObjectForEntityForName: @"CompanyMO" inManagedObjectContext: context];
    
    [companyMO setCompanyID:tempCompanyID];
    [companyMO setName:currentCompany.name];
    [companyMO setRow: tempRow];
    [companyMO setStockSymbol:currentCompany.stockSymbol];
    [companyMO setLogo:currentCompany.logo];
    [context insertObject:companyMO];
    
    ++dao.newCompanyID;
    ++dao.newCompanyRow;
}


+(void) updateCompany:(Company *)currentCompany {
    
    NSNumber *companyID = [[NSNumber alloc]initWithInteger:currentCompany.companyID];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:context]];
    
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"companyID = %@", companyID ];
    [request setPredicate:predicate];
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    // maybe some check before, to be sure results is not empty
    CompanyMO * companyMO = [results objectAtIndex:0];
    [companyMO setName:currentCompany.name];
    [companyMO setStockSymbol:currentCompany.stockSymbol];
    [companyMO setLogo:currentCompany.logo];
    
    //    [context insertObject:companyMO];
    
}


+(void) deleteCompany:(Company *)currentCompany{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:context];
    [request setEntity:e];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"companyID = %i",currentCompany.companyID];
    [request setPredicate:p];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if (result!=nil) {
        //Remove object from context
        [context deleteObject:result.firstObject];
    }
}

+(void) moveCompany:(Company *)currentCompany {
    
    NSNumber *companyID = [[NSNumber alloc]initWithInteger:currentCompany.companyID];
    NSNumber *companyRow = [[NSNumber alloc]initWithFloat:currentCompany.row];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:context]];
    
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"companyID = %@", companyID ];
    [request setPredicate:predicate];
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if (result!=nil) {
        CompanyMO * companyMO = [result objectAtIndex:0];
        [companyMO setName:currentCompany.name];
        [companyMO setRow:companyRow];
        [companyMO setStockSymbol:currentCompany.stockSymbol];
        [companyMO setLogo:currentCompany.logo];
    }
    
}

+(void) undoCompany {
    [context undo];
    [coreDataMethods reloadCompaniesFromContext];
}


#pragma mark Product CRUD functions

+(void) addProduct:(Product *)currentProduct  toCompany:(Company*)currentCompany {
    DAO *dao = [DAO sharedManager];
    
    // get primary key, row number, companyID
    NSNumber *pk = [NSNumber numberWithInteger:dao.newProductID];
    NSNumber *tempRow = [[NSNumber alloc]initWithFloat: currentProduct.row];
    NSNumber *tempCompanyID = [[NSNumber alloc]initWithInteger:dao.currentCompany.companyID];
    
    //Add this object to the contex
    ProductMO *productMO = [NSEntityDescription insertNewObjectForEntityForName: @"ProductMO" inManagedObjectContext: context];
    
    [productMO setProductID: pk ];
    [productMO setCompanyID:tempCompanyID];
    [productMO setRow:tempRow];
    [productMO setName: currentProduct.name];
    [productMO setUrl:currentProduct.url];
    [productMO setLogo:currentProduct.logo];
    
    ++dao.newProductID;
    ++dao.newProductRow;
}


+(void) updateProduct:(Product *)currentProduct {
    
    //update currentProduct and save
    NSNumber *productID = [[NSNumber alloc]initWithInteger:currentProduct.productID];
    NSNumber *companyID = [[NSNumber alloc]initWithInteger:currentProduct.companyID];
    NSNumber *productRow = [[NSNumber alloc]initWithFloat:currentProduct.row];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ProductMO" inManagedObjectContext:context];
    [request setEntity:e];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"productID = %i",currentProduct.productID];
    [request setPredicate:p];
    NSError *error = nil;
    
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if(!result){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }else if (result.count == 1) {
        
        for (ProductMO *productMO in result) {
            [productMO setValue:currentProduct.name forKey:@"name"];
            [productMO setValue:companyID forKey:@"companyID"];
            [productMO setValue:productID forKey:@"productID"];
            [productMO setValue:productRow forKey:@"row"];
            [productMO setValue:currentProduct.url forKey:@"url"];
            [productMO setValue:currentProduct.logo forKey:@"logo"];
        }
    }
}


+(void) deleteProduct:(Product *)currentProduct{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"ProductMO" inManagedObjectContext:context];
    [request setEntity:e];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"productID = %i",currentProduct.productID];
    [request setPredicate:p];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if (result!=nil) {
        //Remove object from context
        [context deleteObject:result.firstObject];
    }
}

+(void) moveProduct:(Product *)currentProduct {
    
    NSNumber *companyID = [[NSNumber alloc]initWithInteger:currentProduct.companyID];
    NSNumber *productID = [[NSNumber alloc]initWithInteger:currentProduct.productID];
    NSNumber *productRow = [[NSNumber alloc]initWithFloat:currentProduct.row];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"ProductMO" inManagedObjectContext:context]];
    
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productID = %@", productID ];
    [request setPredicate:predicate];
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if (result!=nil) {
        ProductMO * productMO = [result firstObject];
        [productMO setProductID:productID];
        [productMO setCompanyID:companyID];
        [productMO setName:currentProduct.name];
        [productMO setRow:productRow];
        [productMO setUrl:currentProduct.url];
        [productMO setLogo:currentProduct.logo];
    }
}

+(void) undoProduct {
    [context undo];
    NSMutableArray *productArray = [[DAO sharedManager] currentCompany].productArray;
    [productArray removeAllObjects];
    productArray = [coreDataMethods reloadProductsFromContextForCompany: [[DAO sharedManager] currentCompany]  forProductArray:(NSMutableArray *)[[DAO sharedManager] currentCompany].productArray];
}


#pragma mark utility methods
+(void) saveChanges
{
    //save context to CoreData
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if(!successful)
        {
        NSLog(@"Error saving: %@", [err localizedDescription]);
        }
    
    [context.undoManager removeAllActions];
    
}


+(float) getNewCompanyRowNumber {
    DAO *dao = [DAO sharedManager];
    //get row number for new company
    float newRowNum = 0.0;
    for (Company *company in dao.companyList) {
        if (company.row > newRowNum) {
            newRowNum = company.row;
        }
    }
    newRowNum++;
    return newRowNum;
}


+(float) getNewProductRowNumber {
    DAO *dao = [DAO sharedManager];
    //get row number for new product
    float newRowNum = 0.0;
    for (Product *product in dao.currentCompany.productArray) {
        if (product.row > newRowNum) {
            newRowNum = product.row;
        }
    }
    newRowNum++;
    return newRowNum;
}

+(void) getNewCompanyIDandProductID {
    DAO *dao = [DAO sharedManager];
    
    //**  get newCompanyID
    // fetch all companies
    NSFetchRequest *requestCompany = [[NSFetchRequest alloc]init];
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   initWithKey:@"companyID" ascending:YES];
    
    [requestCompany setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CompanyMO"];
    [requestCompany setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *Companyresult = [context executeFetchRequest:requestCompany error:&error];
    
    if(!Companyresult){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    CompanyMO *companyMO = [Companyresult lastObject];
    
    long companyID = [companyMO.companyID integerValue];
    dao.newCompanyID = (int)companyID+1;
    
    //**  get newProductID
    
    // fetch all products
    NSFetchRequest *requestProducts = [[NSFetchRequest alloc]init];
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByKey2 = [[NSSortDescriptor alloc]
                                    initWithKey:@"productID" ascending:YES];
    
    [requestProducts setSortDescriptors:[NSArray arrayWithObject:sortByKey2]];
    
    NSEntityDescription *e2 = [[model entitiesByName] objectForKey:@"ProductMO"];
    [requestProducts setEntity:e2];
    NSError *error2 = nil;
    
    //This gets data only from context, not from store
    NSArray *Productresult = [context executeFetchRequest:requestProducts error:&error2];
    
    if(!Productresult){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    ProductMO *productMO = [Productresult lastObject];
    
    long productID = [productMO.productID integerValue];
    dao.newProductID = (int)productID+1;
}


+(void) reloadCompaniesFromContext {
    
    DAO *dao = [DAO sharedManager];
    
    // fetch all companies from Core Data
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByRow = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByRow]];
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CompanyMO"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if(result>0){
        [dao.companyList removeAllObjects];
        
        //convert MO to Company and populate companyList
        for (CompanyMO *companyMO in result) {
            Company *company = [[Company alloc]initWithName:companyMO.name andStockSymbol:companyMO.stockSymbol andLogo:companyMO.logo andRow:[companyMO.row floatValue] andCompanyID:(int)[companyMO.companyID integerValue]];
            
            //fetch all products for the company
            NSMutableArray *prodArray = [[NSMutableArray alloc]init];
            
            prodArray = [coreDataMethods reloadProductsFromContextForCompany:company forProductArray:prodArray];
            company.productArray = prodArray;
            [dao.companyList addObject:company];
        }
    }else {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
}

+(NSMutableArray *) reloadProductsFromContextForCompany: (Company *)currentCompany forProductArray:(NSMutableArray *)productArray {
    
    // fetch all products from Core Data
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSString *companyID = [NSString stringWithFormat:@"companyID =%i", currentCompany.companyID ];
    NSPredicate *p = [NSPredicate predicateWithFormat: companyID];
    [request setPredicate:p];
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByRow = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortByRow]];
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"ProductMO"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if(result>0){
        
        //convert MO to Product and populate productArray
        for (ProductMO *productMO in result) {
            int PID = (int)[productMO.productID integerValue];
            Product *product = [[Product alloc]initWithName:productMO.name andUrl:productMO.url andLogo:productMO.logo andCompanyID:(int)[productMO.companyID integerValue] andRow:[productMO.row floatValue] andProductID:PID];
            
            //fetch all products for the company
            [productArray  addObject:product];
        }
    }else {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    return productArray;
}


@end
