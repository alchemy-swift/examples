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
        .package(url: "https://github.com/alchemy-swift/alchemy", .upToNextMinor(from: "0.2.0")),
        .package(path: "../Shared"),
    ],
    targets: [
        .executableTarget(name: "Server", dependencies: ["App"]),
        .target(
            name: "App",
            dependencies: [
                .product(name: "Alchemy", package: "alchemy"),
                .product(name: "Shared", package: "Shared"),
            ]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)
