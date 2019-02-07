import XCTest
import NIO
import Vapor
@testable import CurlyClient

final class CurlyClientTests: XCTestCase {
    func testHttpBinPost() throws {
        let app = try Application()

        var http = HTTPRequest(method: .POST, url: "https://httpbin.org/post")
        http.headers.replaceOrAdd(name: "X-Test-Header", value: "Foo")
        let req = Request(http: http, using: app)

        try req.content.encode([
            "foo": "bar",
            "baz": "qux"
        ], as: .json)

        let client = CurlyClient(on: app)
        let res = try client.send(req).wait()

        XCTAssertNotNil(res.http.body.data)
        XCTAssert(!Array(res.http.headers).isEmpty)
    }

    static var allTests = [
        ("testHttpBinPost", testHttpBinPost),
    ]
}
