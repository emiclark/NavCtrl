//
//  ProductCollectionViewController.m
//  NavCtrl
// Assignment9
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Emiko Clark on 4/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewController.h"
#import "ProductCollectionViewCell.h"

@class EditCompanyViewController;

@interface ProductCollectionViewController ()
@property (nonatomic, retain) DAO *dao;

@end

@implementation ProductCollectionViewController

NSString * const productReuseIdentifier = @"ProductCollectionViewCell";
BOOL isEditingProduct = NO;
UIBarButtonItem *editButton;
UIBarButtonItem *deleteButton;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    isEditingProduct = NO;
    editButton.title = @"Edit";
    [self.collectionView reloadData];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedManager];
    
    self.installsStandardGestureForInteractiveMovement = YES;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:productReuseIdentifier];
    
    // Do any additional setup after loading the view.

    
    // Register cell classes
    [self.collectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:productReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:productReuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    self.collectionView.allowsSelection = YES;
    //    self.clearsSelectionOnViewWillAppear = NO;
    self.editProductViewController = [[EditProductViewController alloc] init];
    
    //add Add Product Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.title = @"Add Product";
    addButton.action = @selector(addButtonTapped:);
    addButton.target = self;
    
    //add Save Button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]init];
    saveButton.title = @"Save";
    saveButton.action = @selector(saveButtonTapped:);
    saveButton.target = self;
    
    //add Undo Button
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]init];
    undoButton.title = @"Undo";
    undoButton.action = @selector(undoButtonTapped:);
    undoButton.target = self;
    
    //add Edit button
    editButton = [[UIBarButtonItem alloc]init];
    editButton.action = @selector(setEditMode);
    editButton.title = @"Edit";
    editButton.target = self;
    
    // Display all buttons on navigation bar
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:addButton, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: editButton, undoButton, saveButton, nil];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    //[self.collectionView setAllowsSelectionDuringEditing:YES];
    
    [self.collectionView reloadData];
    
}


#pragma mark Product CRUD Methods

-(void)addButtonTapped:(id)sender {
    
    self.editProductViewController = [[EditProductViewController alloc]initWithNibName:@"EditProductViewController" bundle:nil];
    
    self.editProductViewController.currentCompany = self.dao.currentCompany;
    
//    self.editProductViewController.productVC = self;
    
    [self.navigationController pushViewController: self.editProductViewController animated:YES];
}

-(void)undoButtonTapped:(id)sender {
    [DAO undoProduct];
    [self.collectionView reloadData];
}

-(void)saveButtonTapped:(id)sender {
    [DAO save];
    [self.collectionView reloadData];
}

- (void)setEditMode
{
    isEditingProduct  = !isEditingProduct;
    if (isEditingProduct)
        {
        editButton.title = @"Done";
        }
    else
        {
        editButton.title = @"Edit";
        }
    [self.collectionView reloadData];
    
}

    
-(void) deleteItem:(UIButton *)sender {
    ProductCollectionViewCell *cell = ((ProductCollectionViewCell *)sender.superview.superview);

    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    self.dao.currentProduct = [self.dao.currentCompany.productArray objectAtIndex:indexPath.row ];
    
    [self.dao deleteProduct: self.dao.currentProduct atRow:indexPath.row];
    //[self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
    [self.collectionView reloadData];
}


-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath  {

    self.currentProduct = [self.currentCompany.productArray objectAtIndex:sourceIndexPath.row];
    
    if (self.currentCompany.productArray.count > 0){
        
        //more than 1 element
        if (destinationIndexPath.row == self.currentCompany.productArray.count-1) {
            //move to bottom, increment row +1.0 of last product and assign to currentProduct
            
            self.currentProduct.row = [self.currentCompany.productArray objectAtIndex: destinationIndexPath.row].row + 1.0;
        } else if (destinationIndexPath.row == 0){
            //move to top, divide/2 the product.row index in position 1 and set to currentProduct.row
            self.currentProduct.row = [self.currentCompany.productArray objectAtIndex:destinationIndexPath.row].row / 2.0;
            
        } else if (sourceIndexPath.row > destinationIndexPath.row){
            // move up
            float rowBefore =[self.currentCompany.productArray objectAtIndex:destinationIndexPath.row-1].row;
            float rowAfter = [self.currentCompany.productArray objectAtIndex:destinationIndexPath.row].row;
            self.currentProduct.row = (rowBefore + rowAfter) / 2.0;
            
        } else if (sourceIndexPath.row < destinationIndexPath.row){
            //move down
            float rowBefore =[self.currentCompany.productArray objectAtIndex:destinationIndexPath.row].row;
            float rowAfter = [self.currentCompany.productArray objectAtIndex:destinationIndexPath.row+1].row;
            self.currentProduct.row = (rowBefore + rowAfter) / 2.0;
        }
    } else {
        //add 1st product for company
        self.currentProduct.row = 1.0;
    }
    
    [DAO moveProduct:self.currentProduct];
    
    [self.currentCompany.productArray removeObjectAtIndex:sourceIndexPath.row];
    [self.currentCompany.productArray insertObject:self.currentProduct atIndex:destinationIndexPath.row];
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
    return self.dao.currentCompany.productArray.count;
}

- (ProductCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:productReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Product *product = [self.dao.currentCompany.productArray objectAtIndex:indexPath.row];
    cell.name.text = product.name;
    cell.logo.image = [UIImage imageNamed:product.logo ];
    
    if (isEditingProduct == YES) {
        cell.deleteButton.hidden = NO;
    }
    else {
        cell.deleteButton.hidden = YES;
    }
    //draw border around cell
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor orangeColor].CGColor;
    
    [cell.deleteButton addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];

    // Configure the cell
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.dao.currentProduct = [self.dao.currentCompany.productArray objectAtIndex:indexPath.row];
    self.editProductViewController.currentCompany = self.dao.currentCompany;
    
    if (isEditingProduct==YES) {
        //initialize EditProductViewController for editing
        self.editProductViewController = [[[EditProductViewController alloc]initWithNibName:@"EditProductViewController" bundle:nil] autorelease];
        self.editProductViewController.currentRow = indexPath.row;
        self.editProductViewController.currentProduct.row = indexPath.row;
        self.editProductViewController.currentProduct = [[self currentCompany].productArray objectAtIndex:indexPath.row];
        
        self.titleOfCompany =  self.currentProduct.name;
        //set title of EditProductViewController
        self.editProductViewController.title = self.editProductViewController.currentProduct.name;
        //        self.editProductViewController.productVC = self;
        [self.navigationController pushViewController: self.editProductViewController animated:YES];
        
    } else {
        
        self.dao.currentProduct = [self.dao.currentCompany.productArray objectAtIndex:indexPath.row];
        self.editProductViewController.currentCompany = self.dao.currentCompany;
        
        //show product webpage
        //initialize webkit view controller to show url of product
        Product *tempProduct = [self.currentCompany.productArray objectAtIndex:indexPath.row];
        
        // Create the next view controller.
        self.myWebViewCtlr = [[[WebViewController alloc]init] autorelease];
        self.myWebViewCtlr.productURL = tempProduct.url;
        self.myWebViewCtlr.title = tempProduct.name;
        
        if ([self.currentProduct.url isEqualToString:@""]) {
            self.myWebViewCtlr.title = [NSString stringWithFormat:@"No Website provided for product %@.",tempProduct.name];
        }
        
        [self.navigationController pushViewController:self.myWebViewCtlr animated:YES];
    }
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
