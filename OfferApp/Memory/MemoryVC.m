//
//  MemoryVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/15.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "MemoryVC.h"
#import "MemoryObj.h"

@interface MemoryVC () {
	MemoryObj *obj1;
}

@end

@implementation MemoryVC

__weak id objTrack;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MemoryObj *obj = [MemoryObj memoryObj];

	NSString *t1 = @"string";
	NSString *t2 = @"string";
	
	NSString *t3 = [NSString stringWithFormat:@"string"];
	NSString *t4 = [NSString stringWithString:@"string"];
	NSString *t5 = [[NSString alloc] initWithString:@"string"];
	
	NSLog(@"%p %p %p %p",t1,t2,t3,t4);
	NSLog(@"%p %p %p %p",&t1,&t2,&t3,&t4);
	
	NSLog(@"t1==t2 is %d",t1==t2);
	NSLog(@"t2==t3 is %d",t2==t3);
	NSLog(@"t3==t4 is %d",t3==t4);
	
//	obj1 = [MemoryObj new];
//
//	printf("obj1:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(obj1)));
//
//	id obj2 = obj1;
//	printf("obj1:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(obj1)));
//
//	id obj3 = obj2;
//
//	printf("obj1:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(obj1)));
//	printf("obj2:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(obj2)));
//	printf("obj3:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(obj3)));
//
//	id obj4 = [obj1 copy];
//
//	printf("obj4:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(obj4)));
}

/**
 weak底层实现
 
 */

///**
// * The global weak references table. Stores object ids as keys,
// * and weak_entry_t structs as their values.
// */
//struct weak_table_t {
//	weak_entry_t *weak_entries;
//	size_t    num_entries;
//	uintptr_t mask;
//	uintptr_t max_hash_displacement;
//};

/*
The weak table is a hash table governed by a single spin lock.
An allocated blob of memory, most often an object, but under GC any such
allocation, may have its address stored in a __weak marked storage location
through use of compiler generated write-barriers or hand coded uses of the
register weak primitive. Associated with the registration can be a callback
block for the case when one of the allocated chunks of memory is reclaimed.
The table is hashed on the address of the allocated memory.  When __weak
marked memory changes its reference, we count on the fact that we can still
see its previous reference.

So, in the hash table, indexed by the weakly referenced item, is a list of
all locations where this address is currently being stored.
 
For ARC, we also keep track of whether an arbitrary object is being
deallocated by briefly placing it in the table just prior to invoking
dealloc, and removing it via objc_clear_deallocating just prior to memory
reclamation.

*/

//// The address of a __weak variable.
//// These pointers are stored disguised so memory analysis tools
//// don't see lots of interior pointers from the weak table into objects.
//typedef DisguisedPtr<objc_object *> weak_referrer_t;


/**
* The internal structure stored in the weak references table.
* It maintains and stores
* a hash set of weak references pointing to an object.
* If out_of_line_ness != REFERRERS_OUT_OF_LINE then the set
* i
 s instead a small inline array.
*/


//struct weak_entry_t {
//    DisguisedPtr<objc_object> referent;
//    union {
//        struct {
//            weak_referrer_t *referrers;
//            uintptr_t        out_of_line_ness : 2;
//            uintptr_t        num_refs : PTR_MINUS_2;
//            uintptr_t        mask;
//            uintptr_t        max_hash_displacement;
//        };
//        struct {
//            // out_of_line_ness field is low bits of inline_referrers[1]
//            weak_referrer_t  inline_referrers[WEAK_INLINE_COUNT];
//        };
//    };
//
//    bool out_of_line() {
//        return (out_of_line_ness == REFERRERS_OUT_OF_LINE);
//    }
//
//    weak_entry_t& operator=(const weak_entry_t& other) {
//        memcpy(this, &other, sizeof(other));
//        return *this;
//    }
//
//    weak_entry_t(objc_object *newReferent, objc_object **newReferrer)
//        : referent(newReferent)
//    {
//        inline_referrers[0] = newReferrer;
//        for (int i = 1; i < WEAK_INLINE_COUNT; i++) {
//            inline_referrers[i] = nil;
//        }
//    }
//};

// StripedMap<SideTable> {


//}

@end
