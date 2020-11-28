// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WordTools",
    products: [
        .library(
            name: "WordTools",
            targets: ["WordTools"]
        ),
        .library(
            name: "Cryptograms",
            targets: ["Cryptograms"]
        ),
        .library(
            name: "WordSearch",
            targets: ["WordSearch"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "0.0.2"),
    ],
    targets: [
        .target(
            name: "WordTools",
            dependencies: [],
            resources: [
                .process("resources"),
            ]
        ),
        .testTarget(
            name: "WordToolsTests",
            dependencies: ["WordTools"]
        ),
        .target(
            name: "Cryptograms",
            dependencies: ["WordTools"]
        ),
        .testTarget(
            name: "CryptogramsTests",
            dependencies: ["Cryptograms"]
        ),
        .target(
            name: "WordSearch",
            dependencies: [
                "WordTools",
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
        .testTarget(
            name: "WordSearchTests",
            dependencies: ["WordSearch"]
        ),
    ]
)
