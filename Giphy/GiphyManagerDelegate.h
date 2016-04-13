//
//  GiphyManagerDelegate.h
//  Giphy
//
//  Created by Roma Herman on 2/11/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GiphyManagerDelegate

- (void)didReceiveCategories:(NSArray *)categories;
- (void)fetchingCategoriesFailedWithError:(NSError *)error;

@end

@interface GiphyManagerDelegate : NSObject

@end
