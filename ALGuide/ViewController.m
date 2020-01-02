//
//  ViewController.m
//  ALGuide
//
//  Created by lizihong on 2020/1/2.
//  Copyright © 2020 AL. All rights reserved.
//

#import "ViewController.h"
#import "ALGuideView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ALGuideView *guideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.guideView addThroughFrame:CGRectMake(10, 10, 50, 50)];
}

- (IBAction)buttonDidTap:(id)sender {
    NSLog(@"button 点击");
    [self.guideView addThroughCircle:CGPointMake(190, 60) radius:30];
    [self.guideView addThroughFrame:CGRectMake(110, 110, 50, 50)];
    self.guideView.frame = CGRectMake(50, 50, 300, 300);
}

@end
