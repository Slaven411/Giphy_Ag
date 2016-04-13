//
//  GiphyCell.h
//  Giphy
//
//  Created by Roma Herman on 2/12/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"

@interface GiphyCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gif;
@end
