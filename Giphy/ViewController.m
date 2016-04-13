//
//  ViewController.m
//  Giphy
//
//  Created by Roma Herman on 2/10/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import "ViewController.h"
#import "GiphyManager.h"
#import "GiphyCommunicator.h"
#import "GiphyCell.h"
#import "GiphyManagerDelegate.h"
#import "CategoryGiphy.h"

@protocol GiphyManager;

@interface ViewController ()<GiphyManagerDelegate, UISearchBarDelegate>
@property (nonatomic, strong) GiphyManager *giphyManager;
@property (nonatomic, strong) NSMutableArray *gifs;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, strong) NSString *keyWord;


@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gifs = [[NSMutableArray alloc]init];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.collectionView.frame), 44)];
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.delegate = self;
    [self.collectionView addSubview:self.searchBar];
    [self.collectionView setContentOffset:CGPointMake(0, 44)];
    
    
    self.giphyManager = [[GiphyManager alloc] init];
    self.giphyManager.communicator = [[GiphyCommunicator alloc] init];
    self.giphyManager.communicator.delegate = self.giphyManager;
    self.giphyManager.delegate = self;
    

    
}


- (void) viewWillAppear:(BOOL)animated{
    // to show search bar
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
    // to hide search bar
    [self.collectionView setContentOffset:CGPointMake(0, 44)];


}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.keyWord = searchBar.text;
    
    self.offset = 0;
    
    [self.gifs removeAllObjects];
    [self.giphyManager fetchCategories:self.keyWord withOffset:self.offset];
    
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setText:@""];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didReceiveCategories:(NSArray *)categories {
    
    [self.gifs addObjectsFromArray:categories];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;

    });
    
        
}

- (void)fetchingCategoriesFailedWithError:(NSError *)error {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.gifs.count;
}

- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(FLAnimatedImage *animatedImage))completion
{
    NSString *const filename = [NSString stringWithFormat:@"%lu",(unsigned long)url.hash];
    NSString *const diskPath = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    
    NSData * __block animatedImageData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    FLAnimatedImage * __block animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
    
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [data writeToFile:diskPath atomically:YES];
            }
        }] resume];
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"GiphyCell";
    

    CategoryGiphy *categoryGiphy = [self.gifs objectAtIndex:indexPath.row];
    
    GiphyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    NSURL *url2 = [NSURL URLWithString:categoryGiphy.url];

    [self loadAnimatedImageWithURL:url2 completion:^(FLAnimatedImage *animatedImage) {
        cell.gif.animatedImage = animatedImage;//тут присвоить картинке,которая у ячейки animatedImage
    }];
    
    //cell.userInteractionEnabled = YES;
    //cell.tag = indexPath.row;
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryGiphy *categoryGiphy = [self.gifs objectAtIndex:indexPath.row];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Information" message:categoryGiphy.description  delegate:self cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil]; [alertView show];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        // we are at the end
        [self.activityIndicatorView startAnimating];
        self.activityIndicatorView.hidden = NO;
        self.offset = self.offset + 25;
        [self.giphyManager fetchCategories:self.keyWord withOffset:self.offset];

    }
    
}


@end
