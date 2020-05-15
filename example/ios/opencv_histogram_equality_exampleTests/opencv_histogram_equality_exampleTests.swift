//
//  opencv_histogram_equality_exampleTests.swift
//  opencv_histogram_equality_exampleTests
//
//  Created by Grigori on 5/14/20.
//

import XCTest

class opencv_histogram_equality_exampleTests: XCTestCase {

    /// This method will be call before each test method
    override func setUp() {
    }

    /// This method will be call after each test methodÏ
    override func tearDown() {
    }

    /// Test same image equality for two image
    func testSameHistogramEquality() {
        if let firstImage = UIImage(named: "cup"), let secondImage = UIImage(named: "cup"){
            let similarity = HistogramWrapper.similarity(firstImage, source: secondImage)
            assert(similarity == 1, "For same photos similarity coeficent must be 1")
        }
    }
}
