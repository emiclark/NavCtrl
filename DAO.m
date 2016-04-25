//
//  DAO.m
//  NavCtrl
// Assignment9
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "coreDataMethods.h"
#import "Company.h"


static DAO *sharedMyManager = nil;
@interface DAO ()
@property (retain,nonatomic) DAO *dao;


@end

@implementation DAO

#pragma mark Singleton Methods

+(id)sharedManager {
    //ensures object is created only once
    
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    
    return sharedMyManager;
}

+(void) initializeDAO {
    [coreDataMethods initModelContext];
    [coreDataMethods checkToLoadOrCreateCoreData];
}

#pragma mark Company CRUD methods
+(void) addCompany:(Company *)currentCompany{
    [[[DAO sharedManager] companyList] addObject:currentCompany];
    [coreDataMethods addCompany:currentCompany];
}

+(void) updateCompany:(Company *)currentCompany {
    [coreDataMethods updateCompany:currentCompany];
}

-(void) deleteCompany:(Company *)currentCompany atRow:(NSInteger)row {
    [self.companyList removeObjectAtIndex:row];
    [coreDataMethods deleteCompany: currentCompany];
}

+(void) moveCompany:(Company *)currentCompany {
    [coreDataMethods moveCompany:currentCompany];
}

+(void) undoCompany {
    [coreDataMethods undoCompany];
}

+ (void) save {
    [coreDataMethods saveChanges];
}

#pragma mark Product CRUD methods

-(void) addProduct:(Product *)currentProduct {
    [self.currentCompany.productArray addObject:currentProduct];
    [coreDataMethods addProduct:currentProduct toCompany: self.currentCompany];
}

+(void) updateProduct:(Product *)currentProduct{
    [coreDataMethods updateProduct:currentProduct];
}

-(void) deleteProduct:(Product *)currentProduct atRow:(NSInteger)row {
    // Delete the row from the data source
    [self.currentCompany.productArray removeObjectAtIndex:row];
    [coreDataMethods deleteProduct: currentProduct];
}

+(void) moveProduct:(Product *)currentProduct {
    [coreDataMethods moveProduct:currentProduct];
}

+(void) undoProduct{
    [coreDataMethods undoProduct];    
}
    
#pragma mark Get Yahoo Stock Prices
    
-(void)updateStockPrices {
    
    // request for stock prices using Yahoo API
    
    //create query string
    NSMutableString *query = [[[NSMutableString alloc]initWithString:@"http://finance.yahoo.com/d/quotes.csv?s="]autorelease];
    
    NSString *temp = [[[NSString alloc] initWithString: [[self.companyList objectAtIndex:0] stockSymbol ]]autorelease];
    NSLog(@"%ld, %@",self.companyList.count, temp);
    
    self.stockSymbol = [[NSMutableString alloc]init];
    
    for (int i=0; i < self.companyList.count-1; i++) {
        //concatenate symbol names to end of url
        self.stockSymbol = (NSMutableString *)[self.companyList[i] stockSymbol ];
        [query appendString:self.stockSymbol];
        [query appendString:@"+"];
    }
    
    int lastItem = (int)self.companyList.count-1;
    
    [query appendString:[[self.companyList objectAtIndex:lastItem] stockSymbol]];
    [query appendString:@"&f=l1"];
    NSLog(@"query: %@",query);
    
    
    //create url from query string
    NSURL *dataURL = [NSURL URLWithString:query];
    
    //    //create session
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURLSessionDataTask *downloadTask = [manager.session dataTaskWithURL:dataURL
     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

         //update the UI on the main thread
         dispatch_async(dispatch_get_main_queue(), ^(void){
 
             // *price has stock prices in csv format
             NSString *price =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             //stockPrices is an array of stock Prices
             NSLog(@"%@", price);

             NSMutableArray *stockPrices =
             [[NSMutableArray alloc] initWithArray:[price componentsSeparatedByString: @"\n"]];
             
             [price release];
             [stockPrices removeLastObject];
             NSLog(@"%@", stockPrices);
             
             // set company prices in company class
                 for (int i=0; i<stockPrices.count; i++) {
                    Company *company = self.companyList[i];
                    [company setStockPrice: [stockPrices objectAtIndex:i] ];
                    
                  }
             
             [self.ccvc.collectionView reloadData];
             [stockPrices release];
         });
    }];
    [downloadTask resume];

}

    

#pragma mark Miscellaneous Methods

+(float) getNewCompanyRowNumber {
    float newProdRow =[coreDataMethods getNewCompanyRowNumber];
    return newProdRow;
}

+(float) getNewProductRowNumber {
    float newProdRow =[coreDataMethods getNewProductRowNumber];
    return newProdRow;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

+(id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}


-(id)retain {
    return self;
}

-(oneway void)release {
    // never release
}

-(id)autorelease {
    return self;
}

-(void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
    
}

@end