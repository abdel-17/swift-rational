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

	func test_reciprocal_swaps_signs_for_negative_rationals() throws {
		let rational = Rational(-234, 1253)
		let reciprocal = try XCTUnwrap(rational.reciprocal)

		XCTAssertEqual(reciprocal.numerator, -1253)
		XCTAssertEqual(reciprocal.denominator, 234)
	}

	func test_reciprocal_returns_nil_when_numerator_equals_zero() {
		let rational = Rational(0, 1253)
		XCTAssertNil(rational.reciprocal)
	}

	func test_reciprocal_returns_nil_when_numerator_equals_min() {
		XCTAssertNil(Rational(Int8.min, Int8(123)).reciprocal)
		XCTAssertNil(Rational(Int16.min, Int16(12001)).reciprocal)
		XCTAssertNil(Rational(Int32.min, Int32(2_434_345)).reciprocal)
		XCTAssertNil(Rational(Int.min, 33_948_759_038_475).reciprocal)
	}

	func test_random_divisions() {
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
			(
				Rational(548_536_627, 648_014_973),
				Rational(-940_256_818, 869_687_629),
				Rational(-477_055_518_555_287_383, 609_300_496_529_335_914)
			),
			(
				Rational(-869_926_454, 371_125_019),
				Rational(-865_463_599, 423_656_148),
				Rational(368_549_690_544_939_192, 321_195_194_622_683_381)
			),
			(
				Rational(-367_337_633, 441_969_049),
				Rational(220_617_857, 310_660_016),
				Rational(-114_117_114_945_182_128, 97_506_264_450_707_993)
			),
			(
				Rational(466_140_003, 829_764_218),
				Rational(-774_690_403, 741_694_026),
				Rational(-172_866_627_752_361_039, 321_405_188_218_699_927)
			),
			(
				Rational(8428, 624149), Rational(34_241_437, 206_336_530),
				Rational(1_739_004_274_840, 21_371_758_662_113)
			),
			(
				Rational(-857_461_829, 937_695_956),
				Rational(620_178_449, 905_534_416),
				Rational(-194_115_299_141_451_716, 145_384_705_906_413_061)
			),
			(
				Rational(-110_622_177, 142_808_804),
				Rational(164_404_836, 85_797_049),
				Rational(-1_054_561_815_617_297, 2_608_717_555_664_016)
			),
			(
				Rational(-12_067_930, 344_569_237),
				Rational(602_352_722, 346_417_441),
				Rational(-2_090_270_714_383_565, 103_776_108_912_206_557)
			),
			(
				Rational(-2_710_330, 54_884_099),
				Rational(303_005_197, 334_068_671),
				Rational(-905_436_341_071_430, 16_630_167_229_662_503)
			),
			(
				Rational(24_197_347, 15_055_452),
				Rational(105_853_686, 617_495_179),
				Rational(14_941_745_117_090_113, 1_593_675_088_596_072)
			),
			(
				Rational(-299_307_080, 127_095_499),
				Rational(224_877_329, 318_509_321),
				Rational(-95_332_094_821_292_680, 28_580_896_343_042_171)
			),
			(
				Rational(325_688_653, 362_697_611),
				Rational(-688_844_731, 235_630_646),
				Rational(-76_742_227_701_259_838, 249_842_338_283_637_641)
			),
			(
				Rational(684_949_773, 608_947_495),
				Rational(-480_843_105, 951_807_646),
				Rational(-217_313_477_022_454_786, 97_602_734_759_257_325)
			),
			(
				Rational(107_941_681, 163_870_524),
				Rational(190_830_765, 97_920_124),
				Rational(2_642_415_697_072_111, 7_817_884_363_967_715)
			),
			(
				Rational(514_625_728, 281_436_005),
				Rational(283_925_300, 29_119_587),
				Rational(3_746_422_164_733_584, 19_976_700_537_606_625)
			),
			(
				Rational(190_320_478, 3_773_447),
				Rational(888_527_671, 671_246_892),
				Rational(127_752_029_341_454_376, 3_352_812_074_551_937)
			),
			(
				Rational(-240_591_011, 882_540_702),
				Rational(290_782_863, 158_790_976),
				Rational(-19_101_840_726_758_368, 128_313_856_020_794_913)
			),
			(
				Rational(161_764_557, 72_101_627),
				Rational(-25_978_506, 989_166_149),
				Rational(-53_337_341_297_460_331, 624_364_183_209_754)
			),
			(
				Rational(897_932_405, 873_195_796),
				Rational(-65_054_565, 125_705_218),
				Rational(-11_287_478_871_978_929, 5_680_537_266_860_874)
			),
			(
				Rational(211_044_066, 103_938_103),
				Rational(154_391_334, 720_438_757),
				Rational(25_340_720_763_544_327, 2_674_523_729_266_567)
			),
			(
				Rational(566_626_021, 70_293_394),
				Rational(-393_645_847, 93_311_496),
				Rational(-26_436_360_846_018_708, 13_835_351_309_817_359)
			),
			(
				Rational(-414_183_137, 198_076_660),
				Rational(30_574_596, 17_715_421),
				Rational(-7_337_428_643_055_677, 6_056_113_856_529_360)
			),
			(
				Rational(136_939_151, 57_390_790),
				Rational(-779_377_175, 297_863_943),
				Rational(-40_789_235_467_932_393, 44_729_071_781_218_250)
			),
			(
				Rational(-519_763_819, 597_054_909),
				Rational(-165_174_839, 438_780_363),
				Rational(76_020_719_058_362_099, 32_872_816_156_078_217)
			),
			(
				Rational(-632_361_076, 210_214_219),
				Rational(451_917_501, 20_276_771),
				Rational(-12_822_240_727_365_596, 94_999_484_525_146_719)
			),
		]

		for (f1, f2, result) in testCases {
			XCTAssertEqual(f1 / f2, result)
		}
	}

	func test_random_assign_divisions() {
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
			(
				Rational(-31_127_542, 92_486_669),
				Rational(-460_262_665, 691_499_436),
				Rational(21_524_677_737_066_312, 42_568_160_750_912_885)
			),
			(
				Rational(-67_457_607, 26_394_628),
				Rational(-81_355_278, 181_308_005),
				Rational(4_076_868_049_081_345, 715_780_766_215_528)
			),
			(
				Rational(158_040_763, 218_449_831),
				Rational(276_254_427, 897_918_553),
				Rational(141_907_733_227_975_939, 60_347_732_891_151_837)
			),
			(
				Rational(-810_337_306, 80_783_485),
				Rational(-250_583_187, 743_954_207),
				Rational(602_853_847_887_746_342, 20_242_983_128_266_695)
			),
			(
				Rational(737_746_979, 216_074_842), Rational(31_554_079, 8_903_088),
				Rational(3_284_113_137_885_576, 3_409_021_317_190_259)
			),
			(
				Rational(-149_947_135, 329_327_989),
				Rational(-646_878_233, 358_973_515),
				Rational(53_827_050_115_129_525, 213_035_107_601_763_437)
			),
			(
				Rational(840_726_902, 335_196_765),
				Rational(-486_252_065, 94_806_084),
				Rational(-26_568_675_097_357_256, 54_330_039_720_856_575)
			),
			(
				Rational(152_130_598, 8_954_481), Rational(-42_295_827, 21_809_390),
				Rational(-3_317_875_542_715_220, 378_737_179_250_787)
			),
			(
				Rational(-952_890_731, 329_925_510),
				Rational(-139_610_517, 147_475_685),
				Rational(28_105_642_656_875_147, 9_212_214_204_517_734)
			),
			(
				Rational(-305_449_077, 809_751_842),
				Rational(-163_792_243, 71_765_683),
				Rational(21_920_761_632_624_591, 132_631_070_474_561_606)
			),
			(
				Rational(42_217_492, 17_593_269),
				Rational(-244_850_887, 358_619_061),
				Rational(-5_046_665_779_605_004, 1_435_909_173_293_201)
			),
			(
				Rational(-878_451_558, 931_018_891),
				Rational(27_925_073, 16_817_781),
				Rational(-14_773_605_921_552_798, 25_998_770_495_554_043)
			),
			(
				Rational(-154_755_301, 330_662_360),
				Rational(-188_735_109, 240_451_646),
				Rational(18_605_583_426_337_723, 31_203_798_278_398_620)
			),
			(
				Rational(-842_479_413, 405_167_483),
				Rational(-38_730_587, 179_918_653),
				Rational(151_577_761_167_190_689, 15_692_374_449_902_521)
			),
			(
				Rational(-227_997_858, 120_443_371),
				Rational(-529_286_029, 61_773_062),
				Rational(14_084_125_818_101_196, 63_748_993_555_963_759)
			),
			(
				Rational(-391_784_270, 864_101_027),
				Rational(506_761_888, 991_859_929),
				Rational(-194_297_559_112_758_415, 218_946_733_932_629_488)
			),
			(
				Rational(59_965_670, 327_585_769),
				Rational(100_864_073, 810_812_118),
				Rational(48_620_891_899_989_060, 33_041_634_918_177_137)
			),
			(
				Rational(286_231_943, 444_394_673),
				Rational(752_285_904, 212_097_545),
				Rational(60_709_092_410_879_935, 334_311_848_310_589_392)
			),
			(
				Rational(862_969_487, 973_382_317),
				Rational(-182_019_805, 110_399_832),
				Rational(-95_271_686_385_926_184, 177_174_859_530_788_185)
			),
			(
				Rational(-95_454_357, 66_687_169),
				Rational(504_587_412, 708_610_025),
				Rational(-22_546_638_100_042_975, 11_216_502_006_438_876)
			),
			(
				Rational(-24_098_217, 96_772_528),
				Rational(378_168_864, 172_453_505),
				Rational(-1_385_273_995_300_195, 12_198_785_660_056_064)
			),
			(
				Rational(204_602_204, 329_901_323),
				Rational(-403_479_887, 208_860_804),
				Rational(-42_733_380_827_612_016, 133_108_548_525_190_501)
			),
			(
				Rational(-167_185_393, 764_306_440),
				Rational(-183_435_083, 112_975_790),
				Rational(1_888_790_185_063_547, 14_020_061_525_883_452)
			),
			(
				Rational(67_721_832, 45_562_133),
				Rational(444_441_349, 203_231_563),
				Rational(13_763_213_766_583_416, 20_249_695_853_837_417)
			),
			(
				Rational(-917_633_427, 692_556_211),
				Rational(522_619_310, 59_388_869),
				Rational(-54_497_211_386_124_063, 361_943_249_129_034_410)
			),
		]

		for (f1, f2, result) in testCases {
			var f1 = f1
			f1 /= f2
			XCTAssertEqual(f1, result)
		}
	}
}
