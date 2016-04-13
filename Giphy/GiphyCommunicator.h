//
//  GiphyCommunicator.h
//  Giphy
//
//  Created by Roma Herman on 2/10/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GiphyCommunicatorDelegate;

@interface GiphyCommunicator : NSObject
@property (nonatomic, weak) id<GiphyCommunicatorDelegate> delegate;

- (void)searchCategories:(NSString *)category withOffset:(NSInteger)currentOffset;

@end
