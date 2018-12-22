# ALTableKit

A data-driven UITableView framework for building fast and Low coupling, Similar to the IGList CollectionView framework.
数据驱动的UITableView框架，用于构建快速低耦合的tableview，类似IGList CollectionView框架

## Features

### 

* 自动根据cell 和identifier 注册cell，通过context直接重用（再也不怕忘记注册cell闪退）
* 把TableView delegate datasource分发到不同的Section Controller 降低代码耦合
* 通过section controller 可以自动缓存table view cell 高度
* 方便每一个section controller 进行单元测试
* 可以将复杂的Complex Section Controller拆分成多个Section Provider 降低耦合 简化逻辑

* * 如果 cell 1 和 cell 2 根据数据的不同可能存在或不存在。这时候就会有很多逻辑判断cell 4、5、6的位置到底在哪
   现在可以使用section controller将这个section 拆分成多个section provider 
   每一个section provider 单独维护 cell 的位置，如下：

```
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
|      cell 0     |                 |    cell 0     |                           |
 - - - - - - - - -     provier 0     - - - - - - - -                            |
|      cell 1     |                 |    cell 1     |                           |
 - - - - - - - - - - - - - - - - - - - - - - - - - -                            |
|      cell 2     |    provier 1    |    cell 0     |                           |
 - - - - - - - - - - - - - - - - - - - - - - - - - -    section controller 0    |
|      cell 4     |                 |    cell 0     |                           |
 - - - - - - - - -                   - - - - - - - -                            |
|      cell 5     |    provier 2    |    cell 1     |                           |
 - - - - - - - - -                   - - - - - - - -                            |
|      cell 6     |                 |    cell 2     |                           |
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
```

### 

## Installation

### CocoaPods
```
# use_frameworks! is needed for swift projects
use_frameworks!
pod 'ALTableKit', '~>1.1.0'
```

### Carthage
``

## How to use

* [如何使用ALTableKit](https://github.com/wanyawan/ALTableKit/wiki/%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8ALTableKit)

## Requirements

- Xcode 9.0+
- iOS 8.0+

## License

`ALTableKit` is [MIT-licensed](./LICENSE).
