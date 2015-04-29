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

#####Category (UIKit)

- UIView+ZUX

  添加属性: maskToBounds, cornerRadius, borderWidth, borderColor, shadowColor, shadowOpacity, shadowOffset, shadowSize.

  添加属性: zTransforms, zLeftMargin, zWidth, zRightMargin, zTopMargin, zHeight, zBottomMargin. // animatable.

  -initWithTransformDictionary:
  构造自适应UIView, 依据superview.bounds自适应frame, transformDictionary中可设置zLeftMargin, zWidth, zRightMargin, zTopMargin, zHeight, zBottomMargin. 适应方式为: 同一维度上的三个值至少需要设置其二, 根据leftMargin&width&rightMargin计算frame.origin.x&frame.size.width, 根据topMargin&height&bottomMargin计算frame.origin.y&frame.size.height. 当同一维度上三个值都设置时, width&height保持原始设置值, 等量增减左右/上下margin进行缩放以适应superview.bounds(算式见UIView+ZUX.m - transformOriginAndSize(UIView*, CGFloat, id, id, id, CGFloat*, CGFloat*)).

#####View

- ZUXView

  扩展UIView.
  
  增加属性backgroundImage.
  
  -zuxInitial
  增加统一初始化接口.

#####Entities

- ZUXTransform

  变换函数类, 用于自适应UIView的变换式定义.
