//
//  KeywordVC.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/12.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "KeywordVC.h"
#import "Son.h"

#define SuperDesc @"super关键字理解"

@interface KeywordVC ()

@end

@implementation KeywordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSources = @[@{ActionTypeString : @(ActionTypeNone),ActionDescString:SuperDesc,ActionValueString:SuperDesc}];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSDictionary *dict = self.dataSources[indexPath.row];
    
    ActionType type = [dict[ActionTypeString] integerValue];
    NSString *value = dict[ActionValueString];
    
    if (type == ActionTypeNone) {
        if ([value isEqualToString:SuperDesc]) {
            [Son new];
        }  
    }
    
}


- (void)dif {
    /**
        
            struct objc_method {
                SEL method_name
                char *method_types
                IMP method_imp
            }
     
                            
     struct objc_class;
     struct objc_object;

     typedef struct objc_class *Class;
     typedef struct objc_object *id;
     
     
     typedef struct method_t *Method;
     typedef struct ivar_t *Ivar;
     typedef struct category_t *Category;
     typedef struct property_t *objc_property_t;
     
     struct method_t {
         SEL name;
         const char *types;
         MethodListIMP imp;

         struct SortBySELAddress :
             public std::binary_function<const method_t&,
                                         const method_t&, bool>
         {
             bool operator() (const method_t& lhs,
                              const method_t& rhs)
             { return lhs.name < rhs.name; }
         };
     };
     */
    
}

@end
