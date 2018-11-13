//
//  RoundedRedButton.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class RoundedRedButton: UIButton {
    
    override func didMoveToWindow() {
        self.layer.cornerRadius = 6
        self.layer.borderColor = UIColor(named: "newWodType")?.cgColor
        self.layer.borderWidth = 1
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.tintColor = UIColor.clear
        self.setTitleColor(UIColor(hexString: "#F55076"), for: .normal)
        self.setTitleColor(UIColor(hexString: "#263849"), for: .selected)
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(hexString: "#F55076") : UIColor(hexString: "#263849")
        }
    }
    
}
