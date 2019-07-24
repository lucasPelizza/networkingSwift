// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "NetworkingExample",
    products: [
        .library(
            name: "NetworkingExample",
            targets: ["NetworkingExample"]),
    ],
    dependencies: [
        .package(url: "https://github.com/lucasPelizza/networkingSwift", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "NetworkingExample",
            dependencies: ["Networking"]),
    ]
)
