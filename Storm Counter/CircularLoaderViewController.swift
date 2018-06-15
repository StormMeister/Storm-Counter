//
//  ViewController.swift
//  Storm Counter
//
//  Created by Godohaldo Perez on 6/5/18.
//  Copyright © 2018 Godohaldo Perez. All rights reserved.
//

import UIKit

class CircularLoaderViewController: UIViewController {
    @IBOutlet weak var centerLabel: UILabel!
    
    let shapeLayer = CAShapeLayer()
    let numberOfSteps = CGFloat(20)
    var step = CGFloat(0)
    let queue = OperationQueue()
    var lastAnimation: AnimateNextStepOperation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lineWidth = CGFloat(10)
        let radius = min(self.view.frame.width, self.view.frame.height) / 2 - lineWidth
        let center = self.view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true )
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = lineWidth
        self.view.layer.addSublayer(trackLayer)
        
        self.shapeLayer.path = circularPath.cgPath
        self.shapeLayer.strokeColor = UIColor.red.cgColor
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.lineWidth = lineWidth
        self.shapeLayer.strokeEnd = 0
        self.shapeLayer.lineCap = kCALineCapRound
        
        self.view.layer.addSublayer(shapeLayer)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func reset() {
        self.queue.cancelAllOperations()
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.0
        basicAnimation.duration = 0.0
        basicAnimation.isRemovedOnCompletion = false
        DispatchQueue.main.async {
            self.step = 0
            self.centerLabel.text = 0.romanNumeral
            self.shapeLayer.add(basicAnimation, forKey: "fillLoadingBar")
        }
    }

    @objc private func handleTap() {
        guard step.isLess(than: numberOfSteps) else {return}
        let animation = AnimateNextStepOperation(step: self.step, of: self.numberOfSteps, shapeLayer: self.shapeLayer)
        self.step += 1
        DispatchQueue.main.async {
            self.centerLabel.text = Int(self.step).romanNumeral
        }
        if let lastAnimation = self.lastAnimation {
            animation.addDependency(lastAnimation)
        }
        self.lastAnimation = animation
        self.queue.addOperation(animation)
    }
}

