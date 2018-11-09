//
//  WodListFiltersViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

enum WodTypeTabBarSelectedIndex: Int {
    
    case amrap = 0, forTime, finisher, emom
    
    public var wodType: WodType {
        return WodType(rawValue: String(describing: self) )!
    }
}

protocol WodListFiltersViewControllerDelegate: class {
    
    func didFilterWods(toType: WodType)
}

class WodListFiltersViewController: UIViewController {
    
    private lazy var tabBarElements: [HeaderTabBarElement] = {
        return [
            HeaderTabBarElement(label: WodType.amrap.title.uppercased(), notifications: 0, state: .active),
            HeaderTabBarElement(label: WodType.forTime.title.uppercased(), notifications: 0, state: .inactive),
            HeaderTabBarElement(label: WodType.finisher.title.uppercased(), notifications: 0, state: .inactive),
            HeaderTabBarElement(label: WodType.emom.title.uppercased(), notifications: 0, state: .inactive)
        ]
    }()
    
    @IBOutlet weak var headerTabBar: HeaderTabBarControl! {
        didSet {
            headerTabBar.update(withElements: tabBarElements)
            headerTabBar.addTarget(self, action: #selector(didUpdateFilters), for: .valueChanged)
        }
    }
    
    weak var delegate: WodListFiltersViewControllerDelegate?
    
    @objc private func didUpdateFilters() {
        guard let selectedIndex = headerTabBar.selectedIndex, let selected = WodTypeTabBarSelectedIndex(rawValue: selectedIndex) else {return}
        delegate?.didFilterWods(toType: selected.wodType)
    }
    
}
