//
//  BottomControlsViewController.swift
//  Storm Counter
//
//  Created by Godohaldo Perez on 6/14/18.
//  Copyright © 2018 Godohaldo Perez. All rights reserved.
//

import UIKit

protocol BottomControlsViewControllerDelegate: class {
    func didPressReset()
}

class BottomControlsViewController: UIViewController {

    @IBOutlet weak var resetButton: UIButton!
    
    weak var delegate: BottomControlsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetButton.layer.cornerRadius = 8.0
    }
    
    @IBAction func didPressReset(_ sender: Any) {
        self.delegate?.didPressReset()
    }
}
