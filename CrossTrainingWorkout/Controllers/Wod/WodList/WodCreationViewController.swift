//
//  WodCreationViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

struct WodCreationLogicController: AppDependent, ValidableTextFieldContainer {
    
    /// 🏭 Builds a new wod
    ///
    /// - Parameters:
    ///   - name: name of the wod
    ///   - timeCap: timecap of the wod
    ///   - type: type of the wod
    /// - Returns: wod model
    public func buildWod(withName name: String, timeCap: TimeInterval, type: WodType) -> Wod {
        
        let wod = Wod()
        wod.id = UUID().uuidString
        wod.name = name
        wod.timeCap = timeCap
        wod.wodType = type.rawValue
        
        return wod
    }
    
    /// Returns input errors
    ///
    /// - Returns: list of errors
    public func getInputErrors(forTextFields textfields: [ValidableTextField], wodSelectedType: WodType?, wodInterval: TimeInterval?) -> [String]? {
        
        var errors = self.validateInDetails(textfields: textfields)
        
        if wodSelectedType == nil {
            errors.append(Localizations.InputValidation.Wod.WodType)
        }
        
        if wodInterval == nil {
            errors.append(Localizations.InputValidation.Wod.Timecap)
        }
        
        return errors.isEmpty ? nil : errors
    }
    
}

protocol WodCreationViewControllerDelegate: class {
    func didSubmit(wod: Wod)
    func didCancel()
}

class WodCreationViewController: UIViewController, ValidableTextFieldContainer, CommonStateTransitionable {
    
    // **************************************************************
    // MARK: - Outlets
    // **************************************************************
    
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet {
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.isHidden = true
        }
    }
    
    @IBOutlet weak var wodName: ValidableTextField! {
        didSet {
            wodName.validator = .minchars(3)
        }
    }
    
    @IBOutlet weak var timeCap: NoCaretTextField! {
        didSet {
            timeCap.delegate = self
        }
    }
    
    @IBOutlet weak var amrapButton: RoundedRedButton!
    @IBOutlet weak var forTimeButton: RoundedRedButton!
    @IBOutlet weak var finisherButton: RoundedRedButton!
    @IBOutlet weak var emomButton: RoundedRedButton!
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    weak var delegate: WodCreationViewControllerDelegate?
    
    private var logicController: WodCreationLogicController!
    
    private var wodSelectedType: WodType?
    private var wodInterval: TimeInterval?
    
    // **************************************************************
    // MARK: - Life Cycle
    // **************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logicController = WodCreationLogicController()
    }
    
    // **************************************************************
    // MARK: - User Interactions
    // **************************************************************
    
    /// 👆 Handles when user has selected a type for the WOD
    ///
    /// - Parameter sender: sender
    @IBAction func didSelectType(_ sender: Any) {
        
        [amrapButton, forTimeButton, finisherButton, emomButton].forEach { $0?.isSelected = false }
        
        guard let button = sender as? UIButton else { fatalError("Not a button ? 🧐") }
        button.isSelected = !button.isSelected
    
        switch button {
            case amrapButton: wodSelectedType = .amrap
            case forTimeButton: wodSelectedType = .forTime
            case finisherButton: wodSelectedType = .finisher
            case emomButton: wodSelectedType = .emom
            default: fatalError("What is this button ?")
        }
    }
    
    /// 👆 Handles when the user wants to submit the data
    ///
    /// - Parameter sender: sender
    @IBAction func submit(_ sender: Any) {
        
        view.endEditing(true)
        
        let textfields: [ValidableTextField] = [wodName]
        if let errors = logicController.getInputErrors(forTextFields: textfields, wodSelectedType: wodSelectedType, wodInterval: wodInterval) {
            transition(toCommonState: .failure( errors.joined(separator: "\n") ))
            return
        }
        
        let wod = logicController.buildWod(withName: wodName.text!, timeCap: wodInterval!, type: wodSelectedType!)
        
        do {
            try logicController.database.save(wod, updateIfExisting: false)
        } catch {
            transition(toCommonState: .failure(error.localizedDescription))
        }

        delegate?.didSubmit(wod: wod)
    }
    
    /// 👆 Handles when the user wants to cancel input
    ///
    /// - Parameter sender: sender
    @IBAction func cancel(_ sender: Any) {
        view.endEditing(true)
        delegate?.didCancel()
    }
    
}

extension WodCreationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        pickerView.isHidden = true
    }
    
}

extension WodCreationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return 25
        case 1, 2: return 60
        default: return 0
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
        
        let hour = pickerView.selectedRow(inComponent: 0) * 60 * 60
        let minutes = pickerView.selectedRow(inComponent: 1) * 60
        let seconds = pickerView.selectedRow(inComponent: 2)

        let interval = TimeInterval(exactly: hour + minutes + seconds)
        timeCap.text = interval?.stringFromTimeInterval()
        wodInterval = interval
    }
}
