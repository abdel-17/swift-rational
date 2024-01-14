//
//  RationalTests.swift
//
//
//  Created by Maarten Engels on 14/01/2024.
//

import Foundation
import XCTest
@testable import RationalModule

final class RationalTests: XCTestCase {
    func test_min_returnsMinimalIntegerValue_ofAssociatedType() {
        XCTAssertEqual(Rational<Int8>.min, -128)
        XCTAssertEqual(Rational<Int16>.min, -32768)
        XCTAssertEqual(Rational<Int32>.min, -2147483648)
        XCTAssertEqual(Rational<Int>.min, -9223372036854775808)
    }
    
    func test_max_returnsMaximumIntegerValue_ofAssociatedType() {
        XCTAssertEqual(Rational<Int8>.max, 127)
        XCTAssertEqual(Rational<Int16>.max, 32767)
        XCTAssertEqual(Rational<Int32>.max, 2147483647)
        XCTAssertEqual(Rational<Int>.max, 9223372036854775807)
    }
    
    func test_quotient() {
        let testcases = [
            (Rational(5,4), 1),
            (Rational(-5,4), -1),
            (Rational(0,4), 0),
            (Rational(8,4), 2),
            (Rational(25,4), 6),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.quotient, expected)
        }
    }
    
    func test_remainder() {
        let testcases = [
            (Rational(5,4), 1),
            (Rational(-5,4), -1),
            (Rational(0,4), 0),
            (Rational(8,4), 0),
            (Rational(25,4), 1),
            (Rational(25,7), 4),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.remainder, expected)
        }
    }
    
    func test_quotientAndRemainder() {
        let testcases = [
            (Rational(5,4), 1, 1),
            (Rational(-5,4), -1, -1),
            (Rational(0,4), 0, 0),
            (Rational(8,4), 2, 0),
            (Rational(25,4), 6, 1),
            (Rational(25,7), 3, 4),
        ]
        
        for (rational, expectedQuotient, expectedRemainder) in testcases {
            let qandr = rational.quotientAndRemainder
            XCTAssertEqual(qandr.quotient, expectedQuotient)
            XCTAssertEqual(qandr.remainder, expectedRemainder)
        }
    }
    
    func test_isNegative() {
        let testcases = [
            (Rational(5,4), false),
            (Rational(-5,4), true),
            (Rational(0,4), false),
            (Rational(8,4), false),
            (Rational(-25,4), true),
            (Rational(-0,7), false),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.isNegative, expected)
        }
    }
    
    func test_isPositive() {
        let testcases = [
            (Rational(5,4), true),
            (Rational(-5,4), false),
            (Rational(0,4), false),
            (Rational(8,4), true),
            (Rational(-25,4), false),
            (Rational(-0,7), false),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.isPositive, expected)
        }
    }
    
    func test_isInteger() {
        let testcases = [
            (Rational(5,4), false),
            (Rational(-5,4), false),
            (Rational(0,4), true),
            (Rational(8,4), true),
            (Rational(-25,4), false),
            (Rational(-0,7), true),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.isInteger, expected)
        }
    }
    
    func test_isProperFaction() {
        let testcases = [
            (Rational(5,4), false),
            (Rational(-5,4), false),
            (Rational(0,4), true),
            (Rational(8,4), false),
            (Rational(-25,4), false),
            (Rational(-0,7), true),
            (Rational(-3,7), true),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.isProperFraction, expected)
        }
    }
    
    func test_signum() {
        let int8_testcases: [(Rational<Int8>, Int8)] = [
            (Rational(1,4), 1),
            (Rational(0,4), 0),
            (Rational(-1,7), -1),
            (Rational(-0,7), 0),
        ]
        
        for (rational, expected) in int8_testcases {
            XCTAssertEqual(rational.signum(), expected)
        }
        
        let int16_testcases: [(Rational<Int16>, Int16)] = [
            (Rational(1,4), 1),
            (Rational(0,4), 0),
            (Rational(-1,7), -1),
            (Rational(-0,7), 0),
        ]
        
        for (rational, expected) in int16_testcases {
            XCTAssertEqual(rational.signum(), expected)
        }
        
        let int32_testcases: [(Rational<Int32>, Int32)] = [
            (Rational(1,4), 1),
            (Rational(0,4), 0),
            (Rational(-1,7), -1),
            (Rational(-0,7), 0),
        ]
        
        for (rational, expected) in int32_testcases {
            XCTAssertEqual(rational.signum(), expected)
        }
        
        let int64_testcases: [(Rational<Int>, Int)] = [
            (Rational(1,4), 1),
            (Rational(0,4), 0),
            (Rational(-1,7), -1),
            (Rational(-0,7), 0),
        ]
        
        for (rational, expected) in int64_testcases {
            XCTAssertEqual(rational.signum(), expected)
        }
    }
    
    func test_toRatio() {
        let testcases = (0 ..< 50).map { _ in
            Rational(Int.random(in: -1_000_000_000 ... 1_000_000_000), Int.random(in: 0 ... 1_000_000_000))
        }
        
        for testcase in testcases {
            XCTAssertEqual(testcase.toRatio().numerator, testcase.numerator)
            XCTAssertEqual(testcase.toRatio().denominator, testcase.denominator)
        }
    }
}
