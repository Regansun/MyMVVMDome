//
//  PublicModel.h
//  MyMVVMDome
//
//  Created by Regan on 15/4/8.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicModel : NSObject

@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *weiboId;
@property (copy, nonatomic) NSString *userName;
@property (strong, nonatomic) NSURL *imageUrl;
@property (copy, nonatomic) NSString *date;
@property (copy, nonatomic) NSString *text;

@end
