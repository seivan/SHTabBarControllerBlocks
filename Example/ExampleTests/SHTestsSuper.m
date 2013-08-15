#import "SHTestsSuper.h"



@implementation SHTestsSuper

-(void)setUp; {
  [super setUp];
  self.firstVc               = UIViewController.new;
  self.secondVc              = UIViewController.new;
  self.tabVc                 = [[UITabBarController alloc] init];
  self.tabVc.viewControllers = @[self.firstVc, self.secondVc];
  
  [UIApplication sharedApplication].keyWindow.rootViewController = self.tabVc;
  [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
  
}
@end



