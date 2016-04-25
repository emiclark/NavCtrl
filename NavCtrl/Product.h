//
//  Product.h
//  NavCtrl
// Assignment9
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject


@property (nonatomic) int productID;
@property (nonatomic) int companyID;
@property (nonatomic) float row;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *logo;

-(id) initWithName:(NSString*)name andUrl:(NSString*)url andLogo:(NSString*)logo andCompanyID:(int)companyID andRow:(float)row andProductID:(int)productID;

@end
