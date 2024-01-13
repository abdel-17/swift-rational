//
//  AlgebraicFieldTests.swift
//
//
//  Created by Maarten Engels on 13/01/2024.
//

import Foundation
import XCTest
@testable import RationalModule

final class AlgebraicFieldTests: XCTestCase {
    func test_reciprocal_swaps_numerator_and_denominator() throws {
        let rational = Rational(234, 1253)
        let reciprocal = try XCTUnwrap(rational.reciprocal)
        
        XCTAssertEqual(reciprocal.numerator, 1253)
        XCTAssertEqual(reciprocal.denominator, 234)
    }
    
    func test_reciprocal_swaps_numerator_and_denominator_andNegates_forNegativeRationals() throws {
        let rational = Rational(-234, 1253)
        let reciprocal = try XCTUnwrap(rational.reciprocal)
        
        XCTAssertEqual(reciprocal.numerator, -1253)
        XCTAssertEqual(reciprocal.denominator, 234)
    }
    
    func test_reciprocal_returnsNil_whenNumeratorEqualsZero() {
        let rational = Rational(0, 1253)
        XCTAssertNil(rational.reciprocal)
    }
    
    func test_reciprocal_returnsNil_whenNumeratorEqualsTmin() {
        XCTAssertNil(Rational(Int8.min, Int8(123)).reciprocal)
        XCTAssertNil(Rational(Int16.min, Int16(12001)).reciprocal)
        XCTAssertNil(Rational(Int32.min, Int32(2434345)).reciprocal)
        XCTAssertNil(Rational(Int.min, 33948759038475).reciprocal)
    }
    
    func test_division() {
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
        ///    sum_of_pair = fractions[i] / fractions[i+1]
        ///    print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), Rational({fractions[i+1].numerator}, {fractions[i+1].denominator}), Rational({sum_of_pair.numerator}, {sum_of_pair.denominator})),")
        /// ```
        
        let testCases = [
            (Rational(548536627, 648014973), Rational(-940256818, 869687629), Rational(-477055518555287383, 609300496529335914)),
            (Rational(-869926454, 371125019), Rational(-865463599, 423656148), Rational(368549690544939192, 321195194622683381)),
            (Rational(-367337633, 441969049), Rational(220617857, 310660016), Rational(-114117114945182128, 97506264450707993)),
            (Rational(466140003, 829764218), Rational(-774690403, 741694026), Rational(-172866627752361039, 321405188218699927)),
            (Rational(8428, 624149), Rational(34241437, 206336530), Rational(1739004274840, 21371758662113)),
            (Rational(-857461829, 937695956), Rational(620178449, 905534416), Rational(-194115299141451716, 145384705906413061)),
            (Rational(-110622177, 142808804), Rational(164404836, 85797049), Rational(-1054561815617297, 2608717555664016)),
            (Rational(-12067930, 344569237), Rational(602352722, 346417441), Rational(-2090270714383565, 103776108912206557)),
            (Rational(-2710330, 54884099), Rational(303005197, 334068671), Rational(-905436341071430, 16630167229662503)),
            (Rational(24197347, 15055452), Rational(105853686, 617495179), Rational(14941745117090113, 1593675088596072)),
            (Rational(-299307080, 127095499), Rational(224877329, 318509321), Rational(-95332094821292680, 28580896343042171)),
            (Rational(325688653, 362697611), Rational(-688844731, 235630646), Rational(-76742227701259838, 249842338283637641)),
            (Rational(684949773, 608947495), Rational(-480843105, 951807646), Rational(-217313477022454786, 97602734759257325)),
            (Rational(107941681, 163870524), Rational(190830765, 97920124), Rational(2642415697072111, 7817884363967715)),
            (Rational(514625728, 281436005), Rational(283925300, 29119587), Rational(3746422164733584, 19976700537606625)),
            (Rational(190320478, 3773447), Rational(888527671, 671246892), Rational(127752029341454376, 3352812074551937)),
            (Rational(-240591011, 882540702), Rational(290782863, 158790976), Rational(-19101840726758368, 128313856020794913)),
            (Rational(161764557, 72101627), Rational(-25978506, 989166149), Rational(-53337341297460331, 624364183209754)),
            (Rational(897932405, 873195796), Rational(-65054565, 125705218), Rational(-11287478871978929, 5680537266860874)),
            (Rational(211044066, 103938103), Rational(154391334, 720438757), Rational(25340720763544327, 2674523729266567)),
            (Rational(566626021, 70293394), Rational(-393645847, 93311496), Rational(-26436360846018708, 13835351309817359)),
            (Rational(-414183137, 198076660), Rational(30574596, 17715421), Rational(-7337428643055677, 6056113856529360)),
            (Rational(136939151, 57390790), Rational(-779377175, 297863943), Rational(-40789235467932393, 44729071781218250)),
            (Rational(-519763819, 597054909), Rational(-165174839, 438780363), Rational(76020719058362099, 32872816156078217)),
            (Rational(-632361076, 210214219), Rational(451917501, 20276771), Rational(-12822240727365596, 94999484525146719)),
        ]
        
        for (f1, f2, result) in testCases {
            XCTAssertEqual(f1 / f2, result)
        }
    }
    
