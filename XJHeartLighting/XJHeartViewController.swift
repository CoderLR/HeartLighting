//
//  XJHeartViewController.swift
//  XJSwiftKit
//
//  Created by xj on 2021/11/8.
//

import UIKit

/// 循环次数
var loopIndex: Int = 0
/// 循环时间
var timeInterval: TimeInterval = 0.2
// 熄灭颜色
let extinctColor = UIColor.black
// 点亮颜色
let lightingColor = UIColor.red

// MARK: - 点亮模式
enum XJHeartMode {
    
    // 点亮一圈
    case one_clockwise_all    // 顺时针一圈连续
    case one_anticlockwise_all // 逆时针一圈连续
    case one_clockwise_one      // 顺时针一圈一个接一个
    case one_anticlockwise_one  // 逆时针一圈一个接一个
    
    // 点亮半圈
    case half_clockwise_all
    case half_anticlockwise_all
    case half_clockwise_one
    case half_anticlockwise_one
    
    // 点亮1234象限
    case quarter1234_clockwise_all
    case quarter1234_anticlockwise_all
    case quarter1234_clockwise_aone
    case quarter1234_anticlockwise_one
    
    // 点亮13象限
    case quarter13_clockwise_all
    case quarter13_anticlockwise_all
    case quarter13_clockwise_aone
    case quarter13_anticlockwise_one
    
    // 点亮24象限
    case quarter24_clockwise_all
    case quarter24_anticlockwise_all
    case quarter24_clockwise_aone
    case quarter24_anticlockwise_one
    
    // 点亮14象限
    case quarter14_clockwise_all
    case quarter14_anticlockwise_all
    case quarter14_clockwise_aone
    case quarter14_anticlockwise_one
    
    // 点亮23象限
    case quarter23_clockwise_all
    case quarter23_anticlockwise_all
    case quarter23_clockwise_aone
    case quarter23_anticlockwise_one
    
    case allin_allout
    case left_right
    case top_bottom
    case leftup_rightbottom
    case rightup_leftbottom
    case odd_even
}

// MARK: - 控制器
class XJHeartViewController: UIViewController {
    
    lazy var heartView: XJHeartView = {
        let heart = XJHeartView(frame: self.view.bounds)
        return heart
    }()
    
    /// 定时器
    var timer: Timer?
    var switchTimer: Timer?
    
    /// 点亮模式
    var heartMode: XJHeartMode = .one_clockwise_all
    
    /// one by one
    var tempView: UIView?
    var tempLeftView: UIView?
    var tempRightView: UIView?
    var tempLeftUpView: UIView?
    var tempLeftDownView: UIView?
    var tempRightUpView: UIView?
    var tempRightDownView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loopIndex = 0
        self.title = "流水灯"
        
        self.view.addSubview(heartView)
        
        self.createTimer(timeInterval, isFire: false)
    }
    
    /// 创建定时器
    func createTimer(_ timeInterval: TimeInterval, isFire: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {[weak self] (timer) in
            guard let self = self else { return }
            
            self.executionTimer()
        }
        if !isFire {
            timer?.fireDate = .distantFuture
        }
        
    }
    
    /// 销毁定时器
    func invalidateTimer() {
        guard let timer = timer else { return }
        timer.invalidate()
    }
    
    /// 创建定时器--用于切换
    func createSwitchTimer(_ timeInterval: TimeInterval) {
        switchTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {[weak self] (timer) in
            guard let self = self else { return }
            
            self.executionTimer()
        }
    }
    
    /// 销毁定时器--用于切换
    func invalidateSwitchTimer() {
        guard let switchTimer = switchTimer else { return }
        switchTimer.invalidate()
    }
    
    /// 触发定时器
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer?.fireDate = .distantPast
    }
    
    /// 点击返回
    func backBtnClick(_ button: UIButton) {
        self.invalidateTimer()
        self.invalidateSwitchTimer()
    }
    
    /// 设置模式
    func setNextMode(_ heartMode: XJHeartMode) {
    
        // 清空标识
        loopIndex = 0
        
        // 设置新模式
        self.heartMode = heartMode
        
        // 销毁切换定时器
        self.invalidateSwitchTimer()
        
        // 销毁旧定时器
        self.invalidateTimer()
        
        // 创新新定时器
        if heartMode == .allin_allout || heartMode == .left_right || heartMode == .top_bottom || heartMode == .leftup_rightbottom || heartMode == .rightup_leftbottom || heartMode == .odd_even {
            
            self.createSwitchTimer(1.0)
        } else {
            self.createTimer(timeInterval, isFire: true)
        }
    }
    
    /// 执行定时器
    func executionTimer() {
        
        self.personalizedDesignLighting()
    }

}

