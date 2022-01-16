// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "App",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alchemy-swift/alchemy", .branch("main")),
    ],
    targets: [
        .executableTarget(name: "App", dependencies: [
            .product(name: "Alchemy", package: "alchemy")
        ]),
        .testTarget(name: "Tests", dependencies: ["App"]),
    ]
)
