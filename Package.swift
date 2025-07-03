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
            targets: ["KindlySDK"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/daltoniam/Starscream.git", exact: "4.0.6"),
        .package(url: "https://github.com/kirualex/SwiftyGif.git", exact: "5.4.4"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", exact: "5.0.1"),
    ],
    targets: [
        .binaryTarget(name: "KindlySDK", path: "artifacts/Kindly.xcframework"),
        .testTarget(
            name: "KindlySDKTests",
            dependencies: ["KindlySDK"]
        ),
    ]
)
