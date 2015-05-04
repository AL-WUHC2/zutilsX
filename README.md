# zutilsX

收集日常开发中积累的工具代码.

---
#####Category (Foundation)

- NSObject+ZUX

  +swizzleOriSelector:withNewSelector: 封装Selector替换方法.

- NSNull+ZUX

  +isNull:
  +isNotNull: 封装判断空对象方法.

- NSNumber+ZUX

  +numberWithCGFloat:
  -initWithCGFloat:
  -cgfloatValue 添加NSNumber与CGFloat兼容方法.

- NSArray+ZUX

  -deepCopy 深拷贝数组.

  -deepMutableCopy 可变深拷贝数组.

  -objectAtIndex:defaultValue: 取数组元素值方法, 可指定默认返回值.

- NSDictionary+ZUX

  -deepCopy 深拷贝字典.

  -deepMutableCopy 可变深拷贝字典.

  -valueForKey:defaultValue: 取字典元素值方法, 可指定默认返回值.

  -subDictionaryForKeys: 根据Key数组取子字典方法, 区别于-dictionaryWithValuesForKeys:方法, 字典中不包含的Key不会放入子字典.

- NSString+ZUX

  -isEmpty
  -isNotEmpty 判断空字符串.

  -isCaseInsensitiveEqual:
  -isCaseInsensitiveEqualToString: 判断字符串相等(忽略大小写).

  -indexOfString:
  -indexCaseInsensitiveOfString:
  -indexOfString:fromIndex:
  -indexCaseInsensitiveOfString:fromIndex: 定位子字符串.

- NSValue+ZUX

  -valueForKey:
  -valueForKeyPath: 增加NSValue对结构类型的KVC处理.

- NSExpression+ZUX

  +keywordsArrayInExpressionFormat NSExpression保留字列表.

  +expressionWithParametricFormat: NSExpression格式化参数构造方法, 替换${keyPath}为%K, 并添加绑定参数keyPath.

#####Category (UIKit)

- UIView+ZUX

  添加属性: maskToBounds, cornerRadius, borderWidth, borderColor, shadowColor, shadowOpacity, shadowOffset, shadowSize.

  添加属性: zTransforms, zLeftMargin, zWidth, zRightMargin, zTopMargin, zHeight, zBottomMargin. // animatable.

  -initWithTransformDictionary:
  构造自适应UIView, 依据superview.bounds自适应frame, transformDictionary中可设置zLeftMargin, zWidth, zRightMargin, zTopMargin, zHeight, zBottomMargin. 适应方式为: margin默认为0, width/height默认为superview的width/height减去同坐标轴上的margin, 根据leftMargin&width&rightMargin计算frame.origin.x&frame.size.width, 根据topMargin&height&bottomMargin计算frame.origin.y&frame.size.height. 当同坐标轴上的三个值都设置时, width&height保持原始设置值, 等量增减双向的margin进行缩放以适应superview.bounds(算式见UIView+ZUX.m - transformOriginAndSize(UIView*, CGFloat, id, id, id, CGFloat*, CGFloat*)).

  transformDictionary中可用于定义变换式的类型有:
    - NSNumber及其子类(转换为CGFloat类型)
    - ZUXTransform及其子类(取出block传入superview计算结果)
    - NSExpression及其子类(expressionValueWithObject:superview, 获得结果的CGFloat值)
    - NSString及其子类([NSExpression expressionWithParametricFormat:transform]获得NSExpression对象, 按NSExpression及其子类进行计算)

#####View

- ZUXView

  扩展UIView.
  
  增加属性backgroundImage.
  
  -zuxInitial
  增加统一初始化接口.

#####Entities

- ZUXTransform

  变换函数类, 用于自适应UIView的变换式定义.
