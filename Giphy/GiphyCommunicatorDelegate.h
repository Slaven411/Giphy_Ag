//
//  GiphyCommunicatorDelegate.h
//  Giphy
//
//  Created by Roma Herman on 2/10/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GiphyCommunicatorDelegate
- (void)receivedCategoriesJSON:(NSData *)objectNotation;
- (void)fetcingCategoriesFailedWithError:(NSError *)error;
@end

@interface GiphyCommunicatorDelegate : NSObject

@end
