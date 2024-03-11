//
//  FoodPicerTests.swift
//  FoodPicerTests
//
//  Created by jaysun on 2024/3/4.
//

import XCTest
@testable import FoodPicer

final class SuffixTests: XCTestCase {
    
    var sut: Suffix!
    
    
    func testFormatter() throws {
        sut = .init(wrappedValue: 100, "g")
        XCTAssertEqual(sut.projectedValue, "100 g")
        
        sut = .init(wrappedValue: 100.678, "g")
        XCTAssertEqual(sut.projectedValue, "100.7 g")
        
    }
}
