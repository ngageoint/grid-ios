// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Grid",
    platforms: [.macOS(.v11), .iOS(.v13), .watchOS(.v10)],
    products: [
        .library(
            name: "Grid",
            targets: ["Grid"])
    ],
    dependencies: [
        .package(url: "https://github.com/ngageoint/simple-features-ios", from: "5.0.0"),
        .package(url: "https://github.com/ngageoint/color-ios", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "Grid",
            dependencies: [
                .product(name: "SimpleFeatures", package: "simple-features-ios"),
                .product(name: "Color", package: "color-ios")
            ],
            path: "grid-ios"
        ),
        .testTarget(
            name: "GridTests",
            dependencies: [
                "Grid"
            ],
            path: "grid-iosTests"
        )
    ]
)
