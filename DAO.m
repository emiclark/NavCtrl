//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "Company.h"
#import "Product.h"
#import "CompanyViewController.h"

static DAO *sharedMyManager = nil;

@implementation DAO

#pragma mark Singleton Methods
- (id)init {
    if (self = [super init]) {
        [self methodToInstantiate];
    }
    return self;
}

+ (id)sharedManager {
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}
-(void)methodToInstantiate{

    //initialize companies and products
    Company *apple = [[Company alloc]initWithName:@"Apple" andLogo:@"apple.png"];
    
    Product *appleiPad = [[Product alloc] initWithName:@"iPad" andUrl:@"http://www.apple.com/ipad/" andLogo: @"apple.png"];
    [apple.productArray addObject: appleiPad ];
    
    self.companyList = [[NSMutableArray alloc]init];
    [self.companyList addObject:apple];
    [self.companyList addObject:apple];
    NSLog(@"methodToInstantiate:%@, %@,%@", apple, appleiPad, self.companyList);
    
//    appleiPod = [[Product alloc] init];
//    appleiPod.name = @"iPod Touch";
//    appleiPod.url = @"http://www.apple.com/ipod-touch/";
//    appleiPod.logo = @"apple.png";
//    [apple.productArray addObject: appleiPod ];
//    
//    appleiPhone = [[Product alloc] init];
//    appleiPhone.name = @"iPod Touch";
//    appleiPhone.url = @"http://www.apple.com/ipod-touch/";
//    appleiPhone.logo = @"apple.png";
//    [apple.productArray addObject: appleiPhone ];
//    
//    //samsung
//    samsung = [[Company alloc]init ];
//    samsung.name = @"Samsung";
//    samsung.logo = @"samsung.png";
//    
//    samsungS4 = [[Product alloc] init];
//    samsungS4.name = @"Galaxy S4";
//    samsungS4.url = @"http://www.samsung.com/global/microsite/galaxys4/";
//    samsungS4.logo = @"samsung.png";
//    [samsung.productArray addObject: samsungS4 ];
//    
//    samsungNote = [[Product alloc] init];
//    samsungNote.name = @"Galaxy Note";
//    samsungNote.url = @"http://www.samsung.com/us/mobile/galaxy-note/";
//    samsungNote.logo = @"samsung.png";
//    [samsung.productArray addObject: samsungNote ];
//    
//    samsungTab = [[Product alloc] init];
//    samsungTab.name = @"Galaxy Tab";
//    samsungTab.url = @"http://www.samsung.com/us/mobile/galaxy-tab/";
//    samsungTab.logo = @"samsung.png";
//    [samsung.productArray addObject: samsungTab ];
//    
//    //asus
//    asus = [[Company alloc]init ];
//    asus.name = @"Asus";
//    asus.logo = @"asus.png";
//    
//    asusZen = [[Product alloc] init];
//    asusZen.name = @"ZenFone 2E";
//    asusZen.url = @"http://www.asus.com/us/Phone/ZenFone-2E-US-ATT-exclusive/";
//    asusZen.logo = @"asus.png";
//    [asus.productArray addObject: asusZen ];
//    
//    asusPad = [[Product alloc] init];
//    asusPad.name = @"Padfone Infinity";
//    asusPad.url = @"http://www.asus.com/Phone/PadFone-A80/";
//    asusPad.logo = @"asus.png";
//    [asus.productArray addObject: asusPad ];
//    
//    asusPad = [[Product alloc] init];
//    asusPad.name = @"Eee Slate";
//    asusPad.url = @"http://www.asus.com/Tablets/Eee_Slate_EP121/";
//    asusPad.logo = @"asus.png";
//    [asus.productArray addObject: asusPad ];
//    
//    //microsoft
//    microsoft = [[Company alloc]init ];
//    microsoft.name = @"Microsoft";
//    microsoft.logo = @"microsoft.png";
//    
//    microsoftLumina = [[Product alloc] init];
//    microsoftLumina.name = @"Lumia 950 XL";
//    microsoftLumina.url = @"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/";
//    microsoftLumina.logo = @"microsoft.png";
//    [microsoft.productArray addObject: microsoftLumina ];
//    
//    microsoftLenovo = [[Product alloc] init];
//    microsoftLenovo.name = @"Lenovo ideapad MIIX 700";
//    microsoftLenovo.url = @"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/";
//    microsoftLenovo.logo = @"microsoft.png";
//    [microsoft.productArray addObject: microsoftLenovo ];
//    
//    microsoftSurface = [[Product alloc] init];
//    microsoftSurface.name = @"Surface Pro 4";
//    microsoftSurface.url = @"http://www.microsoft.com/surface/en-us/devices/surface-pro-4";
//    microsoftSurface.logo = @"microsoft.png";
//    [microsoft.productArray addObject: microsoftSurface ];
    
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}
//
//- (unsigned)retainCount {
//    return UINT_MAX; //denotes an object that cannot be released
//}

- (oneway void)release {
    // never release
}

- (id)autorelease {
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [super dealloc];
}

@end