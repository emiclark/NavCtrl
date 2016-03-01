//
//  Company.m
//  ASSIGNMENT3
//
//  Created by Aditya Narayan on 2/26/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (id) initWithName:(NSString*)name andLogo:(NSString*)logo{
    self=[super init];
    if (self) {
        self.name = name;
        self.logo = logo;
        NSLog(@"_init:%@",self);
    }
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@, %@", self.name, self.logo];
}
@end
