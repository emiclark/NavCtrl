//
//  DAO.h
//  NavCtrl
//  ASSIGNMENT3
//  DAO
//
//  Created by Aditya Narayan on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray <Company *>  *companyList;
//@property (nonatomic) NSInteger currentCompany;

+ (id)sharedManager;
@end
