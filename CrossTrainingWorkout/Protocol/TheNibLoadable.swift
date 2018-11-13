//
//  NibLoadable.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 19/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit
import SnapKit

public protocol NibLoadable: class {}
public extension NibLoadable where Self: UIView {
    
    /// Nib name of the UIView
    static var nibName: String {
        return String(describing: self)
    }
    
    /// Nib instance
    private var nib: UINib {
        return UINib(nibName: Self.nibName, bundle: nil)
    }
    
    /// Returns an instance of the view
    private var instanceFromNib: UIView {
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    /// Load nib and add it into view
    public func loadView() {
        
        let nib = instanceFromNib
        nib.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nib)
        nib.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
