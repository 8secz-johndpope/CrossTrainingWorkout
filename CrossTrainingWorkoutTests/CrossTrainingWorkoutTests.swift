//
//  CrossTrainingWorkoutTests.swift
//  CrossTrainingWorkoutTests
//
//  Created by Jonathan Arnal on 06/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import XCTest
@testable import CrossTrainingWorkout

class CrossTrainingWorkoutTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_thatNewAthleteLogicController_validateCorrectly_textfields(){
        
        let controller = NewAthleteLogicController()
        
        let field1 = ValidableTextField(frame: CGRect.zero)
        field1.validator = .minchars(2)
        field1.text = "Jonathan"
        
        let field2 = ValidableTextField(frame: CGRect.zero)
        field2.validator = .email
        field2.text = "jonathan.arnal89@gmail.com"
        
        let textfields = [field1, field2]
        
        let validation = controller.validateGlobally(textfields: textfields)
        XCTAssertNil(validation, "Validation seems to have errors")
    }
    
    

}
