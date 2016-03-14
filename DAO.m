//
//  DAO.m
//  NavCtrl
//  ASSIGNMENT 5
//  Use Yahoo finance API to get stock prices
//
//  Created by Emiko Clark on 2/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"


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
    //ensures object is created only once
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}

-(void)methodToInstantiate{
    
    //initialize companies and products
    Company *apple = [[Company alloc] initWithName:@"Apple" andStockSymbol:@"AAPL" andLogo:@"apple.png"];
    
    Product *iPad = [[Product alloc] initWithName:@"iPad" andUrl:@"http://www.apple.com/ipad/" andLogo: @"apple.png"];
    [apple.productArray addObject: iPad ];
    
    Product *iPod = [[Product alloc] initWithName:@"iPod Touch" andUrl:@"http://www.apple.com/ipod-touch/" andLogo: @"apple.png"];
    [apple.productArray addObject: iPod ];
    
    Product *iPhone = [[Product alloc] initWithName:@"iPhone" andUrl:@"http://www.apple.com/iphone/" andLogo: @"apple.png"];
    [apple.productArray addObject: iPhone ];
    
    
    //samsung
    Company *samsung = [[Company alloc] initWithName:@"Samsung" andStockSymbol:@"SSNLF" andLogo:@"samsung.png"];
    
    Product *S4 = [[Product alloc] initWithName:@"Galaxy S4" andUrl:@"http://www.samsung.com/global/microsite/galaxys4/" andLogo: @"samsung.png"];
    [samsung.productArray addObject: S4 ];
    
    Product *Note = [[Product alloc] initWithName:@"Galaxy Note" andUrl:@"http://www.samsung.com/us/mobile/galaxy-note/" andLogo: @"samsung.png"];
    [samsung.productArray addObject: Note ];
    
    
    Product *Tab = [[Product alloc] initWithName:@"Galaxy Tab" andUrl:@"http://www.samsung.com/us/mobile/galaxy-tab/" andLogo: @"samsung.png"];
    [samsung.productArray addObject: Tab ];
    
    //google
    Company *google = [[Company alloc] initWithName:@"Google" andStockSymbol:@"GOOG" andLogo:@"google.png"];
    
    Product *pixelC = [[Product alloc] initWithName:@"Pixel C" andUrl:@"https://pixel.google.com/pixel-c/" andLogo: @"google.png"];
    [google.productArray addObject: pixelC ];
    
    Product *chromebook = [[Product alloc] initWithName:@"Chromebook" andUrl:@"https://www.google.com/chromebook/" andLogo: @"google.png"];
    [google.productArray addObject: chromebook ];
    
    Product *Nexus6P = [[Product alloc] initWithName:@"Nexus 6P" andUrl:@"https://www.google.com/nexus/6p/" andLogo: @"google.png"];
    [google.productArray addObject: Nexus6P ];
    
    //microsoft
    Company *microsoft =  [[Company alloc] initWithName:@"Microsoft" andStockSymbol:@"MSFT" andLogo:@"microsoft.png"];
    
    Product *Lumina = [[Product alloc] initWithName:@"Lumia 950 XL" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia950-xl-dual-sim/" andLogo: @"microsoft.png"];
    [microsoft.productArray addObject: Lumina ];
    
    Product *Lenovo = [[Product alloc] initWithName:@"Lenovo ideapad MIIX 700" andUrl:@"http://shop.lenovo.com/us/en/tablets/ideapad/miix/miix-700/" andLogo: @"microsoft.png"];
    [microsoft.productArray addObject: Lenovo ];
    
    Product *Surface = [[Product alloc] initWithName:@"Surface Pro 4" andUrl:@"http://www.microsoft.com/surface/en-us/devices/surface-pro-4" andLogo: @"microsoft.png"];
    [microsoft.productArray addObject: Surface ];
    
    self.companyList = [[NSMutableArray alloc]init];
    [self.companyList addObject:apple];
    [self.companyList addObject:samsung];
    [self.companyList addObject:google];
    [self.companyList addObject:microsoft];
    
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}


- (id)retain {
    return self;
}

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