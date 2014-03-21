//
//  DTViewController.m
//  ReachabilityTest
//
//  Created by Jonathan Nolen on 3/20/14.
//  Copyright (c) 2014 Developer Town. All rights reserved.
//

#import "DTViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface DTViewController ()

@property (strong, nonatomic) AFNetworkReachabilityManager *domainManager;
@property (strong, nonatomic) AFNetworkReachabilityManager *addressManager;

@property (strong, nonatomic) IBOutlet UILabel *sharedManagerLabel;
@property (strong, nonatomic) IBOutlet UILabel *domainManagerLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressManagerLabel;
@end

@implementation DTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak id wself = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        DTViewController *self = wself;
        NSLog(@"%d", status);
//        AFNetworkReachabilityStatusNotReachable     = 0,
//        AFNetworkReachabilityStatusReachableViaWWAN = 1,
//        AFNetworkReachabilityStatusReachableViaWiFi = 2,
        self.sharedManagerLabel.text = (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN ? @"REACHABLE" : @"NOT REACHABLE");
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    self.domainManager = [AFNetworkReachabilityManager managerForDomain:@"developertown.com"];
    [self.domainManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        DTViewController *self = wself;
        NSLog(@"%d", status);
        //        AFNetworkReachabilityStatusNotReachable     = 0,
        //        AFNetworkReachabilityStatusReachableViaWWAN = 1,
        //        AFNetworkReachabilityStatusReachableViaWiFi = 2,
        self.domainManagerLabel.text = (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN ? @"REACHABLE" : @"NOT REACHABLE");
    }];
    [self.domainManager startMonitoring];
    
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    self.addressManager = [AFNetworkReachabilityManager managerForAddress:&zeroAddress];
    [self.addressManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        DTViewController *self = wself;
        NSLog(@"%d", status);
        //        AFNetworkReachabilityStatusNotReachable     = 0,
        //        AFNetworkReachabilityStatusReachableViaWWAN = 1,
        //        AFNetworkReachabilityStatusReachableViaWiFi = 2,
        self.addressManagerLabel.text = (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN ? @"REACHABLE" : @"NOT REACHABLE");
    }];
    [self.addressManager startMonitoring];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
