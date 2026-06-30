// Radix.Formatter.Sign.Display.swift

public import Radix_Primitive

extension Radix.Formatter.Sign {
    /// Strategy controlling sign display for formatted integers.
    ///
    /// Determines whether to show a plus sign for non-negative numbers, or only
    /// a minus sign for negatives.
    ///
    /// ```swift
    /// 42.formatted(.decimal.sign(.always))     // "+42"
    /// (-5).formatted(.decimal.sign(.always))   // "-5"
    /// ```
    public struct Display {
        @usableFromInline
        let _shouldAlwaysShowSign: @Sendable () -> Bool

        @usableFromInline
        init(shouldAlwaysShowSign: @escaping @Sendable () -> Bool) {
            self._shouldAlwaysShowSign = shouldAlwaysShowSign
        }
    }
}

extension Radix.Formatter.Sign.Display: Sendable {}
