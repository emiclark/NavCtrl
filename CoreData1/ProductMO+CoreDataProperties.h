//
//  ProductMO+CoreDataProperties.h
//  NavCtrl
//
//  Created by Aditya Narayan on 4/9/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProductMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *productID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic) float *row;
@property (nullable, nonatomic, retain) NSSet<CompanyMO *> *productMO;

@end

@interface ProductMO (CoreDataGeneratedAccessors)

- (void)addProductMOObject:(CompanyMO *)value;
- (void)removeProductMOObject:(CompanyMO *)value;
- (void)addProductMO:(NSSet<CompanyMO *> *)values;
- (void)removeProductMO:(NSSet<CompanyMO *> *)values;

@end

NS_ASSUME_NONNULL_END
