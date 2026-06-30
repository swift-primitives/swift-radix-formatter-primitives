// Radix.Formatter+Standard.swift

public import Radix_Primitive

extension Radix.Formatter {
    /// Decimal format (base 10) for integers.
    @inlinable
    public static var decimal: Self {
        .init(radix: .decimal, prefix: "")
    }

    /// Alias for ``decimal``.
    @inlinable
    public static var number: Self { .decimal }

    /// Base-2 (binary) format for integers.
    ///
    /// ```swift
    /// 42.formatted(.base2)         // "101010"
    /// 42.formatted(.base2.prefix)  // "0b101010"
    /// ```
    @inlinable
    public static var base2: Self {
        .init(radix: .binary, prefix: "0b")
    }

    /// Alias for ``base2``.
    ///
    /// ```swift
    /// 255.formatted(.bits)  // "11111111"
    /// ```
    @inlinable
    public static var bits: Self { .base2 }

    /// Octal format (base 8) for integers.
    ///
    /// ```swift
    /// 63.formatted(.octal)         // "77"
    /// 63.formatted(.octal.prefix)  // "0o77"
    /// ```
    @inlinable
    public static var octal: Self {
        .init(radix: .octal, prefix: "0o")
    }

    /// Hexadecimal format (base 16) for integers.
    ///
    /// The hexadecimal alphabet is lower-case `0`–`9` then `a`–`f`, matching the
    /// ``Radix/hexadecimal`` model.
    ///
    /// ```swift
    /// 255.formatted(.hex)         // "ff"
    /// 255.formatted(.hex.prefix)  // "0xff"
    /// ```
    @inlinable
    public static var hex: Self {
        .init(radix: .hexadecimal, prefix: "0x")
    }
}
