//
//  ProductCollectionViewCell.m
//  NavCtrl
//
//  Created by Emiko Clark on 4/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_logo release];
    [_deleteButton release];
    [_name release];
    [_url release];
    [super dealloc];
}
@end
