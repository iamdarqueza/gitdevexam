//
//  Tawk_toModelTests.swift
//  Tawk.toTests
//
//  Created by Danmark Arqueza on 1/24/21.
//

import XCTest
@testable import Tawk_to

class GitDevModelTest: XCTestCase {
  
  var test: DeveloperProfileResponse!

  override func setUpWithError() throws {
    super.setUp()
    let data = try getTestData(fromJSON: "DevTest_200")
    test = try JSONDecoder().decode(DeveloperProfileResponse.self, from: data)
  }
  
  override func tearDownWithError() throws {
    test = nil
    super.tearDown()
  }
  
  func testJSONMapping() {
    XCTAssertEqual(test.login, "ivey")
    XCTAssertNotEqual(test.login, "dandan")
  }

}
