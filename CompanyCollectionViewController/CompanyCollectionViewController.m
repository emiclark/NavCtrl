//
//  CompanyCollectionViewController.m
//  NavCtrl
// Assignment9
// CoreData + AFNetworking to retrieve StockPrices
//
//  Created by Aditya Narayan on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewController.h"
#import "CompanyCollectionViewCell.h"
#import "AFNetworking.h"
#import "DAO.h"
#import <SystemConfiguration/SystemConfiguration.h> 

@interface CompanyCollectionViewController ()
@property ( nonatomic, retain) DAO *dao;

@end

@implementation CompanyCollectionViewController 

NSString * const companyReuseIdentifier = @"CompanyCollectionViewCell";
BOOL isEditingCompany = NO;
UIBarButtonItem *editButton;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setEditing:NO];
    [self getStockPrices];
    [NSTimer scheduledTimerWithTimeInterval: 150.0
                                     target: self
                                   selector: @selector(getStockPrices)
                                   userInfo: nil
                                    repeats: YES];
    isEditingCompany = NO;
    editButton.title = @"Edit";
    [self.collectionView reloadData];
}

    
-(void) getStockPrices {
    [self.dao updateStockPrices];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [DAO initializeDAO];
    self.dao = [DAO sharedManager];
    self.dao.ccvc = self;

    self.installsStandardGestureForInteractiveMovement = YES;
    // Register cell classes
    [self.collectionView registerClass:[CompanyCollectionViewCell class] forCellWithReuseIdentifier:companyReuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CompanyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:companyReuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    self.collectionView.allowsSelection = YES;
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.productCollectionViewController =
    [[ProductCollectionViewController alloc]
     initWithNibName:@"ProductCollectionViewController" bundle:nil];

    //add Add Company button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.action = @selector(addNewCompany);
    addButton.title = @"Add Company";
    addButton.target = self;
    
    //add Save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]init];
    saveButton.action = @selector(saveButtonTapped);
    saveButton.title = @"Save";
    saveButton.target = self;
    
    //add Undo button
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]init];
    undoButton.action = @selector(undoCompany);
    undoButton.title = @"Undo";
    undoButton.target = self;
    
    //add Edit button
    editButton = [[UIBarButtonItem alloc]init];
    editButton.action = @selector(setEditMode);
    editButton.title = @"Edit";
    editButton.target = self;
    
    // Display buttons on LHS
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:addButton, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, undoButton, saveButton, nil];
    
    self.title = @"Mobile device makers";
    
    [self.collectionView reloadData];
}


#pragma mark Company CRUD Methods

    ////////
-(void) addNewCompany {
    self.editCompanyViewController = [[EditCompanyViewController alloc]initWithNibName:@"EditCompanyViewController" bundle:nil];
    self.editCompanyViewController.currentCompany = [[[Company alloc]init]autorelease];
    [self.navigationController pushViewController: self.editCompanyViewController animated:YES];
}

-(void) deleteItem:(UIButton *)sender {
    CompanyCollectionViewCell *cell = ((CompanyCollectionViewCell *)sender.superview.superview);
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [self.dao deleteCompany: self.dao.companyList[indexPath.row] atRow:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self.collectionView reloadData];
}

-(void) saveButtonTapped {
    [DAO save];
    [self.collectionView reloadData];
}

-(void) undoCompany {
    [DAO undoCompany];
    [self.collectionView reloadData];
}

-(void ) collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Company *itemToMove;
    itemToMove = (Company*)[self.dao.companyList objectAtIndex:sourceIndexPath.row];
    [itemToMove retain];
    [self.dao.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.dao.companyList insertObject:itemToMove atIndex:destinationIndexPath.row];
    
    for (int i = 0; i < self.dao.companyList.count; i++){
        Company *company = self.dao.companyList[i];
        company.row = (float)i;
        [DAO moveCompany:company];
    }
    [self.collectionView reloadData];
    [itemToMove release];
    
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

-(CompanyCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CompanyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:companyReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    Company *company = [[[DAO sharedManager] companyList] objectAtIndex:indexPath.row];
    cell.name.text = company.name;
    cell.stockPrice.text = company.stockPrice;
    cell.logo.image = [UIImage imageNamed:company.logo ];

    // display delete button
    if (isEditingCompany == YES) {
        cell.deleteButton.hidden = NO;
    }
    else {
        cell.deleteButton.hidden = YES;
    }
    //draw border around cell
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor orangeColor].CGColor;
    [cell.deleteButton addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}

- (void)setEditMode
{
    isEditingCompany  = !isEditingCompany;

    if (isEditingCompany)
        {
        editButton.title = @"Done";
        }
    else
        {
        editButton.title = @"Edit";
    }
    
    [self setEditing:isEditingCompany];


    [self.collectionView reloadData];
    
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.dao.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
    self.currentCompany = self.dao.currentCompany;
    self.editCompanyViewController.currentCompany = self.currentCompany;
    
    if (self.isEditing == YES) {
        //edit mode - edit company
        //set new viewcontroller to editCompanyViewController
        self.editCompanyViewController = [[EditCompanyViewController alloc]initWithNibName:@"EditCompanyViewController" bundle:nil];
        
        //set title of view controller
        self.productCollectionViewController.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row] ;
        self.productCollectionViewController.titleOfCompany = [[self.dao.companyList objectAtIndex:indexPath.row] name] ;
        
        //pass in pointer of company selected to ediCompanyViewController.companyToedit
        self.editCompanyViewController.currentCompany = [self.dao.companyList objectAtIndex: indexPath.row];
        [self.navigationController pushViewController:self.editCompanyViewController animated:YES  ];
        
    } else {
        //show product details
        self.productCollectionViewController.currentCompany = [self.dao.companyList objectAtIndex:indexPath.row];
        self.productCollectionViewController.titleOfCompany = self.currentCompany.name;
        self.productCollectionViewController.title = self.productCollectionViewController.titleOfCompany;
        [self.navigationController pushViewController:self.productCollectionViewController animated:YES];
    }
}


//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//	return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//	
//}


@end
