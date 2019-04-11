//
//  ASHostModel.h
//  ASKit
//
//  Created by AdamShi on 2018/7/26.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <Foundation/Foundation.h>

//格式:hostIP/hostPort/subURL, 如https://192.168.1.2:8080/mobilServer
@interface ASHostModel : NSObject
@property (nonatomic, strong)NSString *hostName;
@property (nonatomic, strong)NSString *hostIP;
@property (nonatomic, strong)NSString *hostPort;
@property (nonatomic, strong)NSString *hostSubURL;
@property (nonatomic, strong)NSString *hostDNS;
@property (nonatomic, strong)NSString *hostImgBaseURL;
@end
