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


+(void) initModelContext {
    
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
    
    NSLog(@"%@\n",storeURL);
    
    context = [[NSManagedObjectContext alloc] init];
    
    //Add an undo manager
    context.undoManager = [[NSUndoManager alloc] init];
    
    //3. Now the context points to the SQLite store
    [context setPersistentStoreCoordinator:psc];
    //    [coreDataMethods setUndoManager:context.undoManager];
    
}

+(void)loadOrCreateCoreData {
    DAO *dao = [DAO sharedManager];
    
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
    
    NSLog(@"result.count: %ld, %@",result.count, result);
    if(!result){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }else if (result.count > 0) {
        dao.companyList  = [[NSMutableArray alloc]initWithArray:result];
    }else if (result.count == 0) {
        [coreDataMethods addCompanyAndProductsToCoreData];
    }
}

+(void)addCompanyAndProductsToCoreData{
    DAO *dao = [DAO sharedManager];
    float newCompanyRow = 1.0;
    float newProductRow = 1.0;
    //initialize companies and products
    Company *apple = [[Company alloc] initWithName:@"Apple" andStockSymbol:@"AAPL" andLogo:@"apple.png" andRow:newProductRow];
    [coreDataMethods addCompany:apple];

    Product *iPad = [[Product alloc] initWithName:@"iPad" andUrl:@"http://www.apple.com/ipad/" andLogo: @"apple.png"];
    [apple.productArray addObject: iPad ];
    [coreDataMethods addProduct:iPad toCompany:apple];

    Product *iPod = [[Product alloc] initWithName:@"iPod Touch" andUrl:@"http://www.apple.com/ipod-touch/" andLogo: @"apple.png"];
    [apple.productArray addObject: iPod ];
    [coreDataMethods addProduct:iPod toCompany:apple];

    Product *iPhone = [[Product alloc] initWithName:@"iPhone" andUrl:@"http://www.apple.com/iphone/" andLogo: @"apple.png"];
    [apple.productArray addObject: iPhone ];
    [coreDataMethods addProduct:iPhone toCompany:apple];

    //samsung
    Company *samsung = [[Company alloc] initWithName:@"Samsung" andStockSymbol:@"SSNLF" andLogo:@"samsung.png"];
    [coreDataMethods addCompany:samsung];
    dao.currentCompany = samsung;

    Product *S4 = [[Product alloc] initWithName:@"Galaxy S4" andUrl:@"http://www.samsung.com/global/microsite/galaxys4/" andLogo: @"samsung.png"];
    [samsung.productArray addObject: S4 ];
    [coreDataMethods addProduct:S4 toCompany:samsung];
    
    Product *Note = [[Product alloc] initWithName:@"Galaxy Note" andUrl:@"http://www.samsung.com/us/mobile/galaxy-note/" andLogo: @"samsung.png"];
    [samsung.productArray addObject: Note ];
    [coreDataMethods addProduct:Note toCompany:samsung];

    Product *Tab = [[Product alloc] initWithName:@"Galaxy Tab" andUrl:@"http://www.samsung.com/us/mobile/galaxy-tab/" andLogo: @"samsung.png"];
    [samsung.productArray addObject: Tab ];
    [coreDataMethods addProduct:Tab toCompany:samsung];

    //google
    Company *google = [[Company alloc] initWithName:@"Google" andStockSymbol:@"GOOG" andLogo:@"google.png"];
    [coreDataMethods addCompany:google];
    dao.currentCompany = google;

    Product *pixelC = [[Product alloc] initWithName:@"Pixel C" andUrl:@"https://pixel.google.com/pixel-c/" andLogo: @"google.png"];
    [google.productArray addObject: pixelC ];
    [coreDataMethods addProduct:pixelC toCompany:google];

    Product *chromebook = [[Product alloc] initWithName:@"Chromebook" andUrl:@"https://www.google.com/chromebook/" andLogo: @"google.png"];
    [google.productArray addObject: chromebook ];
    [coreDataMethods addProduct:chromebook toCompany:google];

    Product *Nexus6P = [[Product alloc] initWithName:@"Nexus 6P" andUrl:@"https://www.google.com/nexus/6p/" andLogo: @"google.png"];
    [google.productArray addObject: Nexus6P ];
    [coreDataMethods addProduct:Nexus6P toCompany:google];

    //microsoft
    Company *microsoft =  [[Company alloc] initWithName:@"Microsoft" andStockSymbol:@"MSFT" andLogo:@"microsoft.png"];
    [coreDataMethods addCompany:microsoft];
    dao.currentCompany = microsoft;

    Product *Lumina = [[Product alloc] initWithName:@"Lumia 950 XL" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/" andLogo: @"microsoft.png"];
    [microsoft.productArray addObject: Lumina ];
    [coreDataMethods addProduct:Lumina toCompany:microsoft];

    Product *Lenovo = [[Product alloc] initWithName:@"Lenovo ideapad MIIX 700" andUrl:@"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/" andLogo: @"microsoft.png"];
    [microsoft.productArray addObject: Lenovo ];
    [coreDataMethods addProduct:Lenovo toCompany:microsoft];

    Product *Surface = [[Product alloc] initWithName:@"Surface Pro 4" andUrl:@"http://www.microsoft.com/surface/en-us/devices/surface-pro-4" andLogo: @"microsoft.png"];
    [microsoft.productArray addObject: Surface ];
    [coreDataMethods addProduct:Surface toCompany:microsoft];

    
    dao.companyList = [[NSMutableArray alloc]init];
    [dao.companyList addObject:apple];
    [dao.companyList addObject:samsung];
    [dao.companyList addObject:google];
    [dao.companyList addObject:microsoft];
    
}


+(void) addCompany:(Company *)currentCompany{
    DAO *dao=[DAO sharedManager];
    
    // Generating primary key using timestamp.
    NSNumber *pk = [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
    
    //Add this object to the context. Nothing happens till it is saved
    CompanyMO *company = [NSEntityDescription insertNewObjectForEntityForName: @"CompanyMO" inManagedObjectContext: context];
    
    [company setCompanyID:pk ];
    [company setName:currentCompany.name];
    [company setStockSymbol:currentCompany.stockSymbol];
    [company setLogo:currentCompany.logo];
    [company setRow: currentCompany.row];
    [context insertObject:company];
    
    [coreDataMethods saveChanges];

    NSLog(@"DAO:save:currentCompany%@",currentCompany);

    
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


+(void) addProduct:(Product *)currentProduct  toCompany:(Company*)currentCompany {
    
    // Generating primary key using timestamp.
    NSNumber *pk = [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];

    //get companyID
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    //A predicate template can also be used
    NSPredicate *p = [NSPredicate predicateWithFormat:@"productID > 0 "];
    [request setPredicate:p];
    
    //    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByPk = [[NSSortDescriptor alloc]
                                  initWithKey:@"productID" ascending:NO];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByPk]];
    
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"ProductMO"];
    [request setEntity:e];
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }

    //Add this object to the contex. Nothing happens till it is saved
    ProductMO *product = [NSEntityDescription insertNewObjectForEntityForName: @"ProductMO" inManagedObjectContext: context];
    
    [product setProductID: pk ];
    [product setName: currentProduct.name];
//    [product setCompanyID: currentCompany.companyID];
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
