//
//  GiphyManager.m
//  Giphy
//
//  Created by Roma Herman on 2/11/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import "GiphyManager.h"
#import "GiphyCommunicator.h"
#import "CategoryBuilder.h"


@implementation GiphyManager

- (void)fetchCategories:(NSString *)categories withOffset:(NSInteger)currentOffset{
    
    [self.communicator searchCategories:categories withOffset:currentOffset];
    
    
    
}

- (void)receivedCategoriesJSON:(NSData *)objectNotation {
    
    NSError *error = nil;
    NSArray *categories = [CategoryBuilder categoriesFromJSON:objectNotation error:error];
    
    if (error != nil) {
        
        [self.delegate fetchingCategoriesFailedWithError:error];
    }
    else {
        [self.delegate didReceiveCategories:categories];
        
    }
    
}

- (void)fetcingCategoriesFailedWithError:(NSError *)error {
    
    
    [self.delegate fetchingCategoriesFailedWithError:error];
    
}



@end
