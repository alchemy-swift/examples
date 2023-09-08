// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "app",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alchemy-swift/alchemy", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Alchemy", package: "alchemy")
            ],
            path: "App"
        ),
        .testTarget(
            name: "Tests",
            dependencies: [
                "App",
                .product(name: "AlchemyTest", package: "alchemy")
            ],
            path: "Tests"
        ),
    ]
)
