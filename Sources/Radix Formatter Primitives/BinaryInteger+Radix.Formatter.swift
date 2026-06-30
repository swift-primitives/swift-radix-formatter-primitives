// BinaryInteger+Radix.Formatter.swift

public import Formatter_Protocol
public import Radix_Primitive

extension Swift.BinaryInteger {
    /// Formats this integer using the specified radix format.
    ///
    /// ```swift
    /// 255.formatted(.hex)    // "ff"
    /// 42.formatted(.base2)   // "101010"
    /// 63.formatted(.octal)   // "77"
    /// ```
    ///
    /// - Parameter format: The radix format to apply.
    /// - Returns: The formatted base-N spelling.
    @inlinable
    public func formatted(_ format: Radix.Formatter) -> String {
        format.format(self)
    }

    /// Formats this integer using any formatter whose input is this type.
    ///
    /// This is the generic ``Formatter`` entry point; ``formatted(_:)-(Radix.Formatter)``
    /// is the radix-specific convenience that accepts any `BinaryInteger`
    /// receiver.
    ///
    /// - Parameter format: A formatter accepting `Self` as input.
    /// - Returns: The formatter's output.
    /// - Throws: The formatter's `Failure` if formatting fails.
    @inlinable
    public func formatted<F: Formatter_Protocol.Formatter.`Protocol`>(_ format: F) throws(F.Failure) -> F.Output
    where F.Input == Self {
        try format.format(self)
    }
}
