
#import "SHTestsSuper.h"

@interface SHTestsCallbacks : SHTestsSuper

@end

@implementation SHTestsCallbacks


-(void)testSH_blockShouldSelectViewController; {
  __block BOOL didAssert = NO;
  SHTabBarControllerPredicateBlock block = ^BOOL(UITabBarController  * theTabBarController,
                                                 UIViewController * theViewController) {
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(self.firstVc, theViewController);
    didAssert = YES;
    return YES;
  };
  
  [self.tabVc SH_setShouldSelectViewControllerBlock:block];

  XCTAssertTrue(self.tabVc.SH_blockShouldSelectViewController(self.tabVc, self.firstVc));
  XCTAssertTrue(didAssert);

  [self.tabVc SH_setShouldSelectViewControllerBlock:nil];
  XCTAssertNil(self.tabVc.SH_blockShouldSelectViewController);
  

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
  self.tabVc.SH_blockDidSelectViewController(self.tabVc, self.firstVc);
  XCTAssertTrue(didAssert);
  
  [self.tabVc SH_setShouldSelectViewControllerBlock:nil];
  XCTAssertNil(self.tabVc.SH_blockShouldSelectViewController);


}

-(void)testSH_blockWillBeginCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[self.firstVc,self.secondVc];
  SHTabBarControllerCustomizingBlock block = ^(UITabBarController  * theTabBarController,
                                               NSArray  * theViewControllers) {

    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(theViewControllers, controllers );
    didAssert = YES;

  };
  
  [self.tabVc SH_setWillBeginCustomizingViewControllersBlock:block];
  self.tabVc.SH_blockWillBeginCustomizingViewControllers(self.tabVc, controllers);
  XCTAssertTrue(didAssert);
  
  [self.tabVc SH_setWillBeginCustomizingViewControllersBlock:nil];
  XCTAssertNil(self.tabVc.SH_blockWillBeginCustomizingViewControllers);

  
}

-(void)testSH_blockWillEndCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[self.firstVc,self.secondVc];

  SHTabBarControllerCustomizingWithChangeBlock block = ^(UITabBarController  * theTabBarController,
                                                         NSArray * theViewControllers,
                                                         BOOL      isChanged) {
    
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(theViewControllers, controllers );
    XCTAssertTrue(isChanged);
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setWillEndCustomizingViewControllersBlock:block];
  self.tabVc.SH_blockWillEndCustomizingViewControllers(self.tabVc, controllers, YES);
  XCTAssertTrue(didAssert);
  
  [self.tabVc SH_setWillEndCustomizingViewControllersBlock:nil];
  XCTAssertNil(self.tabVc.SH_blockWillEndCustomizingViewControllers);

  
}

-(void)testSH_blockDidEndCustomizingViewControllers; {
  __block BOOL didAssert = NO;
  NSArray * controllers = @[self.firstVc,self.secondVc];

  SHTabBarControllerCustomizingWithChangeBlock block = ^void(UITabBarController  * theTabBarController,
                                                         NSArray * theViewControllers,
                                                         BOOL      isChanged) {
    
    XCTAssertEqualObjects(self.tabVc, theTabBarController);
    XCTAssertEqualObjects(theViewControllers, controllers );
    XCTAssertTrue(isChanged);
    didAssert = YES;
    
  };
  
  [self.tabVc SH_setDidEndCustomizingViewControllersBlock:block];
  self.tabVc.SH_blockDidEndCustomizingViewControllers(self.tabVc, controllers, YES);
  XCTAssertTrue(didAssert);
  
  [self.tabVc SH_setDidEndCustomizingViewControllersBlock:nil];
  XCTAssertNil(self.tabVc.SH_blockDidEndCustomizingViewControllers);

  
}


@end