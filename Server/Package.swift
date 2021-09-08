// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Server",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "Server", targets: ["Server"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alchemy-swift/alchemy", .upToNextMinor(from: "0.2.0")),
    ],
    targets: [
        .executableTarget(name: "Server", dependencies: [
            .product(name: "Alchemy", package: "alchemy")
        ]),
        .testTarget(name: "ServerTests", dependencies: ["Server"]),
    ]
)
