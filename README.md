# ALTableKit

类似IGListKit TableView版本 增加了一些只属于TableView的功能

```
# use_frameworks! is needed for swift projects
use_frameworks!
pod 'YPNavigationBarTransition', '~> 2.0'
```

## Features
*****
* 自动根据cell 和identifier 注册cell，通过context直接重用
* 把TableView delegate分发到不同的Section Controller
* 自动缓存cell 高度

## Installation
` pod 'ALTableKit', '~>1.0.1'  `
