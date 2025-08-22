// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BibiCamKit",
  platforms: [
    .macOS(.v15),
    .macCatalyst(.v18),
    .iOS(.v18),
    .tvOS(.v18),
    .watchOS(.v11),
    .visionOS(.v2),
  ],
  products: [
    .library(
      name: "BibiCamKit",
      targets: ["BibiCamKit"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/stasel/WebRTC", exact: "139.0.0"),
  ],
  targets: [
    .target(
      name: "BibiCamKit",
      dependencies: [
        "BibiCamUI",
        "SmartDeviceManagement",
      ]
    ),
    .target(name: "HTTPKit"),
    .target(
      name: "SmartDeviceManagement",
      dependencies: ["HTTPKit"]
    ),
    .target(
      name: "BibiCamUI",
      dependencies: [
        "SmartDeviceManagement",
        .product(name: "WebRTC", package: "WebRTC"),
      ]
    ),
    .testTarget(
      name: "BibiCamKitTests",
      dependencies: ["BibiCamKit"]
    ),
  ],
  swiftLanguageModes: [.v6]
)
