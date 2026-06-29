# Radix Format Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Integer → base-N string formatting — `Radix.Format` spells any `BinaryInteger` in decimal, hexadecimal, octal, or binary, with optional base prefix, sign strategy, and zero-padding, applied through one uniform `value.formatted(_:)` entry point.

It composes two primitives: the [`Radix`](https://github.com/swift-primitives/swift-radix-primitives) model (which owns the base and its digit alphabet) and the [`Formatter`](https://github.com/swift-primitives/swift-formatter-primitives) capability layer. No Foundation, no `String(_:radix:)` boilerplate, no formatter objects to allocate.

---

## Quick Start

```swift
import Radix_Format_Primitives

// Radix spellings: decimal / hex / octal / bits, with optional prefix and padding.
255.formatted(Radix.Format.hex)                         // "ff"
255.formatted(Radix.Format.hex.prefix)                  // "0xff"
42.formatted(Radix.Format.base2)                        // "101010"
42.formatted(Radix.Format.bits)                         // "101010" (alias)
63.formatted(Radix.Format.octal)                        // "77"
42.formatted(Radix.Format.decimal.sign(.always))        // "+42"
5.formatted(Radix.Format.decimal.zeroPadded(width: 3))  // "005"
```

Every format works with any `BinaryInteger` — `Int`, `UInt8`, `Int64`, and the rest:

```swift
UInt16(0x1301).formatted(Radix.Format.hex.zeroPadded(width: 4).prefix)  // "0x1301"
UInt8(0xFF).formatted(Radix.Format.hex.zeroPadded(width: 2))            // "ff"
9.formatted(Radix.Format.decimal.zeroPadded(width: 2))                  // "09"
```

### Why a separate formatter

A radix is two things — a base and a digit alphabet — and rendering a whole integer needs both *plus* a division-and-remainder algorithm. The [`Radix`](https://github.com/swift-primitives/swift-radix-primitives) model owns the alphabet; `Radix.Format` owns the algorithm and the presentation options. Keeping them apart lets a hex formatter and a Base16 encoder share one definition of the hexadecimal alphabet, and keeps each piece independently testable.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-radix-formatter-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Radix Format Primitives", package: "swift-radix-formatter-primitives"),
    ]
)
```

The package is pre-1.0 — until 0.1.0 is tagged, depend on `branch: "main"` rather than `from: "0.1.0"`. Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

One library product plus a Test Support target. Composes over [swift-radix-primitives](https://github.com/swift-primitives/swift-radix-primitives) and [swift-formatter-primitives](https://github.com/swift-primitives/swift-formatter-primitives) — and nothing else.

| Product | Target | Purpose |
|---------|--------|---------|
| `Radix Format Primitives` | `Sources/Radix Format Primitives/` | The `Radix.Format` formatter: decimal / hex / octal / binary spellings with prefix, sign, and zero-padding, applied through `BinaryInteger.formatted(_:)`. Conforms to `Formatter.Protocol` with `Int` input, `String` output. |
| `Radix Format Primitives Test Support` | `Tests/Support/` | Re-exports the main target (with radix-primitives test support) for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26+ | ✅ |
| iOS 26+ | ✅ |
| tvOS 26+ | ✅ |
| watchOS 26+ | ✅ |
| visionOS 26+ | ✅ |
| Linux (Swift 6.3+) | ✅ |
| Windows (Swift 6.3+) | ✅ |

---

## Related Packages

- [`swift-radix-primitives`](https://github.com/swift-primitives/swift-radix-primitives) — the `Radix` model (base + digit alphabet) this formatter renders with.
- [`swift-formatter-primitives`](https://github.com/swift-primitives/swift-formatter-primitives) — the `Formatter` capability layer `Radix.Format` conforms to.

---

## Community

<!-- BEGIN: discussion -->
<!-- END: discussion -->

## License

Apache License 2.0 — see [LICENSE.md](LICENSE.md).
