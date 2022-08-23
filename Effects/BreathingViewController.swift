//
//  BreathingViewController.swift
//  Effects
//
//  Created by Frédéric ADDA on 22/10/2016.
//  Copyright © 2016 Frédéric Adda. All rights reserved.
//

import UIKit

class BreathingViewController: UIViewController {
    @IBOutlet weak var breathingView: BreathingView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        breathingView.layer.cornerRadius = breathingView.bounds.height/2
        breathingView.layer.masksToBounds = true
    }
}

