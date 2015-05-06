# zutilsX

收集日常开发中积累的工具代码.

#####Constant

* 判断当前设备类型.

        IS_IPHONEX

* 根据设备类型获取视口变化比例.

        DeviceScale

* 判断当前系统版本.

        IOSX_OR_LATER

* IOS7及其后, 状态栏透明, 顶级视图需在顶部增加20个Point高度的空白.

        statusBarHeight

* IOS7之前, 状态栏不透明, 全屏视图需上移20个Point, 隐藏在状态栏后.

        statusBarFix

* 当前应用的BundleID和Version字符串.

        appIdentifier
        appVersion

#####Category (Foundation)

* NSObject+ZUX

		// 封装Selector替换方法.
        +swizzleOriSelector:withNewSelector:

* NSNull+ZUX

		//封装判断空对象方法.
	    +isNull:
	    +isNotNull:

* NSNumber+ZUX

		// 添加NSNumber与CGFloat兼容方法.
	    +numberWithCGFloat:
	    -initWithCGFloat:
	    -cgfloatValue

* NSArray+ZUX

		// 深拷贝数组.
	    -deepCopy

		// 可变深拷贝数组.
	    -deepMutableCopy

		// 取数组元素值方法, 可指定默认返回值.
	    -objectAtIndex:defaultValue:

* NSDictionary+ZUX

		// 深拷贝字典.
	    -deepCopy

		// 可变深拷贝字典.
	    -deepMutableCopy

		// 取字典元素值方法, 可指定默认返回值.
	    -valueForKey:defaultValue:

		// 根据Key数组取子字典方法. (区别于-dictionaryWithValuesForKeys:方法, 字典中不包含的Key不会放入子字典.)
	    -subDictionaryForKeys:

- NSData+ZUX

		// Base64转码方法.
		-base64EncodedString
		+dataWithBase64String: 

- NSString+ZUX

		// 判断空字符串.
		-isEmpty
		-isNotEmpty

		// 裁剪空白字符串.
		-trim
		-trimToNil

		//  判断字符串相等(忽略大小写).
		-isCaseInsensitiveEqual:
		-isCaseInsensitiveEqualToString:

		//  版本号字符串比较方法.
		-compareToVersionString:

		// 定位子字符串.
		-indexOfString:
		-indexCaseInsensitiveOfString:
		-indexOfString:fromIndex:
		-indexCaseInsensitiveOfString:fromIndex:

		// 类构造方法, 根据NSArray构造字符串.
		+stringWithArray:
		+stringWithArray:separator:

		// 追加对象到字符串末尾.
		-appendWithObjects:

		// URL字符串转义方法.
		-stringByEscapingForURLQuery
		-stringByUnescapingFromURLQuery

		// 计算MD5.
		-MD5Sum

		// 计算SHA1.
		-SHA1Sum

		// Base64转码方法.
		-base64EncodedString
		+stringWithBase64String:

		// Unicode/UTF8互转方法.
		+replaceUnicodeToUTF8:
		+replaceUTF8ToUnicode:

		// 参数化字符串方法, 替换字符串中的"${key}"为[object valueForKey:@"key"].
		-parametricStringWithObject:

- NSValue+ZUX

		// 增加NSValue对结构类型的KVC处理.
		-valueForKey:
		-valueForKeyPath:

- NSExpression+ZUX

		// NSExpression保留字列表.
		+keywordsArrayInExpressionFormat

		// NSExpression格式化参数构造方法, 替换${keyPath}为%K, 并添加绑定参数keyPath.
		+expressionWithParametricFormat:

#####Category (UIKit)

