//
//  ViewController.h
//  Giphy
//
//  Created by Roma Herman on 2/10/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@end