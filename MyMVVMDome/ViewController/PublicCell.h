//
//  PublicCell.h
//  MyMVVMDome
//
//  Created by Regan on 15/4/8.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicModel.h"

@interface PublicCell : UITableViewCell

- (void)setValueWithDic:(PublicModel *)publicModel;

@end
