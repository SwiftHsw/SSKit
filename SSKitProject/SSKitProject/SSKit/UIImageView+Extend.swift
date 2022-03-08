//
//  UIImageView+Extend.swift
//  SSKit
//
//  Created by 黄世文 on 2022/3/8.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /// 通用图片
    func loadImage(urlStr: String, placeholder: String = "placeholder") {
        let url = URL(string: IMAGEBASEURL + urlStr)
        self.kf.setImage(with: url, placeholder: UIImage(named: placeholder))
    }
    
}
