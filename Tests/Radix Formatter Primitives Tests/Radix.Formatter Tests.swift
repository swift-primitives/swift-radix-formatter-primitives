// Radix.Formatter Tests.swift

import Radix_Formatter_Primitives_Test_Support
import Testing

// MARK: - Test Suite Structure

extension Radix.Formatter {
    @Suite struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
    }
}

// MARK: - Base-2 Formatting

extension Radix.Formatter.Test.Unit {
    @Test
    func `base2 formatting without prefix`() {
        #expect(5.formatted(Radix.Formatter.base2) == "101")
        #expect(0.formatted(Radix.Formatter.base2) == "0")
        #expect(42.formatted(Radix.Formatter.base2) == "101010")
        #expect(UInt8(255).formatted(Radix.Formatter.base2) == "11111111")
    }

    @Test
    func `base2 formatting with prefix`() {
        #expect(5.formatted(Radix.Formatter.base2.prefix) == "0b101")
        #expect(0.formatted(Radix.Formatter.base2.prefix) == "0b0")
        #expect(42.formatted(Radix.Formatter.base2.prefix) == "0b101010")
        #expect(UInt8(255).formatted(Radix.Formatter.base2.prefix) == "0b11111111")
    }

    @Test
    func `bits alias`() {
        #expect(5.formatted(Radix.Formatter.bits) == "101")
        #expect(255.formatted(Radix.Formatter.bits) == "11111111")
    }

    @Test
    func `base2 with sign strategy`() {
        #expect(5.formatted(Radix.Formatter.base2.prefix.sign(.always)) == "+0b101")
        #expect((-5).formatted(Radix.Formatter.base2.prefix.sign(.always)) == "-0b101")
    }
}

// MARK: - Octal Formatting

extension Radix.Formatter.Test.Unit {
    @Test
    func `octal formatting without prefix`() {
        #expect(8.formatted(Radix.Formatter.octal) == "10")
        #expect(0.formatted(Radix.Formatter.octal) == "0")
        #expect(64.formatted(Radix.Formatter.octal) == "100")
        #expect(UInt8(255).formatted(Radix.Formatter.octal) == "377")
    }

    @Test
    func `octal formatting with prefix`() {
        #expect(8.formatted(Radix.Formatter.octal.prefix) == "0o10")
        #expect(0.formatted(Radix.Formatter.octal.prefix) == "0o0")
        #expect(64.formatted(Radix.Formatter.octal.prefix) == "0o100")
        #expect(UInt8(255).formatted(Radix.Formatter.octal.prefix) == "0o377")
    }

    @Test
    func `octal with sign strategy`() {
        #expect(8.formatted(Radix.Formatter.octal.prefix.sign(.always)) == "+0o10")
        #expect((-8).formatted(Radix.Formatter.octal.prefix.sign(.always)) == "-0o10")
    }
}

// MARK: - Hexadecimal Formatting

extension Radix.Formatter.Test.Unit {
    @Test
    func `hex formatting without prefix`() {
        #expect(255.formatted(Radix.Formatter.hex) == "ff")
        #expect(0.formatted(Radix.Formatter.hex) == "0")
        #expect(16.formatted(Radix.Formatter.hex) == "10")
        #expect(UInt8(255).formatted(Radix.Formatter.hex) == "ff")
    }

    @Test
    func `hex formatting with prefix`() {
        #expect(255.formatted(Radix.Formatter.hex.prefix) == "0xff")
        #expect(0.formatted(Radix.Formatter.hex.prefix) == "0x0")
        #expect(16.formatted(Radix.Formatter.hex.prefix) == "0x10")
    }

    @Test
    func `hex uses lowercase alphabet`() {
        #expect(0xABCDEF.formatted(Radix.Formatter.hex) == "abcdef")
        #expect(UInt8(0xAB).formatted(Radix.Formatter.hex) == "ab")
    }
}

// MARK: - Decimal Formatting

extension Radix.Formatter.Test.Unit {
    @Test
    func `decimal formatting`() {
        #expect(42.formatted(Radix.Formatter.decimal) == "42")
        #expect(0.formatted(Radix.Formatter.decimal) == "0")
        #expect((-42).formatted(Radix.Formatter.decimal) == "-42")
    }

