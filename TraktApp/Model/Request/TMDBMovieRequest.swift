//
//  TMDBMovieRequest.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit

struct TMDBMovieRequest: APIRequest {
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var path: String {
        return "/3/movie/\(id)?api_key=\(UIApplication.tmdbApiKey)"
    }
    
    var mockPath: String {
        return ""
    }
    
    typealias Response = TMDBMovie
}
