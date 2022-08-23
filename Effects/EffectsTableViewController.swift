//
//  EffectsTableViewController.swift
//  Effects
//
//  Created by Frédéric ADDA on 22/10/2016.
//  Copyright © 2016 Frédéric Adda. All rights reserved.
//

import UIKit

class EffectsTableViewController: UITableViewController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "ripple"))
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell {
            segue.destination.title = cell.textLabel?.text
        }
    }
}
