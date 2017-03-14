//
//  DetailViewController.h
//  MaterDetail
//
//  Created by yongjie_zou on 2017/1/19.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

