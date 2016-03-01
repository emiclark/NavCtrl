//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray <Company *> *companyList;

+ (id)sharedManager;
@end
