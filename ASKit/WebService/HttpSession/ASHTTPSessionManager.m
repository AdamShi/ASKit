//
//  ASHTTPSessionManager.m
//  ASKit
//
//  Created by AdamShi on 2018/7/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASHTTPSessionManager.h"
#import "ASHostManager.h"
#import <CFNetwork/CFHTTPStream.h>
#define TIMEOUT 30

@interface ASHTTPSessionManager ()

@end

@implementation ASHTTPSessionManager
+ (instancetype)shareManagerWithHostModel:(ASHostModel *)model{
    static ASHTTPSessionManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForResource = TIMEOUT;
        if (model) {
            configuration.connectionProxyDictionary = @//打开某个代理
            {
                @"HTTPEnable":@YES,
                (id)kCFStreamPropertyHTTPProxyHost:model.hostIP,
                (id)kCFStreamPropertyHTTPProxyPort:model.hostPort,
                @"HTTPSEnable":@YES,
                (id)kCFStreamPropertyHTTPSProxyHost:model.hostIP,
                (id)kCFStreamPropertyHTTPSProxyPort:model.hostPort
            };
        }else{
            configuration.connectionProxyDictionary = @//关闭代理
            {
                @"HTTPEnable":@NO,
                @"HTTPSEnable":@NO
            };
        }
        shareManager = [[ASHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURL] sessionConfiguration:configuration];
        shareManager.requestSerializer.timeoutInterval = TIMEOUT;
        shareManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData; //不使用缓存数据
        shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/json", @"text/javascript", nil];
        shareManager.responseSerializer.acceptableContentTypes = nil;
//        // SSL证书
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"cer"];
//        NSData *certData  = [NSData dataWithContentsOfFile:cerPath];
//        NSSet *certSet = [NSSet setWithObject:certData];
//        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
//        policy.allowInvalidCertificates = NO;// 是否允许自建证书或无效证书（重要！！！）
//        policy.validatesDomainName = NO;
//        shareManager.securityPolicy = policy;
        
//        @weakify(shareManager);
//        [shareManager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
//            @strongify(shareManager);
//            NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//            __autoreleasing NSURLCredential *credential =nil;
//            if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//                if([shareManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
//                    credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//                    if(credential) {
//                        disposition =NSURLSessionAuthChallengeUseCredential;
//                    } else {
//                        disposition =NSURLSessionAuthChallengePerformDefaultHandling;
//                    }
//                } else {
//                    disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
//                }
//            } else {
//                // client authentication
//                SecIdentityRef identity = NULL;
//                SecTrustRef trust = NULL;
//                NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client"ofType:@"p12"];
//                NSFileManager *fileManager =[NSFileManager defaultManager];
//
//                if(![fileManager fileExistsAtPath:p12])
//                {
//                    NSLog(@"client.p12:not exist");
//                }
//                else
//                {
//                    NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
//
//                    if ([[shareManager class] extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
//                    {
//                        SecCertificateRef certificate = NULL;
//                        SecIdentityCopyCertificate(identity, &certificate);
//                        const void*certs[] = {certificate};
//                        CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
//                        credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
//                        disposition =NSURLSessionAuthChallengeUseCredential;
//                    }
//                }
//            }
//            *_credential = credential;
//            return disposition;
//        }];
        
    });
    return shareManager;
}
+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"你的p12密码"
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
@end
