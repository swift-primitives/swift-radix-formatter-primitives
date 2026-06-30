// Radix.Formatter+Formatting.swift

public import Radix_Primitive

extension Radix.Formatter {
    /// Converts the integer to a string using this format's configuration.
    ///
    /// Works with every `BinaryInteger` type — `Int`, `UInt`, `Int8`, `UInt16`,
    /// and the rest. This is the generic workhorse the
    /// ``Swift/BinaryInteger/formatted(_:)-(Radix.Formatter)`` entry point calls.
    ///
    /// - Parameter value: The integer to format.
    /// - Returns: The formatted base-N spelling.
    @inlinable
    public func format<T: Swift.BinaryInteger>(_ value: T) -> String {
        render(value)
    }
}

extension Radix.Formatter {
    /// The digit-by-digit rendering shared by the generic ``format(_:)`` and the
    /// ``Formatter`` protocol witness.
    ///
    /// Digits are produced through the ``Radix`` model's ``Radix/digit(for:)``
    /// over ``Radix/base`` — so the alphabet (lower-case `a`–`f` for
    /// hexadecimal, `0`–`9` for the numeral bases) is the model's, not the
    /// standard library's. Padding is applied first, then the prefix, then the
    /// sign — matching the documented configuration order.
    @usableFromInline
    func render<T: Swift.BinaryInteger>(_ value: T) -> String {
        let base = T.Magnitude(radix.base)
        var magnitude = value.magnitude

        var scalars: [Unicode.Scalar] = []
        if magnitude == 0 {
            scalars.append(radix.digit(for: 0) ?? "0")
        } else {
            while magnitude > 0 {
                let remainder = Int(magnitude % base)
                scalars.append(radix.digit(for: remainder) ?? "0")
                magnitude /= base
            }
            scalars.reverse()
        }

        var result = String(String.UnicodeScalarView(scalars))

        // Apply zero-padding if minWidth is specified.
        if let minWidth {
            let padding = max(0, minWidth - result.count)
            result = String(repeating: "0", count: padding) + result
        }

        // Apply prefix if enabled.
        if showPrefix {
            result = prefixString + result
        }

        // Handle sign.
        if value < 0 {
            result = "-" + result
        } else if signStrategy.shouldAlwaysShowSign {
            result = "+" + result
        }

        return result
    }
}
