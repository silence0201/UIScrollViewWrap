//
//  NSObject+QuickAssociated.m
//  Category
//
//  Created by Silence on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+SIQuickAssociated.h"
#import <objc/runtime.h>

@implementation NSObject (SIQuickAssociated)

- (void)si_quickAssociateValue:(id)value withKey:(void *)key withType:(SIAssociationPolicy)type{
    uintptr_t typeValue = type ;
    objc_setAssociatedObject(self, key, value, typeValue) ;
}

- (void)si_quickAssociateValue:(id)value withKey:(void *)key{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN) ;
}

- (void)si_quickWeaklyAssociateValue:(id)value withKey:(void *)key{
    objc_setAssociatedObject(self,key,value,OBJC_ASSOCIATION_ASSIGN) ;
}

- (id)si_quickGetAssociatedValueForKey:(void *)key{
    return objc_getAssociatedObject(self, key) ;
}

- (void)si_quickRemoveAssociatedValues{
    objc_removeAssociatedObjects(self) ;
}

@end
