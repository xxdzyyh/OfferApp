//
//  AssociateObjectVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/4/23.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "AssociateObjectVC.h"

@interface AssociateObjectVC ()

@end

@implementation AssociateObjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 因为对象的内存分布已经确定，所以关联对象的值不能存储在自身的实例对象的结构中。负责存储这个信息的AssociationsManager
 AssociationsManager维护了一个AssociationsHashMap。
 
 id objc_getAssociatedObject(id object, const void *key) {
	 return _object_get_associative_reference(object, (void *)key);
 }

 id _object_get_associative_reference(id object, void *key) {
	 id value = nil;
	 uintptr_t policy = OBJC_ASSOCIATION_ASSIGN;
	 {
		 AssociationsManager manager;
		 AssociationsHashMap &associations(manager.associations());
 
		 // DISGUISE是一个将对象指针转变的宏
		 // inline disguised_ptr_t DISGUISE(id value) { return ~uintptr_t(value); }
		 // inline id UNDISGUISE(disguised_ptr_t dptr) { return id(~dptr); }
         
		 disguised_ptr_t disguised_object = DISGUISE(object);
		 AssociationsHashMap::iterator i = associations.find(disguised_object);
		 if (i != associations.end()) {
			 ObjectAssociationMap *refs = i->second;
			 ObjectAssociationMap::iterator j = refs->find(key);
			 if (j != refs->end()) {
				 ObjcAssociation &entry = j->second;
				 value = entry.value();
				 policy = entry.policy();
				 if (policy & OBJC_ASSOCIATION_GETTER_RETAIN) {
					 objc_retain(value);
				 }
			 }
		 }
	 }
	 if (value && (policy & OBJC_ASSOCIATION_GETTER_AUTORELEASE)) {
		 objc_autorelease(value);
	 }
	 return value;
 }

 
 */
@end
