//
//  AbstractSyntaxTrees.swift
//  AbstractSyntaxTrees
//
//  Created by Elvis on 08/08/2023.
//

import XCTest
@testable import Calculator

final class AbstractSyntaxTrees: XCTestCase {
    var calculate: Calculate!

    override func setUpWithError() throws {
        calculate = Calculate()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSucessCase() throws {
        XCTAssertEqual(0.0, try calculate.perform(input: "0"))
        XCTAssertEqual(0.1, try calculate.perform(input: ".1"))
        XCTAssertEqual(1123.0, try calculate.perform(input: "1000+123"))
        XCTAssertEqual(877.0, try calculate.perform(input: "1000-123"))
        XCTAssertEqual(123000.0, try calculate.perform(input: "1000×123"))
        XCTAssertEqual(25.0, try calculate.perform(input: "50÷2"))
        XCTAssertEqual(1.0, try calculate.perform(input: "8÷4÷2"))
        XCTAssertEqual(40.0, try calculate.perform(input: "4(5×2)"))
        XCTAssertEqual(240.0, try calculate.perform(input: "(6×4)(5×2)"))
        XCTAssertEqual(34.0, try calculate.perform(input: "(6×4)+(5×2)"))
        XCTAssertEqual(-0.875, try calculate.perform(input: "2+3-4÷8×(7+3-4)÷3×5-(3+4)÷8"))
    }
    
    func testErrorCase() {
        XCTAssertThrowsError(try calculate.perform(input: "1+++++++3")) { error in
            XCTAssertEqual(error as! CalCulatorError, CalCulatorError.SyntaxError)
        }
        XCTAssertThrowsError(try calculate.perform(input: "÷÷÷×")) { error in
            XCTAssertEqual(error as! CalCulatorError, CalCulatorError.SyntaxError)
        }
        XCTAssertThrowsError(try calculate.perform(input: "1÷0")) { error in
            XCTAssertEqual(error as! CalCulatorError, CalCulatorError.MathError)
        }
    }

}
