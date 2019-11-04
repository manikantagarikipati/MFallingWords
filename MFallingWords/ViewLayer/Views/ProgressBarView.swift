//
//  ProgressBarView.swift
//  MFallingWords
//
//  Created by Mani on 04/11/19.
//  Copyright © 2019 geekmk. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    @IBOutlet weak var greenWidth: NSLayoutConstraint!
    
    private let maxScore = 1000
    
    func updateScore(_ score: Int) {
        let physicalMax = CGFloat(maxScore * 2)
        let physicalScore = CGFloat(score + maxScore)
        let percentage = physicalScore / physicalMax
        greenWidth.constant = frame.size.width * percentage
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.layoutIfNeeded()
        }
    }
}
