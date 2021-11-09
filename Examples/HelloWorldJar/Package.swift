// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HelloWorldJar",
    platforms: [ .macOS(.v10_15) ],
    dependencies: [
        .package(
            // url: "https://github.com/SwiftPackageRepository/Jar.swift.git",
            url: "../../../Jar.swift",
            .branch("main")
        )
    ],
    targets: [
        .executableTarget(
            name: "HelloWorldJar",
            dependencies: [
                .product(name: "Jar", package: "Jar.swift")
            ]),
        .testTarget(
            name: "HelloWorldJarTests",
            dependencies: ["HelloWorldJar"]),
    ]
)
