// Radix.Formatter+Formatter.Protocol.swift

public import Formatter_Protocol
public import Radix_Primitive

extension Radix.Formatter: Formatter_Protocol.Formatter.`Protocol` {
    /// The representative integer input type for the formatter capability.
    ///
    /// `Radix.Formatter` formats every `BinaryInteger` via the generic
    /// ``format(_:)`` workhorse and the
    /// ``Swift/BinaryInteger/formatted(_:)-(Radix.Formatter)`` entry point; the
    /// ``Formatter`` protocol requires one concrete `Input`, for which `Int` is
    /// the canonical representative.
    public typealias Input = Int

    /// Formatted output is always a `String`.
    public typealias Output = String

    /// Formatting an integer in a known base never fails.
    public typealias Failure = Never

    /// Formats an `Int` using this format's configuration.
    ///
    /// Satisfies ``Formatter/Protocol`` by delegating to the generic
    /// ``format(_:)`` rendering.
    @inlinable
    public func format(_ value: Int) -> String {
        render(value)
    }
}
