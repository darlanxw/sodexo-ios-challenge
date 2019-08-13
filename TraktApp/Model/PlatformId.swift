//
//  PlatformId.swift
//  TraktApp
//
//  Created by objective on 08/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

struct PlatformId: APIResponse {
    let trakt: Int
    let slug: String
    let imdb: String
    let tmdb: Int
}
