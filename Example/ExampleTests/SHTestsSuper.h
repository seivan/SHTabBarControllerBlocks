//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "KIF.h"
#import "SHTestCaseAdditions.h"
#import "SHFastEnumerationProtocols.h"

#import "SHTabBarControllerBlocks.h"




@interface SHTestsSuper : KIFTestCase
@property(nonatomic,strong) UIViewController   * firstVc;
@property(nonatomic,strong) UIViewController   * secondVc;
@property(nonatomic,strong) UITabBarController * tabVc;
@end

