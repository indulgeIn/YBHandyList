# YBHandyList

[![Cocoapods](https://img.shields.io/cocoapods/v/YBHandyList.svg)](https://cocoapods.org/pods/YBHandyList)&nbsp;
[![Cocoapods](https://img.shields.io/cocoapods/p/YBHandyList.svg)](https://github.com/indulgeIn/YBHandyList)&nbsp;
[![License](https://img.shields.io/github/license/indulgeIn/YBHandyList.svg)](https://github.com/indulgeIn/YBHandyList)&nbsp;


让 UITableView / UICollectionView 更加简单优雅，轻易实现列表动态化、模块化、MVVM 架构。

原理分析文章：[iOS 列表界面如何优雅实现模块化与动态化](https://www.jianshu.com/p/f0a74d5744b8)

## 特性

- 列表动态化、列表模块化
- 为实施 MVVM 架构提供支撑
- IOP 思想，接入或弃用都随心所欲，不拖泥带水
- 无技术难点，轻量化设计，可支持全量的原生功能


## 安装

### CocoaPods

1. 在 Podfile 中添加 `pod 'YBHandyList'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 `<YBHandyList/YBHandyList.h>`。

若搜索不到库，可使用 rm ~/Library/Caches/CocoaPods/search_index.json 移除本地索引然后再执行安装，或者更新一下 CocoaPods 版本。

### 手动导入

1. 下载 YBHandyList 文件夹所有内容并且拖入你的工程中。
2. 导入 `YBHandyList.h`。


## 用法

可下载 DEMO 查看示例。

核心思路：UITableView / UICollectionView 的每一个 Cell / Header / Footer 都对应一个 Config 对象，Cell / Header / Footer 和其对应的 Config 对象都需要实现相应的协议。 

### 简洁使用

组件默认实现了一系列 Config 对象（`YBHTableCellConfig / YBHCollectionCellConfig`等），可以直接使用：

```
YBHTableCellConfig *config0 = [YBHTableCellConfig new];
config0.model = ...;
config0.cellClass = TestTableCell.self;

YBHTableCellConfig *config1 = [YBHTableCellConfig new];
config1.model = ...;
config1.cellClass = TestTableCell.self;

//赋值并刷新
[self.tableView.ybht_rowArray addObjectsFromArray:@[config0, config1]];
[self.tableView reloadData];
```
同时，Cell / Header / Footer 中需要实现对应的协议：
```
@implementation TestTableCell
#pragma mark - <YBHTableCellProtocol>
- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    //根据 config 对象拿到数据做业务处理
    ... = config.ybht_model;
}
+ (CGFloat)ybht_heightForCellWithConfig:(nonnull id<YBHTableCellConfig>)config reuseIdentifier:(nonnull NSString *)reuseIdentifier indexPath:(nonnull NSIndexPath *)indexPath {
    //返回当前 cell 的高度
    return UITableViewAutomaticDimension;
}
@end
```
当然，对于 Config 对象你可以自定义，只需要实现了 Config 相关的协议就行了。


### Cell / Header / Footer 事件和数据传递

由于 Cell / Header / Footer 被抽象出来了，外界与它们联系的最好方式是通过 Config 对象 （或其属性）。通过 Config 对象（或其属性）持有一个代理对象 Delegate，然后在 Cell / Header / Footer 里面通过 Delegate 向外界传递事件和数据。

笔者建议的方式是自定义 Config 类，只需要实现对应的协议（或者继承组件默认实现的 Config 类）。

这部分具体的看 Demo。


### 如何实现更多的 UITableView / UICollectionView 代理方法？

组件做的事情不过是对 UITableView / UICollectionView 的代理方法进行了封装（核心类：`YBHandyTableIMP / YBHandyCollectionIMP`），然后对外暴露了数组来配置，所以难免会有一些未实现的代理方法。

你只需要继承 `YBHandyTableIMP / YBHandyCollectionIMP` 类，然后在这个子类里面随心所欲的实现任何代理方法，并且可以覆盖父类的实现。然后，将这个子类赋值给`self.tableView.ybht_tableIMP`属性；你甚至可以直接将 UITableView / UICollectionView 的代理设置为这个`IMP`子类。

`UITableView+YBHandyList`和`UICollectionView+YBHandyList`都是语法糖而已，组件的核心就是一个代理实现类，非常简单。


### 如何在 MVVM 架构上实施？

Demo 中有个简单的案例。

实际上 MVVM 架构中的 ViewModel 完全可以作为前面所说的 Config 对象，只需要 ViewModel 实现 Config 协议就行了，然后每一个 Cell / Header / Footer 对应一个 ViewModel。

**组件对架构是无感知的，IOP 模式让它能在大部分场景无障碍实施。**

