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
    [self generateRandomPages];
}

-(void)initialAllUIView {
    UIView *containView = [UIView newAutoLayoutView];
    containView.backgroundColor = [UIColor greenColor];
    self.containView = containView;
    
    UIScrollView *scrollView = [UIScrollView newAutoLayoutView];
    scrollView.backgroundColor = [UIColor purpleColor];
    scrollView.userInteractionEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
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


- (void)generateRandomPages
{
    int pages = arc4random() % 10 + 5;
    [self setupPages:pages];
}

- (void)setupPages:(int)pages
{
    //1. clear the previous pageLabel
    NSArray *subviews = self.containView.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    [self.contentWidthConstraint autoRemove];

    self.contentWidthConstraint = [self.containView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:pages];

    CGFloat pageWidth = [UIScreen mainScreen].bounds.size.width / 2.0;
    UILabel *prevLabel = nil;
    for (int i = 0; i < pages; ++i) {
        UILabel *pageLabel = [UILabel newAutoLayoutView];
        pageLabel.text = [NSString stringWithFormat:@"Page %d of %d", i + 1, pages];
        pageLabel.textAlignment = NSTextAlignmentCenter;
        pageLabel.backgroundColor = [UIColor yellowColor];
        
        UIButton *tipsButton = [UIButton newAutoLayoutView];
        [tipsButton setTitle:@"press to reset" forState:UIControlStateNormal] ;
        [tipsButton addTarget:self action:@selector(generateRandomPages) forControlEvents:UIControlEventTouchUpInside];
        tipsButton.userInteractionEnabled = YES;
        tipsButton.backgroundColor = [UIColor redColor];
        [self.containView addSubview:pageLabel];
        [self.containView addSubview:tipsButton];
        
        [pageLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:0.5];
        [pageLabel autoSetDimension:ALDimensionHeight toSize:30.0];
        [pageLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [tipsButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:0.5];
        [tipsButton autoSetDimension:ALDimensionHeight toSize:30.0];
        [tipsButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pageLabel withOffset:4];
        [tipsButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:pageLabel];
        
        if (!prevLabel) {
            [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:pageWidth / 2.0];
        } else {
            [pageLabel autoConstrainAttribute:ALAttributeLeading toAttribute:ALAttributeTrailing ofView:prevLabel withOffset:pageWidth];
        }
        
        prevLabel = pageLabel;
        
    }
    self.scrollView.contentOffset = CGPointZero;

    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
