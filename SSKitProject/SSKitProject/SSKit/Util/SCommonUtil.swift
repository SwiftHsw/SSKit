//
//  CommonUtil.swift
//  SSKitProject
//
//  Created by 黄世文 on 2022/3/8.
//

import Foundation
import UIKit 
import CoreLocation

class SCommonUtil{
   

    
    /// 创建Storyboard视图控制器
    static public func createVC(name: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    /// 跳转到广告页
    static public func pushToOpenPage() {
         
    }
    
    /// 手机号
    static public func validate(mobile: String) -> Bool {
        // 第一位为1第二位为3、4、5、7、8
        let regex = "^1[3-9]\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: mobile)
    }
    
    /// 验证账号
    static public func validate(account: String) -> Bool {
        let passWordRegex = "^[a-zA-Z0-9]{0,12}$"
        let passWordPredicate = NSPredicate(format: "SELF MATCHES %@", passWordRegex)
        return passWordPredicate.evaluate(with: account)
    }
    
    /// 验证邮箱
    static public func validate(email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    /// 验证密码
    static public func validate(pwd: String) -> Bool {
        let passWordRegex = "^[a-zA-Z0-9.]{8,20}$"
        let passWordPredicate = NSPredicate(format: "SELF MATCHES %@", passWordRegex)
        return passWordPredicate.evaluate(with: pwd)
    }
    
    /// 验证密码
    static public func validatelength18(pwd: String) -> Bool {
        let passWordRegex = "^[a-zA-Z0-9.]{6,18}$"
        let passWordPredicate = NSPredicate(format: "SELF MATCHES %@", passWordRegex)
        return passWordPredicate.evaluate(with: pwd)
    }
    
    /// 验证IP地址
    static public func validate(ip: String) -> Bool {
        let ipRegex: String = "^(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}$"
        let ipTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", ipRegex)
        return ipTest.evaluate(with: ip)
    }
    
    /// 识别图片二维码
    static public func detectorQrCode(image: UIImage) -> String? {
        
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow]) else {
            return nil
        }
        
        let results = detector.features(in: ciImage)
        
        guard let code = results.first as? CIQRCodeFeature else { return nil }
        
        return code.messageString
    }
    
