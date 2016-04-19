//
//  CompanyCollectionViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewController.h"
#import "CompanyCollectionViewCell.h"

@interface CompanyCollectionViewController ()

@end

@implementation CompanyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [DAO initializeDAO];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CompanyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CompanyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.collectionView.allowsSelection = YES;
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.productViewController = [[[ProductViewController alloc] init] autorelease];
    
    //add Add New Company button on LHS
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.action = @selector(addNewCompany);
    addButton.title = @"Add New Company";
    addButton.target = self;
    self.navigationItem.leftBarButtonItem = addButton;
    
    //add Save button on LHS
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]init];
    saveButton.action = @selector(saveButtonTapped);
    saveButton.title = @"Save /";
    saveButton.target = self;
    self.navigationItem.leftBarButtonItem = saveButton;
    
    //add Undo button RHS
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]init];
    undoButton.action = @selector(undoCompany);
    undoButton.title = @"Undo /";
    undoButton.target = self;
    
    // Display an 'Add New Company' and Save button on the LHS navigation bar for this view controller.
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:addButton, nil];
    
    // Display an Edit and Undo button on the RHS navigation bar for this view controller.
    //    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, undoButton, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, undoButton, saveButton, nil];
    
    
    self.title = @"Mobile device makers";
    
    [self.collectionView reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return    [[[DAO sharedManager] companyList] count ];
}

- (CompanyCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CompanyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    Company *company = [[[DAO sharedManager] companyList] objectAtIndex:indexPath.row];
    cell.name.text = company.name;
    cell.stockPrice.text = company.stockSymbol;
    cell.logo.image = [UIImage imageNamed:company.logo ];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



//// Uncomment this method to specify if the specified item should be highlighted during tracking
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//	return YES;
//}
//
//
//
//// Uncomment this method to specify if the specified item should be selected
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//
//
//// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
//	return YES;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//	return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//	
//}


@end
