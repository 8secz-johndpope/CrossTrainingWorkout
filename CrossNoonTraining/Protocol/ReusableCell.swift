//
//  ReusableCell.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 19/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

protocol ReusableCell: NibLoadable {
    
    associatedtype Model
    
    static var cellIdentifier: String { get }
    func configure(withModel model: Model)
}
extension ReusableCell where Self: UITableViewCell {
    
    static var cellIdentifier: String {
        return Self.nibName
    }
}
