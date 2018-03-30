//
//  NSDictionary+NilSafe.m
//  NSDictionary-NilSafe
//
//  Created by WangWei on 2017/6/2.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDictionary+NilSafe.h"

@implementation NSObject (Swizzling)

+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
//    class_addMethod(self,
//                    origSel,
//                    class_getMethodImplementation(self, origSel),
//                    method_getTypeEncoding(origMethod));
//    class_addMethod(self,
//                    altSel,
//                    class_getMethodImplementation(self, altSel),
//                    method_getTypeEncoding(altMethod));
    
    
    BOOL didAddMethod = class_addMethod(self,origSel,method_getImplementation(altMethod),method_getTypeEncoding(altMethod));
    
    if(didAddMethod){
    class_replaceMethod(self,
                            altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
        
    }else{
    
    method_exchangeImplementations(origMethod,
                                   altMethod);
        
    }
    return YES;
}

+ (BOOL)gl_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) gl_swizzleMethod:origSel withMethod:altSel];
}

@end

@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gl_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(gl_initWithObjects:forKeys:count:)];
        [self gl_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    
    
    id instance = nil;
    
    @try {
        instance = [self gl_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self gl_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @finally {
        return instance;
    }


   
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id instance = nil;
    
    @try {
        instance = [self gl_initWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self gl_initWithObjects:objects forKeys:keys count:cnt];
    }
    @finally {
        return instance;
    }

}

@end

@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class gl_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(gl_setObject:forKey:)];
        [class gl_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(gl_setObject:forKeyedSubscript:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject == nil) {
        @try {
            [self gl_setObject:anObject forKey:aKey];
        }
        @catch (NSException *exception) {
            MyLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            MyLog(@"%@", [exception callStackSymbols]);
            anObject = [NSString stringWithFormat:@""];
            [self gl_setObject:anObject forKey:aKey];
        }
        @finally {}
    }else {
       [self gl_setObject:anObject forKey:aKey];
    }
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (obj == nil) {
        @try {
            [self gl_setObject:obj forKeyedSubscript:key];
        }
        @catch (NSException *exception) {
            MyLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            MyLog(@"%@", [exception callStackSymbols]);
            obj = [NSString stringWithFormat:@""];
           [self gl_setObject:obj forKeyedSubscript:key];
        }
        @finally {}
    }else {
        [self gl_setObject:obj forKeyedSubscript:key];
    }
}

@end
/*
@implementation NSNull (NilSafe)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gl_swizzleMethod:@selector(methodSignatureForSelector:) withMethod:@selector(gl_methodSignatureForSelector:)];
        [self gl_swizzleMethod:@selector(forwardInvocation:) withMethod:@selector(gl_forwardInvocation:)];
    });
}

- (NSMethodSignature *)gl_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self gl_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)gl_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        // nothing to do
        return;
    }

    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);

    [anInvocation setReturnValue:buffer];
}

@end
*/

@implementation NSArray (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gl_swizzleMethod:@selector(removeObject:)withMethod:@selector(safeRemoveObject:)];
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:)];
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
        [objc_getClass("__NSPlaceholderArray") gl_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(safeInitWithObjects:count:)];
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(safeObjectAtIndexedSubscript:)];
        
    });
}

- (instancetype)safeInitWithObjects:(const id  _Nonnull     __unsafe_unretained *)objects count:(NSUInteger)cnt
{
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
           // DLog(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
           // DLog(@"%s object at index %lu is nil, it will be     filtered", __FUNCTION__, i);
            
            //#if DEBUG
            //      // 如果可以对数组中为nil的元素信息打印出来，增加更容    易读懂的日志信息，这对于我们改bug就好定位多了
            //      NSString *errorMsg = [NSString     stringWithFormat:@"数组元素不能为nil，其index为: %lu", i];
            //      NSAssert(objects[i] != nil, errorMsg);
            //#endif
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self safeInitWithObjects:newObjects count:index];
    }
    return [self safeInitWithObjects:objects count:cnt];
}

- (void)safeAddObject:(id)obj {
    if (obj == nil) {
       // DLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self safeAddObject:obj];
    }
}
- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
      //  DLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self safeRemoveObject:obj];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        //DLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
       // DLog(@"%s index is invalid", __FUNCTION__);
    } else {
        [self safeInsertObject:anObject atIndex:index];
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index {
   
    if (index >= self.count) {
        MyLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self safeObjectAtIndex:index];
}
-(id)safeObjectAtIndexedSubscript:(NSUInteger)index{
    if (index >= self.count) {
        MyLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self safeObjectAtIndexedSubscript:index];
    
}
- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        //DLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
    }
    if (index >= self.count) {
       // DLog(@"%s index out of bound", __FUNCTION__);
        return;
    }
    [self safeRemoveObjectAtIndex:index];
}


@end


