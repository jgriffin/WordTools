// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "WordTools",
    platforms: [
        .macOS(.v13), .iOS(.v17),
    ],
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
        .library(
            name: "WordLists",
            targets: ["WordLists"]
        ),

    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "WordTools",
            dependencies: [
                "WordLists",
                .product(name: "Algorithms", package: "swift-algorithms"),
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
                "WordLists",
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
        .target(
            name: "WordLists",
            resources: [
                .process("resources"),
            ]
        ),
        .testTarget(
            name: "WordSearchTests",
            dependencies: ["WordSearch"]
        ),
    ]
)
