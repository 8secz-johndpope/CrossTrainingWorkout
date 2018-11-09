//
//  NewWodViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class NewWodViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.delegate = self
            pickerView.dataSource = self
        }
    }
    
    @IBOutlet weak var wodName: ValidableTextField!
    
    @IBOutlet weak var amrapButton: RoundedRedButton!
    @IBOutlet weak var forTimeButton: RoundedRedButton!
    @IBOutlet weak var finisherButton: RoundedRedButton!
    @IBOutlet weak var emomButton: RoundedRedButton!
    
    @IBAction func didSelectType(_ sender: Any) {
        
        [amrapButton, forTimeButton, finisherButton, emomButton].forEach { $0?.isSelected = false }
        
        guard let button = sender as? UIButton else { fatalError("Not a button ? 🧐") }
        button.isSelected = !button.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension NewWodViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 25
        case 1, 2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let title = (row < 10) ? "0\(row)" : "\(row)"
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //FIXME: Create TimeInterval
        print("")
    }
}
