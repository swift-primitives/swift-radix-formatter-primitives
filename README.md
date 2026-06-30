# Radix Formatter Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Integer-to-string formatting in any radix for Swift — `Radix.Formatter` spells any `BinaryInteger` in decimal, hexadecimal, octal, or binary, with optional base prefix, sign strategy, and zero-padding, through one uniform `value.formatted(_:)` entry point. Foundation-free, with zero platform dependencies.

---

## Quick Start

`Radix.Formatter` renders a `BinaryInteger` as a base-N string. It composes the [`Radix`](https://github.com/swift-primitives/swift-radix-primitives) model — which owns the base and its digit alphabet — with the [`Formatter`](https://github.com/swift-primitives/swift-formatter-primitives) capability layer, reached through `value.formatted(_:)`. No `String(_:radix:)` boilerplate, no formatter objects to allocate.

```swift
import Radix_Formatter_Primitives

// Radix spellings: decimal / hex / octal / bits, with optional prefix and padding.
255.formatted(.hex)                         // "ff"
255.formatted(.hex.prefix)                  // "0xff"
42.formatted(.base2)                        // "101010"
42.formatted(.bits)                         // "101010" (alias)
63.formatted(.octal)                        // "77"
42.formatted(.decimal.sign(.always))        // "+42"
5.formatted(.decimal.zeroPadded(width: 3))  // "005"
```

Every format works with any `BinaryInteger` — `Int`, `UInt8`, `Int64`, and the rest:

```swift
UInt16(0x1301).formatted(.hex.zeroPadded(width: 4).prefix)  // "0x1301"
UInt8(0xFF).formatted(.hex.zeroPadded(width: 2))            // "ff"
9.formatted(.decimal.zeroPadded(width: 2))                  // "09"
```

Padding, prefix, and sign compose in a fixed order — width first, then the base prefix, then the sign — so `Radix.Formatter.hex.zeroPadded(width: 4).prefix` renders `5` as `"0x0005"`. Keeping the digit alphabet in `Radix` and the rendering algorithm here lets a hexadecimal formatter and a Base16 encoder share one definition of the hex alphabet, each independently testable.

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
        .product(name: "Radix Formatter Primitives", package: "swift-radix-formatter-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

One library product plus a Test Support target, composed over the radix model and the formatter capability — and nothing else.

| Product | Target | Purpose |
|---------|--------|---------|
| `Radix Formatter Primitives` | `Sources/Radix Formatter Primitives/` | The `Radix.Formatter` formatter — decimal / hex / octal / binary spellings with prefix, sign, and zero-padding, applied through `BinaryInteger.formatted(_:)`. Conforms to `Formatter.Protocol` with `Int` input and `String` output. |
| `Radix Formatter Primitives Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Built on `Radix Primitive` (for the base and its digit alphabet) and `Formatter Protocol` (for the `Formatter.Protocol` capability). Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
