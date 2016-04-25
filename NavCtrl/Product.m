//
//  Product.m
//  NavCtrl
// Assignment9
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id) initWithName:(NSString*)name andUrl:(NSString*)url andLogo:(NSString*)logo andCompanyID:(int)companyID andRow:(float)row  andProductID:(int)productID {
    self= [super init];
    if (self) {
        self.companyID = companyID;
        self.productID = productID;
        self.row = row;
        self.name = name;
        self.url  = url;
        self.logo = logo;
    }
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"name:%@, compID:%i, prodID:%i, row:%f, url:%@, logo:%@\n", self.name, self.companyID, self.productID, self.row, self.url, self.logo];
}
@end
