//
//  TraktTMDBMovie.swift
//  TraktApp
//
//  Created by objective on 13/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

struct TraktTMDBMovie {
    
    let trendingMovie: Trending?
    let popMovie: Movie?
    let tmdb: TMDBMovie
    
    init(popMovie: Movie, tmdb: TMDBMovie, trending: Trending? = nil) {
        self.popMovie = popMovie
        self.tmdb = tmdb
        self.trendingMovie = trending
    }
}
