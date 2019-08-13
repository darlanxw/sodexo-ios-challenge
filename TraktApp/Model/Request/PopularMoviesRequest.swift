//
//  PopularMoviesRequest.swift
//  TraktApp
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

struct PopularMovieRequest: APIRequest {
    
    var path: String {
        return "/movies/popular?limit=100"
    }
    
    var mockPath: String {
        return "PopularMovies"
    }
 
    typealias Response = Movie
    
}