// MARK: - 个性化设计点亮方式
extension XJHeartViewController {
    /*
     1.顺时针一圈-加速
     2.顺时针半圈-加速
     3.逆时针半圈
     4.1234象限顺时针点亮
     5.1234象限逆时针点亮
     6.点亮与熄灭执行3次
     7.顺时针一圈-一个-加速
     8.逆时针半圈-一个
     9.左右切换3次
     10.奇偶切换5次
     11.上下切换3次
     12.13象限顺时针点亮
     13.右上左下切换3次
     14.24象限顺时针点亮
     15.左上右下切换3次
     ----------->循环
     */
    
    /// 设计点亮个性化特效
    func personalizedDesignLighting() {
        // 1.顺时针一圈-加速
        if heartMode == .one_clockwise_all {
            if turnOnOneCircle(true, isClockwise: true) {
                self.setNextMode(.half_clockwise_all)
//                self.setNextMode(.left_right)
            }
        // 2.顺时针半圈-加速
        } else if heartMode == .half_clockwise_all {
            if turnOnHalfCircle(true, isClockwise: true) {
                self.setNextMode(.half_anticlockwise_all)
            }
        // 3.逆时针半圈
        } else if heartMode == .half_anticlockwise_all {
            if turnOnHalfCircle(false, isClockwise: false) {
                self.setNextMode(.quarter1234_clockwise_all)
            }
        // 4.1234象限顺时针点亮
        } else if heartMode == .quarter1234_clockwise_all {
            if turnOnQuarter_1234_Circle(false, isClockwise: true) {
                self.setNextMode(.quarter1234_anticlockwise_all)
            }
        // 5.1234象限逆时针点亮
        } else if heartMode == .quarter1234_anticlockwise_all {
            if turnOnQuarter_1234_Circle(false, isClockwise: false) {
                self.setNextMode(.allin_allout)
            }
        // 6.点亮与熄灭执行3次
        } else if heartMode == .allin_allout {
            if switchLightingAndExtinct(number: 3) {
                self.setNextMode(.one_clockwise_one)
            }
        // 7.顺时针一圈-一个-加速
        } else if heartMode == .one_clockwise_one {
            if turnOnOneCircleOneByOne(true, isClockwise: true) {
                self.setNextMode(.half_anticlockwise_one)
            }
        // 8.逆时针半圈-一个
        } else if heartMode == .half_anticlockwise_one {
            if turnOnHalfCircleOneByOne(false, isClockwise: false) {
                self.setNextMode(.left_right)
            }
        // 9.左右切换3次
        } else if heartMode == .left_right {
            if switchLeftAndRight(number: 3) {
                self.setNextMode(.odd_even)
            }
        // 10.奇偶切换5次
        } else if heartMode == .odd_even {
            if switchOddAndEven(number: 5) {
                self.setNextMode(.top_bottom)
            }
        // 11.上下切换3次
        } else if heartMode == .top_bottom {
            if switch14And23(number: 3) {
                self.setNextMode(.quarter13_clockwise_all)
            }
        // 12.13象限顺时针点亮
        } else if heartMode == .quarter13_clockwise_all {
            if turnOnQuarter_13_Circle(false, isClockwise: true) {
                self.setNextMode(.rightup_leftbottom)
            }
        // 13.右上左下切换3次
        } else if heartMode == .rightup_leftbottom {
            if switch13And24(number: 3) {
                self.setNextMode(.quarter24_clockwise_all)
            }
        // 14.24象限顺时针点亮
        } else if heartMode == .quarter24_clockwise_all {
            if turnOnQuarter_24_Circle(false, isClockwise: true) {
                self.setNextMode(.leftup_rightbottom)
            }
        // 15.左上右下切换3次
        } else if heartMode == .leftup_rightbottom {
            if switch13And24(number: 3) {
                // 循环第一步
                self.setNextMode(.one_clockwise_all)
            }
        }
    }
}

