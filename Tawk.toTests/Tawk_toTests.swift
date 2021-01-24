//
//  Tawk_toTests.swift
//  Tawk.toTests
//
//  Created by Danmark Arqueza on 1/24/21.
//

import XCTest
@testable import Tawk_to

class Tawk_toTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private var viewModel = DeveloperListViewModel(task: DeveloperListService())
    private var devDetailViewModel = DeveloperProfileViewModel(task: DeveloperProfileService())

    func testDevList() {
      let expect = expectation(description: "Get developer list")
      viewModel.requestDevList { (status) in
        XCTAssertTrue(status)
        expect.fulfill()
      } onError: { (err) in }
      waitForExpectations(timeout: 5, handler: .none)
    }
    
    func testDevInfo() {
      let expect = expectation(description: "Get developer detail")
      devDetailViewModel.requestDevInfo{ (status) in
        XCTAssertTrue(status)
        expect.fulfill()
      } onError: { (err) in }
      waitForExpectations(timeout: 5, handler: .none)
    }
}
