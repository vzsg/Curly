# CurlyClient

This package wraps [Perfect-CURL](https://github.com/PerfectlySoft/Perfect-CURL) into a Vapor 3 `Client`. If you are running into issues with URLSession on Linux, this might be a way out.

## Usage

1. Add this package as a dependency to your Vapor 3 project

```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporApp",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vzsg/CurlyClient.git", from: "0.1.0"),
        // ... other dependencies ...
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "...", "CurlyClient"]),
        // ... other targets ...
    ]
)
```

1. Register and prefer the CurlyClient implementation

```swift
// Typically, this is part of configure.swift

TODO
```

1. ???
1. Profit!

