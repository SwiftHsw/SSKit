//
//  CustomRefreshHeader.swift
//  1xpocket
//
//  Created by 吴垠锋 on 2022/1/12.
//

import Foundation
import UIKit
import MJRefresh
import Lottie
import SnapKit

class SCustomRefreshHeader: MJRefreshHeader {
    
    lazy var defaultLoadingView: AnimationView = {
        let lot = AnimationView(name: "RefreshLoading")
        lot.contentMode = .scaleAspectFill // 填充模式
        lot.loopMode = .loop // 动画播放次数
        lot.backgroundBehavior = .pauseAndRestore // 后台模式
        return lot
    }()
    
    override func prepare() {
        super.prepare()
        
        self.addSubview(defaultLoadingView)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        defaultLoadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.width.height.equalTo(50)
        }
    }
    
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                defaultLoadingView.stop()
            case .pulling:
                break
            case .refreshing:
                defaultLoadingView.play()
            case .willRefresh:
                break
            default:
                break
            }
        }
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]?) {
        super.scrollViewContentOffsetDidChange(change)
        
        guard let offsetY = self.scrollView?.mj_offsetY,
              offsetY < 0,
              state != .refreshing else {
            return
        }
        
        let y = offsetY + 30
        guard y < 0 else {
            return
        }
        
        var progress: CGFloat = 0
        if -y < MJRefreshHeaderHeight {
            progress = -y / MJRefreshHeaderHeight
        } else {
            progress = 1
        }
        
        defaultLoadingView.currentProgress = progress
    }
    
}
