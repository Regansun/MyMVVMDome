//
//  PublicCell.m
//  MyMVVMDome
//
//  Created by Regan on 15/4/8.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import "PublicCell.h"

@interface PublicCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *weiboText;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@end

@implementation PublicCell

- (void)setValueWithDic:(PublicModel *)publicModel{
    _userName.text = publicModel.userName;
    _date.text = publicModel.date;
    _weiboText.text = publicModel.text;
    [_headImageView setImageWithURL:publicModel.imageUrl];
}

@end
