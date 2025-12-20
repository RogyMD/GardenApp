// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlantTreeFeature",
    platforms:  [
      .iOS(.v18),
    ],
    products: [
        .library(
            name: "PlantTreeFeature",
            targets: ["PlantTreeFeature"]
        ),
    ],
    targets: [
        .target(
            name: "PlantTreeFeature",
            resources: [
              .copy("Localizable.xcstrings"),
            ],
        ),
    ]
)
