//
//  GiphyManager.h
//  Giphy
//
//  Created by Roma Herman on 2/11/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiphyManagerDelegate.h"
#import "GiphyCommunicatorDelegate.h"

@class GiphyCommunicator;

@interface GiphyManager : NSObject<GiphyCommunicatorDelegate>
@property (nonatomic, strong) GiphyCommunicator *communicator;
@property (nonatomic, weak) id<GiphyManagerDelegate> delegate;

- (void)fetchCategories:(NSString *)categories withOffset:(NSInteger)currentOffset;

@end
