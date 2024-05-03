// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LTKAnalytics-iOS",
    platforms: [
        .macOS(
            .v14
        ),
        .iOS(
            .v16
        ),
        .tvOS(
            .v16
        ),
        .watchOS(
            .v9
        ),
        .visionOS(
            .v1
        )
    ],
    products: [
        .library(
            name: "LTKAnalytics",
            targets: ["LTKAnalytics"]
        ),
    ],
    targets: [
        .target(
            name: "LTKAnalytics"
        ),
        .testTarget(
            name: "LTKAnalyticsTests",
            dependencies: ["LTKAnalytics"]
        ),
    ]
)
