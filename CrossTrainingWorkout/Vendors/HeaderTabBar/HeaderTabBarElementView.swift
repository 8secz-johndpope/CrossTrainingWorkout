//
//  HeaderTabBarElementView.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 08/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class HeaderTabBarElementView: UIView, NibLoadable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var notificationNumberLabel: UILabel! {
        didSet {
            notificationNumberLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var roundedNotificiationView: UIView! {
        didSet {
            notificationNumberLabel.isHidden = true
            roundedNotificiationView.layer.cornerRadius = roundedNotificiationView.bounds.height/2
            roundedNotificiationView.layer.borderColor = UIColor.white.cgColor
            roundedNotificiationView.layer.borderWidth = 2
        }
    }
    
    @IBOutlet weak var roundedNotificationWithConstraint: NSLayoutConstraint! {
        didSet {
            roundedNotificationWithConstraint.constant = 0
        }
    }
    
    @IBOutlet weak var activeBottomBorderView: UIView!
    
    // MARK: - Variables
    
    private var state: HeaderTabBarViewState = .inactive
    
    // MARK: - UI
    
    ///
    func build(withData data: HeaderTabBarElement) {
        state = data.state
        titleLabel.text = data.label
        
        roundedNotificiationView.isHidden = (data.notifications == 0)
        notificationNumberLabel.isHidden = (data.notifications == 0)
        notificationNumberLabel.text = "\(data.notifications!)"
        
        roundedNotificationWithConstraint.isActive = (data.notifications == 0)
    }
    
    ///
    func updateUI(withData data: HeaderTabBarViewState, andNotificationNumber notifications: Int) {}
    
}
