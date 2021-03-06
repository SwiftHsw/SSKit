//
//  SBaseNavViewController.swift
//  SSKitProject
//
//  Created by 黄世文 on 2022/3/8.
//

import UIKit
import Foundation

/// 导航栏返回按钮颜色
enum NavBackBtnType: String {
    case white = "icon_back_white"
    case black = "icon_back_black"
}

protocol BaseNavigationControllerDelegate: NSObjectProtocol {
    
    /// 返回按钮颜色
    var backBtnType: NavBackBtnType { get }
    
    /// 返回事件
    func popAction()
    
}

class SBaseNavViewController: UINavigationController , UINavigationControllerDelegate, UIGestureRecognizerDelegate{

    weak var baseDelegate: BaseNavigationControllerDelegate?
     
    override func loadView() {
        super.loadView()
        
        // 设置默认导航栏颜色
        if #available(iOS 15.0, *) {
            // UINavigationBarAppearance属性从iOS13开始
            let navBarAppearance = UINavigationBarAppearance()
            // 背景色
            navBarAppearance.backgroundColor = .white
            // 去掉半透明效果
            navBarAppearance.backgroundEffect = nil
            // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
            navBarAppearance.shadowColor = UIColor.clear
            // 字体颜色
            navBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor:UIColor.black
            ]
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            let navbar = UINavigationBar.appearance()
            navbar.barTintColor = .white
            navbar.tintColor = .black
            navbar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor:UIColor.black
            ]
            navbar.shadowImage = UIImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    /// 重写状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return self.topViewController?.preferredStatusBarStyle ?? .default
        }
    }
    
    /// 重写push
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 自定义返回按钮
        configVC(viewController)
        // 在push一个新的VC时，禁用滑动返回手势
        setPopGesture(false)
        
        super.pushViewController(viewController, animated: animated)
    }
    
    /// 重写setViewControllers
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        
        // 自定义返回按钮
        _ = viewControllers.map({ configVC($0) })
        // 在设置新的VC时，禁用滑动返回手势
        setPopGesture(false)
        
        super.setViewControllers(viewControllers, animated: true)
    }
    
    /// 自定义返回按钮
    func configVC(_ viewController: UIViewController) {
        // 判断是否是第一个VC
        var isFirstVC = false
        if let index = self.viewControllers.firstIndex(of: viewController) {
            isFirstVC = index == 0
        } else {
            isFirstVC = self.viewControllers.count == 0
        }
        // 是否隐藏tabbar
        viewController.hidesBottomBarWhenPushed = !isFirstVC
        // 首页不显示返回按钮
        if viewController.navigationItem.leftBarButtonItem == nil && !isFirstVC {
            // 获取返回按钮类型
            var backBtnType: NavBackBtnType = .black
            if let vc = viewController as? BaseNavigationControllerDelegate {
                backBtnType = vc.backBtnType
            }
            // 设置返回按钮图片
            let backImage = UIImage(named: backBtnType.rawValue)?.withRenderingMode(.alwaysOriginal)
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            button.setImage(backImage, for: .normal)
            button.addTarget(self, action: #selector(popAction), for: .touchUpInside)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 0)
            let backBarButtonItem = UIBarButtonItem(customView: button)
            viewController.navigationItem.leftBarButtonItem = backBarButtonItem
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // 判断是否是根视图
        if navigationController.viewControllers.count == 1 {
            // 解决根试图左滑页面卡死
            setPopGesture(false)
        } else {
            // 完全展示出VC时，启用滑动返回手势
            setPopGesture(true)
        }
    }
    
    /// 设置滑动返回手势
    func setPopGesture(_ isEnabled: Bool) {
        self.interactivePopGestureRecognizer?.delegate = isEnabled ? self : nil
        self.interactivePopGestureRecognizer?.isEnabled = isEnabled
    }
    
    @objc func popAction() {
        if let topVC = self.topViewController as? BaseNavigationControllerDelegate {
            topVC.popAction()
        }
    }
    
    deinit {
        SLog("BaseNavigationController deinit")
    }
    

}
