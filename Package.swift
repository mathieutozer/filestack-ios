// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Filestack",
    platforms: [
      .iOS(.v11),
      .macOS(.v13)
    ],
    products: [
        .library(
            name: "Filestack",
            targets: ["Filestack"]
        ),
    ],
    dependencies: [
///        .package(name: "FilestackSDK", url: "https://github.com/filestack/filestack-swift", .upToNextMajor(from: Version(2, 7, 0))),
      .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.0"),
      .package(path: "../filestack-swift"),
//      .package(url: "https://github.com/mathieutozer/filestack-swift", branch: "master"),
//      .package(name: "FilestackSDK", path: "../filestack-swift"),
    ],
    targets: [
        .target(
            name: "Filestack",
            dependencies: [
              .product(name: "FilestackSDK", package: "filestack-swift"),
              "ZIPFoundation"
            ],
            exclude: ["Filestack.h", "Info.plist"],
            resources: [
                .copy("VERSION")
            ]
        )
    ]
)
