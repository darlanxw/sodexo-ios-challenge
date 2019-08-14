//
//  MovieMock.swift
//  TraktAppTests
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation
@testable import TraktApp

internal class MovieMock {
    
    static let shared = MovieMock()
    
    func get() -> [Movie] {
        var movieList: [Movie] = []
        
        let ids: PlatformId = PlatformId(trakt: 1, slug: "abc", imdb: "def", tmdb: 2)
        let movie = Movie(title: "My Test Movie", year: 2019, ids: ids, movieDB: nil)
        
        movieList.append(movie)
        return movieList
    }
}
