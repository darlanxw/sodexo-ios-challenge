//
//  TMDBMovie.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

struct TMDBMovie: APIResponse {
    
    let video: Bool
    let voteCount: Int?
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {        
        case video
        case voteCount = "vote_count"
        case title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case genres
    }
    
    func formattedReleaseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let date = dateFormatter.date(from: releaseDate ?? "")
        
        return dateFormatter.string(from: date ?? Date())
    }
}
