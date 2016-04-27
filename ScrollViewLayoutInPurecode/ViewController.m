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
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(generateRandomPages)];
    [scrollView addGestureRecognizer:longPress];
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
    int pages = arc4random() % 3 + 2;
    [self setupPages:pages];
}

- (void)setupPages:(int)pages
{
        NSArray *subviews = self.containView.subviews;
        for (UIView *view in subviews) {
            [view removeFromSuperview];
        }
        [self.contentWidthConstraint autoRemove];
        self.contentWidthConstraint = [self.containView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:pages];
        
        UILabel *prevLabel = nil;
        for (int i = 0; i < pages; ++i) {
            UILabel *pageLabel = [[UILabel alloc] initWithFrame:self.scrollView.bounds];
            pageLabel.text = [NSString stringWithFormat:@"Page %d of %d", i + 1, pages];
            pageLabel.textAlignment = NSTextAlignmentCenter;
            pageLabel.backgroundColor = [UIColor yellowColor];
            [self.containView addSubview:pageLabel];
            
            [pageLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView];
            [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            
            if (!prevLabel) {
                // Align to containView
                [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            } else {
                // Align to prev label
                [pageLabel autoConstrainAttribute:ALAttributeLeading toAttribute:ALAttributeTrailing ofView:prevLabel];
            }
            
            if (i == pages - 1) {
                // Last page
                [pageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
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
