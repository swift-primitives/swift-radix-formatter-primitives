// exports.swift
// Re-export test support dependencies for downstream test consumers.
//
// Spine per [MOD-024]: anchors on the lowest in-scope upstream Test Support
// (radix-primitives) and re-exports this package's own product, so consumers
// get the radix-domain fixtures and the Radix.Formatter surface via one import.

@_exported public import Radix_Formatter_Primitives
@_exported public import Radix_Primitives_Test_Support
