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
		XCTAssertEqual(Rational<Int32>.min, -2_147_483_648)
		XCTAssertEqual(Rational<Int>.min, -9_223_372_036_854_775_808)
	}

	func test_max_returnsMaximumIntegerValue_ofAssociatedType() {
		XCTAssertEqual(Rational<Int8>.max, 127)
		XCTAssertEqual(Rational<Int16>.max, 32767)
		XCTAssertEqual(Rational<Int32>.max, 2_147_483_647)
		XCTAssertEqual(Rational<Int>.max, 9_223_372_036_854_775_807)
	}

	func test_quotient() {
		let testcases = [
			(Rational(5, 4), 1),
			(Rational(-5, 4), -1),
			(Rational(0, 4), 0),
			(Rational(8, 4), 2),
			(Rational(25, 4), 6),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.quotient, expected)
		}
	}

	func test_remainder() {
		let testcases = [
			(Rational(5, 4), 1),
			(Rational(-5, 4), -1),
			(Rational(0, 4), 0),
			(Rational(8, 4), 0),
			(Rational(25, 4), 1),
			(Rational(25, 7), 4),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.remainder, expected)
		}
	}

	func test_quotientAndRemainder() {
		let testcases = [
			(Rational(5, 4), 1, 1),
			(Rational(-5, 4), -1, -1),
			(Rational(0, 4), 0, 0),
			(Rational(8, 4), 2, 0),
			(Rational(25, 4), 6, 1),
			(Rational(25, 7), 3, 4),
		]

		for (rational, expectedQuotient, expectedRemainder) in testcases {
			let qandr = rational.quotientAndRemainder
			XCTAssertEqual(qandr.quotient, expectedQuotient)
			XCTAssertEqual(qandr.remainder, expectedRemainder)
		}
	}

	func test_isNegative() {
		let testcases = [
			(Rational(5, 4), false),
			(Rational(-5, 4), true),
			(Rational(0, 4), false),
			(Rational(8, 4), false),
			(Rational(-25, 4), true),
			(Rational(-0, 7), false),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.isNegative, expected)
		}
	}

	func test_isPositive() {
		let testcases = [
			(Rational(5, 4), true),
			(Rational(-5, 4), false),
			(Rational(0, 4), false),
			(Rational(8, 4), true),
			(Rational(-25, 4), false),
			(Rational(-0, 7), false),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.isPositive, expected)
		}
	}

	func test_isInteger() {
		let testcases = [
			(Rational(5, 4), false),
			(Rational(-5, 4), false),
			(Rational(0, 4), true),
			(Rational(8, 4), true),
			(Rational(-25, 4), false),
			(Rational(-0, 7), true),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.isInteger, expected)
		}
	}

	func test_isProperFaction() {
		let testcases = [
			(Rational(5, 4), false),
			(Rational(-5, 4), false),
			(Rational(0, 4), true),
			(Rational(8, 4), false),
			(Rational(-25, 4), false),
			(Rational(-0, 7), true),
			(Rational(-3, 7), true),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.isProperFraction, expected)
		}
	}

	func test_signum() {
		let int8_testcases: [(Rational<Int8>, Int8)] = [
			(Rational(1, 4), 1),
			(Rational(0, 4), 0),
			(Rational(-1, 7), -1),
			(Rational(-0, 7), 0),
		]

		for (rational, expected) in int8_testcases {
			XCTAssertEqual(rational.signum(), expected)
		}

		let int16_testcases: [(Rational<Int16>, Int16)] = [
			(Rational(1, 4), 1),
			(Rational(0, 4), 0),
			(Rational(-1, 7), -1),
			(Rational(-0, 7), 0),
		]

		for (rational, expected) in int16_testcases {
			XCTAssertEqual(rational.signum(), expected)
		}

		let int32_testcases: [(Rational<Int32>, Int32)] = [
			(Rational(1, 4), 1),
			(Rational(0, 4), 0),
			(Rational(-1, 7), -1),
			(Rational(-0, 7), 0),
		]

		for (rational, expected) in int32_testcases {
			XCTAssertEqual(rational.signum(), expected)
		}

		let int64_testcases: [(Rational<Int>, Int)] = [
			(Rational(1, 4), 1),
			(Rational(0, 4), 0),
			(Rational(-1, 7), -1),
			(Rational(-0, 7), 0),
		]

		for (rational, expected) in int64_testcases {
			XCTAssertEqual(rational.signum(), expected)
		}
	}

	func test_toRatio() {
		let testcases = (0..<50).map { _ in
			Rational(
				Int.random(in: -1_000_000_000...1_000_000_000),
				Int.random(in: 1...1_000_000_000)
			)
		}

		for testcase in testcases {
			XCTAssertEqual(testcase.toRatio().numerator, testcase.numerator)
			XCTAssertEqual(testcase.toRatio().denominator, testcase.denominator)
		}
	}

	func test_limitDenominator_whenDenominatorIsLessThanMax() {
		let testcases = (0..<50).map { _ in
			Rational(
				Int.random(in: -1_000_000...1_000_000),
				Int.random(in: 1...100_000)
			)
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
			(Rational(-65_799_040, 325_053_649), Rational(-233695, 1_154_476)),
			(Rational(883_691_245, 294_904_546), Rational(15_565_830, 5_194_613)),
			(Rational(-415_157_373, 223_257_083), Rational(-15_083_021, 8_111_120)),
			(Rational(-90_345_796, 120_451_879), Rational(-7_323_562, 9_764_005)),
			(Rational(126_996_568, 265_733_023), Rational(3_740_377, 7_826_524)),
			(Rational(337_618_238, 336_917_425), Rational(482234, 481233)),
			(Rational(-909_636_717, 167_549_122), Rational(-50_298_011, 9_264_564)),
			(Rational(-237_770_179, 474_386_723), Rational(-1_888_542, 3_767_921)),
			(Rational(949_034_451, 826_874_236), Rational(8_730_550, 7_606_749)),
			(Rational(31_225_911, 162_975_089), Rational(1_575_766, 8_224_279)),
			(Rational(52_262_249, 883_490_677), Rational(199073, 3_365_319)),
			(Rational(-748_557_721, 929_536_198), Rational(-6_004_606, 7_456_337)),
			(Rational(43_358_353, 104_962_330), Rational(3_968_141, 9_606_115)),
			(Rational(291_041_067, 11_009_488), Rational(246_184_160, 9_312_643)),
			(Rational(-121_049_263, 165_896_661), Rational(-2_572_855, 3_526_069)),
			(Rational(27_899_089, 81_263_855), Rational(2_404_625, 7_004_139)),
			(Rational(747_067_270, 344_016_923), Rational(11_909_432, 5_484_173)),
			(Rational(174_589_585, 83_378_303), Rational(19_143_767, 9_142_440)),
			(Rational(-29_266_630, 46_661_233), Rational(-5_477_085, 8_732_387)),
			(Rational(-494_423_055, 872_873_222), Rational(-5_416_929, 9_563_252)),
			(Rational(130_502_527, 149_914_834), Rational(5_881_583, 6_756_471)),
			(Rational(-285_367_091, 745_815_408), Rational(-663112, 1_733_063)),
			(Rational(-65_002_970, 259_868_911), Rational(-1_048_457, 4_191_522)),
			(Rational(-350_936_463, 462_322_268), Rational(-6_535_569, 8_609_932)),
			(Rational(479_733_004, 103_510_685), Rational(26_248_067, 5_663_474)),
			(Rational(103_022_005, 116_495_691), Rational(3_035_481, 3_432_475)),
			(Rational(-437_673_145, 586_507_343), Rational(-3_467_351, 4_646_451)),
			(Rational(578_416_734, 52_330_711), Rational(53_037_209, 4_798_400)),
			(Rational(-112_464_212, 705_358_653), Rational(-1_389_322, 8_713_619)),
			(Rational(-377_776_727, 360_583_935), Rational(-7_957_182, 7_595_047)),
			(Rational(-138_407_569, 122_858_029), Rational(-8_432_537, 7_485_175)),
			(Rational(155_396_977, 28_324_984), Rational(45_968_745, 8_378_953)),
			(Rational(281_722_989, 545_655_067), Rational(2_424_293, 4_695_491)),
			(Rational(166_815_942, 191_410_135), Rational(393141, 451103)),
			(Rational(35_524_361, 806_000_271), Rational(313561, 7_114_280)),
			(Rational(819003, 744_470_030), Rational(10412, 9_464_461)),
			(Rational(-532_268_629, 962_470_865), Rational(-3_475_607, 6_284_741)),
			(Rational(344_777_959, 359_744_488), Rational(9_279_811, 9_682_640)),
			(Rational(860_288_833, 812_318_391), Rational(10_371_505, 9_793_181)),
			(Rational(-104_974_757, 984_982_514), Rational(-1_055_089, 9_899_944)),
			(Rational(-573_409_021, 802_506_185), Rational(-4_648_918, 6_506_325)),
			(Rational(836_383_762, 768_328_541), Rational(6_980_485, 6_412_494)),
			(Rational(-932_109_225, 854_478_229), Rational(-9_692_827, 8_885_557)),
			(Rational(67_420_541, 52_451_458), Rational(11_898_806, 9_256_967)),
			(Rational(885_851_970, 344_337_881), Rational(7_589_244, 2_950_001)),
			(Rational(467_523_161, 434_556_658), Rational(3_204_327, 2_978_380)),
			(Rational(26_331_224, 92_891_061), Rational(1_259_966, 4_444_897)),
			(Rational(976_468_661, 781_334_107), Rational(11_094_743, 8_877_603)),
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
			(Rational(262_145_157, 855_776_251), 0),
			(Rational(511_358_916, 557_170_961), 0),
			(Rational(92_969_496, 90_227_555), 1),
			(Rational(-43_185_664, 39_317_189), -2),
			(Rational(-240_713_497, 238_367_712), -2),
			(Rational(591_146_833, 657_580_281), 0),
			(Rational(290_602_188, 43_467_593), 6),
			(Rational(453_350_972, 355_255_185), 1),
			(Rational(-93_951_361, 801828), -118),
			(Rational(524_801_197, 996_990_896), 0),
			(Rational(12_550_443, 16_801_627), 0),
			(Rational(407_782_537, 379_273_747), 1),
			(Rational(-225_345_144, 122_457_433), -2),
			(Rational(-947_835_479, 17_137_154), -56),
			(Rational(-436_220_527, 569_379_639), -1),
			(Rational(-353_461_135, 89_691_766), -4),
			(Rational(-666702, 156_567_307), -1),
			(Rational(-869_265_084, 47_563_579), -19),
			(Rational(-987_442_149, 769_441_060), -2),
			(Rational(-706_226_072, 659_449_893), -2),
			(Rational(64_427_228, 327_192_567), 0),
			(Rational(-98_414_111, 79_063_118), -2),
			(Rational(520_633_381, 204_569_181), 2),
			(Rational(691_162_461, 329_358_089), 2),
			(Rational(-799_789_171, 62_268_509), -13),
			(Rational(-467_307_305, 181_843_133), -3),
			(Rational(-24_297_916, 24_110_109), -2),
			(Rational(-136_087_555, 130_380_053), -2),
			(Rational(-9_332_725, 302_775_297), -1),
			(Rational(489_654_773, 967_490_752), 0),
			(Rational(957_225_629, 571_790_848), 1),
			(Rational(660_247_850, 354_899_421), 1),
			(Rational(160_297_260, 10_320_593), 15),
			(Rational(99_825_139, 206_529_542), 0),
			(Rational(-140_643_520, 171_692_901), -1),
			(Rational(-273_425_197, 186_920_863), -2),
			(Rational(111_928_403, 182_900_142), 0),
			(Rational(24_933_549, 18_432_077), 1),
			(Rational(-983_886_469, 940_191_617), -2),
			(Rational(-514_690_161, 580_045_693), -1),
			(Rational(-208_758_564, 330_728_159), -1),
			(Rational(-34_289_727, 99_579_073), -1),
			(Rational(-577_470_151, 169_175_797), -4),
			(Rational(-865_650_333, 867_941_038), -1),
			(Rational(402_507_858, 597_947_579), 0),
			(Rational(407_535_651, 67_778_710), 6),
			(Rational(139_935_787, 233_329_375), 0),
			(Rational(-265_512_059, 218_875_992), -2),
			(Rational(-154_540_399, 278_286_079), -1),
			(Rational(-573_054_023, 1_858_939), -309),
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
			(Rational(729_617_977, 693_769_749), 2),
			(Rational(-339_024_775, 182_889_463), -1),
			(Rational(12_411_650, 106_110_749), 1),
			(Rational(-827_560_691, 897_956_012), 0),
			(Rational(-303_501_964, 632_597_711), 0),
			(Rational(-830_233_834, 500_270_675), -1),
			(Rational(34_896_560, 286_987_569), 1),
			(Rational(-119_100_887, 235_755_166), 0),
			(Rational(243_543_911, 170_980_704), 2),
			(Rational(14_829_730, 54_773_027), 1),
			(Rational(-153_596_816, 344_582_257), 0),
			(Rational(-584_346_008, 885_824_759), 0),
			(Rational(-493_848_931, 208_670_816), -2),
			(Rational(-496_058_748, 359_875_355), -1),
			(Rational(-222_969_047, 327_542_980), 0),
			(Rational(252_987_227, 322_910_053), 1),
			(Rational(503_259_821, 807_644_164), 1),
			(Rational(754_421_249, 603_955_343), 2),
			(Rational(324_785_885, 959_256_806), 1),
			(Rational(-197_745_787, 560_092_992), 0),
			(Rational(925_661_337, 953_427_218), 1),
			(Rational(-315_328_277, 492_394_227), 0),
			(Rational(182_733_464, 185_857_189), 1),
			(Rational(941_985_331, 416_377_621), 3),
			(Rational(883_223_164, 219_129_445), 5),
			(Rational(-387_891_323, 117_439_292), -3),
			(Rational(-587_599_951, 310_893_015), -1),
			(Rational(-698_682_539, 520_073_241), -1),
			(Rational(89_323_987, 897_263_149), 1),
			(Rational(-926_010_721, 638_375_695), -1),
			(Rational(-268_427_201, 338_654_349), 0),
			(Rational(-136_206_101, 57_950_538), -2),
			(Rational(731_948_243, 131_060_681), 6),
			(Rational(165_267_054, 1_816_423), 91),
			(Rational(-235_628_485, 504_977_661), 0),
			(Rational(128_769_188, 467_474_889), 1),
			(Rational(-234_180_865, 286_771_171), 0),
			(Rational(754_733_195, 120_324_408), 7),
			(Rational(215_697_047, 894_988_024), 1),
			(Rational(432_585_223, 792_919_671), 1),
			(Rational(609_129_947, 744_632_022), 1),
			(Rational(-340_785_853, 469_270_898), 0),
			(Rational(575_614_931, 488_899_062), 2),
			(Rational(248_202_323, 776_675_732), 1),
			(Rational(128_691_445, 978_412_821), 1),
			(Rational(357_026_785, 10_015_297), 36),
			(Rational(-668_219_806, 85_751_045), -7),
			(Rational(26_753_831, 116_792_127), 1),
			(Rational(-72_969_618, 86_104_715), 0),
			(Rational(370_348_661, 960_606_899), 1),
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
			(Rational(-442_953_198, 161_035_891), -3),
			(Rational(145_572_591, 41_904_785), 3),
			(Rational(369_455_244, 450_441_619), 1),
			(Rational(-26_645_233, 313_679_846), 0),
			(Rational(173_235_281, 63_539_958), 3),
			(Rational(99_597_999, 156_872_312), 1),
			(Rational(4_743_518, 21_380_689), 0),
			(Rational(-6_106_153, 630_866_866), 0),
			(Rational(-617_391_735, 918_185_023), -1),
			(Rational(336_502_607, 601_469_461), 1),
			(Rational(-470_618_449, 381_647_498), -1),
			(Rational(59_458_494, 904_283_479), 0),
			(Rational(235_220_648, 192_965_389), 1),
			(Rational(-475_141_877, 486_562_778), -1),
			(Rational(-218_854_626, 982_833_661), 0),
			(Rational(-800_445_193, 407_793_102), -2),
			(Rational(-61_297_445, 699_073_486), 0),
			(Rational(27_887_271, 106_035_878), 0),
			(Rational(817_429_193, 836_401_092), 1),
			(Rational(682_609_737, 247_987_673), 3),
			(Rational(-280_167_719, 487_973_505), -1),
			(Rational(-1_027_342, 956_624_971), 0),
			(Rational(258_627_324, 764_748_691), 0),
			(Rational(-90_979_598, 191_256_335), 0),
			(Rational(412_028_835, 307_263_104), 1),
			(Rational(-74_944_193, 35_136_677), -2),
			(Rational(-319_150_439, 196_247_867), -2),
			(Rational(718_823_359, 943_120_754), 1),
			(Rational(-780_056_835, 648_890_056), -1),
			(Rational(-2_959_814, 3_601_095), -1),
			(Rational(-587_033_904, 467_255_407), -1),
			(Rational(171_766_619, 373_838_817), 0),
			(Rational(68_670_103, 190_183_655), 0),
			(Rational(-526_476_361, 826_488_955), -1),
			(Rational(441_511_037, 337_758_880), 1),
			(Rational(851_181_533, 341_887_973), 2),
			(Rational(-148_560_757, 651_059_711), 0),
			(Rational(-441_058_157, 326_433_226), -1),
			(Rational(-315_480_221, 132_343_142), -2),
			(Rational(835_788_958, 560_272_033), 1),
			(Rational(60_096_671, 4_847_083), 12),
			(Rational(-879_359_583, 726_629_690), -1),
			(Rational(243_361_472, 49_958_187), 5),
			(Rational(498_495_848, 359_144_109), 1),
			(Rational(102_976_308, 110_289_203), 1),
			(Rational(-270_539_401, 228_262_422), -1),
			(Rational(-232_939_621, 791_369_726), 0),
			(Rational(-634_324_370, 945_168_363), -1),
			(Rational(61_419_539, 391_130_885), 0),
			(Rational(-227_065_415, 193_646_176), -1),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.rounded, expected)
		}
	}

	func test_roundAwayFromZero() {
		let testcases = [
			(Rational(262_145_157, 855_776_251), 1),
			(Rational(511_358_916, 557_170_961), 1),
			(Rational(92_969_496, 90_227_555), 2),
			(Rational(-43_185_664, 39_317_189), -2),
			(Rational(-240_713_497, 238_367_712), -2),
			(Rational(591_146_833, 657_580_281), 1),
			(Rational(290_602_188, 43_467_593), 7),
			(Rational(453_350_972, 355_255_185), 2),
			(Rational(-93_951_361, 801828), -118),
			(Rational(524_801_197, 996_990_896), 1),
			(Rational(12_550_443, 16_801_627), 1),
			(Rational(407_782_537, 379_273_747), 2),
			(Rational(-225_345_144, 122_457_433), -2),
			(Rational(-947_835_479, 17_137_154), -56),
			(Rational(-436_220_527, 569_379_639), -1),
			(Rational(-353_461_135, 89_691_766), -4),
			(Rational(-666702, 156_567_307), -1),
			(Rational(-869_265_084, 47_563_579), -19),
			(Rational(-987_442_149, 769_441_060), -2),
		]

		for (rational, expected) in testcases {
			XCTAssertEqual(rational.roundedAwayFromZero, expected)
		}
	}
}
