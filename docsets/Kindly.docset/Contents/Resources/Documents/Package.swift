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
            targets: ["KindlySDK", "KindlySDKWrapper"]),
    ],
	dependencies: [
		.package(
			url: "https://github.com/daltoniam/Starscream.git",
			exact: "4.0.6"
		),
		.package(
			url: "https://github.com/kirualex/SwiftyGif.git",
			exact: "5.4.4"
		),
		.package(
			url: "https://github.com/SnapKit/SnapKit.git",
			exact: "5.7.0"
		),
		.package(
			url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
			exact: "5.0.1"
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
