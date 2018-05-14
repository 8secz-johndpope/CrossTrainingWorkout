//
//  FakeableCell.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 19/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

protocol FakeableCell: ReusableCell {
    
    static var fakeCellIdentifier: String { get }
}
extension FakeableCell where Self: UITableViewCell {
    
    static var fakeCellIdentifier: String {
        return "\(Self.nibName)Fake"
    }
    
}
