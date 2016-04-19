//
//  CompanyCollectionViewCell.m
//  NavCtrl
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewCell.h"

@implementation CompanyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //background color
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView = bgView;
//    self.backgroundView.backgroundColor = [UIColor blueColor];
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    
    //selected background color
    UIView *selectedView = [[UIView alloc] initWithFrame:[self bounds]];
    self.backgroundView = selectedView;
//    self.selectedBackgroundView.backgroundColor = [UIColor yellowColor];

    self.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]];
}

- (void)dealloc {
    [_logo release];
    [_name release];
    [_stockPrice release];
    [_name release];
    [super dealloc];
}
@end
