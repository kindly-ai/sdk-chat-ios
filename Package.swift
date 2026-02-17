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
        // COMMENTED OUT 2026-02-12: These dependencies are already statically linked inside Kindly.xcframework
        // Declaring them here causes duplicate class warnings at runtime (reported by customer Posten)
        // If you need to restore: uncomment these and rebuild xcframework WITHOUT static linking
        // See ios-source/AGENTS.md "Dependency Architecture" section for details
        /*
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
        */
    ],
    targets: [
        .binaryTarget(name: "KindlySDK", path: "artifacts/Kindly.xcframework"),
        .target(
            name: "KindlySDKWrapper",
            dependencies: [
                // COMMENTED OUT 2026-02-12: KindlySDKWrapper doesn't use these - they're in the binary
                /*
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
                */
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "KindlySDKTests",
            dependencies: ["KindlySDK"]
        ),
    ]
)
