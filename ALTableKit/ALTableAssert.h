//
//  ALTableAssert.h
//  ALTableKitDemo
//
//  Created by Alex on 2018/12/6.
//  Copyright © 2018 Alex. All rights reserved.
//

#ifndef ALAssert
#define ALAssert( condition, ... ) NSCAssert( (condition) , ##__VA_ARGS__)
#endif // ALAssert

#ifndef ALFailAssert
#define ALFailAssert( ... ) ALAssert( (NO) , ##__VA_ARGS__)
#endif // ALFailAssert

#ifndef ALParameterAssert
#define ALParameterAssert( condition ) ALAssert( (condition) , @"Invalid parameter not satisfying: %@", @#condition)
#endif // ALParameterAssert

#ifndef ALAssertMainThread
#define ALAssertMainThread() ALAssert( ([NSThread isMainThread] == YES), @"Must be on the main thread")
#endif // ALAssertMainThread
