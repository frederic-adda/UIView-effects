//
//  BreathingView.swift
//  Effects
//
//  Created by Frédéric ADDA on 22/10/2016.
//  Copyright © 2016 Frédéric Adda. All rights reserved.
//

import UIKit

class BreathingView: UIView {
    @IBInspectable var duration: TimeInterval = 4.0
    
    // Background colors
    var backgroundColors = [
        UIColor.mediumBlue,
        UIColor.darkBlue,
        UIColor.nightSkyBlue
    ]
    
    private var backgroundLoopIndex = 0
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        animateView()
    }

    // MARK: - Private
    private func animateView() {
        if backgroundLoopIndex < backgroundColors.count - 1 {
            backgroundLoopIndex += 1
        } else {
            backgroundLoopIndex = 0
        }

        // "Breathing" effect
        UIView.animateKeyframes(withDuration: duration, delay: 0.5, options: [], animations: {

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                self.backgroundColor = self.backgroundColors[self.backgroundLoopIndex]
            })

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform.identity
            })

        }, completion: { (completed) in
            // Recursive animation
            self.animateView()
        })
    }
}
