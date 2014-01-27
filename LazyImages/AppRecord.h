//
//  AppRecord.h
//  LazyImages
//
//  Created by Igor Tomych on 27/01/14.
//  Copyright (c) 2014 Igor Tomych. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppRecord : NSObject

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) UIImage *appIcon;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *appURLString;

@end
