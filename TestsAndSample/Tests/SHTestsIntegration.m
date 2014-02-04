
#import "SHTestsSuper.h"

@interface SHTestedAnimationController : NSObject
<UIViewControllerAnimatedTransitioning>
@end


@implementation SHTestedAnimationController
-(NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext; {
  return 0.3;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext; {
  
}
@end


@interface SHTestsIntegration : SHTestsSuper

@end

@implementation SHTestsIntegration

-(void)testSH_blockShouldSelectViewController; {
  __block BOOL didAssert = NO;
  SHTabBarControllerPredicateBlock block = ^BOOL(UITabBarController  * theTabBarController,
                                                 UIViewController * theViewController) {
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(self.secondVc, theViewController);
    didAssert = YES;
    return YES;
  };
  
  [self.tabVc SH_setShouldSelectViewControllerBlock:block];

  [tester tapViewWithAccessibilityLabel:self.secondVc.title];

  XCTAssertTrue(didAssert);
  
  
  
}

-(void)testSH_blockDidSelectViewController; {
  __block BOOL didAssert = NO;
  SHTabBarControllerBlock block = ^(UITabBarController  * theTabBarController,
                                    UIViewController * theViewController) {
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(self.firstVc, theViewController);
    didAssert = YES;

  };
  
  [self.tabVc SH_setDidSelectViewControllerBlock:block];
  [tester tapViewWithAccessibilityLabel:self.firstVc.title];

  XCTAssertTrue(didAssert);
  
  
}

-(void)testSH_blockWillBeginCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new, UIViewController.new,UIViewController.new];
  
  SHTabBarControllerCustomizingBlock block = ^(UITabBarController  * theTabBarController,
                                               NSArray  * theViewControllers) {
    
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(theViewControllers, controllers );
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setWillBeginCustomizingViewControllersBlock:block];
  
  self.tabVc.viewControllers = controllers;
  [tester tapViewWithAccessibilityLabel:@"More"];
  [tester tapViewWithAccessibilityLabel:@"Edit"];
  
  XCTAssertTrue(didAssert);
  
  
}

-(void)testSH_blockWillEndCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  
  NSArray * controllers = @[UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new,UIViewController.new, UIViewController.new,UIViewController.new];

  
  SHTabBarControllerCustomizingWithChangeBlock block = ^(UITabBarController  * theTabBarController,
                                                         NSArray * theViewControllers,
                                                         BOOL      isChanged) {
    
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(theViewControllers, controllers );
    XCTAssertFalse(isChanged);
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setWillEndCustomizingViewControllersBlock:block];
  self.tabVc.viewControllers = controllers;
  [tester tapViewWithAccessibilityLabel:@"More"];
  [tester tapViewWithAccessibilityLabel:@"Edit"];
  [tester tapViewWithAccessibilityLabel:@"Done"];

  XCTAssertTrue(didAssert);
  
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
    
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(theViewControllers, controllers);
    XCTAssertTrue(isChanged);
    didAssert = YES;
    
  };

  [self.tabVc SH_setDidEndCustomizingViewControllersBlock:block];
  self.tabVc.viewControllers = controllers;
  [tester tapViewWithAccessibilityLabel:@"More"];
  [tester tapViewWithAccessibilityLabel:@"Edit"];
  [tester swipeViewWithAccessibilityLabel:@"8" inDirection:KIFSwipeDirectionDown];
  
  UIViewController * ten = controllers[10];
  [controllers removeObjectAtIndex:10];
  
  UIViewController * two = controllers[2];
  [controllers removeObjectAtIndex:2];

  [controllers insertObject:ten atIndex:2];
  [controllers insertObject:two atIndex:10];
  [tester tapViewWithAccessibilityLabel:@"Done"];

  
  XCTAssertTrue(didAssert);
  
  
}

-(void)testSH_setInteractiveTransitioningBlock; {
  __block BOOL didAssert = NO;
  
  __weak typeof(self) weakSelf = self;
  [self.tabVc SH_setInteractiveControllerBlock:^id<UIViewControllerInteractiveTransitioning>(UITabBarController *tabBarController, id<UIViewControllerAnimatedTransitioning> animationController) {
    XCTAssertEqualObjects(weakSelf.tabVc, tabBarController);
    didAssert = YES;
    return UIPercentDrivenInteractiveTransition.new;
    
  }];
  UIPercentDrivenInteractiveTransition * percentTrans = self.tabVc.SH_blockInteractiveController(self.tabVc, nil);
  XCTAssert(percentTrans);
  XCTAssertEqualObjects([percentTrans class], [UIPercentDrivenInteractiveTransition class]);
  XCTAssertTrue(didAssert);
}

-(void)testSH_setAnimatedTransitioningBlock; {
  __block BOOL didAssert = NO;
  
  __weak typeof(self) weakSelf = self;
  SHTestedAnimationController  * animation = SHTestedAnimationController.new;
  [self.tabVc SH_setAnimatedControllerBlock:^id<UIViewControllerAnimatedTransitioning>(UITabBarController *tabBarController, UIViewController *fromVC, UIViewController *toVC) {
    
    XCTAssertEqualObjects(weakSelf.tabVc, tabBarController);
    XCTAssertEqualObjects(weakSelf.tabVc.viewControllers.firstObject, fromVC);
    XCTAssertEqualObjects(weakSelf.firstVc, toVC);
    didAssert = YES;
    return animation;
  }];
  id<UIViewControllerAnimatedTransitioning> animatedTrans = self.tabVc.SH_blockAnimatedController(self.tabVc, self.tabVc.viewControllers.firstObject, self.firstVc);
  XCTAssert(animatedTrans);
  XCTAssertEqualObjects(animation, animatedTrans);
  XCTAssertTrue(didAssert);
}


@end