//
//  NSObject+QuickAssociated.h
//  Category
//
//  Created by Silence on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef OBJC_ENUM(unsigned long, SIAssociationPolicy) {
    SIPolicyASSIGN = 0,
    SIPolicyRETAIN_NONATOMIC = 1,
    SIPolicyCOPY_NONATOMIC = 3,
    SIPolicyRETAIN = 01401,
    SIPolicyCOPY = 01403
};

@interface NSObject (SIQuickAssociated)


/** 快速附加一个strong对象 */
- (void)si_quickAssociateValue:(id)value withKey:(void *)key;

/** 快速附加一个weak对象 */
- (void)si_quickWeaklyAssociateValue:(id)value withKey:(void *)key ;

/** 快速附加一个指定管理类型的对象 */
- (void)si_quickAssociateValue:(id)value withKey:(void *)key withType:(SIAssociationPolicy)type ;

/** 根据附加对象的key取出对应的对象 */
- (id)si_quickGetAssociatedValueForKey:(void *)key ;

/** 快速删除关联对象 */
- (void)si_quickRemoveAssociatedValues ;

@end
