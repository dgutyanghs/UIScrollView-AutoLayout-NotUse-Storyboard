//
//  ViewController.m
//  ScrollViewLayoutInPurecode
//
//  Created by AlexYang on 4/27/16.
//  Copyright © 2016 AlexYang. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout/PureLayout.h"

@interface ViewController ()
@property (nonatomic , weak) UIView *containView;
@property (nonatomic , weak) UIScrollView *scrollView;
@property (nonatomic , strong) NSLayoutConstraint *contentWidthConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initialAllUIView];
}

-(void)initialAllUIView {
    UIView *containView = [[UIView alloc] init];
    containView.backgroundColor = [UIColor greenColor];
    self.containView = containView;
    
    UIScrollView *scrollView = [UIScrollView newAutoLayoutView];
    scrollView.backgroundColor = [UIColor purpleColor];
    self.scrollView = scrollView;
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:containView];
    
    [containView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:scrollView];
    [containView autoPinEdge:ALEdgeTop  toEdge:ALEdgeTop  ofView:scrollView];
    NSLayoutConstraint *contentWidthConstraint = [self.scrollView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:containView];
    self.contentWidthConstraint = contentWidthConstraint;
    [scrollView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:containView];
    [scrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:containView];
    [scrollView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:containView];
    
    
    [self.view autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:scrollView];
    [scrollView autoPinToBottomLayoutGuideOfViewController:self withInset:0];
    [scrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
    [scrollView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
