// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KindlySDK",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "KindlySDK",
            targets: ["KindlySDK", "KindlySDKWrapper"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/getsentry/sentry-cocoa.git",
            .upToNextMajor(from: "9.0.0")
        ),
    ],
    targets: [
        .binaryTarget(name: "KindlySDK", path: "artifacts/Kindly.xcframework"),
        .target(
            name: "KindlySDKWrapper",
            dependencies: [
                .product(
                    name: "Sentry",
                    package: "sentry-cocoa",
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
