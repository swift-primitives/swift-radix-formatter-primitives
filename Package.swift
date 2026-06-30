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
            name: "Radix Formatter Primitives",
            targets: ["Radix Formatter Primitives"]
        ),
        .library(
            name: "Radix Formatter Primitives Test Support",
            targets: ["Radix Formatter Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-radix-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-formatter-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Radix Formatter Primitives",
            dependencies: [
                .product(name: "Radix Primitive", package: "swift-radix-primitives"),
                .product(name: "Formatter Protocol", package: "swift-formatter-primitives"),
            ]
        ),
        .target(
            name: "Radix Formatter Primitives Test Support",
            dependencies: [
                "Radix Formatter Primitives",
                .product(name: "Radix Primitives Test Support", package: "swift-radix-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Radix Formatter Primitives Tests",
            dependencies: [
                "Radix Formatter Primitives",
                "Radix Formatter Primitives Test Support",
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
