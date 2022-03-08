//
//  SWidgetUtil.swift
//  SSKitProject
//
//  Created by 黄世文 on 2022/3/8.
//

import Foundation
import Lottie


class SWidgetUtil {
    
    static let share = SWidgetUtil()
    
    lazy var style: ToastStyle = {
        var style = ToastStyle()
        style.messageFont = UIFont.PUHUIRegular(size: 14)
        style.messageColor = .white
        style.messageAlignment = .center
        style.cornerRadius = 10
        style.horizontalPadding = 15
        style.verticalPadding = 15
        style.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 0.89)
        return style
    }()
    
    lazy var defaultLoadingView: AnimationView = {
        let lot = AnimationView(name:DEFULTLOGINGPATHNAME)
        lot.contentMode = .scaleAspectFill // 填充模式
        lot.loopMode = .loop // 动画播放次数
        lot.backgroundBehavior = .pauseAndRestore // 后台模式
        return lot
    }()
    
    lazy var loadingBgView: UIView = {
        let bgViw = UIView()
        bgViw.backgroundColor = .clear
        bgViw.addSubview(defaultLoadingView)
        return bgViw
    }()
    
    private init() {
        ToastManager.shared.style = style
    }
    
    func showLoading(view: UIView = AppWindow, top: CGFloat? = nil) {
        
        loadingBgView.frame = view.bounds
        view.addSubview(loadingBgView)
        
        if let top = top {
            defaultLoadingView.snp.remakeConstraints { make in
                make.centerX.equalTo(self.loadingBgView)
                make.top.equalTo(self.loadingBgView).offset(top)
                make.width.height.equalTo(50)
            }
        } else {
            defaultLoadingView.snp.remakeConstraints { make in
                make.centerX.equalTo(self.loadingBgView)
                make.centerY.equalTo(self.loadingBgView).offset(-30)
                make.width.height.equalTo(50)
            }
        }
        
        defaultLoadingView.play()
    }
    
    func hideLoading() {
        loadingBgView.removeFromSuperview()
        defaultLoadingView.stop()
    }
    
    func showTip(str: String, view: UIView = AppWindow, afterDelay: TimeInterval = DefaultTipDuration) {
        view.makeToast(str, duration: afterDelay, position: .center)
    }
     
}
