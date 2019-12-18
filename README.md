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
        .package(url: "https://github.com/vzsg/Curly.git", from: "0.6.0"),
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

- **proxyPort(Int)** (New in 0.6.0)

    Equivalent to `CURLOPT_PROXYPORT`, which allows separately overriding the port used to connect to the proxy.

- **timeout(Int)**

    Equivalent to the [`-m`/`--max-time`](https://curl.haxx.se/docs/manpage.html#-m) parameter of curl, which allows specifying the maximum time allowed to service the request in seconds.

- **timeoutMs(Int)**

    Same as `timeout`, but with milliseconds precision.

- **connectTimeout(Int)**

    Equivalent to the [`--connect-timeout`](https://curl.haxx.se/docs/manpage.html#--connect-timeout) parameter of curl, which allows specifying the maximum time allowed for the connection to the server in seconds.

- **connectTimeoutMs(Int)** (New in 0.5.0)

    Same as `connectTimeout`, but with milliseconds precision.

- **cookieJar(String)**

    Equivalent to setting **both** the [`-b`/`--cookie`](https://curl.haxx.se/docs/manpage.html#-b) **and** [`-c`/`--cookie-jar`](https://curl.haxx.se/docs/manpage.html#-c) parameters of curl. The file name provided with the option will be used as a cookie storage – reading and writing – for this request. See the tests for an example.

- **followRedirects(Bool)**

    Equivalent to the [`-L`/`--location`](https://curl.haxx.se/docs/manpage.html#-L) parameter of curl, which enables following redirects automatically.

- **insecure(Bool)**

    Equivalent to the [`-k`/`--insecure`](https://curl.haxx.se/docs/manpage.html#-k) parameter of curl, which can disable verification of the certificates received from the remote server. Deprecated in favor of `sslVerifyPeer`.

- **sslVerifyPeer(Bool)** (New in 0.6.0)

    Equivalent to [`CURLOPT_SSL_VERIFYPEER`](https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html]), used to enable or disable server certificate verification.

- **sslVerifyHost(Bool)** (New in 0.6.0)

    Equivalent to [`CURLOPT_SSL_VERIFYHOST`](https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYHOST.html]), used to enable or disable verification of the server host name against the server certificates.

- **sslKey(path: String, type: CurlySSLFileType?, password: String?)** (New in 0.6.0)

    Equivalent to the [`--key`](https://curl.haxx.se/docs/manpage.html#--key), [`--key-type`](https://curl.haxx.se/docs/manpage.html#--key-type) and [`--pass`](https://curl.haxx.se/docs/manpage.html#--pass) parameters, used to specify a private key to use for client certificate verification.

- **sslCert(path: String, type: CurlySSLFileType?)** (New in 0.6.0)

    Equivalent to the [`--cert`](https://curl.haxx.se/docs/manpage.html#--cert) and [`--cert-type`](https://curl.haxx.se/docs/manpage.html#--cert-type) parameters, used to specify a client certificate.

- **sslCAFilePath(String)** (New in 0.6.0)

    Equivalent to the [`--cacert`](https://curl.haxx.se/docs/manpage.html#--cacert) parameter, used to specify a certificate to verify the server certificates against.

- **sslCADirPath(String)** (New in 0.6.0)

    Equivalent to the [`--cadir`](https://curl.haxx.se/docs/manpage.html#--cadir) parameter, used to specify a folder containing certificates to verify the server certificates against.

- **sslCiphers([String])** (New in 0.6.0)

    Equivalent to the [`--ciphers`](https://curl.haxx.se/docs/manpage.html#--ciphers) parameter, used to specify which ciphers to allow. See [this page](https://curl.haxx.se/docs/ssl-ciphers.html) for details.

- **sslPinnedPublicKey(String)** (New in 0.6.0)

    Equivalent to the [`--pinnedpubkey`](https://curl.haxx.se/docs/manpage.html#--pinnedpubkey) parameter, used to specify either a file with a PEM/DER encoded public key, or an SHA-256 hash that the server must present in its certificate chain.
