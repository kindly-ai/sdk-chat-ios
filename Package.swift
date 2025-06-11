// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KindlySDK",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "KindlySDK",
            targets: ["KindlySDK", "KindlySDKWrapper"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/daltoniam/Starscream.git",
            .upToNextMajor(from: "4.0.8")
        ),
        .package(
            url: "https://github.com/kirualex/SwiftyGif.git",
            .upToNextMajor(from: "5.4.4")
        ),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            .upToNextMajor(from: "5.0.2")
        ),
    ],
    targets: [
        .binaryTarget(name: "KindlySDK", path: "artifacts/Kindly.xcframework"),
        .target(
            name: "KindlySDKWrapper",
            dependencies: [
                .product(
                    name: "Starscream",
                    package: "Starscream",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "SwiftyGif",
                    package: "SwiftyGif",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "SwiftyJSON",
                    package: "SwiftyJSON",
                    condition: .when(platforms: [.iOS])
                ),
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "KindlySDKTests",
            dependencies: ["KindlySDK"]
        ),
    ]
)
