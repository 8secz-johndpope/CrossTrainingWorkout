//
//  RoundedCornerView.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 24/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class RoundedCornerView: UIView, Cornerisable {
    
    /// Defines the needed corners for the view
    var neededCorners: UIRectCorner! = [.allCorners] {
        didSet {
            updateCorners()
        }
    }
    
    fileprivate func updateCorners() {
        build(corners: neededCorners, withRadius: CGSize(width: 11, height: 11))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCorners()
    }
    
}

class RoundedCornerButton: UIButton, Cornerisable {
    
    /// Defines the needed corners for the view
    var neededCorners: UIRectCorner! = [.allCorners] {
        didSet {
            updateCorners()
        }
    }
    
    private func updateCorners() {
        build(corners: neededCorners, withRadius: CGSize(width: 4, height: 4))
        
//        self.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        self.titleLabel?.textColor = UIColor(hexString: "#263849")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCorners()
    }
    
}
