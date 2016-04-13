//
//  SQLMethods.h
//  NavCtrl
// Assignment8
// CoreData
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Product.h"
#import "Company.h"

@interface SQLMethods : NSObject

+(void) createOrOpenDB;
+(NSMutableArray*) populateCompanyFromSQL;
+(NSMutableArray *) populateProductsFromSQL:(Company *)currentCompany;

+(NSString *)getDBPath;

+(void) addCompanyToSQL:(Company *)currentCompany;
+(void) addCompanyToSQL:(Company *)currentCompany andRow:(float)row;
+(void) addProductToSQL:(Product *)currentProduct forCompany: (Company * )currentCompany;

+(void) deleteCompanyFromSQL:(Company *)currentCompany;
+(void) deleteProductFromSQL:(Product *)currentProduct;

+(void) updateCompanyToSQL:(Company *)currentCompany;
+(void) updateProductToSQL:(Product *)currentProduct;

+(void) MoveCompany:(Company *)currentCompany;
+(void) MoveProduct:(Product *)currentProduct toIndex:(float)newIndex;

+(int) GetNoOfProductsCount;


@end