    func test_assignDivisionOperator() {
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
        ///    sum_of_pair = fractions[i] / fractions[i+1]
        ///    print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), Rational({fractions[i+1].numerator}, {fractions[i+1].denominator}), Rational({sum_of_pair.numerator}, {sum_of_pair.denominator})),")
        /// ```
        let testcases = [
            (Rational(-31127542, 92486669), Rational(-460262665, 691499436), Rational(21524677737066312, 42568160750912885)),
            (Rational(-67457607, 26394628), Rational(-81355278, 181308005), Rational(4076868049081345, 715780766215528)),
            (Rational(158040763, 218449831), Rational(276254427, 897918553), Rational(141907733227975939, 60347732891151837)),
            (Rational(-810337306, 80783485), Rational(-250583187, 743954207), Rational(602853847887746342, 20242983128266695)),
            (Rational(737746979, 216074842), Rational(31554079, 8903088), Rational(3284113137885576, 3409021317190259)),
            (Rational(-149947135, 329327989), Rational(-646878233, 358973515), Rational(53827050115129525, 213035107601763437)),
            (Rational(840726902, 335196765), Rational(-486252065, 94806084), Rational(-26568675097357256, 54330039720856575)),
            (Rational(152130598, 8954481), Rational(-42295827, 21809390), Rational(-3317875542715220, 378737179250787)),
            (Rational(-952890731, 329925510), Rational(-139610517, 147475685), Rational(28105642656875147, 9212214204517734)),
            (Rational(-305449077, 809751842), Rational(-163792243, 71765683), Rational(21920761632624591, 132631070474561606)),
            (Rational(42217492, 17593269), Rational(-244850887, 358619061), Rational(-5046665779605004, 1435909173293201)),
            (Rational(-878451558, 931018891), Rational(27925073, 16817781), Rational(-14773605921552798, 25998770495554043)),
            (Rational(-154755301, 330662360), Rational(-188735109, 240451646), Rational(18605583426337723, 31203798278398620)),
            (Rational(-842479413, 405167483), Rational(-38730587, 179918653), Rational(151577761167190689, 15692374449902521)),
            (Rational(-227997858, 120443371), Rational(-529286029, 61773062), Rational(14084125818101196, 63748993555963759)),
            (Rational(-391784270, 864101027), Rational(506761888, 991859929), Rational(-194297559112758415, 218946733932629488)),
            (Rational(59965670, 327585769), Rational(100864073, 810812118), Rational(48620891899989060, 33041634918177137)),
            (Rational(286231943, 444394673), Rational(752285904, 212097545), Rational(60709092410879935, 334311848310589392)),
            (Rational(862969487, 973382317), Rational(-182019805, 110399832), Rational(-95271686385926184, 177174859530788185)),
            (Rational(-95454357, 66687169), Rational(504587412, 708610025), Rational(-22546638100042975, 11216502006438876)),
            (Rational(-24098217, 96772528), Rational(378168864, 172453505), Rational(-1385273995300195, 12198785660056064)),
            (Rational(204602204, 329901323), Rational(-403479887, 208860804), Rational(-42733380827612016, 133108548525190501)),
            (Rational(-167185393, 764306440), Rational(-183435083, 112975790), Rational(1888790185063547, 14020061525883452)),
            (Rational(67721832, 45562133), Rational(444441349, 203231563), Rational(13763213766583416, 20249695853837417)),
            (Rational(-917633427, 692556211), Rational(522619310, 59388869), Rational(-54497211386124063, 361943249129034410)),
        ]
        
        for (f1, f2, result) in testcases {
            var f1 = f1
            f1 /= f2
            XCTAssertEqual(f1 , result)
        }
    }
}
