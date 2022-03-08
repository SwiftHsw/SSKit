//
//  SBaseViewController.swift
//  SSKitProject
//
//  Created by 黄世文 on 2022/3/8.
//

import UIKit

class SBaseViewController: UIViewController,BaseNavigationControllerDelegate {
 
    /// 是否隐藏导航栏
    var isHiddenNavBar = false
    
    /// 是否设置背景透明
    var isBackgroundClear = false
    
    /// 返回按钮的颜色
    var backBtnType: NavBackBtnType {
        return .black
    }
    
    /// 导航栏背景颜色
    var barTintColor: UIColor {
        return .white
    }
    
    /// 导航栏按钮颜色
    var tintColor: UIColor {
        return .black
    }
    
    /// 导航栏标题颜色
    var titleTintColor: UIColor {
        return .black
    }
    
    /// 没有数据视图
    lazy var noDataView: SNoDataView = {
        let noDataView = SNoDataView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 0))
        return noDataView
    }()
    
    // 重写statusBar相关方法
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func loadView() {
        super.loadView()
        
        if let nav = self.navigationController as? SBaseNavViewController {
            nav.baseDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        setNavConfig()
    }
    
    // MARK: - Public
    
    /// 显示空白占位符
    func showNoDataView(superView: UIView = AppWindow, imageName: String = "", title: String = "暂无数据", top: CGFloat = 0) {

        noDataView.setupData(imageName: imageName, title: title)

        if top == 0 {
            noDataView.center = superView.center
        } else {
            noDataView.frame = CGRect(x: 0, y: top, width: noDataView.view_width, height: noDataView.view_height)
        }
        
        if noDataView.superview == nil {
            superView.addSubview(noDataView)
        }
    }
    
    /// 隐藏空白占位符
    func hideNoDataView() {
        noDataView.removeFromSuperview()
    }
    
    // MARK: - Override
    
    func setupViews() {
        
    }
    
    func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    /// 设置导航栏配置
    private func setNavConfig() {
        
        self.navigationController?.setNavigationBarHidden(isHiddenNavBar, animated: true)
        
        if !isHiddenNavBar {
            
            if isBackgroundClear {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            } else {
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            }
            
            // 设置默认颜色
            setBarTintColor(color: barTintColor)
            setTintColor(color: tintColor)
            setTitleTintColor(color: titleTintColor)
        }
    }
    
    /// 从导航控制器移除自己
    private func removeSelf(_ vc: UIViewController) {
        guard var vcs = self.navigationController?.viewControllers else { return }
        if let index = vcs.lastIndex(of: self) {
            vcs.remove(at: index)
        }
        // 添加新视图
        vcs.append(vc)
        self.navigationController?.setViewControllers(vcs, animated: true)
    }
    
    deinit {
        SLog("\(self.className) deinit")
    }
    
}

// MARK: - 导航栏设置
extension SBaseViewController {
    
    /// 设置导航栏按钮颜色
    func setTintColor(color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color
    }
    
    /// 设置导航栏背景颜色
    func setBarTintColor(color: UIColor) {
        if #available(iOS 15.0, *) {
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = color
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = color
        } else {
            let image = UIImage(color: color, size: CGSize(width: ScreenWidth, height: StatusBarAndNavigationBarHeight))
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        }
    }
    
    /// 设置导航栏标题颜色
    func setTitleTintColor(color: UIColor) {
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor : color,
            .font : UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
    }
    
}

// MARK: - 转场方法
extension SBaseViewController {
    
    /// 跳转到指定界面,不返回VC
    func push(name: String, identifier: String, isRemoveSelf: Bool = false) {
        
        // 根据storyboard创建视图
        let vc = SCommonUtil.createVC(name: name, identifier: identifier)
        // 是否需要移除自己
        if isRemoveSelf {
            removeSelf(vc)
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 跳转到指定界面,返回VC
    func push<T>(name: String, identifier: String, isRemoveSelf: Bool = false, vcBlock: BlockWithParameters<T>? = nil) {
        
        // 根据storyboard创建视图
        let vc = SCommonUtil.createVC(name: name, identifier: identifier)
        // vc创建完后回调, 可用于参数传递
        if vc is T {
            vcBlock?(vc as! T)
        }
        // 是否需要移除自己
        if isRemoveSelf {
            removeSelf(vc)
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 弹出界面, 不返回vc
    func present(name: String, identifier: String, style: UIModalPresentationStyle = .fullScreen) {
        let vc = SCommonUtil.createVC(name: name, identifier: identifier)
        vc.modalPresentationStyle = style
        self.present(vc, animated: true, completion: nil)
    }
    
    /// 弹出界面, 返回vc
    func present<T>(name: String, identifier: String, style: UIModalPresentationStyle = .fullScreen, vcBlock: BlockWithParameters<T>? = nil) {
        let vc = SCommonUtil.createVC(name: name, identifier: identifier)
        vc.modalPresentationStyle = style
        // ViewController创建完后回调, 可用于参数传递
        if vc is T {
            vcBlock?(vc as! T)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    /// 返回到指定界面
    func popTo(type: AnyClass, animated: Bool = true) {
        guard let vcs = self.navigationController?.viewControllers else { return }
        for vc in vcs {
            if vc.classForCoder == type {
                self.navigationController?.popToViewController(vc, animated: animated)
                break
            }
        }
    }
    
    /// 返回到根视图
    func popToRootVC(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
}
