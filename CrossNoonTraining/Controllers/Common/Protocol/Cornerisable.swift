//
//  Cornerisable.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 24/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

protocol Cornerisable: class {}
extension Cornerisable where Self: UIView {
    
    ///
    func build(corners: UIRectCorner, withRadius radius: CGSize) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        layer.masksToBounds = true
        layer.mask = mask
    }
    
}
