//
//  WodListFiltersViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class WodListFiltersViewController: UIViewController {
    
    private let tabBarElements: [HeaderTabBarElement] = [
        HeaderTabBarElement(label: SessionType.amrap.title.uppercased(), notifications: 0, state: .active),
        HeaderTabBarElement(label: SessionType.forTime.title.uppercased(), notifications: 0, state: .inactive),
        HeaderTabBarElement(label: SessionType.finisher.title.uppercased(), notifications: 0, state: .inactive),
        HeaderTabBarElement(label: SessionType.emom.title.uppercased(), notifications: 0, state: .inactive)
    ]
    
    @IBOutlet weak var headerTabBar: HeaderTabBarControl! {
        didSet {
            headerTabBar.update(withElements: tabBarElements)
        }
    }
    
}
