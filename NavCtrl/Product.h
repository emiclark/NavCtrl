//
//  Product.h
//  NavCtrl
// Assignment6-SQL
// Integrate SQL
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) NSInteger productID;
@property (nonatomic) NSInteger companyID;
@property (nonatomic) NSInteger row;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *logo;


- (id) initWithName:(NSString*)name andUrl:(NSString*)url andLogo:(NSString*)logo;
@end
