//
//  NoCaretTextField.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 13/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class NoCaretTextField: ValidableTextField {
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
}
