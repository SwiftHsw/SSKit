//
//  SMacro.swift
//  SSKitProject
//
//  Created by 黄世文 on 2022/3/8.
//

import Foundation
import UIKit

public let IMAGEBASEURL = ""
public let DEFULTLOGINGPATHNAME = "DefaultLoading"
typealias BlockWithNone = () -> ()
typealias BlockWithParameters<T> = (T) -> ()
 
public let AppWindow = UIApplication.shared.windows.first!
public let ScreenWidth = UIScreen.main.bounds.size.width
public let ScreenHeight = UIScreen.main.bounds.size.height

public let StatusBarHeight: CGFloat = isIphoneX ? 44.0 : 20.0
public let NavigationBarHeight: CGFloat = 44.0
public let StatusBarAndNavigationBarHeight = NavigationBarHeight + StatusBarHeight
public let TabBarSafeBottomMargin: CGFloat = isIphoneX ? 34.0 : 0.0
public let TabBarHeight: CGFloat = 49
public let TabBarAndSafeBottomMargin = TabBarHeight + TabBarSafeBottomMargin


// 自定义Log
public func SLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent;
    print("🔨 [文件名：\(fileName)], [方法：\(funcName)], [行数：\(lineNum)]\n🔨 \(message)");
#endif
}

/// 默认动画时长
public let DefaultAnimationDuration: TimeInterval = 0.25
/// 默认提示语时长
public let DefaultTipDuration: TimeInterval = 1.2

/// 字符串是否为空
public func stringIsEmpty(str: String?) -> Bool {
    return str?.isEmpty ?? true
}

/// 数组是否为空
public func arrayIsEmpty(arr: Array<Any>?) -> Bool {
    return arr?.isEmpty ?? true
}

/// 字典是否为空
public func dicIsEmpty(dic: [AnyHashable : Any]?) -> Bool {
    return dic?.isEmpty ?? true
}

///是否iphoneX
public var isIphoneX: Bool {
    if #available(iOS 11.0, *) {
        return AppWindow.safeAreaInsets.bottom > 0
    }
    return false
}

public var isIphone6: Bool {
    return ScreenWidth == 375.0 && ScreenHeight == 667.0
}

public var isIphone6Plus: Bool {
    return ScreenWidth == 414.0 && ScreenHeight == 736.0
}

/// app当前版本
public let AppCurrentVersion: String = {
    let appVersion = Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as? String ?? "1.0.0"
    return appVersion
}()

/// app名称
public let AppCurrentName: String = {
    let appName = Bundle.main.infoDictionary? ["CFBundleDisplayName"] as? String ?? ""
    return appName
}()

