//
//  TrendingRequest.swift
//  TraktApp
//
//  Created by objective on 09/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

struct TrendingRequest: APIRequest {
    
    var path: String {
        return "/movies/trending?limit=100"
    }
    
    var mockPath: String {
        return "Trending"
    }
    
    typealias Response = Trending
    
}
