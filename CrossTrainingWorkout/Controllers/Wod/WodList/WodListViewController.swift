//
//  WodListViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 08/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class WodListViewController: UIViewController, NibLoadable {
    
    override func viewDidLoad() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        navigationItem.backBarButtonItem?.title = ""
        if let newAthleteVC = segue.destination as? NewWodViewController {
            
            newAthleteVC.navigationItem.title = "^d pzeddzed"
            
            segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
//            newAthleteVC.dutyEndedBlock = { (_) in
            
//                DispatchQueue.main.async {
//                    self.heightConstraint?.isActive = true
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.view.layoutIfNeeded()
//                    })
//                }
//            }
        }
    }
    
}
