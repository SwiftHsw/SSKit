//
//  NSAttributedString+Extend.swift
//  SSKit
//
//  Created by 黄世文 on 2022/3/8.
//

import UIKit

extension NSAttributedString {
    
    func sizeFor(font: UIFont, size: CGSize) -> CGSize {
        let tempAttr = NSMutableAttributedString(attributedString: self)
        tempAttr.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, tempAttr.length))
        let rect = tempAttr.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.size
    }
    
}
