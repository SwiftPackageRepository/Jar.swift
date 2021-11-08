// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JavaVirtualMachines",
    platforms: [ .macOS(.v10_15) ],
    dependencies: [
        .package(
            url: "https://github.com/SwiftPackageRepository/Jar.swift.git",
            from: "0.0.1"
        )
    ],
    targets: [
        .executableTarget(
            name: "JavaVirtualMachines",
            dependencies: [
                .product(name: "Jar", package: "Jar.swift")
            ]),
        .testTarget(
            name: "JavaVirtualMachinesTests",
            dependencies: ["JavaVirtualMachines"]),
    ]
)
