// Radix.Formatter.Sign.Display+Standard.swift

public import Radix_Primitive

extension Radix.Formatter.Sign.Display {
    /// Whether a leading `+` is shown for non-negative values.
    @usableFromInline
    var shouldAlwaysShowSign: Bool {
        _shouldAlwaysShowSign()
    }
}

extension Radix.Formatter.Sign.Display {
    /// Displays a minus sign for negatives only; no sign for non-negatives.
    @inlinable
    public static var automatic: Self {
        .init { false }
    }

    /// Shows a sign for all numbers: plus for non-negatives, minus for negatives.
    @inlinable
    public static var always: Self {
        .init { true }
    }
}
