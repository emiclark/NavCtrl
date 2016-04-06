//
//  Product.m
//  NavCtrl
// Assignment7-MMM
// Manual Memory Management
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.

#import "Product.h"

@implementation Product

- (id) initWithName:(NSString*)name andUrl:(NSString*)url andLogo:(NSString*)logo andCompanyID:(NSInteger)companyID andRow:(float)row {
    self=[super init];
    if (self) {
        self.name = name;
        self.companyID = companyID;
        self.row = row;
        self.url  = url;
        self.logo = logo;
    }
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@, CC:%ld, CP:%ld, row:%f, %@, %@", self.name, self.companyID, self.productID, self.row, self.url, self.logo];
}
@end
