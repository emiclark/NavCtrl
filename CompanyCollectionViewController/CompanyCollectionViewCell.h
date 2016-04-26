//
//  CompanyCollectionViewCell.h
//  NavCtrl
// Assignment10
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCell;
@protocol MyCellDelegate

@end
@interface CompanyCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UIImageView *logo;
@property (retain, nonatomic) IBOutlet UILabel *stockPrice;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;

-(IBAction)deleteButtonTapped:(UIButton *)sender;
-(void)awakeFromNib;
@end
