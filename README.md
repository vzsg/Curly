# Curly

This package wraps [Perfect-CURL](https://github.com/PerfectlySoft/Perfect-CURL) into a Vapor 3 `Client`. If you are running into issues with URLSession on Linux, or you want cookies or proxy support, this might be the way out.

## Usage

### 1. Add this package as a dependency to your Vapor 3 project

```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporApp",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vzsg/Curly.git", from: "0.4.0"),
        // ... other dependencies ...
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "...", "CurlyClient"]),
        // ... other targets ...
    ]
)
```

### 2. Register the CurlyProvider

```swift
// Typically, this is part of configure.swift
import Vapor
import CurlyClient
// ... other imports ...


public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try services.register(CurlyProvider())
    config.prefer(CurlyClient.self, for: Client.self)

    // ... other configuration ...
}
```

### 3. Profit!

Your Vapor app now uses curl directly instead of URLSession.

### 4. Extra profit: CurlyOptions

From 0.3.0, Curly exposes a few useful options from cURL that are otherwise not available via the Client interface, or even URLSession. To use them, you _must_ register Curly via the `CurlyProvider` as seen in step 2.

With that in place, you can call `Request.addCurlyOption` in either the `beforeSend` closure when using the convenience functions of Client, or on the Request instance itself when using `Client.send()` and a self-built Request object.  
See the tests for examples of both methods.

> **Warning**: Calling `Request.addCurlyOption` without the Provider will result in a fatal error in debug builds, and a warning print in release builds.


#### Available options

- **proxy(String)**

    Equivalent to the [`-x`/`--proxy`](https://curl.haxx.se/docs/manpage.html#-x) parameter of curl, which enables proxying via a HTTP, HTTPS or SOCKS proxy.

- **proxyAuth(user: String, password: String)**

    Equivalent to the [`-U`/`--proxy-user`](https://curl.haxx.se/docs/manpage.html#-U) parameter of curl, which allows specifying the username and password to use when authenticating to the proxy server.

- **timeout(seconds: Int)**

    Equivalent to the [`-m`/`--max-time`](https://curl.haxx.se/docs/manpage.html#-m) parameter of curl, which allows specifying the maximum time allowed to service the request.

- **connectTimeout(seconds: Int)**

    Equivalent to the [`--connect-timeout`](https://curl.haxx.se/docs/manpage.html#--connect-timeout) parameter of curl, which allows specifying the maximum time allowed for the connection to the server.

- **cookieJar(String)**
  
  Equivalent to the **both** the [`-b`/`--cookie`](ttps://curl.haxx.se/docs/manpage.html#-b) **and** [`-c`/`--cookie-jar`](ttps://curl.haxx.se/docs/manpage.html#-c) parameters of curl. The file name provided with the option will be used as a cookie storage – reading and writing – for this request. See the tests for an example.

- **followRedirects(Bool)**

    Equivalent to the [`-L`/`--location`](https://curl.haxx.se/docs/manpage.html#-L) parameter of curl, which enables following redirects automatically.

- **insecure(Bool)**

    Equivalent to the [`-k`/`--insecure`](https://curl.haxx.se/docs/manpage.html#-k) parameter of curl, which can disable verification of the certificates received from the remote server.
