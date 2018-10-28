//
//  UIViewControllerExtensions.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 26/10/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController, into subview: UIView) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func add(_ child: UIViewController) {
        add(child, into: self.view)
    }
    
    func remove() {
        
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
