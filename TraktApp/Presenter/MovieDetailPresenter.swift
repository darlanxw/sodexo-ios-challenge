//
//  MovieDetailPresenter.swift
//  TraktApp
//
//  Created by objective on 13/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

protocol DetailPresenterDelegate: class {
    func showDetail(detail: TMDBMovie)
    func showLoading()
    func hideLoading()
}

public class MovieDetailPresenter {
    
    let apiClient: TraktAPIClientProtocol
    weak var delegate: DetailPresenterDelegate?
    
    init(apiClient: TraktAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchTMDB(movie: Movie) {
        
        let request = TMDBMovieRequest(id: movie.ids.tmdb)
        self.delegate?.showLoading()
        apiClient.requestObject(request) { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.hideLoading()
            switch (result) {
            case .success(let response):
                let movie = response as! TMDBMovie
                strongSelf.delegate?.showDetail(detail: movie)                
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
}
