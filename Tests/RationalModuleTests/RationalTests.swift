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
            Rational(Int.random(in: -1_000_000_000 ... 1_000_000_000), Int.random(in: 1 ... 1_000_000_000))
        }
        
        for testcase in testcases {
            XCTAssertEqual(testcase.toRatio().numerator, testcase.numerator)
            XCTAssertEqual(testcase.toRatio().denominator, testcase.denominator)
        }
    }
    
    func test_limitDenominator_whenDenominatorIsLessThanMax() {
        let testcases = (0 ..< 50).map { _ in
            Rational(Int.random(in: -1_000_000 ... 1_000_000), Int.random(in: 1 ... 100_000))
        }
        
        for testcase in testcases {
            XCTAssertEqual(testcase.limitDenominator(to: 1_000_000), testcase)
        }
    }
    
    func test_limitDenominator_whenDenominatorIsLargerThanMax() {
        /// Random test cases created using the following Python script:
        ///
        /// ```
        /// import random
        /// from fractions import Fraction
        ///
        /// # Generate a list of random fractions
        /// fractions = [Fraction(random.randint(-1000000000, 1000000000), random.randint(1, 1000000000)) for _ in range(50)]
        ///
        /// for i in range(0, len(fractions)):
        ///     print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), Rational({fractions[i].limit_denominator(10000000).numerator}, {fractions[i].limit_denominator(10000000).denominator})),")
        /// ```
        ///
        /// Note: testcases where denominator is less than 10_000_000 have been manually removed.
        
        let testcases = [
            (Rational(-65799040, 325053649), Rational(-233695, 1154476)),
            (Rational(883691245, 294904546), Rational(15565830, 5194613)),
            (Rational(-415157373, 223257083), Rational(-15083021, 8111120)),
            (Rational(-90345796, 120451879), Rational(-7323562, 9764005)),
            (Rational(126996568, 265733023), Rational(3740377, 7826524)),
            (Rational(337618238, 336917425), Rational(482234, 481233)),
            (Rational(-909636717, 167549122), Rational(-50298011, 9264564)),
            (Rational(-237770179, 474386723), Rational(-1888542, 3767921)),
            (Rational(949034451, 826874236), Rational(8730550, 7606749)),
            (Rational(31225911, 162975089), Rational(1575766, 8224279)),
            (Rational(52262249, 883490677), Rational(199073, 3365319)),
            (Rational(-748557721, 929536198), Rational(-6004606, 7456337)),
            (Rational(43358353, 104962330), Rational(3968141, 9606115)),
            (Rational(291041067, 11009488), Rational(246184160, 9312643)),
            (Rational(-121049263, 165896661), Rational(-2572855, 3526069)),
            (Rational(27899089, 81263855), Rational(2404625, 7004139)),
            (Rational(747067270, 344016923), Rational(11909432, 5484173)),
            (Rational(174589585, 83378303), Rational(19143767, 9142440)),
            (Rational(-29266630, 46661233), Rational(-5477085, 8732387)),
            (Rational(-494423055, 872873222), Rational(-5416929, 9563252)),
            (Rational(130502527, 149914834), Rational(5881583, 6756471)),
            (Rational(-285367091, 745815408), Rational(-663112, 1733063)),
            (Rational(-65002970, 259868911), Rational(-1048457, 4191522)),
            (Rational(-350936463, 462322268), Rational(-6535569, 8609932)),
            (Rational(479733004, 103510685), Rational(26248067, 5663474)),
            (Rational(103022005, 116495691), Rational(3035481, 3432475)),
            (Rational(-437673145, 586507343), Rational(-3467351, 4646451)),
            (Rational(578416734, 52330711), Rational(53037209, 4798400)),
            (Rational(-112464212, 705358653), Rational(-1389322, 8713619)),
            (Rational(-377776727, 360583935), Rational(-7957182, 7595047)),
            (Rational(-138407569, 122858029), Rational(-8432537, 7485175)),
            (Rational(155396977, 28324984), Rational(45968745, 8378953)),
            (Rational(281722989, 545655067), Rational(2424293, 4695491)),
            (Rational(166815942, 191410135), Rational(393141, 451103)),
            (Rational(35524361, 806000271), Rational(313561, 7114280)),
            (Rational(819003, 744470030), Rational(10412, 9464461)),
            (Rational(-532268629, 962470865), Rational(-3475607, 6284741)),
            (Rational(344777959, 359744488), Rational(9279811, 9682640)),
            (Rational(860288833, 812318391), Rational(10371505, 9793181)),
            (Rational(-104974757, 984982514), Rational(-1055089, 9899944)),
            (Rational(-573409021, 802506185), Rational(-4648918, 6506325)),
            (Rational(836383762, 768328541), Rational(6980485, 6412494)),
            (Rational(-932109225, 854478229), Rational(-9692827, 8885557)),
            (Rational(67420541, 52451458), Rational(11898806, 9256967)),
            (Rational(885851970, 344337881), Rational(7589244, 2950001)),
            (Rational(467523161, 434556658), Rational(3204327, 2978380)),
            (Rational(26331224, 92891061), Rational(1259966, 4444897)),
            (Rational(976468661, 781334107), Rational(11094743, 8877603)),
        ]
        
        for (inputRational, expecetdLimitedRational) in testcases {
            let limitedRational = inputRational.limitDenominator(to: 10_000_000)
            XCTAssertEqual(limitedRational, expecetdLimitedRational)
        }
    }
    
    func test_floor() {
        /// Random test cases created using the following Python script:
        ///
        /// ```
        /// import random
        /// from fractions import Fraction
        ///
        /// # Generate a list of random fractions
        /// fractions = [Fraction(random.randint(-1000000000, 1000000000), random.randint(1, 1000000000)) for _ in range(50)]
        ///
        /// for i in range(0, len(fractions)):
        ///     print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), {fractions[i].__floor__()}),")
        /// ```
        ///
        
        let testcases = [
            (Rational(262145157, 855776251), 0),
            (Rational(511358916, 557170961), 0),
            (Rational(92969496, 90227555), 1),
            (Rational(-43185664, 39317189), -2),
            (Rational(-240713497, 238367712), -2),
            (Rational(591146833, 657580281), 0),
            (Rational(290602188, 43467593), 6),
            (Rational(453350972, 355255185), 1),
            (Rational(-93951361, 801828), -118),
            (Rational(524801197, 996990896), 0),
            (Rational(12550443, 16801627), 0),
            (Rational(407782537, 379273747), 1),
            (Rational(-225345144, 122457433), -2),
            (Rational(-947835479, 17137154), -56),
            (Rational(-436220527, 569379639), -1),
            (Rational(-353461135, 89691766), -4),
            (Rational(-666702, 156567307), -1),
            (Rational(-869265084, 47563579), -19),
            (Rational(-987442149, 769441060), -2),
            (Rational(-706226072, 659449893), -2),
            (Rational(64427228, 327192567), 0),
            (Rational(-98414111, 79063118), -2),
            (Rational(520633381, 204569181), 2),
            (Rational(691162461, 329358089), 2),
            (Rational(-799789171, 62268509), -13),
            (Rational(-467307305, 181843133), -3),
            (Rational(-24297916, 24110109), -2),
            (Rational(-136087555, 130380053), -2),
            (Rational(-9332725, 302775297), -1),
            (Rational(489654773, 967490752), 0),
            (Rational(957225629, 571790848), 1),
            (Rational(660247850, 354899421), 1),
            (Rational(160297260, 10320593), 15),
            (Rational(99825139, 206529542), 0),
            (Rational(-140643520, 171692901), -1),
            (Rational(-273425197, 186920863), -2),
            (Rational(111928403, 182900142), 0),
            (Rational(24933549, 18432077), 1),
            (Rational(-983886469, 940191617), -2),
            (Rational(-514690161, 580045693), -1),
            (Rational(-208758564, 330728159), -1),
            (Rational(-34289727, 99579073), -1),
            (Rational(-577470151, 169175797), -4),
            (Rational(-865650333, 867941038), -1),
            (Rational(402507858, 597947579), 0),
            (Rational(407535651, 67778710), 6),
            (Rational(139935787, 233329375), 0),
            (Rational(-265512059, 218875992), -2),
            (Rational(-154540399, 278286079), -1),
            (Rational(-573054023, 1858939), -309),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.floor, expected)
        }
    }
    
    func test_ceil() {
        /// Random test cases created using the following Python script:
        ///
        /// ```
        /// import random
        /// from fractions import Fraction
        ///
        /// # Generate a list of random fractions
        /// fractions = [Fraction(random.randint(-1000000000, 1000000000), random.randint(1, 1000000000)) for _ in range(50)]
        ///
        /// for i in range(0, len(fractions)):
        ///     print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), {fractions[i].__ceil__()}),")
        /// ```
        ///
        let testcases = [
            (Rational(729617977, 693769749), 2),
            (Rational(-339024775, 182889463), -1),
            (Rational(12411650, 106110749), 1),
            (Rational(-827560691, 897956012), 0),
            (Rational(-303501964, 632597711), 0),
            (Rational(-830233834, 500270675), -1),
            (Rational(34896560, 286987569), 1),
            (Rational(-119100887, 235755166), 0),
            (Rational(243543911, 170980704), 2),
            (Rational(14829730, 54773027), 1),
            (Rational(-153596816, 344582257), 0),
            (Rational(-584346008, 885824759), 0),
            (Rational(-493848931, 208670816), -2),
            (Rational(-496058748, 359875355), -1),
            (Rational(-222969047, 327542980), 0),
            (Rational(252987227, 322910053), 1),
            (Rational(503259821, 807644164), 1),
            (Rational(754421249, 603955343), 2),
            (Rational(324785885, 959256806), 1),
            (Rational(-197745787, 560092992), 0),
            (Rational(925661337, 953427218), 1),
            (Rational(-315328277, 492394227), 0),
            (Rational(182733464, 185857189), 1),
            (Rational(941985331, 416377621), 3),
            (Rational(883223164, 219129445), 5),
            (Rational(-387891323, 117439292), -3),
            (Rational(-587599951, 310893015), -1),
            (Rational(-698682539, 520073241), -1),
            (Rational(89323987, 897263149), 1),
            (Rational(-926010721, 638375695), -1),
            (Rational(-268427201, 338654349), 0),
            (Rational(-136206101, 57950538), -2),
            (Rational(731948243, 131060681), 6),
            (Rational(165267054, 1816423), 91),
            (Rational(-235628485, 504977661), 0),
            (Rational(128769188, 467474889), 1),
            (Rational(-234180865, 286771171), 0),
            (Rational(754733195, 120324408), 7),
            (Rational(215697047, 894988024), 1),
            (Rational(432585223, 792919671), 1),
            (Rational(609129947, 744632022), 1),
            (Rational(-340785853, 469270898), 0),
            (Rational(575614931, 488899062), 2),
            (Rational(248202323, 776675732), 1),
            (Rational(128691445, 978412821), 1),
            (Rational(357026785, 10015297), 36),
            (Rational(-668219806, 85751045), -7),
            (Rational(26753831, 116792127), 1),
            (Rational(-72969618, 86104715), 0),
            (Rational(370348661, 960606899), 1),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.ceil, expected)
        }
    }
    
    func test_round() {
        /// Random test cases created using the following Python script:
        ///
        /// ```
        /// import random
        /// from fractions import Fraction
        ///
        /// # Generate a list of random fractions
        /// fractions = [Fraction(random.randint(-1000000000, 1000000000), random.randint(1, 1000000000)) for _ in range(50)]
        ///
        /// for i in range(0, len(fractions)):
        ///     print(f"(Rational({fractions[i].numerator}, {fractions[i].denominator}), {fractions[i].__round__()}),")
        /// ```
        ///

        let testcases = [
            (Rational(-442953198, 161035891), -3),
            (Rational(145572591, 41904785), 3),
            (Rational(369455244, 450441619), 1),
            (Rational(-26645233, 313679846), 0),
            (Rational(173235281, 63539958), 3),
            (Rational(99597999, 156872312), 1),
            (Rational(4743518, 21380689), 0),
            (Rational(-6106153, 630866866), 0),
            (Rational(-617391735, 918185023), -1),
            (Rational(336502607, 601469461), 1),
            (Rational(-470618449, 381647498), -1),
            (Rational(59458494, 904283479), 0),
            (Rational(235220648, 192965389), 1),
            (Rational(-475141877, 486562778), -1),
            (Rational(-218854626, 982833661), 0),
            (Rational(-800445193, 407793102), -2),
            (Rational(-61297445, 699073486), 0),
            (Rational(27887271, 106035878), 0),
            (Rational(817429193, 836401092), 1),
            (Rational(682609737, 247987673), 3),
            (Rational(-280167719, 487973505), -1),
            (Rational(-1027342, 956624971), 0),
            (Rational(258627324, 764748691), 0),
            (Rational(-90979598, 191256335), 0),
            (Rational(412028835, 307263104), 1),
            (Rational(-74944193, 35136677), -2),
            (Rational(-319150439, 196247867), -2),
            (Rational(718823359, 943120754), 1),
            (Rational(-780056835, 648890056), -1),
            (Rational(-2959814, 3601095), -1),
            (Rational(-587033904, 467255407), -1),
            (Rational(171766619, 373838817), 0),
            (Rational(68670103, 190183655), 0),
            (Rational(-526476361, 826488955), -1),
            (Rational(441511037, 337758880), 1),
            (Rational(851181533, 341887973), 2),
            (Rational(-148560757, 651059711), 0),
            (Rational(-441058157, 326433226), -1),
            (Rational(-315480221, 132343142), -2),
            (Rational(835788958, 560272033), 1),
            (Rational(60096671, 4847083), 12),
            (Rational(-879359583, 726629690), -1),
            (Rational(243361472, 49958187), 5),
            (Rational(498495848, 359144109), 1),
            (Rational(102976308, 110289203), 1),
            (Rational(-270539401, 228262422), -1),
            (Rational(-232939621, 791369726), 0),
            (Rational(-634324370, 945168363), -1),
            (Rational(61419539, 391130885), 0),
            (Rational(-227065415, 193646176), -1),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.rounded, expected)
        }
    }
    
    func test_roundAwayFromZero() {
        let testcases = [
            (Rational(262145157, 855776251), 1),
            (Rational(511358916, 557170961), 1),
            (Rational(92969496, 90227555), 2),
            (Rational(-43185664, 39317189), -2),
            (Rational(-240713497, 238367712), -2),
            (Rational(591146833, 657580281), 1),
            (Rational(290602188, 43467593), 7),
            (Rational(453350972, 355255185), 2),
            (Rational(-93951361, 801828), -118),
            (Rational(524801197, 996990896), 1),
            (Rational(12550443, 16801627), 1),
            (Rational(407782537, 379273747), 2),
            (Rational(-225345144, 122457433), -2),
            (Rational(-947835479, 17137154), -56),
            (Rational(-436220527, 569379639), -1),
            (Rational(-353461135, 89691766), -4),
            (Rational(-666702, 156567307), -1),
            (Rational(-869265084, 47563579), -19),
            (Rational(-987442149, 769441060), -2),
        ]
        
        for (rational, expected) in testcases {
            XCTAssertEqual(rational.roundedAwayFromZero, expected)
        }
    }
}
