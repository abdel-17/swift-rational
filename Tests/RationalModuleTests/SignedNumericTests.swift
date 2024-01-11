//
//  SignedNumericTests.swift
//

import Foundation
import XCTest
@testable import RationalModule

final class SignedNumericTests: XCTestCase {
    func test_magnitude_forRandomPositiveRationals_returns_sameValue() {
        for _ in 0 ..< 20 {
            let r = Rational(Int.random(in: 0...100), Int.random(in: 1...100))
            XCTAssertEqual(r.magnitude, r)
        }
    }
    
    func test_magnitude_forRandomNegativeRationals_returns_negatedNominator() {
        for _ in 0 ..< 20 {
            let n = Int.random(in: -100...0)
            let d = Int.random(in: 1...100)
            let r = Rational(n, d)
            XCTAssertEqual(r.magnitude, Rational(-n, d))
        }
    }
    
    func test_random_negations() {
        for _ in 0 ..< 20 {
            let n = Int.random(in: -100...100)
            let d = Int.random(in: 1...100)
            let r = Rational(n, d)
            XCTAssertEqual(-r, Rational(-n, d))
        }
    }
    
    func test_init_exactly_Int8() throws {
        let testcases = [
            (123, 123),
            (586, nil),
            (-43, -43),
            (-4312342, nil),
        ]
        
        for testcase in testcases {
            let rational = Rational<Int8>(exactly: testcase.0)
            if let expectedValue = testcase.1 {
                let unwrappedRational = try XCTUnwrap(rational)
                XCTAssertEqual(Int(unwrappedRational.numerator), expectedValue)
                XCTAssertEqual(unwrappedRational.denominator, 1)
            } else {
                XCTAssertNil(rational)
            }
        }
    }
    
    func test_init_exactly_Int16() throws {
        let testcases = [
            (22523, 22523),
            (45000, nil),
            (-12542, -12542),
            (-4312342, nil),
        ]
        
        for testcase in testcases {
            let rational = Rational<Int16>(exactly: testcase.0)
            if let expectedValue = testcase.1 {
                let unwrappedRational = try XCTUnwrap(rational)
                XCTAssertEqual(Int(unwrappedRational.numerator), expectedValue)
                XCTAssertEqual(unwrappedRational.denominator, 1)
            } else {
                XCTAssertNil(rational)
            }
        }
    }
    
    func test_random_multiplications() {
        /// Random test cases created using the following Python script:
        ///
        /// ```
        /// import random
        /// from fractions import Fraction
        ///
        /// # Generate a list of random fractions
        /// fractions = [Fraction(random.randint(-1000000000, 1000000000), random.randint(1, 1000000000)) for _ in range(50)]
        ///
        /// # Add them in pairs and print the result
        /// for i in range(0, len(fractions), 2):
        ///    sum_of_pair = fractions[i] * fractions[i+1]
        ///    print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), Rational({fractions[i+1].numerator}, {fractions[i+1].denominator}), Rational({sum_of_pair.numerator}, {sum_of_pair.denominator})),")
        /// ```
        
        let testcases: [(f1: Rational, f2: Rational, e: Rational)] = [
            (Rational(-1392130, 1686001), Rational(816177760, 340819527), Rational(-1136225545028800, 574622063341527)),
            (Rational(-320736793, 180871655), Rational(-497176477, 8954367), Rational(159462788788018261, 1619591178767385)),
            (Rational(883483639, 638393265), Rational(436498448, 416941559), Rational(385639237256892272, 266172683164200135)),
            (Rational(15254924, 29870345), Rational(-908595979, 378415255), Rational(-13860562606350596, 11303394220112975)),
            (Rational(164501515, 8272256), Rational(-227631167, 264460133), Rational(-37445671832718005, 2187681921970048)),
            (Rational(-147815886, 241147387), Rational(73463923, 59719857), Rational(-278439355571302, 369263781219581)),
            (Rational(840073887, 874405163), Rational(-16197271, 92403953), Rational(-13606904407762377, 80798493584809339)),
            (Rational(352317, 28517536), Rational(5773813, 8383986), Rational(678070824907, 79696874192832)),
            (Rational(561412143, 462343888), Rational(-377930965, 844691509), Rational(-212175032966707995, 390537956431646992)),
            (Rational(-74552605, 86819588), Rational(351659266, 440121243), Rational(-13108557176343965, 19105572493653942)),
            (Rational(-4501781, 1065364), Rational(86687000, 60745357), Rational(-97561472386750, 16178979128737)),
            (Rational(-312653215, 193291591), Rational(3208526, 99314351), Rational(-1003155969311090, 19196628913922441)),
            (Rational(320579828, 260298165), Rational(-457793487, 391859372), Rational(-12229946443498353, 8500022955804365)),
            (Rational(-98704344, 86344571), Rational(793279741, 306605116), Rational(-19575039110973726, 6618421801856309)),
            (Rational(-118483026, 62635405), Rational(867886593, 734727236), Rational(-7344987840247887, 3287138427956470)),
            (Rational(-752786903, 90760316), Rational(430280965, 838057038), Rational(-323909875062201395, 76062321594904008)),
            (Rational(499295636, 139356317), Rational(-741253733, 492563884), Rational(-92526188513902297, 17160472190363807)),
            (Rational(-13573122, 210482627), Rational(21624258, 442806695), Rational(-293508691993476, 93203116416787765)),
            (Rational(645357270, 643371127), Rational(943429379, 686044996), Rational(304424504234617665, 220690771124615246)),
            (Rational(-146530775, 54579549), Rational(-484383493, 91962866), Rational(70977088626497075, 5019291751027434)),
            (Rational(-701829450, 791624263), Rational(884551433, 420454051), Rational(-620804245719101850, 332841628248239413)),
            (Rational(640770757, 860314050), Rational(-12026953, 33082465), Rational(-7706519778213421, 28461309448133250)),
            (Rational(455635569, 740038276), Rational(-5821547, 68945492), Rational(-2652503879805243, 51022303037651792)),
            (Rational(230584817, 221847698), Rational(-125533847, 211577084), Rational(-1523484165147421, 2470415212365928)),
            (Rational(49295768, 102060745), Rational(-82318233, 4334290), Rational(-2028970258068972, 221180433223025)),
        ]
        
        for testcase in testcases {
            var f1 = testcase.f1
            f1 *= testcase.f2
            XCTAssertEqual(f1, testcase.e)
        }
    }
}
