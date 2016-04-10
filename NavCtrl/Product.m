//
//  Product.m
//  NavCtrl
// Assignment8
// CoreData
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id) initWithName:(NSString*)name andUrl:(NSString*)url andLogo:(NSString*)logo {
    self=[super init];
    if (self) {
        self.name = name;
        self.url  = url;
        self.logo = logo;
    }
    return self;
}

- (id) initWithName:(NSString*)name andUrl:(NSString*)url andLogo:(NSString*)logo andCompanyID:(int)companyID andRow:(float)row {
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
    return [NSString stringWithFormat:@"%@, CC:%i, CP:%i, row:%f, %@, %@", self.name, self.companyID, self.productID, self.row, self.url, self.logo];
}
@end
