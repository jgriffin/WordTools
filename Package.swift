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

    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
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
    ]
)
