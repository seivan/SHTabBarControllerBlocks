
#import "SHTestsSuper.h"

@interface SHTestsCallbacks : SHTestsSuper

@end

@implementation SHTestsCallbacks


-(void)testSH_blockShouldSelectViewController; {
  __block BOOL didAssert = NO;
  SHTabBarControllerPredicateBlock block = ^BOOL(UITabBarController  * theTabBarController,
                                                 UIViewController * theViewController) {
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(self.firstVc, theViewController, nil);
    didAssert = YES;
    return YES;
  };
  
  [self.tabVc SH_setShouldSelectViewControllerBlock:block];

  STAssertTrue(self.tabVc.SH_blockShouldSelectViewController(self.tabVc, self.firstVc), nil);
  STAssertTrue(didAssert, nil);

  [self.tabVc SH_setShouldSelectViewControllerBlock:nil];
  STAssertNil(self.tabVc.SH_blockShouldSelectViewController, nil);
  

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
  self.tabVc.SH_blockDidSelectViewController(self.tabVc, self.firstVc);
  STAssertTrue(didAssert, nil);
  
  [self.tabVc SH_setShouldSelectViewControllerBlock:nil];
  STAssertNil(self.tabVc.SH_blockShouldSelectViewController, nil);


}

-(void)testSH_blockWillBeginCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[self.firstVc,self.secondVc];
  SHTabBarControllerCustomizingBlock block = ^(UITabBarController  * theTabBarController,
                                               NSArray  * theViewControllers) {

    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(theViewControllers, controllers , nil);
    didAssert = YES;

  };
  
  [self.tabVc SH_setWillBeginCustomizingViewControllersBlock:block];
  self.tabVc.SH_blockWillBeginCustomizingViewControllers(self.tabVc, controllers);
  STAssertTrue(didAssert, nil);
  
  [self.tabVc SH_setWillBeginCustomizingViewControllersBlock:nil];
  STAssertNil(self.tabVc.SH_blockWillBeginCustomizingViewControllers, nil);

  
}

-(void)testSH_blockWillEndCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[self.firstVc,self.secondVc];

  SHTabBarControllerCustomizingWithChangeBlock block = ^(UITabBarController  * theTabBarController,
                                                         NSArray * theViewControllers,
                                                         BOOL      isChanged) {
    
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(theViewControllers, controllers , nil);
    STAssertTrue(isChanged, nil);
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setWillEndCustomizingViewControllersBlock:block];
  self.tabVc.SH_blockWillEndCustomizingViewControllers(self.tabVc, controllers, YES);
  STAssertTrue(didAssert, nil);
  
  [self.tabVc SH_setWillEndCustomizingViewControllersBlock:nil];
  STAssertNil(self.tabVc.SH_blockWillEndCustomizingViewControllers, nil);

  
}

-(void)testSH_blockDidEndCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[self.firstVc,self.secondVc];

  SHTabBarControllerCustomizingWithChangeBlock block = ^void(UITabBarController  * theTabBarController,
                                                         NSArray * theViewControllers,
                                                         BOOL      isChanged) {
    
    STAssertEqualObjects(self.tabVc, theTabBarController, nil);
    STAssertEqualObjects(theViewControllers, controllers , nil);
    STAssertTrue(isChanged, nil);
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setDidEndCustomizingViewControllersBlock:block];
  self.tabVc.SH_blockDidEndCustomizingViewControllers(self.tabVc, controllers, YES);
  STAssertTrue(didAssert, nil);
  
  [self.tabVc SH_setDidEndCustomizingViewControllersBlock:nil];
  STAssertNil(self.tabVc.SH_blockDidEndCustomizingViewControllers, nil);

  
}


@end