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
    
    NSLog(@"%@\n\n",storeURL);
    
    context = [[NSManagedObjectContext alloc] init];
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    //Add an undo manager
    context.undoManager = [[NSUndoManager alloc] init];
    [coreDataMethods setUndoManager:context.undoManager];
    
    
    //3. Now the context points to the SQLite store
    [context setPersistentStoreCoordinator:psc];
    
    }
}


+(void)loadOrCreateCoreData {
    
    // Loads all companies from Core Data Company table into tableview datasource.
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    // A predicate template can also be used
    //    NSPredicate *p = [NSPredicate predicateWithFormat:@"row"];
    //    [request setPredicate:p];
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByPk = [[NSSortDescriptor alloc]
                                  initWithKey:@"row" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByPk]];
    
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CompanyMO"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    NSLog(@"companies:result.count>>: %ld",result.count);
    if(!result){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }else if (result.count > 0) {
        [coreDataMethods loadCoreData:result ];
        
    }else if (result.count == 0) {
        [coreDataMethods addCompanyAndProductsToCoreData];
    }
}

+ (void) loadCoreData: (NSArray *)MOresultArray {
    
    //load all MO objects from coreData to DAO
    DAO *dao = [DAO sharedManager];
    dao.companyList = [[NSMutableArray alloc]init];
    
    //initialize newcompanyID
    dao.newCompanyID = (int)MOresultArray.count;
    
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
    //initialize newcompanyID and newproductID for next company and products
    [coreDataMethods getNewCompanyIDandProductID];
}

+(void) getNewCompanyIDandProductID {
    DAO *dao = [DAO sharedManager];
    
    //get newCompanyID ==
    // fetch all companies from Core Data
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
    
    //  get newProductID   ==
    
    // fetch all companies from Core Data
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
    
    Product *Lumina = [[Product alloc] initWithName:@"Lumia 950 XL" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/" andLogo: @"microsoft.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [microsoft.productArray addObject: Lumina ];
    [coreDataMethods addProduct:Lumina toCompany:microsoft];
    
    Product *Lenovo = [[Product alloc] initWithName:@"Lenovo ideapad MIIX 700" andUrl:@"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/" andLogo: @"microsoft.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [microsoft.productArray addObject: Lenovo ];
    [coreDataMethods addProduct:Lenovo toCompany:microsoft];
    
    Product *Surface = [[Product alloc] initWithName:@"Surface Pro 4" andUrl:@"http://www.microsoft.com/surface/en-us/devices/surface-pro-4" andLogo: @"microsoft.png" andCompanyID:dao.currentCompany.companyID andRow:dao.newProductRow andProductID:dao.newProductID];
    [microsoft.productArray addObject: Surface ];
    [coreDataMethods addProduct:Surface toCompany:microsoft];
    
}


#pragma mark Company CRUD functions

+(void) addCompany:(Company *)currentCompany {
    DAO *dao = [DAO sharedManager];
    NSNumber *tempCompanyID = [[NSNumber alloc]initWithInteger:currentCompany.companyID];
    NSNumber *tempRow = [[NSNumber alloc]initWithFloat:currentCompany.row];
    
    //Add this object to the context. Nothing happens till it is saved
    CompanyMO *company = [NSEntityDescription insertNewObjectForEntityForName: @"CompanyMO" inManagedObjectContext: context];
    
    [company setCompanyID:tempCompanyID];
    [company setName:currentCompany.name];
    [company setRow: tempRow];
    [company setStockSymbol:currentCompany.stockSymbol];
    [company setLogo:currentCompany.logo];
    [context insertObject:company];
    
    [coreDataMethods saveChanges];
    ++dao.newCompanyID;
    ++dao.newCompanyRow;
}


+(void) updateCompany:(Company *)currentCompany {
    //update currentCompany and save
    NSNumber *CompanyRow = [[NSNumber alloc]initWithFloat:currentCompany.row];
    NSNumber *companyID = [[NSNumber alloc]initWithInteger:currentCompany.companyID];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:context];
    [request setEntity:e];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"companyID = %i",currentCompany.companyID];
    [request setPredicate:p];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    CompanyMO *companyMO = [results objectAtIndex:0];
    [companyMO setValue:CompanyRow forKey:@"row"];
    [companyMO setCompanyID:companyID];
    
    [companyMO setName:currentCompany.name];
    [companyMO setStockSymbol:currentCompany.stockSymbol];
    [companyMO setLogo:currentCompany.logo];
    
    [coreDataMethods saveChanges];
    
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
        
        //Save
        [coreDataMethods saveChanges];
    }
}

#pragma mark Product CRUD functions


+(void) addProduct:(Product *)currentProduct  toCompany:(Company*)currentCompany {
    DAO *dao = [DAO sharedManager];
    
    // get primary key, row number, companyID
    NSNumber *pk = [NSNumber numberWithInteger:dao.newProductID];
    NSNumber *tempRow = [[NSNumber alloc]initWithFloat: dao.newProductRow];
    NSNumber *tempCompanyID = [[NSNumber alloc]initWithInteger:dao.currentCompany.companyID];
    
    //Add this object to the contex. Nothing happens till it is saved
    ProductMO *product = [NSEntityDescription insertNewObjectForEntityForName: @"ProductMO" inManagedObjectContext: context];
    
    [product setProductID: pk ];
    [product setCompanyID:tempCompanyID];
    [product setRow:tempRow];
    [product setName: currentProduct.name];
    [product setUrl:currentProduct.url];
    [product setLogo:currentProduct.logo];
    
    [coreDataMethods saveChanges];
    ++dao.newProductID;
    ++dao.newProductRow;
}

+(void) updateProduct:(Product *)currentProduct {

    //update currentProduct and save
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
    
        for (ProductMO *obj in result) {
            [obj setValue:currentProduct.name forKey:@"name"];
            [obj setValue:productRow forKey:@"row"];
            [obj setValue:currentProduct.url forKey:@"url"];
            [obj setValue:currentProduct.logo forKey:@"logo"];
            [coreDataMethods saveChanges];
        }
    }
    NSLog(@"updateProduct:%@, result%@",currentProduct, result);
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
        
        //Save
        [coreDataMethods saveChanges];
    }
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
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

+(void) setUndoManager:(NSManagedObjectContext *)contextMgr{
    
}
//*******************************************=========


//+(NSArray *) fetchCompanies {
//    
//    // fetch all companies from Core Data
//    NSFetchRequest *request = [[NSFetchRequest alloc]init];
//    
//    //Change ascending  YES/NO and validate
//    NSSortDescriptor *sortByRow = [[NSSortDescriptor alloc]
//                                   initWithKey:@"row" ascending:YES];
//    
//    [request setSortDescriptors:[NSArray arrayWithObject:sortByRow]];
//    
//    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CompanyMO"];
//    [request setEntity:e];
//
//    NSError *error = nil;
//    
//    //This gets data only from context, not from store
//    NSArray *result = [context executeFetchRequest:request error:&error];
//    
//    if(!result){
//        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
//    }
//    return result;
//    
//}


@end