- UIView+ZUX

		// 添加属性: (Layer)
		maskToBounds
		cornerRadius
		borderWidth
		borderColor
		shadowColor
		shadowOpacity
		shadowOffset
		shadowSize.

		// 添加属性: (Layout, animatable)
		zTransforms
		zLeftMargin
		zWidth
		zRightMargin
		zTopMargin
		zHeight
		zBottomMargin

		// 构造自适应UIView
		// 依据superview.bounds自适应frame
		// transformDictionary中可设置:
		//   1. zLeftMargin
		//   2. zWidth
		//   3. zRightMargin
		//   4. zTopMargin
		//   5. zHeight
		//   6. zBottomMargin
		// 适应方式为:
		//   1. margin默认为0
		//   2. width/height默认为superview的width/height减去同坐标轴上的margin
		//   3. 根据leftMargin&width&rightMargin计算frame.origin.x & frame.size.width
		//   4. 根据topMargin&height&bottomMargin计算frame.origin.y & frame.size.height
		//   5. 当同坐标轴上的三个值都设置时, width&height保持原始设置值, 等量增减双向的margin进行缩放以适应superview.bounds
		// 算式见UIView+ZUX.m - transformOriginAndSize(UIView*, CGFloat, id, id, id, CGFloat*, CGFloat*)
		-initWithTransformDictionary:

		PS: transformDictionary中可用于定义变换式的类型有:
		- NSNumber及其子类(转换为CGFloat类型)
	    - ZUXTransform及其子类(取出block传入superview计算结果)
	    - NSExpression及其子类(expressionValueWithObject:superview, 获得结果的CGFloat值)
	    - NSString及其子类([NSExpression expressionWithParametricFormat:transform]获得NSExpression对象, 按NSExpression及其子类进行计算)

- UILabel+ZUX

		// 计算Label合适的尺寸.
		-sizeThatConstraintToSize:

- UIImage+ZUX

		// 生成矩形图像并指定颜色.
		-imageRectWithColor:size:

		// 生成椭圆形图像并指定颜色.
		-imageEllipseWithColor:size:

		// 获取对应当前设备尺寸的图片.
		// 依据不同尺寸图片命名后缀规则:
		//   - 6P: -800-Portrait-736h
		//   - 6: -800-667h
		//   - 5: -700-568h
		//   - 其他: @2x或无后缀
		-imageForCurrentDeviceNamed:

- UIColor+ZUX

		// 根据255格式颜色生成UIColor.
		+colorWithIntegerRed:green:blue:
		+colorWithIntegerRed:green:blue:alpha:

		// 根据十六进制字符串格式颜色生成UIColor.
		+colorWithRGBHexString:
		+colorWithRGBAHexString:

#####View

- ZUXView

  扩展UIView.

		// 添加属性
		backgroundImage

		// 统一初始化接口.
		-zuxInitial

- ZUXControl

  扩展UIControl.

		// 添加属性
		backgroundImage

		// 统一初始化接口.
		-zuxInitial

- ZUXLabel

  扩展UILabel.

		// 统一默认设置
		self.backgroundColor = [UIColor clearColor];

		// 添加属性
		backgroundImage
		linesSpacing // 文本行距

- ZUXImageView

  扩展UIImageView, 可复制/保存图片.

		// 添加长按手势弹出菜单.

		// 添加属性
		canCopy // 是否长按弹出复制菜单
		canSave // 是否长按弹出保存菜单

- ZUXVerticalGridView & ZUXVerticalGridViewCell

  定宽网格视图.

  需指定列数和行数(初始), 由数据源提供单元格视图实例数与单元格占宽, 托管响应单元格点击事件.

- ZUXRefreshView

  滚动刷新工具视图.

		// 属性
		direction // 滚动刷新方向
		defaultPadding // 初始边界距离
		pullingMargin // 刷新边界距离
		loadingMargin // 刷新中边界距离

		// 可重写方法
		-didScrollView:
		-didEndDragging:
		-didFinishedLoading:
		-setRefreshState:

		// 托管方法
		-refreshViewIsLoading: // 返回当前刷新状态
		-refreshViewStartLoad: // 开始刷新回调

- ZUXPageControl

  分页指示器.

		// 添加属性
		pageIndicatorColor // 默认指示色
		currentPageIndicatorColor // 当前页指示色

#####MBProgressHUD

- MBProgressHUD

  Created by Matej Bukovinski, Version 0.9.

- UIView+MBProgressHUD

  扩展MBProgressHUD, 增加UIView类别方法, 用于显隐MBProgressHUD视图.

		// 在当前视图内显隐HUD的简易方法:
		-mbProgressHUD
		-showIndeterminateHUDWithText:
		-showTextHUDWithText:hideAfterDelay:
		-showTextHUDWithText:detailText:hideAfterDelay:
		-hideHUD:

		// 在当前视图及其子视图内显隐HUD的简易方法:
		-recursiveMBProgressHUD
		-showIndeterminateRecursiveHUDWithText:
		-showTextRecursiveHUDWithText:hideAfterDelay:
		-showTextRecursiveHUDWithText:detailText:hideAfterDelay:
		-hideRecursiveHUD:

#####Entities

- ZUXTransform

  变换函数类, 用于自适应UIView的变换式定义.
