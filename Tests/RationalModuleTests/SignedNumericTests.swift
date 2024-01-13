import Foundation
import XCTest

@testable import RationalModule

final class SignedNumericTests: XCTestCase {
	func test_magnitude_for_any_positive_rational_returns_the_same_value() {
		for _ in 0..<20 {
			let r = Rational(Int.random(in: 0...100), Int.random(in: 1...100))
			XCTAssertEqual(r.magnitude, r)
		}
	}

	func test_magnitude_for_any_negative_rational_negates_its_numerator() {
		for _ in 0..<20 {
			let n = Int.random(in: -100...0)
			let d = Int.random(in: 1...100)
			let r = Rational(n, d)
			XCTAssertEqual(r.magnitude, Rational(-n, d))
		}
	}

	func test_negating_any_rational_number_negates_its_numerator() {
		for _ in 0..<20 {
			let n = Int.random(in: -100...100)
			let d = Int.random(in: 1...100)
			let r = Rational(n, d)
			XCTAssertEqual(-r, Rational(-n, d))
		}
	}

	func test_init_exactly_int8() throws {
		let testCases = [
			(123, 123),
			(586, nil),
			(-43, -43),
			(-4_312_342, nil),
		]

		for (source, expected) in testCases {
			let rational = Rational<Int8>(exactly: source)
			if let expected {
				let unwrappedRational = try XCTUnwrap(rational)
				XCTAssertEqual(Int(unwrappedRational.numerator), expected)
				XCTAssertEqual(unwrappedRational.denominator, 1)
			} else {
				XCTAssertNil(rational)
			}
		}
	}

	func test_init_exactly_int16() throws {
		let testCases = [
			(22523, 22523),
			(45000, nil),
			(-12542, -12542),
			(-4_312_342, nil),
		]

		for (source, expected) in testCases {
			let rational = Rational<Int16>(exactly: source)
			if let expected {
				let unwrappedRational = try XCTUnwrap(rational)
				XCTAssertEqual(Int(unwrappedRational.numerator), expected)
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

		let testCases = [
			(
				Rational(-1_392_130, 1_686_001), Rational(816_177_760, 340_819_527),
				Rational(-1_136_225_545_028_800, 574_622_063_341_527)
			),
			(
				Rational(-320_736_793, 180_871_655),
				Rational(-497_176_477, 8_954_367),
				Rational(159_462_788_788_018_261, 1_619_591_178_767_385)
			),
			(
				Rational(883_483_639, 638_393_265),
				Rational(436_498_448, 416_941_559),
				Rational(385_639_237_256_892_272, 266_172_683_164_200_135)
			),
			(
				Rational(15_254_924, 29_870_345),
				Rational(-908_595_979, 378_415_255),
				Rational(-13_860_562_606_350_596, 11_303_394_220_112_975)
			),
			(
				Rational(164_501_515, 8_272_256),
				Rational(-227_631_167, 264_460_133),
				Rational(-37_445_671_832_718_005, 2_187_681_921_970_048)
			),
			(
				Rational(-147_815_886, 241_147_387),
				Rational(73_463_923, 59_719_857),
				Rational(-278_439_355_571_302, 369_263_781_219_581)
			),
			(
				Rational(840_073_887, 874_405_163),
				Rational(-16_197_271, 92_403_953),
				Rational(-13_606_904_407_762_377, 80_798_493_584_809_339)
			),
			(
				Rational(352317, 28_517_536), Rational(5_773_813, 8_383_986),
				Rational(678_070_824_907, 79_696_874_192_832)
			),
			(
				Rational(561_412_143, 462_343_888),
				Rational(-377_930_965, 844_691_509),
				Rational(-212_175_032_966_707_995, 390_537_956_431_646_992)
			),
			(
				Rational(-74_552_605, 86_819_588),
				Rational(351_659_266, 440_121_243),
				Rational(-13_108_557_176_343_965, 19_105_572_493_653_942)
			),
			(
				Rational(-4_501_781, 1_065_364), Rational(86_687_000, 60_745_357),
				Rational(-97_561_472_386_750, 16_178_979_128_737)
			),
			(
				Rational(-312_653_215, 193_291_591),
				Rational(3_208_526, 99_314_351),
				Rational(-1_003_155_969_311_090, 19_196_628_913_922_441)
			),
			(
				Rational(320_579_828, 260_298_165),
				Rational(-457_793_487, 391_859_372),
				Rational(-12_229_946_443_498_353, 8_500_022_955_804_365)
			),
			(
				Rational(-98_704_344, 86_344_571),
				Rational(793_279_741, 306_605_116),
				Rational(-19_575_039_110_973_726, 6_618_421_801_856_309)
			),
			(
				Rational(-118_483_026, 62_635_405),
				Rational(867_886_593, 734_727_236),
				Rational(-7_344_987_840_247_887, 3_287_138_427_956_470)
			),
			(
				Rational(-752_786_903, 90_760_316),
				Rational(430_280_965, 838_057_038),
				Rational(-323_909_875_062_201_395, 76_062_321_594_904_008)
			),
			(
				Rational(499_295_636, 139_356_317),
				Rational(-741_253_733, 492_563_884),
				Rational(-92_526_188_513_902_297, 17_160_472_190_363_807)
			),
			(
				Rational(-13_573_122, 210_482_627),
				Rational(21_624_258, 442_806_695),
				Rational(-293_508_691_993_476, 93_203_116_416_787_765)
			),
			(
				Rational(645_357_270, 643_371_127),
				Rational(943_429_379, 686_044_996),
				Rational(304_424_504_234_617_665, 220_690_771_124_615_246)
			),
			(
				Rational(-146_530_775, 54_579_549),
				Rational(-484_383_493, 91_962_866),
				Rational(70_977_088_626_497_075, 5_019_291_751_027_434)
			),
			(
				Rational(-701_829_450, 791_624_263),
				Rational(884_551_433, 420_454_051),
				Rational(-620_804_245_719_101_850, 332_841_628_248_239_413)
			),
			(
				Rational(640_770_757, 860_314_050),
				Rational(-12_026_953, 33_082_465),
				Rational(-7_706_519_778_213_421, 28_461_309_448_133_250)
			),
			(
				Rational(455_635_569, 740_038_276),
				Rational(-5_821_547, 68_945_492),
				Rational(-2_652_503_879_805_243, 51_022_303_037_651_792)
			),
			(
				Rational(230_584_817, 221_847_698),
				Rational(-125_533_847, 211_577_084),
				Rational(-1_523_484_165_147_421, 2_470_415_212_365_928)
			),
			(
				Rational(49_295_768, 102_060_745), Rational(-82_318_233, 4_334_290),
				Rational(-2_028_970_258_068_972, 221_180_433_223_025)
			),
		]

		for (f1, f2, result) in testCases {
			XCTAssertEqual(f1 * f2, result)
		}
	}
}
