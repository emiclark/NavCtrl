//
//  Company.m
//  NavCtrl
// Assignment8
// CoreData
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company


-(id) initWithName:(NSString*)name andStockSymbol:(NSString *)stockSymbol andLogo:(NSString*)logo andRow:(float)row andCompanyID:(int)companyID {
    self=[super init];
    if (self) {
        self.name = name;
        self.row = row;
        self.companyID = companyID;
        self.stockSymbol = stockSymbol;
        self.logo = logo;
        self.productArray = [[[NSMutableArray alloc]init] autorelease];
    }
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat: @"%@", self.name];
//        return [NSString stringWithFormat: @"%@, CC:%d, row:%f, %@", self.name, self.companyID, self.row, self.logo];
}
@end

