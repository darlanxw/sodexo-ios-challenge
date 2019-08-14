//
//  TrendingParseTests.swift
//  TraktAppTests
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import XCTest
@testable import TraktApp

class TrendingParseTests: XCTestCase {
    
    func testParsingTrending_ReturnsTrendingList() {
        let request = TrendingRequest()
        let apiClient = TraktAPIClientMock()
        apiClient.requestList(request) { (response) in
            XCTAssertTrue(apiClient.apiWasExecuted)
            switch (response) {
            case .success(let list):
                let tredingList = list as! [Trending]
                XCTAssert(tredingList.count == 10, "Trending list should have ten items.")
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
        }
    }
    
    func testParsingTrending_ShouldReturnError() {
        let request = TrendingRequest()
        let apiClient = TraktAPIClientMock()
        apiClient.hasError = true
        apiClient.requestList(request) { (response) in
            XCTAssertTrue(apiClient.apiWasExecuted)
            switch (response) {
            case .success(let list):
                let tredingList = list as? [Trending]
                XCTAssertNil(tredingList)
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertFalse(error.isEmpty)
                break
            }
        }
    }
}
