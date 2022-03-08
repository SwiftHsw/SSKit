//
//  ViewController.swift
//  SSKitProject
//
//  Created by 黄世文 on 2022/3/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        SLocationUtil.share.permissionChangeBlock = {
            
        }
        
        SLocationUtil.share.locationBlock = { (tuple) in
            SLog("\(tuple.0)"+"\(tuple.1)")
        }
        
        SWidgetUtil.share.showTip(str: "哈哈哈哈哈哈哈", view: self.view, afterDelay: 3)
        SWidgetUtil.share.showLoading(view: self.view)
    }


}

