//
//  ValidableTextFieldContainerTests.swift
//  CrossTrainingWorkoutTests
//
//  Created by Jonathan Arnal on 06/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import XCTest
@testable import CrossTrainingWorkout

class ConcreteValidableTextFieldContainer: ValidableTextFieldContainer {}

class ValidableTextFieldContainerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_thatValidableTextFieldContainer_validatesCorrectly_Email(){
        
        let controller = ConcreteValidableTextFieldContainer()
        
        let field = ValidableTextField(frame: CGRect.zero)
        field.validator = .email
        field.text = "jonathan.arnalgmail.com"
        
        let textfields = [field]
        
        var validation = controller.validateGlobally(textfields: textfields)
        XCTAssertNotNil(validation, "Validation passed, it should not")
        
        field.text = "jonathan.arnal89@gmail.com"
        
        validation = controller.validateGlobally(textfields: textfields)
        XCTAssertNil(validation, "Validation did not pass, it should")
    }
    
    func test_thatValidableTextFieldContainer_validatesCorrectly_Firstname(){
        
        let controller = ConcreteValidableTextFieldContainer()
        
        let field = ValidableTextField(frame: CGRect.zero)
        field.validator = .firstname
        field.text = "jo"
        
        let textfields = [field]
        
        var validation = controller.validateGlobally(textfields: textfields)
        XCTAssertNotNil(validation, "Validation passed, it should not")
        
        field.text = "Jonathan"
        
        validation = controller.validateGlobally(textfields: textfields)
        XCTAssertNil(validation, "Validation did not pass, it should")
    }
    
}
