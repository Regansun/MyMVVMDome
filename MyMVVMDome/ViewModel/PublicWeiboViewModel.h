//
//  PublicWeiboViewModel.h
//  MyMVVMDome
//
//  Created by Regan on 15/4/8.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import "ViewModelClass.h"
#import "PublicModel.h"

@interface PublicWeiboViewModel : ViewModelClass

//获取围脖列表
-(void) fetchPublicWeiBo;

//跳转到微博详情页
-(void) weiboDetailWithPublicModel: (PublicModel *) publicModel WithViewController: (UIViewController *)superController;

@end
