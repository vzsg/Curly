// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CurlyClient",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CurlyClient",
            targets: ["CurlyClient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
       .package(url: "https://github.com/vapor/vapor.git", from: "3.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CurlyClient",
            dependencies: ["CCurlyCURL", "Vapor"]),
        .systemLibrary(name: "CCurlyCURL", pkgConfig: "libcurl"),
        .testTarget(
            name: "CurlyClientTests",
            dependencies: ["CurlyClient", "CCurlyCURL"]),
    ]
)
