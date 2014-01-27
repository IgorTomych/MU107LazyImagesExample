//
//  ViewController.m
//  LazyImages
//
//  Created by Igor Tomych on 27/01/14.
//  Copyright (c) 2014 Igor Tomych. All rights reserved.
//

#import "ViewController.h"
#import "AppRecord.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface ViewController ()


@property (nonatomic, strong) NSMutableArray* applications;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray* rawApps = responseObject[@"feed"][@"entry"];
        
        self.applications = [[NSMutableArray alloc] init];
        
        for (NSDictionary* attributes in rawApps) {
            AppRecord* applicationRecord = [[AppRecord alloc] init];
            applicationRecord.appName = attributes[@"title"][@"label"];
            applicationRecord.imageURLString = attributes[@"im:image"][0][@"label"];
            
            [self.applications addObject:applicationRecord];
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.applications.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    AppRecord* applicationRecord = (AppRecord *)self.applications[indexPath.row];
    
    cell.textLabel.text = applicationRecord.appName;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:applicationRecord.imageURLString]];
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"Placeholder"] success:nil failure:nil];
    
    return cell;
}

@end
