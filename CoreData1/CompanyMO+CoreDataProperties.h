//
//  CompanyMO+CoreDataProperties.h
//  NavCtrl
//
//  Created by Aditya Narayan on 4/9/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CompanyMO.h"
#import "ProductMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *companyID;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *row;
@property (nullable, nonatomic, retain) NSNumber *stockPrice;
@property (nullable, nonatomic, retain) NSString *stockSymbol;
@property (nullable, nonatomic, retain) NSSet<ProductMO *> *productArray;

@end

@interface CompanyMO (CoreDataGeneratedAccessors)

- (void)addProductArrayObject:(ProductMO *)value;
- (void)removeProductArrayObject:(ProductMO *)value;
- (void)addProductArray:(NSSet<ProductMO *> *)values;
- (void)removeProductArray:(NSSet<ProductMO *> *)values;

@end

NS_ASSUME_NONNULL_END
