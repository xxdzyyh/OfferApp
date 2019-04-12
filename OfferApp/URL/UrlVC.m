//
//  UrlVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/4/12.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "UrlVC.h"

@interface UrlVC ()

@end

@implementation UrlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *string = @"http://www.baidu.com?title=ironman=hehhe&batman=hahaha";
    
    [self testWithURLString:string];
    
    string = @"http://www.baidu.com?title=hehhe&batman";
    
    [self testWithURLString:string];
    
    string = @"xnoapp://xno.cn/SHARE?title=7.8%25%E8%BF%94%E7%8E%B0+6888%E7%8E%B0%E9%87%91=%E5%9B%9B%E6%9C%88%E5%A5%8B%E6%96%97%E5%AD%A3&img=https://m.qpic.cn/psb?/V1251VNC1MPmnt/fQ4luRenh6IbgA9ldKUM4XaED0of9XEKuuWyXc7Kx2Q!/b/dL4AAAAAAAAA&bo=eAB4AAAAAAARBzA!&rf=viewer_4&url=https://www.xiaoniu88.com/neo/weixin/5cafed17e9b21c248558fba4/html/2.html&desc=%E5%A5%8B%E6%96%97%E5%B0%B1%E6%8B%BF%E9%92%B1%EF%BC%81%EF%BC%81%EF%BC%81%EF%BC%81%EF%BC%81";
    
    [self testWithURLString:string];
}

- (void)testWithURLString:(NSString *)string {
    NSLog(@"%@",string);
    NSURL *URL = [NSURL URLWithString:string];
    
    NSDictionary *dict;
    
    dict = [self parameterWithURL:URL];
    
    NSLog(@"%@",dict);
    
    dict = [self parseUrlQueryString:URL.query];
    
    NSLog(@"%@",dict);
    NSLog(@"-----------------------------------");
}


/**
 获取url的所有参数
 @param url 需要提取参数的url
 @return NSDictionary
 */
- (NSDictionary *)parameterWithURL:(NSURL *) url {
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.value != nil) {
            [parm setObject:obj.value forKey:obj.name];
        } else {
            [parm setObject:@"" forKey:obj.name];
        }
        
    }];
    
    return parm;
}

- (nullable NSDictionary *)parseUrlQueryString:(nullable NSString *)queryString {
    if (queryString && queryString.length) {
        NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        for (NSInteger i = 0; i < queryComponents.count; i++) {
            
            NSString *componentString = queryComponents[i];
            NSArray *componentArray = [componentString componentsSeparatedByString:@"="];
            
            if (componentArray && componentArray.count == 2) {
                NSString *key = componentArray[0];
                NSString *value = [componentArray[1] stringByRemovingPercentEncoding];
                dictionary[key] = value;
            }
        }
        
        return dictionary;
    }
    
    return nil;
}

@end
