//
//  AnimateNextStepOperation.swift
//  Storm Counter
//
//  Created by Godohaldo Perez on 6/6/18.
//  Copyright © 2018 Godohaldo Perez. All rights reserved.
//

import Foundation
import UIKit

class AnimateNextStepOperation: Operation {
    override var isExecuting: Bool {
        return self._isExecuting
    }
    
    private var _isExecuting = false {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
        }
        didSet {
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isFinished: Bool {
        return self._isFinished
    }
    
    private var _isFinished = false {
        willSet {
            self.willChangeValue(forKey: "isFinished")
        }
        didSet {
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    let step: CGFloat
    let numberOfSteps: CGFloat
    let shapeLayer: CAShapeLayer
    
    init(step: CGFloat, of numberOfSteps: CGFloat, shapeLayer: CAShapeLayer){
        self.step = step
        self.numberOfSteps = numberOfSteps
        self.shapeLayer = shapeLayer
        super.init()
    }
    
    override func main() {
        guard !self.isCancelled, self.step.isLess(than: self.numberOfSteps) else {
            self._isFinished = true
            return
        }
        self._isExecuting = true
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = step/numberOfSteps
        basicAnimation.toValue = (step + 1)/numberOfSteps
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.delegate = self
        DispatchQueue.main.async {
            self.shapeLayer.add(basicAnimation, forKey: "fillLoadingBar")
        }
    }
    
}
extension AnimateNextStepOperation: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self._isExecuting = false
        self._isFinished = true
    }
}
