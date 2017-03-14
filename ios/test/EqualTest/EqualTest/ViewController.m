//
//  ViewController.m
//  EqualTest
//
//  Created by yongjie_zou on 2016/11/1.
//  Copyright © 2016年 yongjie_zou. All rights reserved.
//

#import "ViewController.h"
#import <Mantle/Mantle.h>

@interface ObjectSuper : MTLModel

@end

@implementation ObjectSuper

//- (BOOL)isEqual:(id)object
//{
//    if (self == object)
//    {
//        return YES;
//    }
//    
//    if ([self class] == [object class])
//    {
//        NSData *dataSelf = [NSKeyedArchiver archivedDataWithRootObject:self];
//        NSData *dataObject = [NSKeyedArchiver archivedDataWithRootObject:object];
//        return [dataSelf isEqualToData:dataObject];
//    }
//    else
//    {
//        return [super isEqual:object];
//    }
//}

@end

@interface ObjectA : ObjectSuper

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) NSDictionary *dictionary;
@property (nonatomic, strong) id object;

@end

@implementation ObjectA

@end

@interface ObjectB : ObjectSuper

@property (nonatomic, copy) NSString *name;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ObjectA *a = [ObjectA new];
    a.name = @"name";
    a.array = @[@[@"array"], [a copy]];
    a.dictionary = @{
                     @"key" : @"value"
                     };
    a.object = [a copy];
    
    ObjectA *b = [ObjectA new];
    b.name = @"name";
    b.array = @[@[@"array"], [b copy]];
    b.dictionary = @{
                     @"key" : @"value"
                     };
    b.object = [b copy];
    
    BOOL resulet = [a isEqual:b];
    NSLog(@"%d", resulet);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
