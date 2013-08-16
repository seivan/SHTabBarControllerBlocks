
#import "SHTestsSuper.h"

@interface SHTestsIntegration : SHTestsSuper

@end

@implementation SHTestsIntegration

-(void)testSH_blockShouldSelectViewController; {
  __block BOOL didAssert = NO;
  SHTabBarControllerPredicateBlock block = ^BOOL(UITabBarController  * theTabBarController,
                                                 UIViewController * theViewController) {
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(self.secondVc, theViewController, nil);
    didAssert = YES;
    return YES;
  };
  
  [self.tabVc SH_setShouldSelectViewControllerBlock:block];

  [tester tapViewWithAccessibilityLabel:self.secondVc.title];

  STAssertTrue(didAssert, nil);
  
  
  
}

-(void)testSH_blockDidSelectViewController; {
  __block BOOL didAssert = NO;
  SHTabBarControllerBlock block = ^(UITabBarController  * theTabBarController,
                                    UIViewController * theViewController) {
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(self.firstVc, theViewController, nil);
    didAssert = YES;

  };
  
  [self.tabVc SH_setDidSelectViewControllerBlock:block];
  [tester tapViewWithAccessibilityLabel:self.firstVc.title];

  STAssertTrue(didAssert, nil);
  
  
}

-(void)testSH_blockWillBeginCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new, UIViewController.new,UIViewController.new];
  
  SHTabBarControllerCustomizingBlock block = ^(UITabBarController  * theTabBarController,
                                               NSArray  * theViewControllers) {
    
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(theViewControllers, controllers , nil);
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setWillBeginCustomizingViewControllersBlock:block];
  
  self.tabVc.viewControllers = controllers;
  [tester tapViewWithAccessibilityLabel:@"More"];
  [tester tapViewWithAccessibilityLabel:@"Edit"];
  
  STAssertTrue(didAssert, nil);
  
  
}

-(void)testSH_blockWillEndCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  
  NSArray * controllers = @[UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new, UIViewController.new,UIViewController.new];

  
  SHTabBarControllerCustomizingWithChangeBlock block = ^(UITabBarController  * theTabBarController,
                                                         NSArray * theViewControllers,
                                                         BOOL      isChanged) {
    
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(theViewControllers, controllers , nil);
    STAssertFalse(isChanged, nil);
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setWillEndCustomizingViewControllersBlock:block];
  self.tabVc.viewControllers = controllers;
  [tester tapViewWithAccessibilityLabel:@"More"];
  [tester tapViewWithAccessibilityLabel:@"Edit"];
  [tester tapViewWithAccessibilityLabel:@"Done"];

  STAssertTrue(didAssert, nil);
  
}

-(void)testSH_blockDidEndCustomizingViewControllers; {
  __block BOOL didAssert = NO;

  
  NSMutableArray * controllers = @[].mutableCopy;
  for (NSInteger i = 0; i <= 14; i++) {
    UIViewController * vc = UIViewController.new;
    vc.title = @(i).stringValue;
    [controllers addObject:vc];
  }

  
  SHTabBarControllerCustomizingWithChangeBlock block = ^void(UITabBarController  * theTabBarController,
                                                             NSArray * theViewControllers,
                                                             BOOL      isChanged) {
    
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(theViewControllers, controllers, nil);
    STAssertTrue(isChanged, nil);
    didAssert = YES;
    
  };

  [self.tabVc SH_setDidEndCustomizingViewControllersBlock:block];
  self.tabVc.viewControllers = controllers;
  [tester tapViewWithAccessibilityLabel:@"More"];
  [tester tapViewWithAccessibilityLabel:@"Edit"];
  [tester swipeViewWithAccessibilityLabel:@"8" inDirection:KIFSwipeDirectionDown];
  UIViewController * ten = [controllers SH_popObjectAtIndex:10];
  UIViewController * two = [controllers SH_popObjectAtIndex:2];
  [controllers insertObject:ten atIndex:2];
  [controllers insertObject:two atIndex:10];
  [tester tapViewWithAccessibilityLabel:@"Done"];

  
  STAssertTrue(didAssert, nil);
  
  
}


@end