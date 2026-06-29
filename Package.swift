// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-radix-formatter-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Radix Format Primitives",
            targets: ["Radix Format Primitives"]
        ),
        .library(
            name: "Radix Format Primitives Test Support",
            targets: ["Radix Format Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-radix-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-formatter-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Radix Format Primitives",
            dependencies: [
                .product(name: "Radix Primitive", package: "swift-radix-primitives"),
                .product(name: "Formatter Protocol", package: "swift-formatter-primitives"),
            ]
        ),
        .target(
            name: "Radix Format Primitives Test Support",
            dependencies: [
                "Radix Format Primitives",
                .product(name: "Radix Primitives Test Support", package: "swift-radix-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Radix Format Primitives Tests",
            dependencies: [
                "Radix Format Primitives",
                "Radix Format Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
