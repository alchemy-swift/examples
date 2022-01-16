// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Server",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alchemy-swift/alchemy", .branch("main")),
        .package(path: "../Shared"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Alchemy", package: "alchemy"),
                .product(name: "Shared", package: "Shared"),
            ]),
        .testTarget(name: "Tests", dependencies: ["App"]),
    ]
)
