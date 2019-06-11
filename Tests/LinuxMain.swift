import XCTest

import CurlyClientTests

var tests = [XCTestCaseEntry]()
tests += CurlyClientTests.allTests()
tests += CurlyClientInternalTests.allTests()
XCTMain(tests)
