//
//  DotView.swift
//  Effects
//
//  Created by Frédéric ADDA on 24/10/2016.
//  Copyright © 2016 Frédéric Adda. All rights reserved.
//

import UIKit
import QuartzCore

class DotView: UIView {
    @IBInspectable var color = UIColor.lightGray

    private let replicator = CAReplicatorLayer()
    private let dot = CALayer()
    
    private let dotLength: CGFloat = 6.0
    private let dotOffset: CGFloat = 10.0

    // MARK: - Public
    override func draw(_ rect: CGRect) {
        addAnimatedDots(rect: rect)
    }

    // MARK: - Private
    private func addAnimatedDots(rect: CGRect) {
        replicator.frame = rect
        self.layer.addSublayer(replicator)
        
        dot.frame = CGRect(
            x: replicator.frame.origin.x + dotLength,
            y: replicator.position.y,
            width: dotLength,
            height: dotLength
        )
        dot.backgroundColor = color.cgColor
        dot.cornerRadius = 1.5
        
        replicator.addSublayer(dot)
        replicator.instanceCount = Int(rect.size.width / dotOffset)
        replicator.instanceTransform = CATransform3DMakeTranslation(dotOffset, 0.0, 0.0)
        replicator.instanceDelay = 0.08
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.duration = 0.33
        fade.beginTime = CACurrentMediaTime() + 0.33
        fade.repeatCount = .infinity
        fade.autoreverses = true
        fade.timingFunction = CAMediaTimingFunction(name: .easeOut)
        dot.add(fade, forKey: "dotOpacity")
    }
}
