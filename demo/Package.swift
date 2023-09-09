// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "app",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "app", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alchemy-swift/alchemy", branch: "main"),
        //.package(url: "https://github.com/alchemy-swift/aws", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Alchemy", package: "alchemy"),
                //.product(name: "AlchemyS3", package: "aws"),
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
