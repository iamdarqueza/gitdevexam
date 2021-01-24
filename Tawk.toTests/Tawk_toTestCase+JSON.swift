//
//  Tawk_toTestCase+JSON.swift
//  Tawk.toTests
//
//  Created by Danmark Arqueza on 1/24/21.
//

import XCTest

extension XCTestCase {
  enum TestError: Error {
    case fileNotFound
  }
  
  func getTestData(fromJSON fileName: String) throws -> Data {
    let bundle = Bundle(for: type(of: self))
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
      XCTFail("Missing File: \(fileName).json")
      throw TestError.fileNotFound
    }
    do {
      let data = try Data(contentsOf: url)
      return data
    } catch {
      throw error
    }
  }
}

