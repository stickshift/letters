//
//  RootViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "RootViewController.h"
#import "SampleGridFeatureExtractor.h"
#import "LinearGuessClassifier.h"

@interface RootViewController()

@property (nonatomic) NSObject<FeatureExtractor>* featureExtractor;

@property (nonatomic) NSObject<Classifier>* classifier;

@property (weak, nonatomic) TeachingViewController* teachingViewController;

@property (weak, nonatomic) TestingViewController* testingViewController;

@end

@implementation RootViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.featureExtractor = [[SampleGridFeatureExtractor alloc] init];
    self.classifier = [[LinearGuessClassifier alloc] init];
    self.teachingViewController = self.viewControllers[0];
    self.testingViewController = self.viewControllers[1];
    
    self.teachingViewController.featureExtractor = self.featureExtractor;
    self.teachingViewController.classifier = self.classifier;

    self.testingViewController.featureExtractor = self.featureExtractor;
    self.testingViewController.classifier = self.classifier;
}

@end
