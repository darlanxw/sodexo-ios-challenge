//
//  MovieParseTests.swift
//  TraktAppTests
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import XCTest
@testable import TraktApp

public class MovieParseTests: XCTestCase {
    
    func testParsingMovies_ReturnsMovieList() {
        let request = PopularMovieRequest()
        let apiClient = TraktAPIClientMock()
        apiClient.requestList(request) { (response) in
            XCTAssertTrue(apiClient.apiWasExecuted)
            switch (response) {
            case .success(let list):
                let movieList = list as! [Movie]
                XCTAssert(movieList.count == 10, "Movie list should have \(movieList.count) items.")
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
        }
    }
    
    func testParsingMovies_ShouldReturnError() {
        let request = PopularMovieRequest()
        let apiClient = TraktAPIClientMock()
        apiClient.hasError = true
        apiClient.requestList(request) { (response) in
            XCTAssertTrue(apiClient.apiWasExecuted)
            switch (response) {
            case .success(let list):
                let movieList = list as? [Movie]
                XCTAssertNil(movieList)
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertFalse(error.isEmpty)
                break
            }
        }
    }
    
}
