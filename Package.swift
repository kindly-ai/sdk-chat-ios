// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KindlySDK",
	platforms: [
		.iOS(.v12),
	],
    products: [
        .library(
            name: "KindlySDK",
            targets: ["KindlySDK"]),
    ],
	dependencies: [
		.package(
			url: "https://github.com/daltoniam/Starscream.git",
			exact: "4.0.6"
		),
		.package(
			url: "https://github.com/kirualex/SwiftyGif.git",
			exact: "5.4.3"
		),
		.package(
			url: "https://github.com/SnapKit/SnapKit.git",
			exact: "5.6.0"
		),
		.package(
			url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
			exact: "5.0.1"
		),
	],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
		.binaryTarget(name: "KindlySDK", path: "artifacts/KindlySDK.xcframework"),
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
					name: "SnapKit",
					package: "SnapKit",
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
            dependencies: ["KindlySDK"]),
    ]
)