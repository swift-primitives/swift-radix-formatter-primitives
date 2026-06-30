// Radix.Formatter+Initialization.swift

public import Radix_Primitive

extension Radix.Formatter {
    /// Creates a base-10 (decimal) format with the given sign and width options.
    ///
    /// ```swift
    /// 42.formatted(Radix.Formatter())                       // "42"
    /// 5.formatted(Radix.Formatter(minWidth: 3))             // "005"
    /// ```
    ///
    /// - Parameters:
    ///   - signStrategy: Whether to show a leading sign. Defaults to
    ///     ``Radix/Formatter/Sign/Display/automatic``.
    ///   - minWidth: The minimum digit width to render, zero-padded on the left,
    ///     or `nil` for no padding. Defaults to `nil`.
    public init(signStrategy: Sign.Display = .automatic, minWidth: Int? = nil) {
        self.init(
            radix: .decimal,
            prefix: "",
            showPrefix: false,
            signStrategy: signStrategy,
            minWidth: minWidth
        )
    }
}