    /// 验证昵称
    static public func validate(nickName: String) -> Bool {
        let regex = "^[\\u4e00-\\u9fa5a-zA-Z0-9]{2,10}$" // 中文 a-z  A-Z 0-9 _ -
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: nickName)
    }
    
    /// 解析Html
    static public func parsingHtmlString(_ string: String, foregroundColor: UIColor = UIColor.black) -> NSAttributedString? {
        var attstring: NSMutableAttributedString? = nil
        if let data = string.data(using: .utf8) {
            attstring = try? NSMutableAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
            attstring?.addAttribute(NSAttributedString.Key.foregroundColor, value: foregroundColor,range: NSMakeRange(0,attstring?.length ?? 0))
            attstring?.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14),range: NSMakeRange(0,attstring?.length ?? 0))
        }
     
        return attstring
    }
    
    /// 是否需要更新
    static public func isNeedUpdate(localVersion: String, newVersion: String) -> Bool {
        
        guard !stringIsEmpty(str: localVersion) else {
            return false
        }
        
        guard !stringIsEmpty(str: newVersion) else {
            return false
        }
        
        let localArray = localVersion.components(separatedBy: ".")
        let newArray = newVersion.components(separatedBy: ".")
        // 取字段最大的，进行循环比较
        let bigCount = (localArray.count > newArray.count) ? localArray.count : newArray.count;

        for i in (0..<bigCount) {
            // 字段有值，取值；字段无值，置0。
            let localValue = (localArray.count > i) ? NSInteger(localArray[i]) : 0;
            let newValue = (newArray.count > i) ? NSInteger(newArray[i]) : 0;
            // 本地版本字段"小于"最新版本字段，返回"需要"更新
            if (localValue ?? 0 < newValue ?? 0) {
                return true
            }
            // 本地版本字段"大于"最新版本字段，返回"不需要"更新
            else if (localValue ?? 0 > newValue ?? 0) {
                return false
            }
        }
        
        // 版本"相同",返回"不需要"更新
        return false
    }
    
    /// 获取当前VC
    static public func getCurrentVC(base: UIViewController? = AppWindow.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getCurrentVC(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            return getCurrentVC(base: tab.selectedViewController)
        }
        
        if let presented = base?.presentedViewController {
            return getCurrentVC(base: presented)
        }
        
        if let split = base as? UISplitViewController {
            return getCurrentVC(base: split.presentingViewController)
        }
        
        return base
    }
    
    /// 生成二维码图片
    static public func createQrImage(str: String, size: CGSize) -> UIImage? {
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        filter.setDefaults()
        let contentData = str.data(using: String.Encoding.utf8)
        filter.setValue(contentData, forKey: "inputMessage")
        
        // 从滤镜中取出生成的图片
        guard let ciImage = filter.outputImage else { return nil }

        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(ciImage, from: ciImage.extent)

        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)

        // draw image
        let scale = min(size.width / ciImage.extent.width, size.height / ciImage.extent.height)
        bitmapContext!.interpolationQuality = CGInterpolationQuality.none
        bitmapContext?.scaleBy(x: scale, y: scale)
        bitmapContext?.draw(bitmapImage!, in: ciImage.extent)

        // 保存bitmap到图片
        guard let scaledImage = bitmapContext?.makeImage() else { return nil }

        return UIImage(cgImage: scaledImage)
    }
    
    /// json解析
    static public func jsonData(data: Data) -> Any? {
        let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return object
    }
    
    /// 解析json字符串
    static public func jsonStr(obj: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: obj, options: []) else {
            return nil
        }
        let jsonStr = String(data: data, encoding: .utf8)
        return jsonStr
    }
    
    /// json解析
    static public func jsonObject(json: String) -> Any? {
        guard let data = json.data(using: .utf8) else { return nil }
        let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return object
    }
    
    /// 唯一id
    static public func uuidStr() -> String {
        return UUID().uuidString + "\(Int(Date().timeIntervalSince1970))"
    }
    
    /// 解析图片URL字符串的宽高
    static public func pasringOSSImageSize(_ urlStr: String) -> CGSize {
        
        let lastArr = urlStr.components(separatedBy: "?")
        guard let lastStr = lastArr.last else {
            return CGSize.zero
        }
        
        let sizeArr = lastStr.components(separatedBy: "&")
        guard sizeArr.count == 2 else {
            return CGSize.zero
        }
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        for sizeStr in sizeArr {
            let arr = sizeStr.components(separatedBy: "=")
            guard arr.count == 2 else {
                return CGSize.zero
            }
            if arr.first! == "width" {
                width = CGFloat(Double(arr.last!) ?? 0)
            } else if arr.first! == "height" {
                height = CGFloat(Double(arr.last!) ?? 0)
            }
        }
        
        return CGSize(width: width, height: height)
    }
    
    /// 拼接URL参数
    static func splicingUrlStr(params: [String: Any]) -> String {
        var urlStr = ""
        for (key, value) in params {
            let spacter = stringIsEmpty(str: urlStr) ? "" : "&"
            urlStr += spacter + "\(key)=\(value)"
        }
        return urlStr
    }
   
    
    /// 解析URL参数
    static func parsingUrlParams(paramsStr: String) -> [String: String] {
        var paramsDic = [String: String]()
        let paramsArr = paramsStr.components(separatedBy: "&")
        for paramStr in paramsArr {
            let paramArr = paramStr.components(separatedBy: "=")
            if paramArr.count > 1 {
                paramsDic.updateValue(paramArr.last!, forKey: paramArr.first!)
            }
        }
        return paramsDic
    }
    
    /// 跳转到外部web
    static func pushToSafari(urlStr: String, params: [String: Any] = [:]) {
 
        let urlTemp = urlStr + "?" + SCommonUtil.splicingUrlStr(params: params)
        if let url = URL(string: urlTemp) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// 16进制转字符串
    static func hexToStr(hex: String) -> String {
//        let data = Data(hex: hex)
//        return String(data: data, encoding: .utf8) ?? ""
        return ""
    }
    
 
    /// 两个坐标之间的距离
    static func distanceWith(coordinate1: CLLocationCoordinate2D, coordinate2: CLLocationCoordinate2D) -> String {
        
        let loc1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let loc2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        let distance = loc1.distance(from: loc2)
        
        return distance > 1000 ? "\(Int(distance/1000))km" : "\(Int(distance))m"
    }
    
    
}
