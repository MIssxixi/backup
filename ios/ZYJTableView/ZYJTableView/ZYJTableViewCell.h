//
//  ZYJTableViewCell.h
//  ZYJTableView
//
//  Created by yongjie_zou on 16/8/3.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYJTableViewCellModel : NSObject

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *detailString;
@property (nonatomic, copy) NSString *sourceString;
@property (nonatomic, assign) NSInteger supportCount;
@property (nonatomic, assign) NSInteger commentCount;

@end

@interface ZYJTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat height;

- (void)updateWithModel:(ZYJTableViewCellModel *)model;

+ (CGFloat)heightWithModel:(ZYJTableViewCellModel *)model;

@end
