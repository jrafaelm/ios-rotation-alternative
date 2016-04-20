//
//  ViewController.m
//  IpadRotationApproach
//
//  Created by Jose Rafael on 4/15/16.
//  Copyright © 2016 Jose Rafael. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray* portraitConstraintsCollection;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray* landscapeConstraintsCollection;
@property (nonatomic) InterfaceOrientation lastOrientation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.lastOrientation = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? Portrait : Landscape;

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.lastOrientation != Landscape) { //The orientation specifiend on the nib file
        [self setUpViewConstraintsForInterfaceOrientation:self.lastOrientation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

-(void) setUpViewConstraintsForInterfaceOrientation:(InterfaceOrientation) interfaceOrientation {
        self.lastOrientation = interfaceOrientation;
        if (interfaceOrientation == Landscape) {
            [NSLayoutConstraint deactivateConstraints:self.portraitConstraintsCollection];
            [NSLayoutConstraint activateConstraints:self.landscapeConstraintsCollection];
        }else if(interfaceOrientation == Portrait){
            [NSLayoutConstraint deactivateConstraints:self.landscapeConstraintsCollection];
            [NSLayoutConstraint activateConstraints:self.portraitConstraintsCollection];
        }
        [self.view layoutIfNeeded];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if (size.height < size.width && self.lastOrientation != Landscape) {
        [self setUpViewConstraintsForInterfaceOrientation:Landscape];
    }else if (size.height >= size.width && self.lastOrientation != Portrait){
        [self setUpViewConstraintsForInterfaceOrientation:Portrait];
    }
    
}
@end
