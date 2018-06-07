//
//  ViewController.swift
//  Storm Counter
//
//  Created by Godohaldo Perez on 6/5/18.
//  Copyright © 2018 Godohaldo Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let shapeLayer = CAShapeLayer()
    let numberOfSteps = CGFloat(10)
    var step = CGFloat(0)
    let queue = OperationQueue()
    var lastAnimation: AnimateNextStepOperation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let center = self.view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true )
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @objc private func handleTap() {
        guard step.isLess(than: numberOfSteps) else {return}
        let animation = AnimateNextStepOperation(step: self.step, of: self.numberOfSteps, shapeLayer: self.shapeLayer)
        self.step += 1
        if let lastAnimation = self.lastAnimation {
            animation.addDependency(lastAnimation)
        }
        self.lastAnimation = animation
        self.queue.addOperation(animation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

