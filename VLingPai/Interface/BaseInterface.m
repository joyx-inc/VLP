//
//  BaseInterface.m
//  ZReader_HD
//
//  接口父类
//
//  Created by  on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseInterface.h"
#import "ASIFormDataRequest.h"
//#import "JSONKit.h"

@interface BaseInterface()

@property (nonatomic,strong) NSMutableDictionary *requestArgs;

@end

@implementation BaseInterface

@synthesize baseDelegate = _baseDelegate , request = _request;
@synthesize interfaceUrl = _interfaceUrl , headers = _headers , bodys = _bodys;



-(void)connect {
    if (self.interfaceUrl) {
        [self.request setTimeOutSeconds:15];

        if (self.headers) {
            for (NSString *key in self.headers) {
                [self.request addRequestHeader:key value:[self.headers objectForKey:key]];
            }
        }
        
        NSString *urlString = nil;
        
        if (self.requestArgs) {
            NSMutableString *prams = [[NSMutableString alloc] init];
            for (NSString *key in self.requestArgs) {
                [prams appendFormat:@"%@=%@&",key,[self.requestArgs objectForKey:key]];
            }
            NSString *removeLastChar = [prams substringWithRange:NSMakeRange(0, [prams length]-1)];
            urlString = [NSString stringWithFormat:@"%@?%@",self.interfaceUrl ,removeLastChar];
        }else{
            urlString = self.interfaceUrl;
        }
        
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        
        if (self.postParams) {
            ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
            for (NSString *key in self.postParams) {
                [formRequest setPostValue:[self.postParams objectForKey:key] forKey:key];
            }
            self.request = formRequest;
        }else{
            self.request = [ASIHTTPRequest requestWithURL:url];
            
            if (self.requestMethod) {
                [self.request setRequestMethod:self.requestMethod];
            }
        }
                
        [self.request setDelegate:self];
        [self.request startAsynchronous]; 
        
    }else{
        //抛出异常
    }
}


#pragma mark - ASIHttpRequestDelegate

-(void)requestFinished:(ASIHTTPRequest *)request {
    if (request.responseStatusCode >= 200 && request.responseStatusCode < 300) {
        if (_baseDelegate && [_baseDelegate respondsToSelector:@selector(parseResult:)]) {
            [_baseDelegate parseResult:request];
        }
    }else{
        [self requestFailed:request];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request {
//    NSLog(@"-------responseStatusMessage:%@",request.responseStatusMessage);
    if (_baseDelegate && [_baseDelegate respondsToSelector:@selector(requestIsFailed:)]) {
        [_baseDelegate requestIsFailed:request.error];
    }
}

-(void)dealloc {
    self.baseDelegate = nil;
    
    [self.request clearDelegatesAndCancel];
    self.request = nil;
    
    self.interfaceUrl = nil;
    self.headers = nil;
    self.bodys = nil;
    self.args = nil;
    self.postParams = nil;
    self.requestMethod = nil;
    self.requestArgs = nil;
    
}


@end
