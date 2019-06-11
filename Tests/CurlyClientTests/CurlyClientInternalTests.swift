import XCTest
import NIO
import Vapor
import CCurlyCURL
@testable import CurlyClient

class CurlyClientInternalTests: XCTestCase {

    func testAllCurlCodeMappedIntoCurlyErrorCode() throws {
        let firstValidErrorCode = (CURLE_OK.rawValue+1)
        for codeValue in firstValidErrorCode..<CURL_LAST.rawValue {
            let curlCode = CURLcode(rawValue: codeValue)
            let curlyErrorCode = CURLErrorCode.from(curlCode)
            XCTAssertEqual(curlyErrorCode.rawValue, Int(codeValue))
            XCTAssert(curlyErrorCode != .unknownCode, "Missing mapping for some Curl error code")
        }
    }

    static var allTests = [
        ("testAllCurlCodeMappedIntoCurlyErrorCode", testAllCurlCodeMappedIntoCurlyErrorCode),
    ]
}
