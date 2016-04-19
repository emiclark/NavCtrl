//
//  CompanyCollectionViewCell.h
//  NavCtrl
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCollectionViewCell : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *logo;
@property (retain, nonatomic) IBOutlet UILabel *stockPrice;
@property (retain, nonatomic) IBOutlet UILabel *name;

-(void)awakeFromNib;
@end
