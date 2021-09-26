// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Server",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "Server", targets: ["Server"]),
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alchemy-swift/alchemy", from: "0.3.0"),
    ],
    targets: [
        .executableTarget(name: "Server", dependencies: ["App"]),
        .target(name: "App", dependencies: [
            .product(name: "Alchemy", package: "alchemy")
        ]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)
