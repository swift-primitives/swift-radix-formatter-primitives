// exports.swift
// Re-exports the upstream namespaces this package builds on, so a consumer
// importing `Radix_Formatter_Primitives` sees `Radix` (and therefore
// `Radix.Formatter`) and the `Formatter` capability namespace via a single
// import.

@_exported public import Formatter_Protocol
@_exported public import Radix_Primitive
