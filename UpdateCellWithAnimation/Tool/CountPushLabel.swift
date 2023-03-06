//
//  CountPushLabel.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import UIKit

class CountPushLabel: UILabel {
    var duration: TimeInterval!
    
    func config(num: Int, duration: TimeInterval = 0.1) {
        self.duration = duration
        self.text = "\(num)"
    }
    
    func animate() {
        pushAnimate()
    }
}

extension CountPushLabel: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.layer.removeAllAnimations()
        return
    }
}

private extension CountPushLabel {
    func pushAnimate() {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromBottom
        transition.delegate = self
        self.layer.add(transition, forKey: CATransitionType.push.rawValue)
    }
}
