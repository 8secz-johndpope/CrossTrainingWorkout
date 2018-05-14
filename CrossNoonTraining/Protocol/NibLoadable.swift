//
//  NibLoadable.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 19/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    
    static var nibName: String { get }
}
extension NibLoadable {
    
    /// Nib name of the UIView
    static var nibName: String {
        return String(describing: self)
    }
    
}
extension NibLoadable where Self: UIView {
    
    /// Nib instance
    static var nib: UINib {
        return UINib(nibName: Self.nibName, bundle: nil)
    }
    
    /// Returns an instance of the view wich extends the protocol
    static var instanceFromNib: Self {
        let view: Self = Self.nib.instantiate(withOwner: nil, options: nil)[0] as! Self
        return view
    }
}
