//
//  Movie.swift
//  TraktApp
//
//  Created by objective on 08/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

struct Movie: APIResponse {
    let title: String
    let year: Int
    let ids: PlatformId
    
    var movieDB: TMDBMovie?
}