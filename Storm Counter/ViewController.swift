//
//  ViewController.swift
//  Storm Counter
//
//  Created by Godohaldo Perez on 6/13/18.
//  Copyright © 2018 Godohaldo Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum Segue: String {
        case toLoaderVC = "ToLoaderVC"
        case toBottomControls = "ToBottomControls"
    }

    @IBOutlet weak var circularLoaderViewContainer: UIView!
    var circularLoaderViewController: CircularLoaderViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueType = Segue(rawValue: identifier) else { return }
        switch segueType {
        case .toLoaderVC:
            let destination = segue.destination as! CircularLoaderViewController
            self.circularLoaderViewController = destination
        case .toBottomControls:
            let destination = segue.destination as! BottomControlsViewController
            destination.delegate = self
        }
    }
}

extension ViewController: BottomControlsViewControllerDelegate {
    func didPressReset() {
        self.circularLoaderViewController?.reset()
    }
}
