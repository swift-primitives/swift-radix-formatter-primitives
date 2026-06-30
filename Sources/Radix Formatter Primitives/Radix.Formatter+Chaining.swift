// Radix.Formatter+Chaining.swift

public import Radix_Primitive

extension Radix.Formatter {
    /// Returns a format that emits the radix prefix before the digits.
    ///
    /// ```swift
    /// 255.formatted(.hex.prefix)   // "0xff"
    /// 42.formatted(.base2.prefix)  // "0b101010"
    /// ```
    @inlinable
    public var prefix: Self {
        .init(
            radix: radix,
            prefix: prefixString,
            showPrefix: true,
            signStrategy: signStrategy,
            minWidth: minWidth
        )
    }

    /// Returns a format with the specified sign display strategy.
    ///
    /// ```swift
    /// 42.formatted(.decimal.sign(.always))     // "+42"
    /// (-42).formatted(.decimal.sign(.always))  // "-42"
    /// ```
    ///
    /// - Parameter strategy: The sign display strategy to apply.
    /// - Returns: A copy of this format with the given sign display strategy.
    @inlinable
    public func sign(_ strategy: Sign.Display) -> Self {
        .init(
            radix: radix,
            prefix: prefixString,
            showPrefix: showPrefix,
            signStrategy: strategy,
            minWidth: minWidth
        )
    }

    /// Returns a format that pads with leading zeros to the specified width.
    ///
    /// ```swift
    /// 5.formatted(.decimal.zeroPadded(width: 2))   // "05"
    /// 42.formatted(.decimal.zeroPadded(width: 4))  // "0042"
    /// ```
    ///
    /// - Parameter width: The minimum digit width; values shorter than `width`
    ///   are padded on the left with `0`. Values already at least `width` digits
    ///   wide are not truncated.
    /// - Returns: A copy of this format padded with leading zeros to at least
    ///   `width` digits.
    @inlinable
    public func zeroPadded(width: Int) -> Self {
        .init(
            radix: radix,
            prefix: prefixString,
            showPrefix: showPrefix,
            signStrategy: signStrategy,
            minWidth: width
        )
    }
}
