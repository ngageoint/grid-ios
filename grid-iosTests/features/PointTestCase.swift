//
//  PointTestCase.swift
//  grid-iosTests
//
//  Created by Brian Osborn on 8/4/22.
//

import XCTest
@testable import grid_ios

class PointTestCase: XCTestCase {

    func testExample() {
        
        let point = GridPoint.degrees(-112.500003, 21.943049)
        XCTAssertEqual(Unit.DEGREE, point.unit)
        XCTAssertEqual(-112.500003, point.longitude, accuracy: 0.0000000000001)
        XCTAssertEqual(21.943049, point.latitude, accuracy: 0.0000000000001)
        
        let point2 = point.toMeters()
        XCTAssertEqual(Unit.METER, point2.unit)
        XCTAssertEqual(-12523443.048201751, point2.longitude, accuracy: 0.00000001)
        XCTAssertEqual(2504688.958883909, point2.latitude, accuracy: 0.00000001)
        
        let point3 = point.toDegrees()
        XCTAssertEqual(Unit.DEGREE, point3.unit)
        XCTAssertEqual(-112.500003, point3.longitude, accuracy: 0.0000000000001)
        XCTAssertEqual(21.943049, point3.latitude, accuracy: 0.0000000000001)
        
    }

}
