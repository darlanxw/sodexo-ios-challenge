//
//  Trending.swift
//  TraktApp
//
//  Created by objective on 08/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

struct Trending: APIResponse {
    let watchers: Int
    let movie: Movie
}
