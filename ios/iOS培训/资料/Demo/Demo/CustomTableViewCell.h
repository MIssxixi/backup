//
//  CustomTableViewCell.h
//  Demo
//
//  Created by Mac_ZL on 16/8/2.
//  Copyright © 2016年 Mac_ZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString *imgName;

@property (nonatomic,strong) NSString *title;

+ (CGFloat)heightForCell:(NSInteger )row;
@end
