// Radix.Formatter.swift

public import Radix_Primitive

extension Radix {
    /// A formatter that renders an integer in this radix's base.
    ///
    /// `Radix.Formatter` is the integer → base-N string formatter: it spells a
    /// `BinaryInteger` in decimal, hexadecimal, octal, or binary, with optional
    /// base prefix, sign strategy, and zero-padding. It composes the ``Radix``
    /// model (which owns the base and its digit alphabet) with the
    /// ``Formatter`` capability layer.
    ///
    /// Apply a format through the ``Swift/BinaryInteger/formatted(_:)-(Radix.Formatter)``
    /// entry point and configure it by chaining:
    ///
    /// ```swift
    /// 255.formatted(.hex)                          // "ff"
    /// 255.formatted(.hex.prefix)                   // "0xff"
    /// 42.formatted(.base2)                         // "101010"
    /// 42.formatted(.bits)                          // "101010" (alias)
    /// 63.formatted(.octal)                         // "77"
    /// 42.formatted(.decimal.sign(.always))         // "+42"
    /// 5.formatted(.decimal.zeroPadded(width: 3))   // "005"
    /// ```
    public struct Formatter {
        /// The radix model whose base and digit alphabet spell each digit.
        @usableFromInline
        let radix: Radix

        /// The glyphs emitted before the digits when ``showPrefix`` is set
        /// (`"0x"` for hexadecimal, `"0o"` for octal, `"0b"` for binary).
        @usableFromInline
        let prefixString: String

        /// Whether the radix ``prefixString`` is emitted before the digits.
        @usableFromInline
        let showPrefix: Bool

        /// The strategy governing whether a leading sign is shown for the
        /// formatted value.
        public let signStrategy: Sign.Display

        /// The minimum digit width to render, zero-padded on the left, or `nil`
        /// for no padding.
        public let minWidth: Int?

        /// Creates a format from a radix model and its presentation options.
        ///
        /// This is the canonical storage initializer used by the standard
        /// formats and the chaining methods.
        @usableFromInline
        init(
            radix: Radix,
            prefix: String,
            showPrefix: Bool = false,
            signStrategy: Sign.Display = .automatic,
            minWidth: Int? = nil
        ) {
            self.radix = radix
            self.prefixString = prefix
            self.showPrefix = showPrefix
            self.signStrategy = signStrategy
            self.minWidth = minWidth
        }
    }
}

extension Radix.Formatter: Sendable {}
