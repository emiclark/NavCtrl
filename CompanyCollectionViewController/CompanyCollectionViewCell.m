//
//  CompanyCollectionViewCell.m
//  NavCtrl
// Assignment9
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewCell.h"

@implementation CompanyCollectionViewCell

- (IBAction)deleteButtonTapped:(UIButton *)sender {
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_logo release];
    [_name release];
    [_stockPrice release];
    [_name release];
    [super dealloc];
}


@end
