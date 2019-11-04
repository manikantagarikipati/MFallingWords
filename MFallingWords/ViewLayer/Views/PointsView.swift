//
//  PointsView.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import RxSwift

class PointsView: UIView {
    
    @IBOutlet weak var translationLabel: UILabel!
    
    let didNotHitSignal = PublishSubject<Void>()
    
    private var previousWord = ""
    private var currentWord = ""
    
    func newFall(with word: String, duration: CFTimeInterval) {
        translationLabel.text = word
        currentWord = word
        let animation = CABasicAnimation()
        animation.keyPath = "position"
        animation.fromValue = NSValue(cgPoint: translationLabel.center)
        let finishPoint = CGPoint(x: translationLabel.center.x,
                                  y: frame.size.height)
        animation.toValue = NSValue(cgPoint: finishPoint)
        animation.duration = duration
        animation.repeatCount = 1
        animation.autoreverses = false
        animation.delegate = self
        translationLabel.layer.add(animation, forKey: animation.keyPath!)
    }
    
    func stopFalling() -> Int {
        previousWord = translationLabel.text ?? ""
        let y = translationLabel.layer.presentation()!.frame.origin.y
        translationLabel.layer.removeAllAnimations()
        let zoneHeight = frame.size.height / 5
        if y > zoneHeight * 4 { return 10 }
        else if y > zoneHeight * 3 { return 30 }
        else if y > zoneHeight * 2 { return 50 }
        else if y > zoneHeight { return 70 }
        else { return 100 }
    }
    
}

extension PointsView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if previousWord != currentWord {
            didNotHitSignal.onNext(())
        }
    }
}
