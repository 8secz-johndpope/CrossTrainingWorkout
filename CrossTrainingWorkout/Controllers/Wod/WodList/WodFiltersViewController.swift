//
//  WodListFiltersViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

protocol WodFiltersViewControllerDelegate: class {
    
    func didFilterWods(toType: WodType)
}

class WodFiltersViewController: UIViewController {
    
    // **************************************************************
    // MARK: - Wod Type TabBar Selected Index
    // **************************************************************
    
    enum WodTypeTabBarSelectedIndex: Int {
        
        case amrap = 0, forTime, finisher, emom
        
        public var wodType: WodType {
            return WodType(rawValue: String(describing: self) )!
        }
    }
    
    // **************************************************************
    // MARK: - Outlets
    // **************************************************************
    
    @IBOutlet weak var headerTabBar: HeaderTabBarControl! {
        didSet {
            headerTabBar.update(withElements: tabBarElements)
            headerTabBar.addTarget(self, action: #selector(didUpdateFilters), for: .valueChanged)
        }
    }
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    weak var delegate: WodFiltersViewControllerDelegate?
    
    private lazy var tabBarElements: [HeaderTabBarElement] = {
        return [
            HeaderTabBarElement(label: WodType.amrap.title.uppercased(), notifications: 0, state: .active),
            HeaderTabBarElement(label: WodType.forTime.title.uppercased(), notifications: 0, state: .inactive),
            HeaderTabBarElement(label: WodType.finisher.title.uppercased(), notifications: 0, state: .inactive),
            HeaderTabBarElement(label: WodType.emom.title.uppercased(), notifications: 0, state: .inactive)
        ]
    }()
    
    // **************************************************************
    // MARK: - User Interactions
    // **************************************************************
    
    /// 👆 Handles when user has updated filters
    @objc private func didUpdateFilters() {
        guard let selectedIndex = headerTabBar.selectedIndex, let selected = WodTypeTabBarSelectedIndex(rawValue: selectedIndex) else {return}
        delegate?.didFilterWods(toType: selected.wodType)
    }
    
}
