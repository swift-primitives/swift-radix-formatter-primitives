# ``Radix_Formatter_Primitives``

@Metadata {
    @DisplayName("Radix Formatter Primitives")
    @TitleHeading("Swift Primitives")
}

Integer-to-string formatting in any radix — spells a `BinaryInteger` in decimal,
hexadecimal, octal, or binary (`255` as `"ff"`, `"0xff"`, or `"11111111"`).

## Overview

This package renders a `BinaryInteger` as a base-N string. The formatter
(``Radix/Formatter``) composes the ``Radix`` model — which owns the base and its
digit alphabet — with the `Formatter.Protocol` capability layer, so a
hexadecimal formatter and a Base16 encoder can share one definition of the hex
alphabet. An optional base prefix (`"0x"`, `"0o"`, `"0b"`), sign strategy, and
left zero-padding are applied by chaining, and every spelling is reached through
the uniform `value.formatted(_:)` entry point.

It conforms to the same `Formatter.Protocol` as every other style in the
ecosystem. Foundation-free.

## Topics

### Formatting an Integer in a Radix

- ``Radix/Formatter``
