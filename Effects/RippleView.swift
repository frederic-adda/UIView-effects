//
//  RippleView.swift
//  Effects
//
//  Created by Frédéric ADDA on 22/10/2016.
//  Copyright © 2016 Frédéric Adda. All rights reserved.
//

import UIKit

class RippleView: UIView {
    @IBInspectable var animationDuration: TimeInterval = 2.0
    @IBInspectable var animationColor = UIColor.darkBlue
    
    private var backgroundLoopIndex = 0

    // MARK: - Public
    override func draw(_ rect: CGRect) {
        addAnimatedDisc(rect: rect)
        
        if let sublayers = layer.sublayers,
            sublayers.count < 2 { // limit to 2 discs at the same time
            
            delay(seconds: animationDuration/2) {
                self.addAnimatedDisc(rect: rect)
            }
        }
    }

    // MARK: - Private
    private func addAnimatedDisc(rect: CGRect) {
        let width = rect.width
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let disc = CAShapeLayer()
        disc.frame = rect
        let path = UIBezierPath(arcCenter: center, radius: width/4, startAngle: 0, endAngle: CGFloat(Double.pi)*2, clockwise: true)
        disc.path = path.cgPath
        disc.fillColor = animationColor.cgColor
        disc.opacity = 0.0 // Start hidden
        layer.addSublayer(disc)
        
        // Animations
        let scaleUpAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleUpAnimation.fromValue = 0.5
        scaleUpAnimation.toValue = 2
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0

        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1

        // Animations
        scaleUpAnimation.beginTime = CACurrentMediaTime()
        scaleUpAnimation.duration = animationDuration
        scaleUpAnimation.fillMode = CAMediaTimingFillMode.forwards
        disc.add(scaleUpAnimation, forKey: nil)
        
        fadeInAnimation.beginTime = CACurrentMediaTime()
        fadeInAnimation.duration = animationDuration/2
        fadeInAnimation.fillMode = .forwards
        disc.add(fadeInAnimation, forKey: nil)
        
        fadeOutAnimation.beginTime = CACurrentMediaTime() + animationDuration/2
        fadeOutAnimation.duration = animationDuration/2
        fadeOutAnimation.fillMode = .forwards
        
        // Set delegate to be informed when the animation ends
        fadeOutAnimation.setValue(disc, forKey: "layer")
        fadeOutAnimation.delegate = self

        disc.add(fadeOutAnimation, forKey: nil)
    }
}

// MARK: - CAAnimationDelegate
extension RippleView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {}
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let disc = anim.value(forKey: "layer") as? CAShapeLayer else {
            return
        }
        
        // Start again animation
        disc.removeFromSuperlayer()
        setNeedsDisplay()
    }
}
