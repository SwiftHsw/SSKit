//
//  AnyObject+Extansion.swift
//  DeWallet
//
//  Created by 黄世文 on 2022/3/8.
//

import Foundation
import UIKit
import CommonCrypto

extension NSObject {
    
    static var className: String {
        get {
            let name = self.classForCoder().description()
            if (name.contains(".")) {
                return name.components(separatedBy: ".")[1]
            } else {
                return name
            }
        }
    }
    
    var className: String {
        get {
            let name = type(of: self).description()
            if (name.contains(".")) {
                return name.components(separatedBy: ".")[1]
            } else {
                return name
            }
        }
    }
    
}