    @Test
    func `decimal with sign strategy`() {
        #expect(42.formatted(Radix.Formatter.decimal.sign(.always)) == "+42")
        #expect((-42).formatted(Radix.Formatter.decimal.sign(.always)) == "-42")
        #expect(0.formatted(Radix.Formatter.decimal.sign(.always)) == "+0")
    }

    @Test
    func `decimal with zero padding`() {
        #expect(5.formatted(Radix.Formatter.decimal.zeroPadded(width: 3)) == "005")
        #expect(42.formatted(Radix.Formatter.decimal.zeroPadded(width: 4)) == "0042")
        // No truncation when value already wider than the requested width.
        #expect(123.formatted(Radix.Formatter.decimal.zeroPadded(width: 2)) == "123")
    }

    @Test
    func `number alias`() {
        #expect(42.formatted(Radix.Formatter.number) == "42")
    }

    @Test
    func `default initializer is decimal`() {
        #expect(42.formatted(Radix.Formatter()) == "42")
        #expect(5.formatted(Radix.Formatter(minWidth: 3)) == "005")
        #expect(42.formatted(Radix.Formatter(signStrategy: .always)) == "+42")
    }
}

// MARK: - Edge Cases

extension Radix.Formatter.Test.`Edge Case` {
    @Test
    func `negative values across radixes`() {
        #expect((-255).formatted(Radix.Formatter.hex) == "-ff")
        #expect((-255).formatted(Radix.Formatter.hex.prefix) == "-0xff")
        #expect((-42).formatted(Radix.Formatter.base2) == "-101010")
        #expect((-8).formatted(Radix.Formatter.octal) == "-10")
    }

    @Test
    func `zero padding combines with prefix and sign`() {
        #expect(5.formatted(Radix.Formatter.hex.zeroPadded(width: 4).prefix) == "0x0005")
        #expect(5.formatted(Radix.Formatter.decimal.zeroPadded(width: 3).sign(.always)) == "+005")
        #expect((-5).formatted(Radix.Formatter.decimal.zeroPadded(width: 3)) == "-005")
    }

    @Test
    func `wide integer types`() {
        #expect(Int64.max.formatted(Radix.Formatter.hex) == "7fffffffffffffff")
        #expect(UInt64.max.formatted(Radix.Formatter.hex) == "ffffffffffffffff")
        #expect(UInt32(0xDEAD_BEEF).formatted(Radix.Formatter.hex.prefix) == "0xdeadbeef")
    }

    @Test
    func `zero is never sign-suppressed under automatic`() {
        #expect(0.formatted(Radix.Formatter.decimal) == "0")
        #expect(0.formatted(Radix.Formatter.hex.prefix) == "0x0")
    }
}

// MARK: - Integration — RFC consumer parity

extension Radix.Formatter.Test.Integration {
    /// The exact outputs the three migrating RFC call sites
    /// (rfc-5322, rfc-8446, rfc-6455) currently obtain from
    /// `Binary.Format.Radix`.
    ///
    /// These MUST be byte-identical.
    @Test
    func `rfc consumer call sites are byte identical`() {
        #expect(9.formatted(Radix.Formatter.decimal.zeroPadded(width: 2)) == "09")
        #expect(2026.formatted(Radix.Formatter.decimal.zeroPadded(width: 4)) == "2026")
        #expect(UInt16(0x1301).formatted(Radix.Formatter.hex.zeroPadded(width: 4).prefix) == "0x1301")
        #expect(UInt8(0xFF).formatted(Radix.Formatter.hex.zeroPadded(width: 2)) == "ff")
    }

    @Test
    func `formatter protocol conformance`() {
        let format = Radix.Formatter.hex
        // Concrete Formatter.`Protocol` witness (Int input).
        #expect(format.format(255) == "ff")
        // Generic format<T> workhorse over any BinaryInteger.
        #expect(format.format(UInt8(255)) == "ff")
        // Exercised through a generic constraint on Formatter.`Protocol`.
        #expect(rendered(255, with: format) == "ff")
    }
}

/// Exercises the ``Formatter/Protocol`` conformance through a generic constraint.
private func rendered<F: Formatter.`Protocol`>(_ value: F.Input, with formatter: F) -> F.Output
where F.Failure == Never {
    formatter.format(value)
}
